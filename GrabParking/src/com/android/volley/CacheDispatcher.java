/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.volley;

import android.os.Process;

import java.util.concurrent.BlockingQueue;

/**
 * Provides a thread for performing cache triage on a queue of requests.
 *
 * Requests added to the specified cache queue are resolved from cache.
 * Any deliverable response is posted back to the caller via a
 * {@link ResponseDelivery}.  Cache misses and responses that require
 * refresh are enqueued on the specified network queue for processing
 * by a {@link NetworkDispatcher}.
 */
@SuppressWarnings("rawtypes")
public class CacheDispatcher extends Thread {

    private static final boolean DEBUG = VolleyLog.DEBUG;

    /** The queue of requests coming in for triage. */
  //本地队列，从RequestQueue中传递进来的  
    private final BlockingQueue<Request> mCacheQueue;

    /** The queue of requests going out to the network. */
  //网络请求队列，也是从RequestQueue中传递进来，当本地缓存没有命中时，需要把请求从本地队列加入网络队列  
    private final BlockingQueue<Request> mNetworkQueue;

    /** The cache to read from. */
  //磁盘缓存对象  
    private final Cache mCache;

    /** For posting responses. */
  //就是用于从子线程向Ui线程发送数据  
    private final ResponseDelivery mDelivery;

    /** Used for telling us to die. */
    private volatile boolean mQuit = false;

    /**
     * Creates a new cache triage dispatcher thread.  You must call {@link #start()}
     * in order to begin processing.
     *
     * @param cacheQueue Queue of incoming requests for triage
     * @param networkQueue Queue to post requests that require network to
     * @param cache Cache interface to use for resolution
     * @param delivery Delivery interface to use for posting responses
     */
    public CacheDispatcher(
            BlockingQueue<Request> cacheQueue, BlockingQueue<Request> networkQueue,
            Cache cache, ResponseDelivery delivery) {
        mCacheQueue = cacheQueue;
        mNetworkQueue = networkQueue;
        mCache = cache;
        mDelivery = delivery;
    }

    /**
     * Forces this dispatcher to quit immediately.  If any requests are still in
     * the queue, they are not guaranteed to be processed.
     */
    public void quit() {
        mQuit = true;
        interrupt();
    }

    /**
     * 通过上面的代码，我们来总结一下一个请求的执行过程吧：
1、一个请求就是一个Request对象，首先将Request对象加入到RequestQueue中.
2、判断Request是否可以缓存，如果可以，则加入到本地缓存队列，否则加入网络队列
3、本地线程不断监听本地队列是否有请求，如果有请求取出来
4、判断Request是否取消，如果取消，处理下一个请求
5、判断缓存是否命中，如果没有命中，将该请求加入网络队列
6、如果命中，但是过期，同样将该请求加入网络队列
7、如果命中，并且不用刷新，那么直接放回结果，不用加入网络队列
8、如果命中，并且需要刷新，那么放回结果，并且加入网络队列
9、同样4条网络线程也在不断监听网络队列是否有请求，一旦发现有请求，取出请求，判断是否取消，如果取消，那么取出下一个请求
10、如果没有取消，那么通过NetWork进行http请求，将请求结果封装成NetworkResponse,然后转换为Response
11、如果可以缓存，那么将数据写入缓存
12、通过Delivery将Response返回到ui线程
     */
    @Override
    public void run() {
        if (DEBUG) VolleyLog.v("start new dispatcher");
        Process.setThreadPriority(Process.THREAD_PRIORITY_BACKGROUND);

        // Make a blocking call to initialize the cache.
     // 缓存初始化，将磁盘中的数据读入内存  
        mCache.initialize();

        while (true) {
            try {
                // Get a request from the cache triage queue, blocking until
                // at least one is available.
            	// 阻塞式从队列中取出请求  
                final Request request = mCacheQueue.take();
                request.addMarker("cache-queue-take");

                // If the request has been canceled, don't bother dispatching it.
             // 判断request是否被取消了(调用cancel方法)，如果取消了就不执行，再次到队列中取请求  
                if (request.isCanceled()) {
                    request.finish("cache-discard-canceled");
                    continue;
                }

                // Attempt to retrieve this item from cache.
             // 从缓存中读取数据  
                Cache.Entry entry = mCache.get(request.getCacheKey());
                if (entry == null) {
                	// 没有命中
                    request.addMarker("cache-miss");
                    // Cache miss; send off to the network dispatcher.
                 // 没有命中时，就将请求放入网络队列  
                    mNetworkQueue.put(request);
                    continue;
                }

                // If it is completely expired, just send it to the network.
             // 数据已经过期，将请求放入网络队列  
                if (entry.isExpired()) {
                    request.addMarker("cache-hit-expired");
                    request.setCacheEntry(entry);
                    mNetworkQueue.put(request);
                    continue;
                }

                // We have a cache hit; parse its data for delivery back to the request.
             // 本地命中  
                request.addMarker("cache-hit");
                Response<?> response = request.parseNetworkResponse(
                        new NetworkResponse(entry.data, entry.responseHeaders));
                request.addMarker("cache-hit-parsed");

                if (!entry.refreshNeeded()) {
                    // Completely unexpired cache hit. Just deliver the response.
                    mDelivery.postResponse(request, response);
                } else {
                    // Soft-expired cache hit. We can deliver the cached response,
                    // but we need to also send the request to the network for
                    // refreshing.
                    request.addMarker("cache-hit-refresh-needed");
                    request.setCacheEntry(entry);

                    // Mark the response as intermediate.
                    response.intermediate = true;

                    // Post the intermediate response back to the user and have
                    // the delivery then forward the request along to the network.
                    mDelivery.postResponse(request, response, new Runnable() {
                        @Override
                        public void run() {
                            try {
                                mNetworkQueue.put(request);
                            } catch (InterruptedException e) {
                                // Not much we can do about this.
                            }
                        }
                    });
                }

            } catch (InterruptedException e) {
                // We may have been interrupted because it was time to quit.
                if (mQuit) {
                    return;
                }
                continue;
            }
        }
    }
}

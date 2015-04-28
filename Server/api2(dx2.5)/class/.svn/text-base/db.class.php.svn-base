<?php
/**
 * Discuz!手机接口api的DB类
 * ShopNC Alex Lee 2012.2.23
 */
require_once('define.ini.php');
class DB{
	 private static $instance = null;
	 private static $conn;
	 
	 public static function getInstance(){
		if(self::$instance === null || !(self::$instance instanceof DB)){
			self::$instance = new DB();
			self::$instance->connect();
		} 
		return self::$instance;
	}
	
	function connect(){
		switch(DBTYPE){
			case 'mysql':
				if(self::$conn = mysql_connect(DBSERVER.':'.DBSERVER_PORT,DBUSER,DBPASSWD)){
					if(mysql_select_db(DBNAME,self::$conn)){
						mysql_query("SET character_set_connection=".DBCHARSET.", character_set_results=".DBCHARSET.", character_set_client=binary",self::$conn);
					}else{
						echo 'can not select db';exit;
					}
				}else{
					echo 'can not connect db';exit;
			    }
				break;
			case 'mysqli':
				if(self::$conn = new mysqli(DBSERVER,DBUSER,DBPASSWD,DBNAME,DBSERVER_PORT)){
					self::$conn->query("SET character_set_connection=".DBCHARSET.", character_set_results=".DBCHARSET.", character_set_client=binary");
				}else{
					echo 'can not connect db';exit;
				}
				break;
		}
	}
	
	function query($sql){
		self::getInstance();
		switch(DBTYPE){
			case 'mysql':
				$query = mysql_query($sql,self::$conn);
			    break;
			case 'mysqli':
				$query = self::$conn->query($sql);
				break;
		}
		return $query;
	}

	function fetch_array($query, $result_type = MYSQL_ASSOC) {
		switch(DBTYPE){
			case 'mysql':
				return mysql_fetch_array($query, $result_type);
				break;
			case 'mysqli':
				return mysqli_fetch_array($query, $result_type);
			    break;
		}
	}

	function fetch_all($sql) {
		$query = $this->query($sql);
		while($data = $this->fetch_array($query)) {
			//转码
			if(strtoupper(DBCHARSET) == 'GBK'){
				if(!empty($data)){
					foreach ($data as $k=>$v){
						$data[$k] = mb_convert_encoding($v,'UTF-8','GBK');
					}
				}
			}
			$arr[] = $data;
		}
		
		return $arr;
	}

	function getLastId(){
		self::getInstance();
		switch(DBTYPE){
			case 'mysql':
				return mysql_insert_id(self::$conn);
				break;
			case 'mysqli':
				return mysqli_insert_id(self::$conn);
			    break;
		}
	}

	function close() {
		return mysql_close(self::$conn);
	}
	function test(){
		return 'OK';
	}
 }
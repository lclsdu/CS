<?php
/**
 * JSON类
 * ShopNC AlexLee 2012.2.24 
 * 
 * 使用方法：加载此类后将处理后的数组作为参数传给此类的ArrayGetjson方法
 * 例如：$json   = new JSON();
 *       $result = $json->ArrayGetjson($your_array);
 */
require_once 'config.ini.php';
class JSON{
	function json_encode_string($in_str) {
		    mb_internal_encoding("UTF-8");
			$convmap = array(0x80, 0xFFFF, 0, 0xFFFF);
			$mb = function_exists('mb_ereg')?'mb_ereg':'preg_match';
			$regex = function_exists('mb_ereg')?"&#(\\d+);":"/&#(\\d+);/u";
			$str = "";
			for($i=mb_strlen($in_str)-1; $i>=0; $i--) {
				$mb_char = mb_substr($in_str, $i, 1);
				if($mb($regex, mb_encode_numericentity($mb_char, $convmap, "UTF-8"), $match)) {
					$str = sprintf("\\u%04x", $match[1]) . $str;
				} else {
					$str = $mb_char . $str;
				}
			}
			return $str;
	}
	function _array2json($array) {
		
			$piece = array();
			foreach ($array as $k => $v) {
				$piece[] = '"'.$k . '":' . $this->php2json($v);
			}
			if ($piece) {
				$json = '{' . implode(',', $piece) . '}';
			} else {
				$json = '[]';
			}
			return $json;
		}
	
	function php2json($value) {
			if (is_array($value)) {
				return $this->_array2json($value);
			}
			if (is_string($value)) {
				$value = str_replace(array("\n", "\t"), array(), $value);
				$value = addslashes($value);
				$value = $this->json_encode_string($value);
				return '"'.$value.'"';
			}
			if (is_bool($value)) {
				return $value ? 'true' : 'false';
			}
			if (is_null($value)) {
				return 'null';
			}
			return $value;
	}
	/**
	 * 生成json数据
	 * @param Array $array 数据数组
	 * @param int $code 状态代码
	 */
	function ArrayGetjson($array,$code,$count=''){
		$temp_array = array();
		if(!empty($array)){
			foreach ($array as $k=>$v){
				$temp_array[] = $this->_array2json($v);
			}
		}
		$json_string = '{"code":"'.$code.'","datas":[';
		if(!empty($temp_array)){
			foreach ($temp_array as $k=>$v){
				$json_string .= $v.',';
			}
		}
		if($count == ''){
			$json_string = trim($json_string,',').']}';
		}else{
			$json_string = trim($json_string,',').'],"count":"'.$count.'"}';
		}
		return $json_string;
	}
}
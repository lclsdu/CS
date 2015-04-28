<?php
require_once('define.ini.php');
class DBUC{
	 private static $instance = null;
	 private static $conn;
	 
	 public static function getInstance(){
		if(self::$instance === null || !(self::$instance instanceof DBUC)){
			self::$instance = new DBUC();
			self::$instance->connect();
		} 
		return self::$instance;
	}
	
	function connect(){
		switch(UCTYPE){
			case 'mysql':
				if(self::$conn = mysql_connect(UCSERVER.':'.UCSERVER_PORT,UCUSER,UCPASSWD)){
					if(mysql_select_db(UCNAME,self::$conn)){
						mysql_query("SET character_set_connection=".UCCHARSET.", character_set_results=".UCCHARSET.", character_set_client=binary",self::$conn);
					}else{
						echo 'can not select db';exit;
					}
				}else{
					echo 'can not connect db';exit;
			    }
				break;
			case 'mysqli':
				if(self::$conn = new mysqli(UCSERVER,UCUSER,UCPASSWD,UCNAME,UCSERVER_PORT)){
					self::$conn->query("SET character_set_connection=".UCCHARSET.", character_set_results=".UCCHARSET.", character_set_client=binary");
				}else{
					echo 'can not connect db';exit;
				}
				break;
		}
	}
	
	function query($sql){
		self::getInstance();
		switch(UCTYPE){
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
		switch(UCTYPE){
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
			if(strtoupper(UCCHARSET) == 'GBK'){
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
		switch(UCTYPE){
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









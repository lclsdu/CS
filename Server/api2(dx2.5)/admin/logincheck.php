<?php
session_start();
$captcha = strtoupper($_POST['captcha']);

if ($_POST['form_submit'] === 'ok' && $captcha === $_SESSION['ShopNC_app_seccode']) {
	$acc = trim($_POST['user_name']);
	$pw = md5(trim($_POST['password']));

	if ($acc == 'UCenterAdministrator' && $pw != '') {
		require_once('..'.DIRECTORY_SEPARATOR.'class'.DIRECTORY_SEPARATOR.'config.ini.php');
		require_once($ucpath);
		if (md5($pw.UC_FOUNDERSALT) == UC_FOUNDERPW) {
			$check = 1;
		} else {
			$check = 0;
            echo '<script>alert("账号或密码错误，请重新输入！");history.back();</script>';
		}
	} else {
		$check = 0;
        echo '<script>alert("账号或密码错误，请重新输入！");history.back();</script>';
	}

	if ($check) {
		$_SESSION["ShopNC_app_isLogin"] = true;
		$_SESSION["username"] = 'UCenterAdministrator';
		echo '<script>location="index.php"</script>';
	} else {
		echo '<script>location="login.php"</script>';
	}
} else {
	echo '<script>location="login.php"</script>';
}



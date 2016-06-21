<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>很抱歉页面未找到</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="/OnlineShopping/css/error.css"
	media="screen" />

<style>
.f {
	font-style: oblique;
	font-family: "华文彩云";
	font-size: 64px;
	color: #FFF;
}
</style>

<script>
	window.onload = function() {
		var oDiv = document.getElementById('div1');
		var value = 4;
		setInterval(function() {
			oDiv.innerHTML = value;
			value--;
			if (value < 0) {
				document.location = "/OnlineShopping/user/index";
				value = 0;
				return;
			}
		}, 1000);
	};
</script>

</head>
<body>
	<div id="container">
		<p>
			<img class="png1" src="/OnlineShopping/images/404.png" />
		</p>
		<p>
			<img class="png1 msg" src="/OnlineShopping/images/404_msg.png" />
		</p>
		<div id="div1" class="f">5</div>
		<p>
			<a href="/OnlineShopping/user/index"><img class="png2"
				src="/OnlineShopping/images/404_to_index.png" /></a>
		</p>
	</div>
	<div id="cloud" class="png"></div>
	<pre style="DISPLAY: none"></pre>


</body>
</html>
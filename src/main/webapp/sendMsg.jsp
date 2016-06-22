<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>  
<script type="text/javascript" src="dwr/interface/SendMsg.js"></script> 
<script type="text/javascript" src="jquery/jquery.js"></script> 
<script type="text/javascript">
function onload(){	
	dwr.engine.setActiveReverseAjax(true);
}
function sendMsg(){
	SendMsg.sendMsg($("#msg").val());

}
</script>
<title>Insert title here</title>
</head>  
<body onload="onload()">
	<!-- 两个事件参考http://blog.csdn.net/zhbitxhd/article/details/12943091 -->
	<input type="text" id="msg" oninput="sendMsg()" onpropertychange="sendMsg()" />
	<input type="button" value="发送" id="but" onclick="sendMsg()" />
</body>
</html>
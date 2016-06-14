<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/OnlineShopping/jquery/jquery.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		//do something
		bindData();
	})
	function bindData(){
	//	document.getElementById("userId").value = "123123";
	//	alert(${cookie.password.value});
		document.getElementById("userId").value = "${cookie.userId.value}";  
		document.getElementById("password").value = "${cookie.password.value}";  
	}
	//更换验证码，加随机数防止缓存
	function changeCode(obj) {
		obj.src = "/OnlineShopping/user/createCode?" + Math.random();
	}

	//核对验证码
	function checkCode() {
		$.post("/OnlineShopping/user/captchaCheck", {
			captcha:$("#captcha").val()
		}, function(data) {
			//设置验证信息
			$('#checkResult').html(data);
		});
	}
	
	//数据验证，符立明你来完善。。
	function dataValid() {
		var flag = true;
		
		//验证码是否正确验证
		var checkResult = document.getElementById("checkResult");
		if (checkResult.innerHTML != "填写正确")
			flag = false;
		
		if ($("#captcha").val() == "")
		{
			checkResult.innerHTML = "请填写验证码";
			alert("请填写验证码");
		}
		return flag;
	}
</script>

</head>
<body>
	<span>${loginError }</span>
	<!-- 登录表单 -->
	<form:form modelAttribute="user" onsubmit="return dataValid()">
		用户名：<form:input id="userId" path="userId" value = "${request.user.userId }"/>
			
		<!-- 如果用户名不为空，则显示字段校验信息 -->
		<c:if test="${loginError != '用户名不能为空'}">
			<form:errors path="userId"/>
		</c:if><br/>
		
		密码：<form:password id="password" path="password"/>  <form:errors path="password"/> <br/>
		验证码：<input id="captcha" name="captcha" type="text" onblur="checkCode()"/>
		<span id="checkResult">请填写验证码</span> <br>
		<img src="/OnlineShopping/user/createCode?<%=Math.random()%>"  id="code" onclick="changeCode(this)"/><br/>
		<input type="checkbox" name="isRememberPwd"/>记住密码
		<select name = "rememberd_days">
			<option value="1">1天</option>
			<option value="7">1个星期</option>
			<option value="30">1个月</option>
		</select>
		<br/>
		<input type="submit" value="提交"/> 
	</form:form>
	
</body>
</html>
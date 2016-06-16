<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- resourceRoot是在XML中配置的逻辑路径 -->
<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">

	function validAndSubmit()
	{
		//写验证数据的代码。。
		
		userInfo.action="/OnlineShopping/user/manage/operUserInfo";
		$("#userInfo").submit();
	}
	
	//发送验证验证码邮件，并告知用户发送情况
	function sendVerifyEmail() {
		$.post("/OnlineShopping/user/manage/sendEmail", {
			receiveAddress:$("#receiveAddress").val()
		}, function(data) {
			//返回的发送情况，如"发送成功"等。
			alert(data);
		});
	}

</script>
</head>

<body>
	<!-- 更新用户信息的结果 -->
	${updateInfoResult }
	<form id="userInfo" name="userInfo"  method="post">
		<!-- 用户名无法修改，从session中获取已经登录用户的信息-->
		用户名：<input type="text" name="userId" disabled="disabled" value="${sessionScope.loginedUser.userId }" /> <br/><br/>
		昵称：<input type="text" name="userName" value="${sessionScope.loginedUser.userName }" /><br/><br/>
		可用余额：<input type="text" name="balance"  disabled="disabled" value="${sessionScope.loginedUser.balance }" /><br/><br/>
		邮箱：<input type="text" id="receiveAddress" name="email" value="${sessionScope.loginedUser.email }" disabled="disabled" /> 
		<button type="button" onclick="sendVerifyEmail()">发送</button><br/><br/>
		验证码：<input type="text" name="emailCaptcha"> <br/><br/>
		新邮箱：<input type="text" name="newEmailAddress"> <br/><br/>
		头像请您在<a href="<c:url value = '/user/manage/'/>" >主界面</a>修改<br/><br/>
		<button type="button" onclick="validAndSubmit()">修改</button>
	</form>

</body>
</html>
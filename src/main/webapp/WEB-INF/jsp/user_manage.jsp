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
	//显示上传的结果
	function showUploadResult()
	{
		if ("${upLoadResult}" != null && "${upLoadResult}" != "")
		alert("${upLoadResult}");
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
	//自动执行显示上传结果
	window.onload = showUploadResult();
</script>
</head>
<body>
	<!-- 如果用户的头像是默认的，则加载images下的defaultHead.jpg，
		否则加载uploads下的用户文件夹下的上传的头像文件 -->
	<c:choose>
		<c:when test="${loginedUser.headScul  == 'defaultHead.jpg'}"> 
		   <c:set var="userHeadSrc">images/defaultHead.jpg</c:set>
	   	</c:when>
		<c:otherwise> 
			<c:set var="userHeadSrc">uploads/${loginedUser.userId}/${loginedUser.headScul }</c:set>
	  	</c:otherwise>
	</c:choose>
	
	用户的头像：<img alt="头像" src="<c:url value = '/${userHeadSrc}'/>"/>
	<br/>
	<%=request.getSession().getServletContext().getRealPath("/") %>
	绑定邮箱<br/>
	<br/><br/>
	
	<!-- 邮箱绑定结果 -->
	${bindResult }
	<!-- 绑定邮箱表单 -->

	<form action="<c:url value = "/user/manage/bindEmail"/>" method="post">
		邮箱：<input type="text" id="receiveAddress" name="receiveAddress" value="${requestScope.emailAddress}" >
		<!-- 必须设置button的类型，否则会在除IE的浏览器自动提交表单 -->
		<button type="button" onclick="sendVerifyEmail()">发送</button><br/>
		验证码：<input type="text" id="emailCaptcha" name="emailCaptcha"/><br/>
		<input type="submit" value="绑定"/>
	</form>

	<br/><br/><br/>
	<!-- 上传头像 -->
	上传头像
	<!-- 上传文件必须设置post和encType -->
	<form action="<c:url value = '/user/manage/upHeadScul'/>" method="post" enctype="multipart/form-data">
		<input type="file" name="headScul"/><br/>
		<input type="submit" value="上传"/>
	</form>
	
	<a href="">查询或修改您的信息</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- 引入jQuery源码 -->
<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">

	//检查用户名是否可用
	function checkUserIdAvl() {
		$.post("/OnlineShopping/user/userExistCheck", {
			userId:$("#userId").val()
		}, function(data) {
			//设置可用信息
			document.getElementById("checkAvlResult").src = data;
		});
	}
	
	//数据验证，符立明你来完善哈。。
	function dataValid() {
		var flag = true;
		
		//TODO 进行用户名和密码及确认密码字段的校验，在这里写代码，请进行完善！！！！
		if ($("#userId").val() == "") {
			alert("用户名不能为空");
			flag = false;
		}
		//如果图片的src不为用户名可用图片的src
		else if (document.getElementById("checkAvlResult").src.indexOf("userAvl.jpg") == -1) {
			alert("该用户名已经注册，请更换");
			flag = false;
		}
		return flag;
	}
</script>

</head>
<body>
	<!-- 密码和确认密码相等的提示信息 -->
	${pwdEquals }

	<!-- 注册表单 -->
	<form:form modelAttribute="regUser" onsubmit="return dataValid()">
		用户名：<form:input id="userId" path="userId" value = "${request.user.userId }" onblur="checkUserIdAvl()"/>
		<form:errors path="userId"/>
		
		<!-- 如果用户名不为空，则不用显示用户名可用的结果的图片 -->
		<c:if test="${createInfo != '用户名不能为空'}">
			<img id="checkAvlResult"/> <br/><!--检测用户名可用的结果的图片 -->
		</c:if>
		
		<!-- 添加换行符 -->
		<c:if test="${createInfo == '用户名不能为空'}">
			${createInfo }<br/>
		</c:if>
		
		昵称：<form:input id="userName" path="userName" value = "${request.user.userName }"/><br>
		密码：<form:password id="password" path="password"/> 
		
		 <form:errors path="password"/> <br/>
		确认密码：<input type="password" name="confirmPassword"/> 
		
		<br/>
		<input type="submit" value="注册"/> 
	</form:form>
	
</body>
</html>
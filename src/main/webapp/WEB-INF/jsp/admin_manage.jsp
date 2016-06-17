<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">

	//查询用户信息
	function queryUserInfo() {
		$.post("/OnlineShopping/admin/queryUserInfo", {
			userId:$("#userId").val()
		}, function(data) {
			
			if (data == "")
				alert("没有该用户");
			else  {
				var info = data.split('&')
				
				if (info[1]  == 'defaultHead.jpg')
					var headScul = '/OnlineShopping/images/defaultHead.jpg';
				else  {
					var headScul = '/OnlineShopping/uploads/'+$("#userId").val() + '/'+ info[1];
				}
				$("#userName").val(info[0]);
				$("#headScul").attr('src', headScul);
			}
			
			//设置可用信息
		//	document.getElementById("checkAvlResult").src = data;
		});
	}
	
	//修改用户昵称
	function updateUserName() {
		$.post("/OnlineShopping/admin/updateUserName", {
			userId:$("#userId").val(), 
			userName:$("#userName").val()
		}, function(data) {
			alert(data);
		});
	}
	
	function validAndUpdate(){
		//使用隐藏域将id值传过去。。
		$("#userId2").val($("#userId").val());
		headForm.submit();
	}
</script>
</head>
<body>

	${updateHeadResult}
	<h2>管理员管理界面</h2>
	<form:form modelAttribute="regUser">
		用户Id：<form:input path="userId" id="userId"  value = "${userId }"/>
		<button type="button" onclick="queryUserInfo()">查询</button><br/><br/>
		昵称：<input type="text" id="userName" />
		<button type="button" onclick="updateUserName()">修改用户昵称</button><br/><br/>
	</form:form>
	
	<form name="headForm" action="<c:url value = '/admin/updateUserHead'/>" method="post" enctype="multipart/form-data">
		头像：<img src="" id="headScul" /><br/>
		<button type="button" onclick="validAndUpdate()">修改用户头像</button>
		<input type="file" name="newHeadScul"/>
		<input type="hidden" id="userId2" name="userId2"/>
	</form>
</body>
</html>
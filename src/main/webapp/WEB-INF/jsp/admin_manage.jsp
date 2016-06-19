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
	
	//查询商品信息
	function queryGoodInfo() {
		window.location = "/OnlineShopping/admin/queryGoodInfo?goodId=" + $("#goodId").val();
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
	
	//显示查询商品结果
	function showQueryGoodResult()
	{
		if ("${queryResult}" != null && "${queryResult}" != "")
			alert("${queryResult}");	
	}
	
	//显示更新商品结果
	function showUpdateGoodResult()
	{
		if ("${updateGoodResult}" != null && "${updateGoodResult}" != "")
			alert("${updateGoodResult}");	
	}
	//显示信息。
	function showInfos()
	{
		//执行显示查询商品结果
		showQueryGoodResult();
		showUpdateGoodResult();
		//执行显示添加商品结果
		showInsertGoodResult();
	}
	
	//显示添加商品结果
	function showInsertGoodResult()
	{
		if ("${insertGoodResult}" != null && "${insertGoodResult}" != "")
			alert("${insertGoodResult}");	
	}
	
	//删除商品
	function deleteGood() {
		$.post("/OnlineShopping/admin/deleteGood", {
			goodId:$("#goodId").val()
		}, function(data) {
			alert(data);
			//符立明，你来清空文本框的数据！！等等。
		});
	}
	//修改商品信息
	function updateGoodInfo() {
		goodForm.action = "/OnlineShopping/admin/updateGoodInfo";
		goodForm.submit();
	}
	
	//添加商品
	function insertGood() {
		goodForm.action = "/OnlineShopping/admin/insertGood";
		goodForm.submit();
	}
	
	//自动执行显示结果
	window.onload = showInfos();
	
</script>
</head>
<body>
${updateGoodResult }

	<!-- 上传头像结果 -->
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
	
	<br/><br/><br/>
	商品信息管理：
	<form:form id="goodForm" modelAttribute="good"  method="post" enctype="multipart/form-data">
		商品Id：<form:input path="goodId" id="goodId"  value = "${goodId }"/>
		<button type="button" onclick="queryGoodInfo()">查询</button><br/><br/>
		<button type="button" onclick="deleteGood()">删除</button><br/><br/>
		名称：<form:input path="goodName" id="goodName" /><br/><br/>
		类型：<form:input path="goodType" id="goodType" /><br /><br />
		<!-- 如果商品的图片是默认的，则加载images下的defaultGoodPicture.jpg，
				否则加载uploads/goods下图片文件 -->
		<c:choose>
			<c:when test="${good.pictureSrc  == 'defaultGoodPicture.jpg'}">
				<c:set var="goodPicSrc">/images/defaultGoodPicture.jpg</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="goodPicSrc">/uploads/goodTypes/${typeId}/${good.pictureSrc }</c:set>
			</c:otherwise>
		</c:choose>

		<img alt="商品图片" src="<c:url value = '${goodPicSrc}'/>" />
		<input type="file" name="goodPic"/><br/>
		数量：<form:input path="amount" id="amount" /><br />	<br />
		单价：<form:input path="unitPrice" id="unitPrice" /><br />	<br />
		<button type="button" onclick="updateGoodInfo()">修改</button><br/><br/>	
		<button type="button" onclick="insertGood()">添加</button><br/><br/>	
	</form:form>
</body>
</html>
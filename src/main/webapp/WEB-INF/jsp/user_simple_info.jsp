<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${!empty loginedUser }">
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

		<span class="navbar-text pull-right"> <img alt="头像"
			class="img-circle" width="20px" height="20px"
			src="<c:url value = '/${userHeadSrc}'/>" /> &nbsp;&nbsp;
			${loginedUser.userName} ，你好&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="/OnlineShopping/user/logout">退出</a>
		</span>
	</c:if>
	<script type="text/javascript"
		src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
	<script>
		$('.img-circle').click(function () {
			window.location="/OnlineShopping/user/manage";
		})
		
		$('.img-circle').mouseover(function(){
			$(this).css("cursor","pointer");
		})
		
		$('.img-circle').mouseleave(function(){
			$(this).css("cursor","default");
		})
	</script>
</body>
</html>
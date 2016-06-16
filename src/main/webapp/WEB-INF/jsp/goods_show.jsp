<%@page import="tool.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pager"  tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 定义页面默认大小，如果URL直接输入没有大小的地址的话。 -->
	<c:set var="DEFAULT_PAGE_SIZE"> <%=Page.DEFAULT_PAGE_SIZE %></c:set>
	<!-- 遍历商品类型 -->
	商品分类：
	<c:forEach var="goodType" items="${goodTypes }">
		<!-- 如果页面大小用户已经设置，或其他改变，则使用之，否则使用默认大小：4 -->
		<a href="<c:url value ="/good/type/${goodType.typeId}/showGoods?pageNo=1&pageSize=${pageSize == null ? DEFAULT_PAGE_SIZE : pageSize }"/>" >${goodType.typeName }</a>&nbsp;
	</c:forEach>
	
	<!-- 遍历某类型下的分页商品 -->
	<c:forEach var="good" items="${goods }">
		<div>
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
			 
			<img alt="商品图片" src="<c:url value = '${goodPicSrc}'/>"/>
			<span>${good.goodName}</span>
		</div>
	</c:forEach>
	
	<pager:PageBar pageUrl="/good/type/${typeId }/showGoods" pageAttrKey="goodsPaged"></pager:PageBar>
</body>
</html>
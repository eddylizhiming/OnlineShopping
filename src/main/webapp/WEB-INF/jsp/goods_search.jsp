<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="pager"  tagdir="/WEB-INF/tags"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">

//显示搜索的结果
function showSearchResult()
{
	if ("${searchResult}" != null && "${searchResult}" != "")
	alert("${searchResult}");
}

//自动执行显示搜索商品结果
window.onload = showSearchResult();

</script>
</head>
<body>
	<h2>商品搜索结果</h2>
<!-- 遍历搜索到的分页商品 -->
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
	
	<pager:PageBar pageUrl="/good/searchGoods/" pageAttrKey="goodsPaged"></pager:PageBar>
</body>
</html>
<%@ page import="tool.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="pager"  tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">
	//！！！！符立明你来解决，获取选中的商品id，以及那一行文本框的值
	//，id值我放在了addToCar的button数组，把goodId，buyNum的值设置好。
	
	//添加到购物车
	function addToCar() {
		var goodId = "44";
		var buyNum = "222";
		$.post("/OnlineShopping/good/"+ goodId +"/addToCar", {
			buyNum : buyNum
		}, function(data) {
			//返回的添加情况，如"添加成功"等。
			alert(data);
		});
	}

</script>

</head>
<body>
	<!-- 搜索商品 -->
	<!-- 商品类型选择框。 -->
	<form id="searchForm" action="/OnlineShopping/good/searchGoods" method="post">
		<form:select id="goodTypes" path="goodType.typeId" items="${goodTypes}"
			itemLabel="typeName" itemValue="typeId">
		</form:select>
		<input type="text" id="goodCondition" name="goodCondition">
	</form>
	
	<button type="button" onclick="validAndSubmit()">搜索</button>
	
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
			<!-- 商品数量 -->
			<button name="minus" type="button">减</button>
			<input type="text" id="buyNum" name="buyNum"/>
			<button name="plus" type="button">加</button>
			<button name="addToCar[]" id="addToCar" type="button" value="${good.goodId }" onclick="addToCar()">添加到购物车</button>
			
		</div>
	</c:forEach>
	
	<pager:PageBar pageUrl="/good/type/${typeId }/showGoods" pageAttrKey="goodsPaged"></pager:PageBar>
	
	<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">

//数据验证及提交
function validAndSubmit() {
	//进行数据的验证，请在这里写代码
	//TDOO

	$('#searchForm').submit();
}

//显示搜索的结果
function showSearchResult()
{
	if ("${searchResult}" != null && "${searchResult}" != "")
	alert("${searchResult}");
}

//自动执行显示搜索商品结果
window.onload = showSearchResult();

$(document).ready(function(){
	var numberOfGood = $('<select ')
});

</script>
</body>
</html>
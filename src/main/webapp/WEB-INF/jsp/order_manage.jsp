<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<%@ taglib prefix="pager"  tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
<script type="text/javascript">
	
	//批量删除
	function batchDelete() {
		orderForm.action = "/OnlineShopping/order/batchDelete";
		orderForm.submit();
	}

	//批量更新
	function batchUpdate() {
		orderForm.action = "/OnlineShopping/order/batchUpdate";
		orderForm.submit();
	}
	//保存为Excel格式
	function saveAsExcel() {
	
		window.location = "/OnlineShopping/order/orderListExcel2";
	}
	//保存为PDF格式
	function saveAsPdf() {
		window.location = "/OnlineShopping/order/orderListPdf2";
	}
	
	//保存为XML格式
	function saveAsXml() {
		window.location = "/OnlineShopping/order/orderListXml2";
	}
</script>

</head>
<body>
	<!-- 遍历批量删除商品结果的信息 -->
	<c:forEach var="deleteInfo" items="${deleteInfos }">
				${deleteInfo }<br />
	</c:forEach>
	<form id="orderForm" method="post">
		<table border="1">
			<c:forEach var="order" items="${orders }">
				<tr>
					<td><input type="checkbox" name="selectIds"
						value="${order.orderId }" /></td>
					<td>${order.orderId }</td>
					<td>${order.userId }</td>
					<td><input type="text" value="${order.goodIds }" /></td>
					<td><input type="text" value="${order.amounts }" /></td>
					<td><input type="text" value="${order.total }" /></td>
					<td>${order.generateTime }</td>
					<td><input type="text" value="${order.status }" /></td>
				</tr>
			</c:forEach>
		</table>
		<button type="button" onclick="batchUpdate()">批量修改</button>
		<button type="button" onclick="batchDelete()">批量删除</button>
	</form>
	
	<!-- 查询商品表单 -->
	<form:form modelAttribute="order" action="/OnlineShopping/order/findOrders">
		订单编号<form:input path="orderId"/><br/><br/>
		用户Id：<form:input path="userId"/><br/><br/>
		商品编号列表：<form:input path="goodIds"/>请以逗号分隔<br/><br/>
		数量列表：<form:input path="amounts"/>请以逗号分隔<br/><br/>
		订单状态：<form:input path="status"/><br/>
		<input type="submit" value="查询">
	</form:form>
	
	<!-- 分页栏，获取list长度，如果没有订单，不显示分页栏 -->
	<c:if test="${fn:length(orders) > 0}">
		<pager:PageBar pageUrl="/order/manage" pageAttrKey="ordersPaged"></pager:PageBar>
	</c:if>
	<c:if test="${fn:length(orders) <= 0}">
		没有您要查询的商品
	</c:if>
	
	<button type="button" onclick="saveAsExcel()">保存为Excel</button>
	<button type="button" onclick="saveAsPdf()">显示或保存为PDF</button>
<!-- 	<button type="button" onclick="saveAsXml()">显示为XML</button>-->
	<a href="?content=xml" target="_blank">显示为XML</a>
	<a href="?content=json" target="_blank">显示或保存为JSON</a>
</body>
</html>
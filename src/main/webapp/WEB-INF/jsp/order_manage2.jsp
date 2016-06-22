<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="pager" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
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

	//将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
	(function($) {
		$.fn.serializeJson = function() {
			var jsonData1 = {};
			var serializeArray = this.serializeArray();
			alert(serializeArray);
			// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
			$(serializeArray).each(
					function() {
						if (jsonData1[this.name]) {
							if ($.isArray(jsonData1[this.name])) {
								jsonData1[this.name].push(this.value);
							} else {
								jsonData1[this.name] = [ jsonData1[this.name],
										this.value ];
							}
						} else {
							jsonData1[this.name] = this.value;
						}
					});
			// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
			var vCount = 0;
			// 计算json内部的数组最大长度
			for ( var item in jsonData1) {
				var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
						: 1;
				vCount = (tmp > vCount) ? tmp : vCount;
			}

			if (vCount > 1) {
				var jsonData2 = new Array();
				for (var i = 0; i < vCount; i++) {
					var jsonObj = {};
					for ( var item in jsonData1) {
						jsonObj[item] = jsonData1[item][i];
					}
					jsonData2.push(jsonObj);
				}
				return JSON.stringify(jsonData2);
			} else {
				return "[" + JSON.stringify(jsonData1) + "]";
			}
		};
	})(jQuery);

	function submitUserList_4() {

		var jsonStr = $("#form1").serializeJson();
		//console.log("jsonStr:\r\n" + jsonStr);
		//alert(jsonStr);
		$.ajax({
			url : "/OnlineShopping/order/batchUpdate",
			type : "POST",
			contentType : 'application/json;charset=utf-8', //设置请求头信息
			dataType : "json",
			data : jsonStr,
			success : function(data) {
				alert(data);
			},
			error : function(res) {
				alert(res.responseText);
			}
		});
	};
	/* 
	 $.ajax({
	 url: "D:/zq/submitUserList_4",
	 type: "POST",
	 contentType : 'application/json;charset=utf-8', //设置请求头信息
	 dataType:"json",
	 data: jsonStr,
	 success: function(data){
	 alert(data);
	 alert("ok");
	 },
	 error: function(res){
	
	 alert(res.responseText);
	 alert(url);
	 }
	 } );*/
</script>

</head>
<body>
	<!-- 遍历批量删除商品结果的信息 -->
	<c:forEach var="deleteInfo" items="${deleteInfos }">
				${deleteInfo }<br />
	</c:forEach>
	<!-- 遍历批量更新商品结果的信息 -->
	<c:forEach var="updateInfos" items="${updateInfos }">
				${updateInfos }<br />
	</c:forEach>
	<form id="orderForm" method="post">
		<table border="1" align="center">
			<c:forEach var="order" items="${orders }">
				<tr>
					<td><input type="checkbox" name="selectIds"
						value="${order.orderId }" /></td>
					<td>${order.orderId }</td>
					<td>${order.userId }</td>
					<td><input type="text" name="goodIds"
						value="${order.goodIds }" /></td>
					<td><input type="text" name="amounts"
						value="${order.amounts }" /></td>
					<td><input type="text" name="totalArray"
						value="${order.total }" /></td>
					<td>${order.generateTime }</td>
					<td><input type="text" name="statusArray"
						value="${order.status }" /></td>
					<!-- 设置隐藏域将所有的id发送过去，和选中的id进行比对 -->
				</tr>
				<input type="hidden" name="orderIds" value="${order.orderId }" />
			</c:forEach>
		</table>
		<button type="button" onclick="batchUpdate()">批量修改</button>
		<button type="button" onclick="batchDelete()">批量删除</button>
	</form>

	<!-- 查询商品表单 -->
	<form:form modelAttribute="order"
		action="/OnlineShopping/order/findOrders">
		订单编号<form:input path="orderId" />
		<br />
		<br />
		用户Id：<form:input path="userId" />
		<br />
		<br />
		商品编号列表：<form:input path="goodIds" />请以逗号分隔<br />
		<br />
		数量列表：<form:input path="amounts" />请以逗号分隔<br />
		<br />
		订单状态：<form:input path="status" />
		<br />
		<input type="submit" value="查询">
	</form:form>

	<!-- 分页栏，获取list长度，如果没有订单，不显示分页栏 -->
	<c:if test="${fn:length(orders) > 0}">
		<pager:PageBar pageUrl="/order/manage" pageAttrKey="ordersPaged"></pager:PageBar>
	</c:if>
	<c:if test="${fn:length(orders) <= 0}">
		没有您要查询的商品
	</c:if>
	<c:if test="${fn:length(orders)> 0}">
		<button type="button" onclick="saveAsExcel()">保存为Excel</button>
		<button type="button" onclick="saveAsPdf()">显示或保存为PDF</button>
		<!-- 	<button type="button" onclick="saveAsXml()">显示为XML</button>-->
		<a href="?content=xml" target="_blank">显示为XML</a>
		<a href="?content=json" target="_blank">显示或保存为JSON</a>

		<button type="button" onclick="submitUserList_4()">测试格式化Jason</button>
	</c:if>
</body>
</html>
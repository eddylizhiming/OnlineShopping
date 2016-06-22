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
<link
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">

<style>
body {
	overflow-y: hidden;
}

#queryForm {
	left: 50%;
	top: 50%;
	width: 400px;
	height: 360px;
	z-index: 9999;
}

.form-group {
	margin-top: 20px;
}

.col-sm-12 img, #queryForm, table, #orderForm, .page-bar, button,
	#buttonGroup {
	position: absolute;
}

.col-sm-12 {
	background-image:
		url("http://img1.ph.126.net/7z_KVVOqCG-7md70mOPAfQ==/6631569143001149038.jpg");
	background-size: cover;
}

th {
	text-align: center;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${loginedUser.headScul  == 'defaultHead.jpg'}">
			<c:set var="userHeadSrc">images/defaultHead.jpg</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="userHeadSrc">uploads/${loginedUser.userId}/${loginedUser.headScul }</c:set>
		</c:otherwise>
	</c:choose>
	<div class="col-sm-12">
		<span>&nbsp;</span> <img alt="头像" class="img-circle" width="120px"
			height="120px" src="<c:url value = '/${userHeadSrc}'/>" />
	</div>


	<div id="queryForm" class="draggable ui-widget-content">
		<!-- 查询商品表单 -->
		<form:form modelAttribute="order"
			action="/OnlineShopping/order/findOrders" role="form"
			class="form-horizontal" id="readQueryForm">
			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-3 control-label">订单编号：</label>
				<div class="col-sm-5">
					<form:input path="orderId" class="form-control" />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-3 control-label">用户Id：</label>
				<div class="col-sm-5">
					<form:input path="userId" class="form-control" />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-3 control-label">商品编号：</label>
				<div class="col-sm-5">
					<form:input path="goodIds" placeholder="请以逗号分隔"
						class="form-control" />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-3 control-label">数量：</label>
				<div class="col-sm-5">
					<form:input path="amounts" placeholder="请以逗号分隔"
						class="form-control" />
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-3 control-label">订单状态：</label>
				<div class="col-sm-5">
					<form:input path="status" class="form-control" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-8">
					<button type="button" class="btn btn-default btn-lg btn-block"
						id="queryButton">查询</button>
				</div>
			</div>
		</form:form>
	</div>


	<!-- 遍历批量删除商品结果的信息 -->
	<c:forEach var="deleteInfo" items="${deleteInfos }">
    ${deleteInfo }<br />
	</c:forEach>
	<!-- 遍历批量更新商品结果的信息 -->
	<c:forEach var="updateInfos" items="${updateInfos }">
	${updateInfos }<br />
	</c:forEach>

	<form id="orderForm" method="post">
		<div class="form-group">
			<div class="col-sm-offset-1 col-sm-10">
				<table border="1" class="table" align="center">
				<c:if test="${fn:length(orders) > 0}">
					<thead>
						<tr>
							<th></th>
							<th>订单号</th>
							<th>用户ID</th>
							<th>商品编号</th>
							<th>数量</th>
							<th>单价</th>
							<th>生成订单时间</th>
							<th>订单状态</th>
							</tr>
						</thead>
					</c:if>
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
			</div>
		</div>
	</form>


	<!-- 分页栏，获取list长度，如果没有订单，不显示分页栏 -->
	<c:if test="${fn:length(orders) > 0}">
		<pager:PageBar pageUrl="/order/manage" pageAttrKey="ordersPaged"></pager:PageBar>
	</c:if>

	<c:if test="${fn:length(orders) > 0}">
	<div id="buttonGroup">
		<div class="btn-group">
			<button type="button" onclick="batchUpdate()" class="btn btn-default">批量修改</button>
			<button type="button" onclick="batchDelete()" class="btn btn-default">批量删除</button>
		</div>

		<div class="btn-group">
			<button type="button" onclick="saveAsExcel()" class="btn btn-default">保存为Excel</button>
			<button type="button" onclick="saveAsPdf()" class="btn btn-default">显示或保存为PDF</button>
		</div>

		<div class="btn-group">
			<a href=" ?content=xml" target="_blank" class="btn btn-default">显示为XML</a>
			<a href="?content=json" target="_blank" class="btn btn-default">显示或保存为JSON</a>
		</div>
	</div>
	</c:if>

	<script type="text/javascript"
		src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script
		src="http://apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
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
				// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
				$(serializeArray).each(
						function() {
							if (jsonData1[this.name]) {
								if ($.isArray(jsonData1[this.name])) {
									jsonData1[this.name].push(this.value);
								} else {
									jsonData1[this.name] = [
											jsonData1[this.name], this.value ];
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
			alert("ok");

			var jsonStr = $("#orderForm").serializeJson();
			//console.log("jsonStr:\r\n" + jsonStr);
			alert(jsonStr);
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

		function locate() {
			//撑开col-sm-12
			$('.col-sm-12').css('background-size', '100% 300px');
			$('.col-sm-12 span').css('line-height', '300px');

			//头像居中
			putThisCenter('.col-sm-12 img');

			//表格居中
			var sum = 0;
			for (i = 0; i < 8; i++) {
				sum += parseInt($('th').eq(i).css('width'));
			}
			$('#orderForm').css('left', ($(window).width() - sum) / 2);
			$('#orderForm').css('top', 320);
			$('.page-bar').css('top',
					parseInt($('#orderForm').css('top')) + 354);
			$('.page-bar').css('left',
					($(window).width() - $('.page-bar').width()) / 2);

			//定位button
			$('#buttonGroup').css('top',
					parseInt($('.page-bar').css('top')) + 40);
			$('#buttonGroup').css('left',
					($(window).width() - $('#buttonGroup').width()) / 2);
			$('.btn-group').css('margin-right', 10);
		}

		$(window).load(function() {
			locate();
		});

		$(document).ready(function() {
			locate();
			if ("${fn:length(orders)}" <= 0)
			{
				alert("没有您要查询的商品");
				window.location="/OnlineShopping/order/manage";
			}
		});

		$(window).resize(function() {
			locate();
		});

		$(function() {
			$("#queryForm").resizable({
				maxHeight : 400,
				maxWidth : 800,
				minHeight : 360,
				minWidth : 400
			});
			$("#queryForm").draggable({
				containment : "body",
				scroll : false
			});
			$("#queryForm").draggable({
				cursor : "move",
				cursorAt : {
					top : $('#queryForm').height() / 2,
					left : $('#queryForm').width() / 2
				}
			});
		});

		function putThisCenter(Element) {
			var elementWidth = $(Element).width();
			var parentWidth = $(Element).parent().width();
			var elementHeight = $(Element).height();
			var parentHeight = $(Element).parent().height();
			$(Element).css({
				'left' : parentWidth * 0.5 - elementWidth / 2,
				'top' : parentHeight * 0.7 - elementHeight / 2
			});
		}

		$('#queryButton').click(function() {

			readQueryForm.submit();
		})
	</script>
</body>
</html>
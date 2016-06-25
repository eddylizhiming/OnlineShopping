<%@page import="domain.Good"%>
<%@page import="service.GoodService"%>
<%@page import="service.ShoppingCarService"%>
<%@page import="service.ShoppingCarServiceImpl"%>
<%@page import="domain.User"%>
<%@page import="java.util.List"%>
<%@page import="domain.ShoppingCar"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="http://apps.bdimg.com/libs/fontawesome/4.4.0/css/font-awesome.min.css"
	rel="stylesheet">
<style>
th {
	text-align: center;
}


</style>
</head>
<body>
	<div class="row" style="margin-top:10px;margin-bottom:10px">
		<div class="text-center">
			<i class="fa fa-cart-arrow-down fa-2x" aria-hidden="true">&nbsp;&nbsp;购物车信息</i>
		</div>
	</div>

	<%
		//在JSP中调用Service的方法。
		ServletContext servletContext = this.getServletContext();
		ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContext);
		//获取Service bean
		ShoppingCarService shoppingCarService = (ShoppingCarService) applicationContext
				.getBean("shoppingCarService");

		GoodService goodService = (GoodService) applicationContext.getBean("goodService");
		User user = (User) request.getSession().getAttribute("loginedUser");
		
		if (user != null) {
			String userId = user.getUserId();
			//获取用户购物车信息
			List<ShoppingCar> shoppingCars = shoppingCarService.getUserShoppingCar(userId);
			request.setAttribute("shoppingCars", shoppingCars);
		}
	%>

	<div class="row  table-responsive">
		<!-- 用户购物车信息 -->
		<table class="table col-sm-offset-1 col-sm-10">
			<thead>
				<tr>
					<th>商品ID</th>
					<th>商品名称</th>
					<th>商品单价</th>
					<th>商品数量</th>
					<th>总价</th>
				</tr>
			</thead>
			<c:forEach var="shoppingCar" items="${shoppingCars }">
				<!-- 必须设置范围为request，否则request后面取不到值 -->
				<c:set var="goodId" value="${shoppingCar.goodId }" scope="request" />
				<%
					//通过商品id查找商品其他信息
						String goodId = (String) request.getAttribute("goodId");
						Good good = goodService.findGoodById(goodId);
						request.setAttribute("goodName", good.getGoodName());
						request.setAttribute("unitPrice", good.getUnitPrice());
				%>
				<tr align="center">
					<td>${shoppingCar.goodId }</td>
					<td>${goodName }</td>
					<td>${unitPrice }</td>
					<td><input type="text" value="${shoppingCar.amount }"
						style="text-align: center" onchange="calculate(this)"></td>
					<!-- 保留两位小数 -->
					<td class="total"><fmt:formatNumber type="number"
							value="${shoppingCar.amount * unitPrice }" pattern="0.00"
							maxFractionDigits="2" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div class="row">
		<div class="col-sm-offset-3 col-sm-6">
			<button type="button" class="btn btn-default btn-lg btn-block"
				id="total">总价：</button>
		</div>
	</div>

	<div class="row" style="margin-top: 20px">
		<div class="col-sm-offset-3 col-sm-6">
			<button type="button" class="btn btn-primary btn-lg btn-block" id="pay">去付款</button>
		</div>
	</div>

	<script type="text/javascript"
		src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script>
		function calculate(Element) {
			var unitPrice = $(Element).parent().prev().text();
			var total = unitPrice * parseInt($(Element).val());
			
			$(Element).parent().next().text(total.toFixed(2));
			var t = 0;
			$.each($('.total'), function() {
				t += parseFloat($(this).text()); //this指向当前属性的值
			});

			$('#total').text("总价：" + t.toFixed(2));
		}
		
		$('#pay').click(function(){
			var t = 0;
			$.each($('.total'), function() {
				t += parseFloat($(this).text()); //this指向当前属性的值
			});
			$('#total').text("总价：" + t.toFixed(2));
		})
		
		
		function windowReload(){
			window.location.reload();
		}
		
	</script>
</body>
</html>
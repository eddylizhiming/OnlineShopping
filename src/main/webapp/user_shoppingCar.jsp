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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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

	<!-- 用户购物车信息 -->
	<table>
		<c:forEach var="shoppingCar" items="${shoppingCars }">
			<!-- 必须设置范围为request，否则request后面取不到值 -->
			<c:set var="goodId" value="${shoppingCar.goodId }" scope="request" />
			<%
				//通过商品id查找商品其他信息
				out.println(request.getAttribute("goodId"));
				String goodId = (String) request.getAttribute("goodId");
				Good good = goodService.findGoodById(goodId);
				request.setAttribute("goodName", good.getGoodName());
				request.setAttribute("unitPrice", good.getUnitPrice());
			%>
			<tr>
				
				<td>${shoppingCar.goodId }</td>
				<td>${goodName }</td>
				<td>${unitPrice }</td>
				<td>${shoppingCar.amount }</td>
				<!-- 保留两位小数 -->
				<td><fmt:formatNumber type="number" value="${shoppingCar.amount * unitPrice }" pattern="0.00" maxFractionDigits="2"/>  </td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
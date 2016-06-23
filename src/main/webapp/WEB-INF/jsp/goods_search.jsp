<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pager" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<style>
#userHead {
	background-image:
		url(/OnlineShopping/images/searchGoodBackground.jpg);
	background-size: cover;
}

#userHead img, .container{
	position: absolute;
}

.container {
	width: 70%;
	border-left: medium solid #ccc;
	border-top: medium solid #ccc;
	border-right: medium solid #ccc;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.row,.thumbnail{
	margin-top:15px
}

</style>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse"
                data-target="#example-navbar-collapse">
            <span class="sr-only">切换导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">shopping</a>
    </div>
    <div class="collapse navbar-collapse" id="example-navbar-collapse">
        <ul class="nav navbar-nav">
            <li><a href="/OnlineShopping/user/index">主页</a></li>
            <li><a href="/OnlineShopping/user/manage">用户管理</a></li>
            <li><a href="/OnlineShopping/order/manage">订单管理</a></li>
            <li class="active"><a href="#">商品信息</a></li>
        </ul>
		
		<c:choose >
		    <c:when test="${empty loginedUser }">
		          <a href="#" data-toggle="modal" data-target="#myModal2" class="navbar-text pull-right" id="register"><spring:message code="register"/></a>
	        <a href="#" data-toggle="modal" data-target="#myModal1" class="navbar-text pull-right" id="login"><spring:message code="login"/></a>
		    </c:when>
		    <c:otherwise>
	     		<c:import url="user_simple_info.jsp"/>
       </c:otherwise>
       </c:choose>
    </div>
</nav>
	<c:choose>
		<c:when test="${loginedUser.headScul  == 'defaultHead.jpg'}">
			<c:set var="userHeadSrc">images/defaultHead.jpg</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="userHeadSrc">uploads/${loginedUser.userId}/${loginedUser.headScul }</c:set>
		</c:otherwise>
	</c:choose>
	<div class="col-sm-12" id="userHead">
		<span>&nbsp;</span> <img alt="头像" class="img-circle" width="120px"
			height="120px" src="<c:url value = '/${userHeadSrc}'/>" />
	</div>

	<div class="container">
		<!-- 遍历搜索到的分页商品 -->
		<c:forEach var="good" items="${goods }">
			<div class="col-sm-6 col-md-3">
				<div class="thumbnail">
					<div class="caption">
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
						<img alt="商品图片" src="<c:url value = '${goodPicSrc}'/>" class="img-responsive"/>
						<div class="row">
							<p class="text-center">${good.goodName}</p>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
		
		<div class="row">
		<div class="col-sm-12 text-center">
		<c:if test="${fn:length(goods) > 0}">
			<pager:PageBar pageUrl="/good/searchGoods/" pageAttrKey="goodsPaged"></pager:PageBar>
		</c:if>
		</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
	<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		//显示搜索的结果
		function showSearchResult() {
			if ("${searchResult}" != null && "${searchResult}" != "")
				alert("${searchResult}");
		}

		//自动执行显示搜索商品结果
		window.onload = showSearchResult();

		var documentHeight = $(document).height();
		function locate() {
			//撑开col-sm-12
			$('.col-sm-12').css('background-size', '100% 300px');
			$('.col-sm-12 span').css('line-height', '300px');

			//头像居中
			putThisCenter('.col-sm-12 img');

			//container定位
			$(".container").css({
				'height' : documentHeight,
				'top' : 320,
				'left' : '15%'
			});
		}

		$(document).ready(function() {
			locate();
		});

		$(window).load(function() {
			locate();
		});

		$(window).resize(function() {
			locate();
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
	</script>

</body>
</html>
<%@ page import="tool.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pager" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="http://apps.bdimg.com/libs/fontawesome/4.4.0/css/font-awesome.min.css"
	rel="stylesheet">
<style>
.col-sm-12 {
	background-image: url(/OnlineShopping/images/showGoodBackground.png);
	background-size: cover;
}

.col-sm-12 img, .container, .page-bar {
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

.form-group {
	margin-top: 30px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#example-navbar-collapse">
			<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">shopping</a>
	</div>
	<div class="collapse navbar-collapse" id="example-navbar-collapse">
		<ul class="nav navbar-nav">
			<li><a href="/OnlineShopping/user/index">主页</a></li>
			<li><a href="/OnlineShopping/user/manage">用户管理</a></li>
			<li><a href="/OnlineShopping/order/manage">订单管理</a></li>
			<li class="active"><a href="#">商品信息</a></li>
			<li><a data-toggle="modal" data-target="#myModal3" id="watchCar">查看购物车</a></li>
		</ul>

		<c:choose>
			<c:when test="${empty loginedUser }">
				<a href="#" data-toggle="modal" data-target="#myModal2"
					class="navbar-text pull-right" id="register"><spring:message
						code="register" /></a>
				<a href="#" data-toggle="modal" data-target="#myModal1"
					class="navbar-text pull-right" id="login"><spring:message
						code="login" /></a>
			</c:when>
			<c:otherwise>
				<c:import url="user_simple_info.jsp" />
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
	<div class="col-sm-12">
		<span>&nbsp;</span> <img alt="头像" class="img-circle" width="120px"
			height="120px" src="<c:url value = '/${userHeadSrc}'/>" />
	</div>

	<div class="container">
		<!-- 搜索商品 -->
		<!-- 商品类型选择框。 -->
		<form id="searchForm" action="/OnlineShopping/good/searchGoods"
			method="post" role="form" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label"> <form:select
						id="goodTypes" path="goodType.typeId" items="${goodTypes}"
						itemLabel="typeName" itemValue="typeId">
					</form:select>
				</label>
				<div class="col-sm-6">
					<input type="text" id="goodCondition" name="goodCondition"
						class="form-control" placeholder="请根据商品的类型或ID来搜索">
				</div>
				<div class="col-sm-3">
					<button type="button" onclick="validAndSubmit()"
						class="btn btn-link">搜索</button>
				</div>
			</div>
		</form>


		<div class="row text-center" style="margin-bottom: 10px">
			<!-- 定义页面默认大小，如果URL直接输入没有大小的地址的话。 -->
			<c:set var="DEFAULT_PAGE_SIZE">
				<%=Page.DEFAULT_PAGE_SIZE%></c:set>
			<!-- 遍历商品类型 -->
			<label class="col-sm-3 text-right">商品分类：</label>
			<c:forEach var="goodType" items="${goodTypes }">
				<!-- 如果页面大小用户已经设置，或其他改变，则使用之，否则使用默认大小：4 -->
				<a class="col-sm-3"
					href="<c:url value ="/good/type/${goodType.typeId}/showGoods?pageNo=1&pageSize=${pageSize
            == null ?
            DEFAULT_PAGE_SIZE : pageSize }"/>">${goodType.typeName }</a>&nbsp;
        </c:forEach>
		</div>

		<div class="row">
			<!-- 遍历某类型下的分页商品 -->
			<c:forEach var="good" items="${goods }">
				<div class="col-sm-6 col-md-3">
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
					<div class="thumbnail">
						<img alt="商品图片" src="<c:url value = '${goodPicSrc}'/>" />
						<div class="caption">
							<div class="row">
								<p class="text-center">${good.goodName}</p>
							</div>
							<div class="row">
								<div class="col-sm-offset-2 col-sm-8">
									<input type="text" id="buyNum" name="buyNum"
										style="width: 100%; text-align: center" />
								</div>
							</div>
							<div class="row">
								<div class="btn-group col-sm-offset-1 col-sm-10">
									<button name="minus" type="button" class="btn btn-link"
										style="width: 50%" onclick="minusFunc(this)">
										<i class="fa fa-arrow-circle-o-down fa-2x"></i></a>
										<button name="plus" type="button" class="btn btn-link"
											id="plus" style="width: 50%" onclick="plusFunc(this)">
											<i class="fa fa-arrow-circle-o-up fa-2x"></i>
										</button>
								</div>
							</div>
							<div class="row" style="margin-top: 10px">
								<div class="col-sm-offset-1 col-sm-10">
									<button name="addToCar[]" id="addToCar" type="button"
										value="${good.goodId }" onclick="addToCar(this)"
										class="btn btn-default btn-lg btn-block">
										<i class="fa fa-cart-plus"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<!-- 如果查询出来才会显示分页栏 -->
		<c:if test="${fn:length(goodTypes) > 0}">
			<pager:PageBar pageUrl="/good/type/${typeId }/showGoods"
				pageAttrKey="goodsPaged"></pager:PageBar>
		</c:if>


		<!-- 模态框（Modal）购物车 -->
		<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">
							购物车
						</h4>
					</div>
					<div class="modal-body">
						<iframe src="/OnlineShopping/user/shoppingCar"
							frameborder="no" border="0" marginwidth="0" marginheight="0"
							scrolling="no" allowtransparency="yes" id="iframepage"
							width="100%" height="400px")></iframe>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<script type="text/javascript"
			src="<c:url value = '/resourceRoot/jquery/jquery.js'/>"></script>
		<script
			src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			//！！！！符立明你来解决，获取选中的商品id，以及那一行文本框的值
			//id值我放在了addToCar的button数组，把goodId，buyNum的值设置好。

			//添加到购物车
			function addToCar(Element) {
				
				var goodId = $(Element).attr('value');
				var buyNum = $(Element).parent().parent().prev()
						.prev().find('#buyNum');
				
				if(buyNum.val() == "" || parseInt(buyNum.val()) < 1)
				{
					alert("数量不能小于1或空");
					return;
				}
				
				$.post("/OnlineShopping/good/" + goodId + "/addToCar", {
					buyNum : parseInt(buyNum.val())
				}, function(data) {
					//返回的添加情况，如"添加成功"等。
					alert(data);
				});
			}

			//数据验证及提交
			function validAndSubmit() {
				//进行数据的验证，请在这里写代码
				//TDOO

				$('#searchForm').submit();
			}

			//显示搜索的结果
			function showSearchResult() {
				if ("${searchResult}" != null && "${searchResult}" != "")
					alert("${searchResult}");
			}

			//自动执行显示搜索商品结果
			window.onload = showSearchResult();

			$(document).ready(function() {
				var numberOfGood = $('<select ')
			});

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

				//page-bar居中
				$('.page-bar').css('left',
						($('.container').width() - $('.page-bar').width()) / 2);
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

			function minusFunc(Element) {

				var buyNum = $(Element).parent().parent().prev()
						.find('#buyNum');
				if ($(buyNum).val() == "" || parseInt($(buyNum).val()) < 1) {
					alert('商品数量不能小于0或空');
					return;
				}
				var newValue = parseInt($(buyNum).val()) - 1;
				$(buyNum).val(newValue);
			};

			function plusFunc(Element) {
				var buyNum = $(Element).parent().parent().prev()
						.find('#buyNum');
				if ($(buyNum).val() == "" || parseInt($(buyNum).val()) < 0) {
					$(buyNum).val("1");
					return;
				}
				var newValue = parseInt($(buyNum).val()) + 1;
				$(buyNum).val(newValue);
			};
			
			$('#watchCar').click(function(){
				 document.getElementById("iframepage").contentWindow.windowReload();
			})
		</script>
</body>
</html>
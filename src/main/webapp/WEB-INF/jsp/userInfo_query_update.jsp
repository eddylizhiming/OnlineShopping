<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        .col-sm-12 {
            background-image: url(/OnlineShopping/images/userInfoBackground.jpg);
            background-size: cover;
        }

        .col-sm-12 img, .container {
            position: absolute;
        }

        .container {
            width: 70%;
            border-left: medium solid #8393c6;
            border-top: medium solid #8393c6;
            border-right: medium solid #8393c6;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .form-group {
            margin-top: 30px;
        }

        .newEmailAndCaptcha,#resendButton {
            display: none;
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
            <li class="active"><a href="#">用户管理</a></li>
            <li><a href="/OnlineShopping/order/manage">订单管理</a></li>
            <li><a href="/OnlineShopping/good/type/1/showGoods">商品信息</a></li>
            <li><a data-toggle="modal" data-target="#myModal3">查看购物车</a></li>
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
<!-- 如果用户的头像是默认的，则加载images下的defaultHead.jpg，
    否则加载uploads下的用户文件夹下的上传的头像文件 -->
<c:choose>
    <c:when test="${loginedUser.headScul  == 'defaultHead.jpg'}">
        <c:set var="userHeadSrc">images/defaultHead.jpg</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="userHeadSrc">uploads/${loginedUser.userId}/${loginedUser.headScul }</c:set>
    </c:otherwise>
</c:choose>
<div class="col-sm-12">
    <span>&nbsp;</span>
    <img alt="头像" class="img-circle" width="120px" height="120px" src="<c:url value = '/${userHeadSrc}'/>"/>
</div>


<!-- 必须设置button的类型，否则会在除IE的浏览器自动提交表单 -->
<!-- 用户名无法修改，从session中获取已经登录用户的信息-->
<div class="container">
    <form id="userInfo" name="userInfo" method="post" role="form" class="form-horizontal">

        <div class="form-group">
            <label class="col-sm-3 control-label">用户名：
            </label>
            <div class="col-sm-6">
                <input type="text" name="userId" disabled="disabled" value="${sessionScope.loginedUser.userId }"
                       class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 昵称：
            </label>
            <div class="col-sm-6">
                <input type="text" name="userName" value="${sessionScope.loginedUser.userName }" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">可用余额：
            </label>
            <div class="col-sm-6">
                <input type="text" name="balance" disabled="disabled" value="${sessionScope.loginedUser.balance }"
                       class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">邮箱：
            </label>
            <div class="col-sm-6">
                <input type="text" id="receiveAddress" name="email" value="${sessionScope.loginedUser.email }"
                       disabled="disabled" class="form-control"/>
            </div>
            <div class="col-sm-3">
                <button type="button" onclick="sendVerifyEmail()" class="btn btn-link" id="sendButton">发送</button>
            </div>
        </div>

        <div class="newEmailAndCaptcha">
            <div class="form-group">
                <label class="col-sm-3 control-label">验证码：
                </label>
                <div class="col-sm-6">
                    <input type="text" name="emailCaptcha" class="form-control" maxlength="6" id="emailCaptcha">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">新邮箱：
                </label>
                <div class="col-sm-6">
                    <input type="text" name="newEmailAddress" class="form-control" id="newEmailAddress">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-6">
                    <button type="button" class="btn btn-default btn-lg btn-block" id="resendButton">
                        重新发送
                    </button>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-6">
                    <button type="button" class="btn btn-default btn-lg btn-block" id="closeButton">
                        关闭
                    </button>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" class="btn btn-default btn-lg btn-block" onclick="validAndSubmit()">
                    修改
                </button>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" class="btn btn-default btn-lg btn-block" id="manageButton">
                    头像请您在主界面修改
                </button>
            </div>
        </div>
    </form>
</div>

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
					<iframe  src="/OnlineShopping/user/shoppingCar" frameborder="no"
						border="0" marginwidth="0" marginheight="0" scrolling="no"
						allowtransparency="yes" id="iframepage" width="100%" 

height="400px")></iframe>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
<!-- resourceRoot是在XML中配置的逻辑路径 -->
<script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript">

    function validAndSubmit() {
        //写验证数据的代码。。
        if ($('#sendButton').text() != "发送") {
            var checkCaptcha = /^[0-9]{6}$/;
            if (checkCaptcha.test($('#emailCaptcha').val()) == false) {
                alert('验证码是6个数字哦');
                return;
            }

            if (isEmail($('#newEmailAddress').val()) == false) {
                alert('请输入正确的邮箱');
                return;
            }
            
            
        }

        userInfo.action = "/OnlineShopping/user/manage/operUserInfo";
        $("#userInfo").submit();

    }

    function isEmail(str) {
        var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        return reg.test(str);
    }

    //发送验证验证码邮件，并告知用户发送情况
    function sendVerifyEmail() {
        if ($('#sendButton').text() == "发送") {
            $('.newEmailAndCaptcha').fadeIn();
            $.post("/OnlineShopping/user/manage/sendEmail", {
                receiveAddress: $("#receiveAddress").val()
            }, function (data) {
                //返回的发送情况，如"发送成功"等。
                alert(data);
                if (data == "发送失败") {
                    $('#resendButton').fadeIn();
                }else{
                    $('#resendButton').fadeOut();
                }
            });
        }

    }

    $('#closeButton').click(function(){
        $('.newEmailAndCaptcha').fadeOut();
        $('#sendButton').text("发送");
    });

    function locate() {
        //撑开col-sm-12
        $('.col-sm-12').css('background-size', '100% 300px');
        $('.col-sm-12 span').css('line-height', '300px');

        //头像居中
        putThisCenter('.col-sm-12 img');

        //container定位
        $(".container").css({'height': $(window).height() - 310, 'top': 320, 'left': '15%'});
    }

    $(document).ready(function () {
        locate();
        if ("${updateInfoResult}" != null && "${updateInfoResult}" != "")
            alert('${updateInfoResult}');
    });


    $(window).resize(function () {
        locate();
    });

    function putThisCenter(Element) {
        var elementWidth = $(Element).width();
        var parentWidth = $(Element).parent().width();
        var elementHeight = $(Element).height();
        var parentHeight = $(Element).parent().height();
        $(Element).css({
            'left': parentWidth * 0.5 - elementWidth / 2,
            'top': parentHeight * 0.7 - elementHeight / 2
        });
    }

    $('#manageButton').click(function () {
        window.location = "/OnlineShopping/user/manage";
    });

</script>
</body>
</html>
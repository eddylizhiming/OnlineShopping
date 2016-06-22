<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
            rel="stylesheet">

    <style>
        .carousel, .container {
            width: 100%;
            padding: 0;
        }

        .carousel, .controlIcon, .container,p {
            position: absolute;
        }

        .container .col-sm-6 {
            background-image: url("http://img2.ph.126.net/PRk3BXbJlQYXjgUeILjRNg==/4856569248267458660.png");
            background-size: cover;
        }

        hr {
            position: absolute;
            left: 5%;
        }

		#coverImage {
            display: none;
            position: absolute;
        }

        .filterEffects {
            animation: myfirst 3s;
            animation-delay: 1.5s;
        }

        @keyframes myfirst {

            from {
                filter: brightness(1) blur(0px);

            }

            to {
                filter: brightness(.8) blur(2px);
            }

        }

        .filter {
            filter: brightness(.8) blur(2px);
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
        <a class="navbar-brand" href="#">W3Cschool</a>
    </div>
    <div class="collapse navbar-collapse" id="example-navbar-collapse">
        <ul class="nav navbar-nav">
            <li class="active"><a href="#">iOS</a></li>
            <li><a href="#">SVN</a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    Java <b class="caret"></b>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">jmeter</a></li>
                    <li><a href="#">EJB</a></li>
                    <li><a href="#">Jasper Report</a></li>
                    <li class="divider"></li>
                    <li><a href="#">分离的链接</a></li>
                    <li class="divider"></li>
                    <li><a href="#">另一个分离的链接</a></li>
                </ul>
            </li>
        </ul>

        <a href="#" data-toggle="modal" data-target="#myModal2" class="navbar-text pull-right" id="register"><spring:message code="register"/></a>
        <a href="#" data-toggle="modal" data-target="#myModal1" class="navbar-text pull-right" id="login"><spring:message code="login"/></a>
    </div>
</nav>

<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="http://img1.ph.126.net/7z_KVVOqCG-7md70mOPAfQ==/6631569143001149038.jpg" alt="First slide">
            <div class="carousel-caption"><spring:message code="Carousel1"/></div>
        </div>
        <div class="item">
            <img src="http://img1.ph.126.net/7z_KVVOqCG-7md70mOPAfQ==/6631569143001149038.jpg" alt="Second slide">
            <div class="carousel-caption"><spring:message code="Carousel2"/></div>
        </div>
        <div class="item">
            <img src="http://img1.ph.126.net/7z_KVVOqCG-7md70mOPAfQ==/6631569143001149038.jpg" alt="Third slide">
            <div class="carousel-caption"><spring:message code="Carousel3"/></div>
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <span class="carousel-control left" href="#myCarousel"
          data-slide="prev">
        <a class="controlIcon">&lsaquo;</a>
    </span>
    <span class="carousel-control right" href="#myCarousel"
          data-slide="next">
        <a class="controlIcon">&rsaquo;</a>
    </span>
</div>

<div class="container">
    <div class="col-sm-6"><span>&nbsp;</span></div>
    <div class="col-sm-6"><span>&nbsp;</span></div>
    <div class="col-sm-6"><span>&nbsp;</span></div>
    <div class="col-sm-6"><span>&nbsp;</span></div>
</div>

<hr size="1" width="90%" color="#000">
<p><spring:message code="footer"/></p>
<img src="http://img1.ph.126.net/7z_KVVOqCG-7md70mOPAfQ==/6631569143001149038.jpg" id="coverImage" class="filterEffects" style="z-index: 99999">


</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"><spring:message code="login"/></h4>
            </div>
            <div class="modal-body">
                <!-- 登录表单 -->
                <form:form modelAttribute="user" role="form" name="loginForm" 
                           class="form-horizontal" method="post">
                    <div class="form-group" id="userIdGroup">
                        <label class="col-sm-3 control-label"><spring:message code="userId"/></label>
                        <div class="col-sm-6">
                        	<c:set var="userIdNote"><spring:message code='userIdNote'/></c:set>
                            <form:input id="userId" path="userId"
                                        value="${request.user.userId }" class="form-control"
                                        placeholder="${userIdNote }"/>
                        </div>
                    </div>

                    <div class="form-group" id="passwordGroup">
                        <label class="col-sm-3 control-label"><spring:message code="password"/></label>
                        <div class="col-sm-6">
                        <c:set var="passwordNote"><spring:message code='passwordNote'/></c:set>
                            <form:password id="password" path="password"
                                           class="form-control" placeholder="${passwordNote }"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <div class="checkbox">
                                <label class="control-label"> <input type="checkbox"
                                                                     name="isRememberPwd"/><spring:message code="RememberMe"/>
                                </label>
                            </div>
                            <label class="control-label"> <select
                                    name="rememberd_days">
                                <option value="1"><spring:message code="ADay"/></option>
                                <option value="7"><spring:message code="AWeek"/></option>
                                <option value="30"><spring:message code="AMonth"/></option>
                            </select>
                            </label>
                        </div>
                    </div>


                    <div class="form-group" id="captchaGroup">
                        <label class="col-sm-3 control-label"><spring:message code="Captcha"/></label>
                        <div class="col-sm-3">
                            <input id="captcha" name="captcha" type="text"
                                   class="form-control" maxlength="4"/>
                        </div>
                        <div class="col-sm-3">
                            <img src="/OnlineShopping/user/createCode?<%=Math.random()%>"
                                 id="code" onclick="changeCode(this)" class="img-responsive"/>
                        </div>
                        <div class="col-sm-3">
                            <label id="checkResult" class="control-label">请填写验证码</label>
                        </div>
                    </div>
                </form:form>
                <span id="loginError">${loginError}</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="close"/>
                </button>
                <button type="button" class="btn btn-primary" id="loginButton">
           			<spring:message code="login"/>
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>

<!--注册表单 -----------------------------------------------------  -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel"> <spring:message code="register"/></h4>
            </div>
            <div class="modal-body">
                <!-- 注册表单 -->
                <form:form modelAttribute="regUser" role="form"
                           class="form-horizontal" id="registerForm">
                    <div class="form-group" id="ruserIdGroup">
                        <label class="col-sm-3 control-label"><spring:message code="userId"/></label>
                        <div class="col-sm-6">
                            <form:input id="ruserId" path="userId"
                                        value="${request.user.userId }" class="form-control"/>
                            <form:errors path="userId"/>
                        </div>
                        <div class="col-sm-3">
                                <label class="control-label" id="iconToDetermine"> <span></span>
                                </label>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-3 control-label"><spring:message code="nickname"/></label>
                        <div class="col-sm-6">
                            <form:input id="userName" path="userName"
                                        value="${request.user.userName }" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group" id="rpasswordGroup">
                        <label class="col-sm-3 control-label"><spring:message code="password"/></label>
                        <div class="col-sm-6">
                            <form:password id="rpassword" path="password"
                                           class="form-control"/>
                            <form:errors path="password"/>
                        </div>
                    </div>

                    <div class="form-group" id="confirmPasswordGroup">
                        <label class="col-sm-3 control-label"><spring:message code="confirmPassword"/></label>
                        <div class="col-sm-6">
                            <input type="password" name="confirmPassword"
                                   class="form-control" id="confirmPassword"/>
                        </div>
                    </div>
                </form:form>

                <!-- 密码和确认密码相等的提示信息 -->
                <span id="registerError">${pwdEquals }</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="close"/></button>
                <button type="button" class="btn btn-primary" id="registerButton">
                  <spring:message code="register"/>
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>


<script src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script>

    //轮播按钮垂直居中
    function putThisVCenter(Element) {
        var elementHeight = $(Element).height();
        var parentHeight = $(Element).parent().height();
        $(Element).css('top', parentHeight * 0.5 - elementHeight / 2);
    }
    function locate() {
        $('.carousel-inner img').attr({'width':'100%'});


        //保持轮播控件与导航栏20px
        $('.carousel').css('top', $('.nav').height() + 20);

        //保持商品类别图片在轮播图下
        $('.container').css('top', (parseInt($('.carousel').css('top')) + $('.carousel').height()) + 20);

        //撑开col-sm-6
        $('.container .col-sm-6').css('background-size', '100% 150px');
        $('.container .col-sm-6 span').css('line-height', '150px');

        //保持水平线在分类图下
        $('hr').css('top', (parseInt($('.container').css('top')) + $('.container').height()) + 10);

        $('p').css({'top': (parseInt($('hr').css('top')) + $('hr').height()) + 30,'left':$(window).width() * 0.5 - $('p').width() / 2});

    }

    //窗口resize
    $(window).resize(function () {
        putThisVCenter(".controlIcon");
        locate();
    })


    var flag = true;
    var checkUserId = /^[A-Za-z0-9_]{6,30}$/;
    var checkPassword = /^[A-Za-z0-9]{6,30}$/;

    $(document).ready(function () {
        //do something
        $("#userId").val("${cookie.userId.value}");
        $("#password").val("${cookie.password.value}");
        putThisVCenter(".controlIcon");
        locate();
        $('body').css('overflow','hidden');
    });

    //更换验证码，加随机数防止缓存
    function changeCode(obj) {
        obj.src = "/OnlineShopping/user/createCode?" + Math.random();
    }

    //核对验证码
    function checkCode() {
        $.post("/OnlineShopping/user/captchaCheck", {
            captcha: $("#captcha").val()
        }, function (data) {
            //设置验证信息
            $('#checkResult').html(data);
            if (data == "验证码错误") {
                $('#captchaGroup').removeClass('has-success');
                $('#captchaGroup').addClass('has-error');
            } else {
                $('#captchaGroup').removeClass('has-error');
                $('#captchaGroup').addClass('has-success');
            }
        });
    }

    //边输入边验证
    $('#captcha').bind('input propertychange', function () {
        checkCode();
    });

    //数据验证，符立明你来完善。。
    function dataValid() {

        flag = true;
        $('#userIdGroup').removeClass('has-error has-success');
        $('#passwordGroup').removeClass('has-error has-success');

        //验证码是否正确验证
        if ($("#checkResult").html() != "填写正确") {
            flag = false;
        }

        //正则验证

        if (checkUserId.test($('#userId').val()) == false) {
            $('#userIdGroup').addClass('has-error');
            alert('用户名长度为6至30个字符,且只能包含字母、数字和下划线');
            flag = false;
        } else {
            $('#userIdGroup').addClass('has-success');
        }
        if (checkPassword.test($('#password').val()) == false) {
            $('#passwordGroup').addClass('has-error');
            alert('密码长度为6至30个字符');
            flag = false;
        } else {
            $('#passwordGroup').addClass('has-success');
        }

    }

    //登录按钮
    $('#loginButton').click(function () {
        dataValid();
        if (flag == true) {
            $.post("/OnlineShopping/user/loginCheck", {
                userId: $("#userId").val(),
                password: $("#password").val()
            }, function (data) {
                //设置验证信息

                if (data == "该用户名不存在") {
                    $('#userIdGroup').addClass('has-error');
                }
                if (data == "密码错误") {
                    $('#passwordGroup').addClass('has-error');
                }
                if (data == "登录成功") {
                    $('#userIdGroup').addClass('has-success');
                    $('#passwordGroup').addClass('has-success');
                    user.action = "/OnlineShopping/user/login";
                    loginForm.submit();
                }

            });
        }
    });

    //-------------注册表单js------------------------

    //检查用户名是否可用
    function checkUserIdAvl() {
        $.post("/OnlineShopping/user/userExistCheck", {
            userId: $("#ruserId").val()
        }, function (data) {
            //设置可用信息
            $('#iconToDetermine').removeClass(
                    'glyphicon glyphicon-ok glyphicon glyphicon-remove');
            $('#ruserIdGroup').removeClass('has-error has-success');

            if (data == 'false') {
                $('#iconToDetermine')
                        .addClass('glyphicon glyphicon-remove');
                $('#ruserIdGroup').addClass('has-error');
                $('#iconToDetermine').css('color', '#f00');

            } else {
                $('#iconToDetermine').addClass('glyphicon glyphicon-ok');
                $('#ruserIdGroup').addClass('has-success');
                $('#iconToDetermine').css('color', '#0f0');
            }
        });
    }

    function checkConfirmPassword() {
        $('#confirmPasswordGroup').removeClass('has-error has-success');
        if ($('#confirmPassword').val() != $('#rpassword').val()) {
            $('#confirmPasswordGroup').addClass('has-error');
        } else {
            $('#confirmPasswordGroup').addClass('has-success');
        }
    }

    //数据验证，符立明你来完善哈。。
    function rdataValid() {
        var flag = true;
        if ($('#rpasswordGroup').attr('class') == 'form-group has-error') {
            alert('请确保密码在6至30个字符内');
            flag = false;
        }
        if ($("#ruserId").val() == "") {
            alert("用户名不能为空");
            flag = false;
        }
        if ($('#iconToDetermine').attr('class') == 'control-label glyphicon glyphicon-remove') {
            alert('请确保用户名在6至30个字符内 or 有人已经用了这个名字了');
            flag = false;
        }
        if ($('#confirmPasswordGroup').attr('class') == 'form-group has-error'
                || ($('#confirmPassword').val() != $('#rpassword').val())) {
            flag = false;
            $('#confirmPasswordGroup').addClass('has-error');
            alert('确认密码输错啦');
        }
        return flag;
    }
    //边输入边验证用户名
    $('#ruserId').bind('input propertychange', function () {
        checkUserIdAvl();
    });
    //边输入边验证确认密码
    $('#confirmPassword').bind('input propertychange', function () {
        checkConfirmPassword();
    });
    $('#rpassword').bind('input propertychange', function () {
        checkConfirmPassword();
    });
    //边输入边验证密码
    $('#rpassword').bind('input propertychange', function () {
        $('#rpasswordGroup').removeClass('has-error has-success');
        if (checkPassword.test($('#rpassword').val())) {
            $('#rpasswordGroup').addClass('has-success');
        } else {
            $('#rpasswordGroup').addClass('has-error');
        }
    });
    //注册按钮
    $('#registerButton').click(function () {
        if (rdataValid()) {
            alert('注册成功');
            registerForm.action = "/OnlineShopping/user/register";
            $('#registerForm').submit();
        }
    });

    //-------------背景图片js------------------------
    $('#coverImage').attr({
        'width': $(window).width(),
        'height': $(window).height()
    });
    $('#coverImage').fadeIn(2000);

    $(window).resize(function () {
        $('#coverImage').attr({
            'width': $(window).width(),
            'height': $(window).height()
        });

        putThisCenter('#login', 0.4);
        putThisCenter('#register', 0.6);
    });

    setTimeout('addFilter()', 4500);
    setTimeout("removeCover()", 4500);
    
    function addFilter() {
        $('#coverImage').removeClass().addClass('filter');
    }
    
    function removeCover(){
    	$('#coverImage').fadeOut(2000);
    	$('body').css('overflow','scroll');
    }

    //-------------按钮布局js------------------------
    function putThisCenter(Element, percent) {
        var elementWidth = $(Element).width();
        var bodyWidth = $(window).width();
        var elementHeight = $(Element).height();
        var bodyHeight = $(window).height();
        $(Element).css({'left': bodyWidth * percent - elementWidth, 'top': bodyHeight * 0.5 - elementHeight / 2});
    }

    putThisCenter('#login', 0.4);
    putThisCenter('#register', 0.6);

</script>

</body>
</html>
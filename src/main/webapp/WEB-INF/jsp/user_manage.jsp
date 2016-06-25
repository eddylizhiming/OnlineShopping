<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        .col-sm-12 {
            background-image: url(/OnlineShopping/images/userManageBackground.jpg);
            background-size: cover;
        }

        .col-sm-12 img, .container {
            position: absolute;
        }

        .container {
            width: 70%;
            border-left: medium solid #ffbebe;
            border-top: medium solid #ffbebe;
            border-right: medium solid #ffbebe;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .form-group {
            margin-top: 30px;
        }

        #preview, .img {
            width: 100%;
            height: 200px;
            border: 1px solid #ccc;
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

<div class="container">
    <form action="<c:url value = '/user/manage/bindEmail'/>" method="post" role="form" class="form-horizontal"
          id="bindEmailForm">
        <div class="form-group">
            <label class="col-sm-3 control-label">邮箱：
            </label>
            <div class="col-sm-6">
                <input type="text" id="receiveAddress" name="receiveAddress" value="${requestScope.emailAddress}"
                       class="form-control">
                <!-- 必须设置button的类型，否则会在除IE的浏览器自动提交表单 -->
            </div>
            <div class="col-sm-3">
                <button type="button" class="btn btn-link" id="sendButton">发送</button>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label">
                验证码：
            </label>
            <div class="col-sm-6">
                <input type="text" id="emailCaptcha" name="emailCaptcha" class="form-control"/>
            </div>
            <div class="col-sm-3">
                <button type="button" class="btn btn-link" id="bindButton">绑定</button>
            </div>
        </div>
    </form>

    <form action="<c:url value = '/user/manage/upHeadScul'/>" method="post" enctype="multipart/form-data"
          role="form" class="form-horizontal" id="uploadHeadSculForm">
        <div class="form-group">
            <label class="control-label col-sm-3">上传头像：</label>
            <div class="col-sm-6">
                <input type="file" id="inputfile" name="headScul" class="control-label" onchange="preview(this)">
            </div>
            <div class="col-sm-3">
                <button type="button" class="btn btn-link" id="uploadButton">上传</button>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <div id="preview" style="display: none"></div>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" class="btn btn-default btn-lg btn-block" id="queryOrUpdateButton">
                    查询或修改您的信息
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
<script>

    //显示上传的结果
    function showUploadResult() {
        if ("${upLoadResult}" != null && "${upLoadResult}" != "") {
        }
            alert("${upLoadResult}");
    }

    //发送验证验证码邮件，并告知用户发送情况
    function sendVerifyEmail() {
        $.post("/OnlineShopping/user/manage/sendEmail", {
            receiveAddress: $("#receiveAddress").val()
        }, function (data) {
            //返回的发送情况，如"发送成功"等。
            alert(data);
            if(data != "发送成功"){
                $('#sendButton').removeAttr("disabled");
                $('#sendButton').text("重新发送");
            }
        });
    }

    
    $(document).ready(function () {   	
        locate();
      //自动执行显示上传结果
        showUploadResult();
    });


    $(window).resize(function () {
        locate();
    });

    function isEmail(str) {
        var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        return reg.test(str);
    }

    var t;
    $('#sendButton').click(function () {
        if (isEmail($('#receiveAddress').val())) {
            t = 60;
            $('#sendButton').attr('disabled', 'disabled');
            autoPlay();
            sendVerifyEmail();
        }else{
            alert('请输入正确的email地址')
        }
    });

    function autoPlay() {
        var time = setInterval(function () {
            $('#sendButton').text(t--);
            if (t == -1) {
                clearInterval(time);
                $('#sendButton').removeAttr("disabled");
                $('#sendButton').text("重新发送");
            }
        }, 1000);
    }

    function locate() {
        //撑开col-sm-12
        $('.col-sm-12').css('background-size', '100% 300px');
        $('.col-sm-12 span').css('line-height', '300px');

        //头像居中
        putThisCenter('.col-sm-12 img');

        //container定位
        $(".container").css({'height': $(window).height() - 310, 'top': 320, 'left': '15%'});

        //预览图片拉伸
        $("#preview img").css({'height': $('#preview').height() - 1, 'width': $('#preview').width() - 1});

    }


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

    $('#bindButton').click(function () {
    	
    	  $.post("/OnlineShopping/user/manage/bindEmail", {
          	emailCaptcha: $("#emailCaptcha").val(),
          	receiveAddress:$("#receiveAddress").val()
          }, function (data) {
              //alert绑定的结果。
              alert(data);
          });
    });

    $('#queryOrUpdateButton').click(function () {
        window.location = "/OnlineShopping/user/manage/operUserInfo";
    });

    //预览图片
    function preview(file) {
        var prevDiv = document.getElementById('preview');
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                var prevDivWidth = $('#preview').width() - 1;
                var prevDivHeight = $('#preview').height() - 1;
                prevDiv.innerHTML = '<img src="' + evt.target.result + '" width="' + prevDivWidth + '"height="' + prevDivHeight + '"/>';
            }
            reader.readAsDataURL(file.files[0]);
        }
        else {
            prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
        }
    }

    $('#inputfile').click(function () {
        $('#preview').fadeIn();
    })

    $('#uploadButton').click(function () {
        $('#preview').fadeOut();
        $('#uploadHeadSculForm').submit();
    });
    
  	//显示上传头像的结果
    function showUploadResult()
    {
    	if ("${upLoadResult}" != null && "${upLoadResult}" != "")
    	alert("${upLoadResult}");
    }

   
</script>

</body>
</html>
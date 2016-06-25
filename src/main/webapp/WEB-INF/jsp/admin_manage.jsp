<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link
            href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
            rel="stylesheet">
    <link href="http://apps.bdimg.com/libs/fontawesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
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
            border-left: medium solid #ccc;
            border-top: medium solid #ccc;
            border-right: medium solid #ccc;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .form-group {
            margin-top: 30px;
        }

        .preview, .img {
            width: 100%;
            height: 200px;
            border: 1px solid #ccc;
        }

        #previewGoodPicGroup, #previewHeadSculPicGroup {
            display: none;
        }
    </style>
</head>
<body onload="onload()">
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
                             height="120px" src="<c:url value = '/${userHeadSrc}'/>"/>
</div>

<div class="container">
    <div class="form-group">
        <p class="text-center">
            <i class="fa fa-users fa-2x"></i>
            &nbsp;
            <i class="fa fa-2x">用户信息管理</i>
        </p>
    </div>
    <form:form modelAttribute="regUser" role="form"
               class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-3 control-label"> 用户ID： </label>
            <div class="col-sm-6">
                <form:input path="userId" id="userId" value="${userId }"
                            class="form-control"/>
            </div>
            <div class="col-sm-3">
                <button type="button" onclick="queryUserInfo()"
                        class="btn btn-link">查询
                </button>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 昵称： </label>
            <div class="col-sm-6">
                <input type="text" id="userName" class="form-control"/>
            </div>
            <div class="col-sm-3">
                <button type="button" onclick="updateUserName()"
                        class="btn btn-link">修改用户昵称
                </button>
            </div>
        </div>
    </form:form>

    <form name="headForm" action="<c:url value='/admin/updateUserHead'/>"
          method="post" enctype="multipart/form-data" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-3 control-label"> 头像： </label>
            <div class="col-sm-6">
                <img src="" id="headScul" class="preview"/>
            </div>
            <div class="col-sm-3">
                <button type="button" onclick="validAndUpdate()"
                        class="btn btn-link">修改用户头像
                </button>
                <input type="hidden" id="userId2" name="userId2"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 更改头像： </label>
            <div class="col-sm-6">
                <input type="file" name="newHeadScul" class="control-label"
                       onchange="preview(this,'previewHeadSculPic')"
                       onclick="fadeInElement('#previewHeadSculPicGroup')"/>
            </div>
        </div>

        <div id="previewHeadSculPicGroup">
            <div>
                <div class="col-sm-offset-3 col-sm-6">
                    <div id="previewHeadSculPic" class="preview"></div>
                </div>
            </div>

            <div>
                <div class="col-sm-offset-3 col-sm-6">
                    <button type="button" onclick="fadeOutElement('#previewHeadSculPicGroup')"
                            class="btn btn-default btn-lg btn-block">关闭
                    </button>
                </div>
            </div>
        </div>


        <div class="form-group">
            <p class="text-center">
                <i class="fa fa-bullhorn fa-2x"></i>
                &nbsp;
                <i class="fa fa-2x"> 用户群广播</i>
            </p>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label"> 广播消息： </label>
            <div class="col-sm-6">
                <input id="broadcast" class="form-control"/>
            </div>
            <div class="col-sm-3">
                <button type="button" class="btn btn-link"  onclick="broadCastMsg()">广播
                </button>
            </div>
        </div>
    </form>

    <form:form id="goodForm" modelAttribute="good" method="post"
               enctype="multipart/form-data" class="form-horizontal">
        <div class="form-group">
            <p class="text-center">
                <i class="fa fa-tags fa-2x"></i>
                &nbsp;
                <i class="fa fa-2x"> 商品信息管理</i>
            </p>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label"> 商品ID： </label>
            <div class="col-sm-6">
                <form:input path="goodId" id="goodId" value="${goodId }" class="form-control"/>
            </div>
            <div class="col-sm-3">
                <div class="btn-group">
                    <button type="button" onclick="queryGoodInfo()" class="btn btn-link">查询</button>
                    <button type="button" onclick="deleteGood()" class="btn btn-link">删除</button>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label">名称： </label>
            <div class="col-sm-6">
                <form:input path="goodName" id="goodName" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 类型： </label>
            <div class="col-sm-6">
                <form:input path="goodType" id="goodType" class="form-control"/>
            </div>
        </div>

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

        <div class="form-group">
            <label class="col-sm-3 control-label"> 商品图片： </label>
            <div class="col-sm-6">
                <img alt="商品图片" src="<c:url value='${goodPicSrc}'/>" align="middle" class="img-responsive"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 更改图片： </label>
            <div class="col-sm-6">
                <input type="file" name="goodPic" onchange="preview(this,'previewGoodPic')"
                       onclick="fadeInElement('#previewGoodPicGroup')" class="control-label"/>
            </div>
        </div>

        <div id="previewGoodPicGroup">
            <div>
                <div class="col-sm-offset-3 col-sm-6">
                    <div id="previewGoodPic" class="preview"></div>
                </div>
            </div>

            <div>
                <div class="col-sm-offset-3 col-sm-6">
                    <button type="button" onclick="fadeOutElement('#previewGoodPicGroup')"
                            class="btn btn-default btn-lg btn-block">关闭
                    </button>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 数量： </label>
            <div class="col-sm-6">
                <form:input path="amount" id="amount" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-3 control-label"> 单价： </label>
            <div class="col-sm-6">
                <form:input path="unitPrice" id="unitPrice" class="form-control"/>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" onclick="updateGoodInfo()"
                        class="btn btn-default btn-lg btn-block">修改
                </button>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-6">
                <button type="button" onclick="insertGood()"
                        class="btn btn-default btn-lg btn-block">添加
                </button>
            </div>
        </div>

    </form:form>
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
					<iframe src="/OnlineShopping/user/shoppingCar" frameborder="no"
						border="0" marginwidth="0" marginheight="0" scrolling="no"
						allowtransparency="yes" id="iframepage" width="100%" 

height="400px")></iframe>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

<script type="text/javascript" src="/OnlineShopping/dwr/engine.js"></script>
<script type="text/javascript" src="/OnlineShopping/dwr/util.js"></script>  
<script type="text/javascript" src="/OnlineShopping/dwr/interface/DwrSender.js"></script> 
<script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function onload(){	
		dwr.engine.setActiveReverseAjax(true);
	}
    //查询用户信息
    function queryUserInfo() {
        $.post("/OnlineShopping/admin/queryUserInfo",
                {
                    userId: $("#userId").val()
                },
                function (data) {

                    if (data == "")
                        alert("没有该用户");
                    else {
                        alert("查询到了用户");
                        var info = data.split('&')

                        if (info[1] == 'defaultHead.jpg')
                            var headScul = '/OnlineShopping/images/defaultHead.jpg';
                        else {
                            var headScul = '/OnlineShopping/uploads/'
                                    + $("#userId").val()
                                    + '/'
                                    + info[1];
                        }
                        $("#userName").val(info[0]);
                        $("#headScul").attr('src', headScul);
                    }

                    //设置可用信息
                    // document.getElementById("checkAvlResult").src = data;
                });
    }

    //查询商品信息
    function queryGoodInfo() {
        window.location = "/OnlineShopping/admin/queryGoodInfo?goodId="
                + $("#goodId").val();
    }

    //修改用户昵称
    function updateUserName() {
        $.post("/OnlineShopping/admin/updateUserName", {
            userId: $("#userId").val(),
            userName: $("#userName").val()
        }, function (data) {
            alert(data);
        });
    }

    function validAndUpdate() {
        //使用隐藏域将id值传过去。。
        $("#userId2").val($("#userId").val());
        headForm.submit();
    }

    //显示查询商品结果
    function showQueryGoodResult() {
        if ("${queryResult}" != null && "${queryResult}" != "")
            alert("${queryResult}");
    }

    //显示更新商品结果
    function showUpdateGoodResult() {
        if ("${updateGoodResult}" != null && "${updateGoodResult}" != "")
            alert("${updateGoodResult}");
    }
    //显示信息。
    function showInfos() {
        //执行显示查询商品结果
        showQueryGoodResult();
        showUpdateGoodResult();
        //执行显示添加商品结果
        showInsertGoodResult();

        //上传头像结果
        if ("${updateHeadResult}" != null && "${updateHeadResult}" != "")
            alert("${updateHeadResult}");

    }

    //显示添加商品结果
    function showInsertGoodResult() {
        if ("${insertGoodResult}" != null && "${insertGoodResult}" != "")
            alert("${insertGoodResult}");
    }

    //删除商品
    function deleteGood() {
        $.post("/OnlineShopping/admin/deleteGood", {
            goodId: $("#goodId").val()
        }, function (data) {
            alert(data);
            //符立明，你来清空文本框的数据！！等等。
        });
    }
    //修改商品信息
    function updateGoodInfo() {
        goodForm.action = "/OnlineShopping/admin/updateGoodInfo";
        goodForm.submit();
    }

    //添加商品
    function insertGood() {
        goodForm.action = "/OnlineShopping/admin/insertGood";
        goodForm.submit();
    }

    function locate() {
        //撑开col-sm-12
        $('.col-sm-12').css('background-size', '100% 300px');
        $('.col-sm-12 span').css('line-height', '300px');

        //头像居中
        putThisCenter('.col-sm-12 img');

        //container定位
        $(".container").css({
            'height': $(document).height(),
            'top': 320,
            'left': '15%'
        });

        //preView拉伸
        $("#preview img").css({'height': $('#preview').height() - 1, 'width': $('#preview').width() - 1});
    }

    $(document).ready(function () {
        locate();
        showInfos();
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

    //预览图片
    function preview(file, id) {
        var prevDiv = document.getElementById(id);
        if (file.files && file.files[0]) {
            var reader = new FileReader();
            reader.onload = function (evt) {
                var prevDivWidth = $('#' + id).width() - 1;
                var prevDivHeight = $('#' + id).height() - 1;
                prevDiv.innerHTML = '<img src="' + evt.target.result + '" width="' + prevDivWidth + '"height="' + prevDivHeight + '"/>';
            }
            reader.readAsDataURL(file.files[0]);
        }
        else {
            prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';
        }
    }

    var documentHeight = $(document).height();

    function fadeOutElement(Element) {
        $(Element).fadeOut();
        $(Element).find('.col-sm-offset-3').parent().addClass('form-group');
        $(".container").css('height', documentHeight);
    }

    function fadeInElement(Element) {
        $(Element).fadeIn();
        $(Element).find('.col-sm-offset-3').parent().addClass('form-group');
        $(".container").css('height', documentHeight + 523);
    }
    
    function broadCastMsg(){
    	DwrSender.sendMsg($('#broadcast').val());
    }
    
</script>
</body>
</html>
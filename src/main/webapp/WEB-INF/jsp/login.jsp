<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
	href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<button class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal1">登录</button>

	<button class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal2">注册</button>

	<!-- 模态框（Modal） -->
<%-- 	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">登录</h4>
				</div>
				<div class="modal-body">
					<!-- 登录表单 -->
					<form:form modelAttribute="user" role="form"
						class="form-horizontal">
						<div class="form-group" id="userIdGroup">
							<label class="col-sm-3 control-label">用户名：</label>
							<div class="col-sm-9">
								<form:input id="userId" path="userId"
									value="${request.user.userId }" class="form-control"
									placeholder="请输入用户名" />
							</div>
						</div>

						<div class="form-group" id="passwordGroup">
							<label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
							<div class="col-sm-9">
								<form:password id="password" path="password"
									class="form-control" placeholder="请输入密码" />
							</div>
						</div>


						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<div class="checkbox">
									<label class="control-label"> <input type="checkbox"
										name="isRememberPwd" />记住密码
									</label>
								</div>
								<label class="control-label"> <select
									name="rememberd_days">
										<option value="1">1天</option>
										<option value="7">1个星期</option>
										<option value="30">1个月</option>
								</select>
								</label>
							</div>
						</div>


						<div class="form-group" id="captchaGroup">
							<label class="col-sm-3 control-label">验证码：</label>
							<div class="col-sm-3">
								<input id="captcha" name="captcha" type="text"
									class="form-control" maxlength="4" />
							</div>
							<div class="col-sm-3">
								<img src="/OnlineShopping/user/createCode?<%=Math.random()%>"
									id="code" onclick="changeCode(this)" class="img-responsive" />
							</div>
							<div class="col-sm-3">
								<label id="checkResult" class="control-label">请填写验证码</label>
							</div>
						</div>
					</form:form>
					<span id="loginError">${loginError}</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" id="loginButton">
						登录</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div> --%>

	<!--注册表单 -----------------------------------------------------  -->
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">注册</h4>
				</div>
				<div class="modal-body">
					<!-- 注册表单 -->
					<form:form modelAttribute="regUser" role="form"
						class="form-horizontal" id="registerForm">
						<div class="form-group">
							<label class="col-sm-3 control-label">用户名：</label>
							<div class="col-sm-6">
								<form:input id="ruserId" path="userId"
									value="${request.user.userId }" onblur="checkUserIdAvl()"
									class="form-control" />
								<form:errors path="userId" />
							</div>
							<div class="col-sm-3">
								<!-- 如果用户名不为空，则不用显示用户名可用的结果的图片 -->
								<c:if test="${createInfo != '用户名不能为空'}">
									<!--<img id="checkAvlResult" class="img-responsive"/> &lt;!&ndash;检测用户名可用的结果的图片 &ndash;&gt;-->
									<label class="control-label"><span
										class="glyphicon glyphicon-remove"
										style="color: rgb(255, 0, 0);"></span></label>
								</c:if>
								<!-- 添加换行符 -->
								<c:if test="${createInfo == '用户名不能为空'}">
                                ${createInfo }
                            </c:if>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">昵&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
							<div class="col-sm-6">
								<form:input id="userName" path="userName"
									value="${request.user.userName }" class="form-control" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
							<div class="col-sm-6">
								<form:password id="rpassword" path="password"
									class="form-control" />
								<form:errors path="password" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">确认密码：</label>
							<div class="col-sm-6">
								<input type="password" name="confirmPassword"
									class="form-control" />
							</div>
						</div>
						<input type="submit" value="tijiao"/>
					</form:form>

					<!-- 密码和确认密码相等的提示信息 -->
					<span id="registerError">${pwdEquals }</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="registerButton">
						注册</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>




	<script src="http://apps.bdimg.com/libs/jquery/2.0.0/jquery.min.js"></script>
	<script
		src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		var flag = true;

		$(document).ready(function() {
			//do something
			$("#userId").val("${cookie.userId.value}");
			$("#password").val("${cookie.password.value}");
		});

		//更换验证码，加随机数防止缓存
		function changeCode(obj) {
			obj.src = "/OnlineShopping/user/createCode?" + Math.random();
		}

		//核对验证码
		function checkCode() {
			$.post("/OnlineShopping/user/captchaCheck", {
				captcha : $("#captcha").val()
			}, function(data) {
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
		$('#captcha').bind('input propertychange', function() {
			checkCode();
		});

		//数据验证，符立明你来完善。。
		function dataValid() {

			flag = true;
			$('#userIdGroup').removeClass('has-error');
			$('#userIdGroup').removeClass('has-success');
			$('#passwordGroup').removeClass('has-error');
			$('#passwordGroup').removeClass('has-success');

			//验证码是否正确验证
			if ($("#checkResult").html() != "填写正确") {
				flag = false;
			}

			//正则验证
			var checkUserId = /^[A-Za-z0-9_]{6,20}$/;
			var checkPassword = /^[A-Za-z0-9]{6,20}$/;
			if (checkUserId.test($('#userId').val()) == false) {
				$('#userIdGroup').addClass('has-error');
				alert('用户名长度为6至20个字符,且只能包含字母、数字和下划线');
				flag = false;
			} else {
				$('#userIdGroup').addClass('has-success');
			}
			if (checkPassword.test($('#password').val()) == false) {
				$('#passwordGroup').addClass('has-error');
				alert('密码长度为6至20个字符');
				flag = false;
			} else {
				$('#passwordGroup').addClass('has-success');
			}

		}

		//登录按钮
		$('#loginButton').click(function() {
			dataValid();
			if (flag == true) {
				$.post("/OnlineShopping/user/loginCheck", {
					userId : $("#userId").val(),
					password : $("#password").val()
				}, function(data) {
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
						$('#user').submit();
					}

				});
			}
		});

		//-------------注册表单js------------------------

		//检查用户名是否可用
		function checkUserIdAvl() {
			$.post("/OnlineShopping/user/userExistCheck", {
				userId : $("#ruserId").val()
			}, function(data) {
				//设置可用信息
				//document.getElementById("checkAvlResult").src = data;
			});
		}

		//数据验证，符立明你来完善哈。。
		function dataValid() {
			var flag = true;

			//TODO 进行用户名和密码及确认密码字段的校验，在这里写代码，请进行完善！！！！
			if ($("#ruserId").val() == "") {
				alert("用户名不能为空");
				flag = false;
			}
			//如果图片的src不为用户名可用图片的src
			else if (document.getElementById("checkAvlResult").src
					.indexOf("userAvl.jpg") == -1) {
				alert("该用户名已经注册，请更换");
				flag = false;
			}
			return flag;
		}
		
		$('#registerButton').click(function(){
			alert("caonimalegebi0");
			registerForm.action = "/OnlineShopping/user/register";
			$('#registerForm').submit();
		})
	</script>

	<form method="POST">
		<input type="submit" value="sdfds"/>
	</form>
</body>
</html>
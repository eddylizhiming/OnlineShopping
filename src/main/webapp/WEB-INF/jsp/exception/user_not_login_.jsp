<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>未登录</title>
<style>

.no{
	width:400px;
	height:80px;

	position:absolute;  
	top:50%;  
	left:50%;  
	margin-left:-200px;  
	margin-top:60px;  
}

.re{
	position:relative;
	top:0%;
}

.login{
	position: relative;
	left:30%;
}

.line2{
	position: relative;
	top:80%;
}

.button_bg{
	width:150px;
	height:50px;

	background-image:url(/OnlineShopping/images/button.jpg);
	background-repeat: no-repeat;
	background-size:151px 51px;

	position: relative;
	left:44%;
}

.back{

	font-size:15px;

	display:inline;
}

.f{
	font-style:oblique;
	font-family:隶书;
	font-size:30px;
	color:#6a93ef;

	text-align:center;
}

.d{
	width:100px;
	display:inline;
}
</style>


<script>
window.onload=function ()
{
 var oDiv=document.getElementById('div1');
 var value=4;
 setInterval(function(){
  oDiv.innerHTML=value;
  value--;
  if(value<0){
   document.location="/OnlineShopping/user/index";
   value=0;
   return;
  }
 },1000);
};
</script>

</head>

<body>
<br/><br/>

<hr style="filter: alpha(opacity=100,finishopacity=0,style=3)" width="90%" color=#987cb9 size=2>

<div class="re">
  <img src="/OnlineShopping/images/noLogin.jpg" class="no">
</div>

<br/><br/><br/><br/><br/><br/><br/>

<br/><br/><br/><br/><br/><br/><br/>
<hr style="filter: alpha(opacity=100,finishopacity=0,style=3)" width="90%" color=#bfbfbf size=2 class="line2">
<br/>
<div class="f">
  本页将在<div id="div1" class="d">5</div>秒钟后跳转...
  <div class="back"><a href="/OnlineShopping/user/index">返回主页</a></div>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>无权限</title>
<style>

body{
	margin:0;
	padding:0
}

.top_black{
	width:100%;
	height:15%;
	background-color:#000;
}

.bottom_black{
	position:fixed;
	bottom:0;

	width:100%;
	height:15%;
	background-color:#000;
}

.pic{
	position:relative;
	top:10%;
	left:10%;
}

.zi{
	position:relative;
	top:-18%;
	left:35%;

	color:#0044f1;
	font-size:45px;
	font-family:华文行楷;
}

.f{
	position:relative;

	font-style:oblique;
	font-family:隶书;
	font-size:25px;
	color:#6a93ef;

	left:35%;
	top:-5%;
	
}

.back{

	font-size:15px;

	display:inline;
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

<div class="top_black">aaaaa</div>

<div class="pic"><img src="/OnlineShopping/images/noAuthority.png"></div>

<div class="zi">您的权限不符，请您确认！</div>

<div class="f">
  本页将在<div id="div1" class="d">5</div>秒钟后跳转...
  <div class="back"><a href="/OnlineShopping/user/index">返回主页</a></div>
</div>

<div class="bottom_black"></div>

</body>
</html>
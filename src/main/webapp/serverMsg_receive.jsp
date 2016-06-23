<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.openqa.selenium.WebDriver"%>
<%@page import="org.openqa.selenium.htmlunit.HtmlUnitDriver"%>
<%@page import="org.jsoup.Jsoup"%>
<%@ page language="java" contentType="text/html; charset=utf-8"  
    pageEncoding="utf-8"%>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">  
<script type="text/javascript" src="dwr/util.js"></script>    
<script type="text/javascript" src="dwr/engine.js"></script>   
<script type="text/javascript" src="jquery/jquery.js"></script>   
<script type="text/javascript">
	$(document).ready(function(){
		//这句话必須！ ，表示允许使用推送技术  
		dwr.engine.setActiveReverseAjax(true);
	})

    //这个函数是提供给后台推送的时候  调用的    
    function recvServerMsg(msg){  
        alert(msg);  
        $("#message").text(msg);  
    }  
</script>  
<title>Insert title here</title>

<style type="text/css">
.testClass{ 
	color:blue !important;
	font:x-small;
}
</style>  
</head>    
<body>  
<%
WebDriver driver = new HtmlUnitDriver();
driver.get("http://www.people.com.cn/");
String html = driver.getPageSource();
//	System.out.println(driver.getPageSource());
Document document = Jsoup.parse(html);
Element infoDiv =  document.getElementById("list_new_c_1");
request.setAttribute("infoDiv", infoDiv);
%>	
<div class="testClass">
	${infoDiv }</div>
    <div id="message" style="width: 200px;height: 200px;border: 1px solid red ; text-align: center; padding: 5px;"></div>  
</body>  
</html>  
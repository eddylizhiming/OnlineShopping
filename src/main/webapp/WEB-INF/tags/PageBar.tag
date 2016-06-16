<%@ tag pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="pageUrl" required="true" rtexprvalue="true" description="分页页面对应的URl" %>
<%@ attribute name="pageAttrKey" required="true" rtexprvalue="true" description="Page对象在Request域中的键名称" %>
<c:set var="pageUrl" value="${pageUrl}" />
<%
	String separator = pageUrl.indexOf("?") > -1?"&":"?";
   jspContext.setAttribute("pageResult", request.getAttribute(pageAttrKey));
   jspContext.setAttribute("pageUrl", pageUrl);
   jspContext.setAttribute("separator", separator);
   //将页面的大小放入jspContext，如果没有pageSize这个参数，从Attribute中取。
	if (request.getParameter("pageSize") == null)
		jspContext.setAttribute("pageSize", request.getAttribute("pageSize"));
	else
		jspContext.setAttribute("pageSize", request.getParameter("pageSize"));
%>

<div class="page-bar">
	第${pageResult.currentPageNo}页，共${pageResult.totalPageCount}页
	<!-- 第一页的情况。。则首页会没有超链接 -->
	<c:if test="${pageResult.currentPageNo <=1}">
	   首页&nbsp;&nbsp;
	</c:if>
	<c:if test="${pageResult.currentPageNo >1 }">
	   <a href="<c:url value="${pageUrl}"/>${separator}pageNo=1&pageSize=${pageSize}">首页</a>&nbsp;&nbsp;
	</c:if>
	<c:if test="${pageResult.hasPreviousPage}">
	  <a href="<c:url value="${pageUrl}"/>${separator}pageNo=${pageResult.currentPageNo -1 }&pageSize=${pageSize}">上一页</a>&nbsp;&nbsp;
	</c:if>
	<c:if test="${!pageResult.hasPreviousPage}">
	  上一页&nbsp;&nbsp;
	</c:if>
	<c:if test="${pageResult.hasNextPage}">
	  <a href="<c:url value="${pageUrl}"/>${separator}pageNo=${pageResult.currentPageNo +1 }&pageSize=${pageSize}">下一页</a>&nbsp;&nbsp;
	</c:if>
	<c:if test="${!pageResult.hasNextPage}">
	  下一页&nbsp;&nbsp;
	</c:if>
	<!-- 第一页的情况，则末页会没有超链接 -->
	<c:if test="${pageResult.currentPageNo >= pageResult.totalPageCount}">
	   末页&nbsp;&nbsp;
	</c:if>
	<c:if test="${pageResult.currentPageNo < pageResult.totalPageCount}">
	   <a href="<c:url value="${pageUrl}"/>${separator}pageNo=${pageResult.totalPageCount }&pageSize=${pageSize}">末页</a>&nbsp;&nbsp;
	</c:if>
</div>
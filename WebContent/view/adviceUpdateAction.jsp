<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	ObjectBeanService obs=new ObjectBeanService();
	FileUtil fu=new FileUtil();
	String advice = request.getParameter("advice");
	String username = request.getParameter("username");
	boolean au = StudentService.updateAdvice(username, advice);
	
	if(au){
		%>
	<script>
		alert("提交成功");
	</script>
	<% 
		response.sendRedirect("studentsInfo.jsp");
	}else{
%>
	<script>
		alert("提交失败");
	</script>
		<%response.sendRedirect("studAdminInfo.jsp");
	}
%>
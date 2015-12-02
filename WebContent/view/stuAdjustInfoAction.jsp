<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	ObjectBeanService obs=new ObjectBeanService();
	FileUtil fu=new FileUtil();
	ObjectBean ob = new ObjectBean();
	String username = request.getParameter("username");
	String discribe = request.getParameter("discribe");
	boolean stua = StudentService.updateNameAndFeedback(username, discribe);

	if(stua){
		response.sendRedirect("stuInfo.jsp");
	}else{
%>
	<script>
		alert("创建失败");
	</script>
		<%response.sendRedirect("stuInfo.jsp");
	}
%>
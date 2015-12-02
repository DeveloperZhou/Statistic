<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	QianDaoService obs=new QianDaoService();
	QianDao ob = new QianDao();
	ob.setState(1);
	ob.setCreater("yeying");
	
	int id = obs.intsertQianDao(ob);
	if(id >0){
		response.sendRedirect("qdList.jsp");
	}else{
%>
	<script>
		alert("创建失败");
	</script>
		<%response.sendRedirect("qdList.jsp");
	}
%>
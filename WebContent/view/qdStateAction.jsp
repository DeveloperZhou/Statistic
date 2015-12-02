<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	String qid = request.getParameter("qid");
	String action = request.getParameter("action");
	QianDaoService obs=new QianDaoService();
	QianDao ob = new QianDao();
	ob.setState(Integer.parseInt(action));
	ob.setCreater("yeying");
	ob.setQid(Integer.parseInt(qid));
	
	int id = obs.changeQianDao(ob);
	if(id >0){
		response.sendRedirect("qdList.jsp");
	}else{
%>
	<script>
		alert("发布失败");
	</script>
		<%response.sendRedirect("qdList.jsp");
	}
%>
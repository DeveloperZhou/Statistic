<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%
	String getid = request.getParameter("qid");
	int qid = Integer.parseInt(getid.trim());
	boolean flag = QianDaoService.delObjectBean(qid);
    response.sendRedirect("qdList.jsp");
%>
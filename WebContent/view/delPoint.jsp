<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.sql.*"%>
<%
	String psep = request.getParameter("sep");
	int sep = Integer.parseInt(psep);
	PointService ps = new PointService();
	
	boolean flagq = ps.delPoint(sep);
	if (flagq)	response.sendRedirect("pointList.jsp");
%>

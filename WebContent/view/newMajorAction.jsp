<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
	<%
	MajorService ms = new MajorService();
	String content = request.getParameter("content");
	if(content!=null&&content.trim().length()>0){
		//content=new String(content.getBytes("iso8859-1"),"UTF-8");
		}
	Major major = new Major();
	major.setMajorName(content);
	ms.intsertMajor(major);
	
	response.sendRedirect("majorList.jsp");
%>

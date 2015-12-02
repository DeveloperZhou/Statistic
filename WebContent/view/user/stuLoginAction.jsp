<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%

 String username = request.getParameter("username");
 String password = request.getParameter("password");
 StudentService ss=new StudentService();
 StudentBean sb=ss.longin(username,password);
 
 if(username.equals(sb.getUsername())) {
	   String chk="true";
	   session.setAttribute("Enter",chk);
	   session.setAttribute("userName",username);
	    response.sendRedirect("../stuIndex.jsp");
	 } else {
	  String errmsg="error1";
	  out.println("<script>alert('登录失败')</script>");
	  //response.sendRedirect("../login.jsp?errmsg="+errmsg);
	}
%>
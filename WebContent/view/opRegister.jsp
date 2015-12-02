<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.vote.bean.*" %>
<%@ page import="com.vote.service.*" %>

<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("username");
	String pwd = request.getParameter("password");
	String xm = request.getParameter("user");
	String point = request.getParameter("point");
	StudentBean user = new StudentBean();
	user.setUsername(name);
	user.setPassword(pwd);
   	//创建业务逻辑层接口对象
   	StudentService ius = new StudentService();
   	boolean isTrue = false;
   	boolean isHas = false;
   	isHas = ius.isHas(name);
   	if (isHas)
   	{
   		out.print("<script>alert('用户名已存在');window.history.back()</script>");
   	}
   	else
   	{
   		isTrue = ius.registerUser(name,pwd,xm,point);
   	}
   	if(isTrue){
   		out.print("<script>alert('注册成功');window.location='../view/stuLogin.jsp'</script>");
   	}else{
   		out.print("<script>alert('注册失败');window.history.back()</script>");
   	}
 %>

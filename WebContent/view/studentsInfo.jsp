<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="java.io.PrintWriter"%>
<%
	//从请求当中获取到ID，根据ID查询出题目和内容
	SelecterService ss = new SelecterService();
	PointService ps = new PointService();
	QuestionService qs = new QuestionService();
	int allScore = 0;
	List<StudentBean> students = new LinkedList<StudentBean>();
	students = StudentService.getAllStudents();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>个人信息</title>
		<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
		<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>
		
		<script type="text/javascript">
		//返回
		function back() {
			window.location.href="./wjList.jsp";
		}
		</script>
	</head>
	<body topmargin="2">
				<br>
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">总共<font color="red"> <%=students.size()%> </font>个人。</span>
					</td>
				</tr>
		</table>
		<table align="center" cellpadding="2" cellspacing="1" class="tab1" border="1" width="80%">
			<tr>
			  <th bgcolor="#E0E0E0" width="20%">学号</th>
			　  <th bgcolor="#FF9797" width="8%">姓名</th>
			  <th bgcolor="#FFFF00" width="8%">班级</th>
			  <th bgcolor="#D3A4FF" width="8%">得分</th>
			  <th bgcolor="#006699" width="8%">回答次数</th>
			  <th bgcolor="#006699" width="8%">签到次数</th>
			  <th bgcolor="#A6FFA6" width="20%">建议</th>
			  <th bgcolor="#A6FFA6" width="20%">学生反馈</th>
			</tr>
			<%
				if (students != null && students.size() > 0) {
				for (int i = 0; i < students.size(); i++) {
					StudentBean stu = (StudentBean) students.get(i);
			%>
			<tr>
				<td align="center" bgcolor="#E8FFC4"><a href="stuAdminInfo.jsp?studentName=<%=stu.getUsername()%>"><%=stu.getUsername() %></a></td>
				
				<td bgcolor="#D6D6AD">
					<%=stu.getName() %>
				</td>
				
				<td bgcolor="#D6D6AD">
					<%=stu.getMajor() %>
				</td>
				
				<td bgcolor="#B3D9D9">
					<%=stu.getScore() %>
				</td>
				
				<% if (stu.getAnsTimes()>0) 
				{
				%>
				<td bgcolor="#99CC33">
					<%=stu.getAnsTimes() %>
				</td>
				<%}else { %>
				<td bgcolor="#FF6666">
					<%=stu.getAnsTimes() %>
				</td>
				<% }%>
				
				<% int t = QderService.QianDaoTimes(stu.getUsername());
				if (t>0) 
				{
				%>
				<td bgcolor="#99CC33">
					<%=t %>
				</td>
				<%}else { %>
				<td bgcolor="#FF6666">
					<%=t %>
				</td>
				<% }%>
				
				<td bgcolor="#FAF4FF">
					<%=stu.getAdvice() %>
				</td>
				
				<td bgcolor="#FAF4FF">
					<%=stu.getFeedback() %>
				</td>
			</tr>
				
				<% }
				} %>
				
		</table>
		<table  width="750" align="center" cellpadding="2" cellspacing="1" class="tab1">
		<tr>
			<td colspan=4 align="left">
			<br>
				<input type="button" name="back" value=" 返  回   "  onclick="back();" class="btn"/>
			</td>
		</tr>
		</table>
	</body>
</html>

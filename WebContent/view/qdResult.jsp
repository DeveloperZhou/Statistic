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
	String id = request.getParameter("qid");
	System.out.println("qid=" + id);
	int qid = Integer.parseInt(id);
	//
	List<Qder> qdersByOne = new LinkedList<Qder>();
	qdersByOne =  QderService.getQders(qid);
	System.out.println(qdersByOne.size());
	//回复总数
	int rcount = QderService.getQderCount(qid);
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>问卷管理系统</title>
		<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
		<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>
		
		<script type="text/javascript">
		//返回
		function back() {
			window.location.href="./qdList.jsp";
		}
		</script>
	</head>
	<body topmargin="2">
				<br>
				<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="center">
						<strong><%="签到表"+id%> </strong>
					</td>
				</tr>
				<tr>
					<td align="center"><br></td>
				</tr>
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">本次签到共有<font color="red"> <%=rcount%> </font>人签到。</span>
					</td>
				</tr>
		</table>
		<table align="center" cellpadding="2" cellspacing="1" class="tab1" border="1">
			<tr>
			  <th bgcolor="##FFFF99">人数</th>
			　  <th bgcolor="##FFFF99">IP</th>
			  <th bgcolor="##FFFF99">学号</th>
			</tr>
			<%
				if (qdersByOne != null && qdersByOne.size() > 0) {
				for (int i = 0; i < qdersByOne.size(); i++) {
					Qder qder = (Qder) qdersByOne.get(i);
			%>
			<tr>
				<td bgcolor="#FFFF99">
					<%=i+1 %>
				</td>
				<td bgcolor="#FFFF99">
					<%=qder.getQdIp() %>
				</td>
				<td bgcolor="#FFFF99">
					<%=qder.getQdCode() %>
				</td>
			</tr>
			<%
				}
			}
			%>
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

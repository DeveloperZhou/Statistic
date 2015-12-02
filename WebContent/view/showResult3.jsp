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
	String id = request.getParameter("oid");
	System.out.println("oid=" + id);
	int oid = Integer.parseInt(id);
	SelecterService ss = new SelecterService();
	ObjectBean ob = ObjectBeanService.findPublishedObjectBeanByID(oid);//查找发布后的问卷
	QuestionService qs = new QuestionService();
	List quesList = qs.litQuesByOid(oid);
	//
	List<Answer> answersByOne = new LinkedList<Answer>();
	answersByOne =  ReplayService.getAnswersByOne(oid);
	System.out.println(answersByOne.size());
	//回复总数
	int rcount = ReplayService.getAnswerCount(oid);
	Map<Integer, List<Map<Integer, Integer>>> allCount = ReplayService
			.getAllAnswer(oid);
	//System.out.println(allCount);
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
			window.location.href="./wjList.jsp";
		}
		</script>
	</head>
	<body topmargin="2">
				<br>
				<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="center">
						<strong><%=ob.getTitle()%> </strong>
					</td>
				</tr>
				<tr>
					<td align="center"><br></td>
				</tr>
				<tr>
					<td>
						<%=ob.getDiscribe().replaceAll("\\n","<br/>")%>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">本主题共有<font color="red"> <%=rcount%> </font>人作答。</span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<a href="showResult.jsp?oid=<%=oid%>">切换柱状图显示</a>
					</td>
				</tr>
				<tr>
					<td align="left">
						<a href="showResult2.jsp?oid=<%=oid%>">切换饼图显示</a>
					</td>
				</tr>
				<tr>
					<td align="left">
						<a href="showResult4.jsp?oid=<%=oid%>">切换表格显示</a>
					</td>
				</tr>
		</table>
		<table width="750" align="center" cellpadding="2" cellspacing="1" class="tab1">
			<%
				if (answersByOne != null && answersByOne.size() > 0) {
				for (int i = 0; i < answersByOne.size(); i++) {
					Answer answer = (Answer) answersByOne.get(i);
					String str[] = answer.getSeValue().split("--");
			%>
			<tr>
				<td bgcolor="##FFFF99">
					<span id="title<%=i%>"><%=i+1%>.<%=""%></span>
					<br/>
				</td>
			</tr>
				<%
					for (int j = 0; j < str.length; j++) 
					{
				%>
			<tr>
			<%
			if (j%2==0)
			{
			%>
				<td bgcolor="#CCCCCC">
				<%
			}else{
				%>
				<td bgcolor="#EEEEEE">
				<%
			}
				%>
					<span id="title<%=i%>"><%=str[j]%></span>
					<br/>
				</td>
			</tr>
			<%
					}
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

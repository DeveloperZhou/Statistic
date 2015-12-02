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
	String userName = session.getAttribute("userName").toString();
	QuestionService qs = new QuestionService();
	List<Replay> replayList = StudentService.getReplays(userName);
	StudentBean me = StudentService.getOne(userName);
	int allScore = 0;
	//
	//List<Answer> answersByOne = new LinkedList<Answer>();
	//answersByOne =  ReplayService.getAnswersByOne(oid);
	//System.out.println(answersByOne.size());
	//回复总数
	//int rcount = ReplayService.getAnswerCount(oid);
	//Map<Integer, List<Map<Integer, Integer>>> allCount = ReplayService
	//		.getAllAnswer(oid);
	//System.out.println(allCount);
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
			window.location.href="./stuWjList.jsp";
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
						<span class="m_right">你共签到了<font color="red"> <%=QderService.QianDaoTimes(userName)%> </font>次。</span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">你共回答了<font color="red"> <%=replayList.size()%> </font>次。</span>
					</td>
				</tr>
		</table>
		<%
		
		for (int k = 0; k < replayList.size(); k++) {
			Replay replay = replayList.get(k);
			List quesList = qs.litQuesByOid(replay.getoId());
			List<Answer> answersByOne =  ReplayService.getAnswersById(replay.getoId(),replay.getReplayId());
			int thisScore = ReplayService.getScoreById(replay.getoId(),replay.getReplayId());
			allScore += thisScore;
			ObjectBean ob = ObjectBeanService.findPublishedObjectBeanByID(replay.getoId());//查找发布后的问卷
		%>
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right"><%=k+1 %>.<%=ob.getTitle()%></span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">此次得分： <%=thisScore %> 分</span>
					</td>
				</tr>
		</table>
		
		<table align="center" cellpadding="2" cellspacing="1" class="tab1" border="1">
			<tr>

			<%
			for (int i = 0; i < quesList.size(); i++) {
				Question ques = (Question) quesList.get(i);
			%>
					<th bgcolor="#B9B9FF"><%=ques.getContent()%></th>
			<%
			}
			%>
			</tr>
			<%
				if (answersByOne != null && answersByOne.size() > 0) {
				for (int i = 0; i < answersByOne.size(); i++) {
					Answer answer = (Answer) answersByOne.get(i);
					String str[] = answer.getSeValue().split("--");
			%>
			<tr>
				<%
					for (int j = 0; j < str.length; j++) 
					{
				%>
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
					<%=str[j]%>
				</td>
				<%
					}
				%>
			</tr>
			<%
				}
			}
			%>
		</table>
		<% } %>
		
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">总得分： <%=allScore %> 分</span>
					</td>
				</tr>
		</table>
		
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">教师意见： <%=me.getAdvice() %></span>
					</td>
				</tr>
		</table>
		
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left">
						<span class="m_right">我的反馈： <%=me.getFeedback() %></span>
					</td>
				</tr>
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

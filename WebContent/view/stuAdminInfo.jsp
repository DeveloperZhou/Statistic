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
	StudentService stus = new StudentService();
	String userName = request.getParameter("studentName");;
	QuestionService qs = new QuestionService();
	List<Replay> replayList = StudentService.getReplays(userName);
	List<Point> pointList = ps.ListPoint();
	int allScore = 0;
	String myPositiveAdvice = "";
	String myNegativeAdvice = "";
	/*
	ArrayList<DefineMap> pointScore = new ArrayList<DefineMap>();
	
	for (int m=0;m<pointList.size();m++)
	{
		DefineMap dm = new DefineMap();
		dm.setKey(pointList.get(m).getPid());
		dm.setValue(0);
		pointScore.add(dm);
	}
	*/
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
		//提交
		function sbmOK(){
			if (chkForm()) {
				document.am.submit();
			}
		 }

		//校验
		function chkForm() {
			var advice = document.all("advice").value;

			if (advice == "" || advice.length == 0) {
				alert("输入域 意见 不能为空。");
				document.all("advice").focus();
				return false;
			}
			return true;
		}

		//取消
		function cancel(){
			window.location.href="./studentsInfo.jsp";
		 }
		</script>
	</head>
	<body topmargin="2">
	<form action="./adviceUpdateAction.jsp?username=<%=userName%>" name="am" method="post">
		<br>
		<table cellspacing="0" cellpadding="1" width="750" align="center" class="tab1">
				<tr>
					<td align="right">
						<span class=""> <br> </span>
					</td>
				</tr>
				<tr>
					<td align="left" name="username">
						<span class="m_right"><%=userName%><font color="red"></span>
					</td>
				</tr>
		</table>
		<table align="center" cellpadding="2" cellspacing="1" class="tab1" border="1">
			<tr>

			<%
			for (int i = 0; i < pointList.size(); i++) {
				Point point = (Point) pointList.get(i);
			%>
					<th bgcolor="#D3A4FF">知识点：<%=point.getPid()%></th>
			<%
			}
			%>
			</tr>
			<%
			for (int i = 0; i < pointList.size(); i++) {
				Point point = (Point) pointList.get(i);
			%>
					<th bgcolor="#FFFF93"><%=point.getContent()%></th>
			<%
			}
			%>
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
				List<Point> points = ps.Points(replay.getoId(), i);
				String pointString = "";
				for (int j=0;j<points.size();j++)
				{
					pointString +=points.get(j).getPid()+"  ";
				}
			%>
					<th bgcolor="##FFFF99"><%=ques.getContent()%>(知识点：<%=ques.getPoint()%> )(详细知识点：<%=pointString%>)</th>
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
		<br>
		<table align="center" cellpadding="2" cellspacing="1" class="tab1" border="1">
				<tr>
					<th align="right">
						<span class=""> 知识点得分情况汇总<br> </span>
					</th>
				</tr>
				<td align="left">
						<span class="m_right">知识点</span>
					</td>
					<td align="left">
						<span class="m_right">得分</span>
					</td>
					<td align="left">
						<span class="m_right">总分</span>
					</td>
					<td align="left">
						<span class="m_right">百分比</span>
					</td>
					<td align="left">
						<span class="m_right">建议</span>
					</td>
				<%
				Map<Integer,Integer> wordsFrenMaps = StudentService.getOneAllPointScore(userName);
				Map<Integer,Integer> AllPointScore = StudentService.getAllPointScore(userName);
				Iterator<Map.Entry<Integer,Integer>> wordsFrenMapsIterator=wordsFrenMaps.entrySet().iterator();
				//Iterator<Map.Entry<Integer,Integer>> allPointScoreIterator=AllPointScore.entrySet().iterator();
				while (wordsFrenMapsIterator.hasNext()){
					Map.Entry<Integer,Integer> wordsFrenEntry=wordsFrenMapsIterator.next();
					//Map.Entry<Integer,Integer> allPointScoreEntry=allPointScoreIterator.next();
				%>
				<tr>
					<td align="left">
						<span class="m_right">知识点：<%=wordsFrenEntry.getKey() %></span>
					</td>
					<td align="left">
						<span class="m_right"><%=wordsFrenEntry.getValue() %></span>
					</td>
					<td align="left">
					<%
					int pointAllScore = 0;
					if(AllPointScore.containsKey(wordsFrenEntry.getKey())){
						pointAllScore = AllPointScore.get(wordsFrenEntry.getKey());
					}
					%>
						<span class="m_right"><%=pointAllScore %></span>
					</td>
					
					<td align="left">
					<%
					String percent = "";
					float p = 0;
					if(pointAllScore==0){
						p = -1;
						percent = "此知识点总分为零";
					}
					else{
						p = 1000*wordsFrenEntry.getValue()/pointAllScore;
						p /= 10;
						percent = ""+p+"%";
					}
					%>
						<span class="m_right"><%=percent %></span>
					</td>
					
					
					<%
					String pointAdvice = "";
					if(p==-1){
						pointAdvice = "该知识点总分为0，无法评论";
					%>
					<td align="left" bgcolor="E0E0E0" >
						<span class="m_right"><%=pointAdvice %></span>
					</td>
					<%
					}
					else if(p<=35){
						pointAdvice = "该知识点薄弱";
						myNegativeAdvice += " "+"知识点:"+ps.getPoint(wordsFrenEntry.getKey()).getContent();
						%>
						<td align="left" bgcolor="FF0000" >
							<span class="m_right"><%=pointAdvice %></span>
						</td>
						<%
					}
					else if(p<=50){
						pointAdvice = "该知识点较弱";
						//myNegativeAdvice += " "+"知识点"+ps.getPoint(wordsFrenEntry.getKey());
						%>
						<td align="left" bgcolor="FFD306" >
							<span class="m_right"><%=pointAdvice %></span>
						</td>
						<%
					}
					else if(p<=70){
						pointAdvice = "该知识点一般";
						//myPositiveAdvice += " "+"知识点"+ps.getPoint(wordsFrenEntry.getKey());
						%>
						<td align="left" bgcolor="2828FF" >
							<span class="m_right"><%=pointAdvice %></span>
						</td>
						<%
					}
					else {
						pointAdvice = "该知识点很好";
						myPositiveAdvice += " "+"知识点"+ps.getPoint(wordsFrenEntry.getKey()).getContent();
						%>
						<td align="left" bgcolor="00BB00" >
							<span class="m_right"><%=pointAdvice %></span>
						</td>
						<%
					}
					%>
				</tr>
				<%
				}
				%>
		</table>
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
		
		<table width="100%" align="center" class="table">
				<tr>
					<td height="30" width="80px" align="right">
						意见：
					</td>
					<td>
						&nbsp;
						<%
						if(myNegativeAdvice!="")
						{
							myNegativeAdvice = "在"+myNegativeAdvice+"上表现欠佳，";
						}
						if(myPositiveAdvice!="")
						{
							myPositiveAdvice = "在"+myPositiveAdvice+"上表现较好.";
						}
						%>
						<textarea name="advice" cols="100" rows="5" ><%=myNegativeAdvice+myPositiveAdvice %></textarea>
					</td>
				</tr>
				<tr>
					<td height="30">
					</td>
					<td>
						&nbsp;
						<input type='button'   onClick="sbmOK();" value=' 确     定 ' />
						&nbsp;&nbsp;
						<input type="button"   onclick="cancel()" value=" 返     回 " />
					</td>
				</tr>
		</table>
	</body>
</html>

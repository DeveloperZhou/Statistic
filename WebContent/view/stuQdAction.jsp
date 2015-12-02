<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	QderService obs=new QderService();
	String replayCode = "";
	String id = request.getParameter("qid");//主题Id
	String replayIp = Func.getIpAddr(request);
	String userName = Func.getString(session.getAttribute("userName"));
	if("".equals(userName)){
		 String errmsg="error1";
		 out.println("<script>alert('登录失败')</script>");
	     return;
	   }
	else{
		replayCode = userName;
	}
	Qder ob = new Qder();
	ob.setQdCode(replayCode);
	ob.setQdId(Integer.parseInt(id));
	ob.setQdIp(replayIp);
	int count = obs.has(ob);
	int num = 0;
	if (count>0)
	{
		num = -1;
	}
	else
	{
		num = obs.intsertQder(ob);
	}
	
	if(num > 0){
	%>
	<script>
		alert("签到成功");
	</script>
	<%
	}else if (num == -1){
		%>
	<script>
		alert("已经签到");
	</script>
	<%
	}else{
		%>
	<script>
		alert("签到失败");
	</script>
	<%
	}
%>
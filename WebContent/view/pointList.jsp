<%@page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
		List<Point> pointList = PointService.ListPoint();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
//新建题目
function newQues() {
	window.self.location="./newPoint.jsp";
}

//删除题目
function delQues(sep) {
	if(confirm("您确实要删除该知识点吗？删除后，不能再恢复。"))
	{
		window.self.location="./delPoint.jsp?"+"sep="+sep;
	}
}
	
//返回
function back() {
	window.location.href="./wjList.jsp";
}
</script>
</head>
<body topmargin="2">
		<table class="table">
			<tr>
				<td valign="top">
					<table class="table">
						<tr>
							<td width="35" rowspan="2" valign="top"></td>
							<td>
								<table class="table">
									<tr>
										<td colspan="2">
											<div align="center" style="font-size: 14px;">
												<strong><%="知识点："%></strong>
											</div>
											<br />
										</td>
									</tr>
									<tr>
										<td>
											<table class="table">
												<tr>
													<td>
														<%="所含知识点涵盖"%>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="10">
											<span> <input type="button" name="sbmQues"  onclick="newQues();" value=" 新加知识点 " /> </span>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<form method="post" action="" name="myForm">
												<table class="table2">
													<%
														int subCnt = 0;
														if (pointList != null && pointList.size() > 0) {
														for (int i = 0; i < pointList.size(); i++) {
																Point point = (Point) pointList.get(i);
																int sep = point.getPid();
																subCnt++;
															%>
													<tr>
														<td bgcolor="#CDE2FD" colspan=4>
															<span id="title<%=i%>"><%=i+1%>.<%=point.getContent()%></span>
															<br />
														</td>
													</tr>
													<td>
						<br/>
						<a onclick="delQues(<%=point.getPid()%>);" href="#">删除知识点</a>
						<br />
					</td>
													<%
														}
													}
													%>
												</table>
											</form>
										</td>
									</tr>
									<tr>
										<td height="5">

										</td>
									</tr>
									<tr>
										<td height="5">
										</td>
									</tr>
									<tr>
										<td>
											<div id="buttonArea">
												<input type="button" name="btnOK" value=" 返  回   "  onclick="back();" />
												<br />
											</div>
										</td>
									</tr>
								</table>
								<input type="hidden" name="subCnt" id="subCnt"
									value="<%=subCnt%>" />
							</td>
						</tr>
						<tr>
							<td height="20"></td>
						</tr>
					</table>
					<br />
				</td>
				<td width="23" rowspan="2">
					&nbsp;
				</td>
			</tr>
		</table>

	</body>
</html>

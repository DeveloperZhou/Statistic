<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.sql.*"%>
<%
			PointService ps = new PointService();
%>
<html>
	<head>
		<title>问卷管理系统</title>
		<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
		<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>
		
		<script type="text/javascript">
	var textNumber = 1,sEle;
	var qvalue=0;
	
    //提交
	function submit(){
 		if(document.myForm.content.value.length==0)	{
 			alert("输入域 知识点 不能为空");
 			document.myForm.content.focus();
 			return false;
 		}else{
 		  	 	document.myForm.action="./newPointAction.jsp";
 		  	    document.myForm.submit();
 				return true;
		}
	}
	
	//返回
	function back() {
		window.location.href="./pointList.jsp";
	}
</script>
</head>
<body topmargin="2">
		<table cellspacing="0" cellpadding="0" width="500" align="center" class="tab">
			<tbody>
				<tr>
					<td height="30"></td>
				</tr>
				<tr>
					<td align="center">
						知识点
					</td>
				</tr>
				<tr>
					<td align="left">
						<button type="button" class="btn" class="btn" onclick="submit();"> 保     存 </button>
						<button type="button" class="btn" class="btn" onclick="back();"> 返     回 </button>
					</td>
				</tr>
			</tbody>
		</table>
		<form action="" name="myForm" method="post">
			<table width="500" border="0" align="center" cellpadding="2"  cellspacing="1" id="myTable" class="tab">
				<tr>
					<td valign="top">
						<label>
							知识点：
						</label>
					</td>
					<td>
						<input type="text" name="content"  style="width:300px;"/>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="oid" value="" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
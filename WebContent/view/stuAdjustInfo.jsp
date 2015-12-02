<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
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
//提交
function sbmOK(){
	if (chkForm()) {
		document.sm.submit();
	}
 }

//校验
function chkForm() {
	var discribe = document.all("discribe").value;

	if (discribe == "" || discribe.length == 0) {
		alert("输入域 反馈 不能为空。");
		document.all("discribe").focus();
		return false;
	}
	return true;
}

//取消
function cancel(){
 	history.go(-1);
 }
</script>
	</head>
	<body leftmargin="8" topmargin="8">
		<form action="./stuAdjustInfoAction.jsp?username=<%=session.getAttribute("userName").toString() %>" name="sm" method="post">
		<input type="hidden" name="createUser" value="<%=session.getAttribute("userName")%>" />
		<table width="100%" align="center" class="table">
				<tbody>
					<tr>
						<td height="30"></td>
					</tr>
					<tr>
						<td align="center">
							更改信息及信息反馈<br/>
						</td>
					</tr>
				</tbody>
			</table>
			<table width="100%" align="center" class="table">
				<tr>
					<td height="30" align="right">
						反馈：
					</td>
					<td>
						&nbsp;
						<textarea name="discribe" cols="100" rows="15" ></textarea>
					</td>
				</tr>
				<tr>
				<td height="30" ></td>
				</tr>
				<tr>
					<td height="30">
					</td>
					<td>
						&nbsp;
						<input type='button'   onClick="sbmOK();" value=' 确     定 ' />
						&nbsp;&nbsp;
						<input type="button"   onclick="cancel()" value=" 取    消 " />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	//清IE缓存，防止用户注销后点IE后退进入系统
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String errmsg = request.getParameter("errmsg");
	request.getSession(true);
	String chk = "false";
	session.setAttribute("Enter", chk);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MyLearn身份确认</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<link href="css/login.css" rel="stylesheet" type="text/css" />
	<script src="js/login.js" type="text/javascript"></script>
	<script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
	<!--                       CSS                       -->
	  
		<!-- Reset Stylesheet -->
		<link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />
	  
		<!-- Main Stylesheet -->
		<link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />
		
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />	
		
		<!--                       Javascripts                       -->
	  
		<!-- jQuery -->
		<script type="text/javascript" src="resources/scripts/jquery-1.3.2.min.js"></script>
		
		<!-- jQuery Configuration -->
		<script type="text/javascript" src="resources/scripts/simpla.jquery.configuration.js"></script>
		
		<!-- Facebox jQuery Plugin -->
		<script type="text/javascript" src="resources/scripts/facebox.js"></script>
		
		<!-- jQuery WYSIWYG Plugin -->
		<script type="text/javascript" src="resources/scripts/jquery.wysiwyg.js"></script>
<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>
<script>
    
	function OK_onClick() {
		if (chkForm()) {
			document.all("logform").submit();
			return;
		}
	}

	function chkForm() {
		var chkName = document.all("username").value;
		var chkPassword = document.all("password").value;

		if (chkName == "" || chkName.length == 0) {
			alert("请输入学号。");
			document.all("username").focus();
			return false;
		} else if (chkPassword == "" || chkPassword.length == 0) {
			alert("请输入密码。");
			document.all("password").focus();
			return false;
		}
		return true;
	}

	//通过点击回车键提交表单
	function entersubmit(e) {
		var charCode = (navigator.appName == "Netscape") ? e.which : e.keyCode;
		if (charCode == 13) {
			OK_onClick();
		}
	}

	//重置
	function resetForm() {
		document.all("logform").reset();
		return;
	}
</script>
<meta name="viewport" content="width=device-width, initial-scale=1" /> 
</HEAD>
<body id="login">
		
		<div id="login-wrapper" class="png_bg">
			<div id="login-top">
				<h1>登录</h1>
				<img id="logo" src="resources/images/logo3.png" alt="Simpla Admin logo" width="100" height="100"/>
				MYL身份验证
			</div> 
			
			<div id="login-content">
				
				<form action="user/adminLoginAction.jsp" id="logform" method="post" onKeyDown="entersubmit(event)">
				
					<div class="notification information png_bg" id="announce">
						<div>
							请输入正确的学号和密码.
						</div>
					</div>
					
					<p>
						<label>学&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
						<input class="text-input" type="text" name="username" id="loginUser" onfocus="" onblur="checkUser()"/>
					</p>
					<div class="clear"></div>
					<p>
						<label>密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
						<input class="text-input" type="password" name="password" id="loginPwd" onfocus="" onblur="checkPwd()"/>
					</p>
					<div class="clear"></div>
					<div class="clear"></div>
					<p>
						<input class="button" type="submit" value="登录" onclick="javascript:OK_onClick()" />
					</p>
					
				</form>
			</div>
			
		</div>
		
  </body>
</HTML>

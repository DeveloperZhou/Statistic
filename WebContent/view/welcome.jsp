<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>课程交互平台</TITLE>
<meta name="viewport" content="width=device-width, initial-scale=1" /> 
<!--  
		<LINK href="images/public.css" type=text/css rel=stylesheet>
		<LINK href="images/login.css" type=text/css rel=stylesheet>
-->
		<link rel="shortcut icon" href="../resources/images/favicon.ico" />
		<link href="../resources/bootstrap/css/bootstrap-huan.css"
		rel="stylesheet">
		<link href="../resources/font-awesome/css/font-awesome.min.css"
		rel="stylesheet">
		<link href="../resources/css/style.css" rel="stylesheet">
		
<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>

<script>
    function admin_onClick(){
    	window.location.href = "./adminLogin.jsp";
    }
    function stu_onClick(){
    	window.location.href = "./stuLogin.jsp";
    }
</script>

		<style>
			.question-number{
				color: #5cb85c;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}
			
			.question-number-2{
				color: #5bc0de;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}
			.question-number-3{
				color: #d9534f;
				font-weight: bolder;
				display: inline-block;
				width: 30px;
				text-align: center;
			}
			
			a.join-practice-btn{
				margin:0;
				margin-left:20px;
			}
			
			.content ul.question-list-knowledge{
				padding:8px 20px;
			}
			
			.knowledge-title{
				background-color:#EEE;
				padding:2px 10px;
				margin-bottom:20px;
				cursor:pointer;
				border:1px solid #FFF;
				border-radius:4px;
			}
			
			.knowledge-title-name{
				margin-left:8px;
			}
			
			.point-name{
				width:200px;
				display:inline-block;
			}
		</style>

</HEAD>
<BODY>
	<DIV id=div1>
		<header>
			<div class="container">
				<div class="row">
					<div class="col-xs-5">
						<div class="logo">
							<h1><a href="#"><img alt="" src="../resources/images/logo.png"></a></h1>
						</div>
					</div>
				</div>
			</div>
		</header>
		
		<div class="full-slider">
			<!-- Slider (Flex Slider) -->

			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="flexslider">
							<div class="flex-caption">
								<!-- Left column -->
								<div class="col-l">
									<p style="text-indent:2em;">课程交互平台</p>
									<p style="text-indent:2em;"></p>
								</div>
								<!-- Right column -->
								<div class="col-r">

									<!-- Use the class "flex-back" to add background inside flex slider -->

									<!-- <img alt="" src="resources/images/ad.png"> -->
									<p>如果使用过程中出现任何疑问，欢迎发送邮件至1374335743@qq.com。</p>

									<!-- Button -->
									<!--  
										<a class="btn btn-default btn-cta" href="welcome.jsp"><i class="fa fa-arrow-circle-down"></i> 建议</a>
									-->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content" style="margin-bottom: 100px;">
			<div class="container">
					<div class="row">
						<div class="col-xs-7" id="login-info">
							<a class="btn btn-primary" href = "./adminLogin.jsp">管理员</a>
							<a class="btn btn-success" href="./stuLogin.jsp">学生</a>
						</div>
					</div>
			</div>
		</div>
	</DIV>
<DIV id=div2 style="DISPLAY: none"></DIV>
</CONTENTTEMPLATE>
</BODY>
</HTML>

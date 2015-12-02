<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
	List<Major> majorList = MajorService.ListMajor();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>MYL注册</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <link rel="stylesheet" href="css/register.css" type="text/css" />
	<script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/sliding.form.js"></script>
	<script type="text/javascript" src="js/registerAjax.js"></script>
  </head>
 <body>
	<div> <span class="reference"> <a href="stuLogin.jsp">返回登录</a> </span> </div>
<div id="content">
  <h1>MYL注册界面</h1>
  <div id="wrapper">
    <div id="steps">
      <form id="formElem" name="formElem" action="opRegister.jsp" method="post">
        <fieldset class="step">
          <legend>账号</legend>
          <div id="announce"></div>
          <p>
            <label for="username">学号</label>
            <input id="username" name="username" onfocus="clearAnnounce()" onblur="searchSuggest()"/>
          </p>
          <p>
            <label for="user">姓名</label>
            <input id="user" name="user" onfocus="clearAnnounce()" onblur="searchSuggest()"/>
          </p>
          <p>
            <label for="password">密码</label>
            <input id="rpassword" name="password" type="password" AUTOCOMPLETE=OFF />
          </p>
          <p>
            <label for="password">重复密码</label>
            <input id="password" name="password" type="password" AUTOCOMPLETE=OFF />
          </p>				
			<p>
				 <select name="point" onchange=getSelect() style="width:120px;">
						<%
						if (majorList != null && majorList.size() > 0) {
							for (int i = 0; i < majorList.size(); i++) {
								Major m = (Major) majorList.get(i);
								int sep = m.getMid(); 
								%>
								
							<option value=<%=sep %> selected>
								<%=m.getMajorName() %>
							</option>
								<% 	
							}	
						}
						%>
						</select>
					</p>
        </fieldset>
        <fieldset class="step">
          <legend>完成</legend>
          <p> 确认填写完毕,点击注册. </p>
          <p class="submit">
            <button id="registerButton" type="submit">立即注册</button>
          </p>
        </fieldset>
      </form>
    </div>
    <div id="navigation" style="display:none;">
      <ul>
        <li class="selected"> <a href="#">账号</a> </li>
        <li> <a href="#">完成</a> </li>
      </ul>
    </div>
  </div>
</div>

</body>
</html>
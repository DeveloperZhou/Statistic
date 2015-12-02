<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>menu</title>
<link rel="stylesheet" href="skin/css/base.css" type="text/css" />
<link rel="stylesheet" href="skin/css/menu.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>
<script language='javascript'>var curopenItem = '1';</script>
<script language="javascript" type="text/javascript" src="skin/js/frame/menu.js"></script>
<base target="main" />
</head>
<body target="main">
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	<!-- Item 1 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items1_1")'><b>常用操作</b></dt>
        <dd style='display:block' class='sitem' id='items1_1'>
          <ul class='sitemu'>
            <li>
              <div class='items'>
                <div class='fllct'><a href='./wjList.jsp' target='main'>问卷管理</a></div>
                <div class='flrct'> <a href='./wjNew.jsp' target='main'><img src='skin/images/frame/gtk-sadd.png' alt='创建问卷' title='创建问卷'/></a> </div>
              </div>
            </li>
            <%--
            <li><a href='archives.html' target='main'>所有列表</a> </li>
            <li>
              <div class='items'>
                <div class='fllct'><a href='archives.html' target='main'>内容回收站</a></div>
                <div class='flrct'> <a href='archives.html' target='main'><img src='skin/images/frame/gtk-del.png' alt='清空回收站' title='清空回收站'/></a> </div>
              </div>
            </li>
             --%>
          </ul>
          <ul class='sitemu'>
            <li>
              <div class='items'>
                <div class='fllct'><a href='./qdList.jsp' target='main'>签到表管理</a></div>
              </div>
            </li>
          </ul>
        </dd>
      </dl>
      <!-- Item 1 End -->
      <dl class='bitem'>
        <dt onClick='showHide("items3_1")'><b>学生管理</b></dt>
        <dd style='display:block' class='sitem' id='items3_1'>
          <ul class='sitemu'>
            <li>
              <div class='items'>
                <div class='fllct'><a href='./studentsInfo.jsp' target='main'>学生信息</a></div>
              </div>
            </li>
          </ul>
        </dd>
      </dl>
      
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>系统帮助</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
             <li>
              <div class='items'>
                <div class='fllct'><a href='http://asciimath.org/' target='main'>公式编辑</a></div>
              </div>
            </li>
          </ul>
          
          <ul class='sitemu'>
             <li>
              <div class='items'>
                <div class='fllct'><a href='http://localhost:8080/vote/view/Browser.jsp' target='main'>我的网盘</a></div>
              </div>
            </li>
          </ul>
          
          <ul class='sitemu'>
             <li>
              <div class='items'>
                <div class='fllct'><a href='register.jsp' target='main'>学生注册</a></div>
              </div>
            </li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
</body>
</html>
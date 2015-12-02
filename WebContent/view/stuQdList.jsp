<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	List objList=QianDaoService.StuListQianDao();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String contextPath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>签到表</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<script async
	      src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=AM_HTMLorMML-full.js">
        </script>
		<script src="<%=request.getContextPath() %>/view/js/ASCIIMathML.js"></script>

<script language="javascript">

//获取选中的radio
function getCheckedRadio(radioObj)
{
   if(typeof radioObj=="undefined")
      return null;
   else if(typeof radioObj.length=="undefined")
      return radioObj;
   else
   {
      for(var i=0;i<radioObj.length;i++)
      {
         if(radioObj[i].checked)
            return radioObj[i];
      }
   }
   return null;
}

//获取radio值
function getRadioValue(radioObj)
{
   if(typeof radioObj=="undefined")
      return "";
   else if(typeof radioObj.length=="undefined")
      return radioObj.value;
   else
   {
      for(var i=0;i<radioObj.length;i++)
      {
         if(radioObj[i].checked)
            return radioObj[i].value;
      }
   }
   return "";
}

//获取CheckBox值
function getCheckBoxValue(checkboxObj,cnt)
{
   return getCheckBoxProperty(checkboxObj,cnt,'value');
}

//获取CheckBox某个属性值
function getCheckBoxProperty(checkboxObj,cnt,propertyName)
{
   var sValue = null;
   if(typeof cnt=="undefined") cnt=2;
   if(typeof checkboxObj=='undefined')
   {
      alert("没有可以选择的记录！");
      return "";
   }
   else if(typeof checkboxObj.length=="undefined")
   {
      checkboxObj.checked=true;
      return checkboxObj[propertyName];
   }
   else
   {
      for(var i=0;i<checkboxObj.length;i++)
      {
         if(checkboxObj[i].checked)
         {
            if(sValue==null) sValue='';
            sValue += ";"+checkboxObj[i][propertyName];
         }
      }
   }
   if(sValue==null)
   {
   	  alert("请至少选择一条记录！");
   	  return '';
   }
   if(sValue.length>0 && sValue.charAt(0)==';')
      sValue = sValue.substring(1);
   if(cnt==1 && sValue.indexOf(';')>-1)
   {
      alert("只能选择一条记录！");
      return "";
   }

   return sValue;
}

//新增问卷
function QD_onClick()
{
	if(typeof document.fm.radio=='undefined') return;
	   var pkValue=getCheckBoxValue(document.fm.radio);
	   if(pkValue!=""){
		   var topicCode = pkValue.split(",")[0];
		   var status = pkValue.split(",")[1];
		  if(status==1)
		   {
			  window.location.href="./stuQdAction.jsp?qid="+topicCode;
		   }
		   else
		   {
			alert("该签到表已经结束!");
		   }
	   }
}


</script>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="skin/images/newlinebg3.gif">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="center">
    <input type='button' class="coolbg np" onClick="QD_onClick();" value='签到' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>
  
<!--  内容列表   -->
<form name="fm" action="" method="post">
<input type="hidden" name="doType" value="" />
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="10" background="skin/images/tbg.gif">&nbsp;内容列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td width="6%">序号</td>
	<td width="4%">选择</td>
	<td width="35%">签到表</td>
	<td width="15%">状态</td>
	<td width="15%">更新时间</td>
	<td width="10%">发布人</td>
	<td width="20%">操作</td>
</tr>
<%
if(objList.size()==0){
%>
<tr align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
<td height="24" colspan="10" background="skin/images/tbg.gif">no data&nbsp;</td>
</tr>
<%}%>
<%
if(objList.size()>0){
	for(int i=0;i<objList.size();i++){
		QianDao ob=(QianDao)objList.get(i);
		int qid=ob.getQid();
		int state=ob.getState();
		String stateAlias = "";
		
		if(state==0) stateAlias = "草稿";
		if(state==1) stateAlias = "正在签到...";
		if(state==2) stateAlias = "已终止签到！";
		
		String userName = Func.getString(session.getAttribute("userName"));
		Qder qd = new Qder();
		qd.setQdCode(userName);
		qd.setQdId(qid);
		if(QderService.has(qd)>0)
		{
			stateAlias = "已经签过了";
		}else{
			stateAlias = "正在签到...";
		}
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><%=(i+1)%></td>
	<td><input name="radio" type="radio" value="<%=qid+","+state%>" class="np"></td>
	<td align="left"><a href="wjDetail.jsp"><%="签到表"+qid%></a></td>
	<td><%=stateAlias%></td>
	<td><%=sdf.format(ob.getCreateTime())%></td>
	<td>yeying</td>
	<td><a href="#" onclick='QD_onClick()'>签到</a></td>
</tr>
<%
  }
}
%>

<tr bgcolor="#FAFAF1">
<td height="28" colspan="10">
</td>
</tr>
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="10" align="center"><!--翻页代码 --></td>
</tr>
</table>
</form>
</body>
</html>
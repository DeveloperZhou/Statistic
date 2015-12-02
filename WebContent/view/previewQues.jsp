<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
			String id = request.getParameter("oid");
			String qseq = request.getParameter("seq");
			int oid = Integer.parseInt(id);
			int seq = Integer.parseInt(qseq);
			MyTool tool = new MyTool();
			QuestionService qs=new QuestionService();
			SelecterService ss=new SelecterService();
			PointService ps = new PointService();
			Question ques=qs.getQuesBySeq(seq,oid);
			ObjectBean ob = ObjectBeanService.findObjectBeanByID(oid);
			List selList=ss.listSelecterBySeq(seq,oid);
			int selCount = selList.size();
			int state = ob.getState();
			List<Point> pointList = PointService.ListPoint();
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
	function getSelect(){
		var qvalue = document.myForm.qtype.value;
		var addbutton=document.getElementById("add");
		 if(qvalue!=3){
		 	addbutton.removeAttribute("disabled");
		}else if(qvalue==3){
			addbutton.setAttribute("disabled","false");
		}
	 }
function addTextBox(form, afterElement) {
	var myTable = document.getElementById("myTable");
	var rowCnt = myTable.rows.length;
	textNumber = (rowCnt-4);
	textNumber++;
		var label1 = document.createElement("label");
		label1.setAttribute("class", "m_left");
		label1.appendChild(document.createTextNode("选项  "+textNumber+"："));
		var myTable = document.getElementById("myTable");
		var rowCnt = myTable.rows.length;
		var nextRow = myTable.insertRow(rowCnt - 1);
		var cellTitle = nextRow.insertCell(0);
		var cellText = nextRow.insertCell(1);
		cellTitle.className = "m_left";
		cellTitle.setAttribute("valign", "top");
		cellTitle.appendChild(label1);
		var txtName = "txt" + textNumber;
		var txtId = "txt" + textNumber;
		cellText.innerHTML = "<input type='text' name='" + txtName + "' id='" + txtId + "' style=\"width:260px;\"/>";
		//
		var label2 = document.createElement("label");
		label2.setAttribute("class", "m_left");
		label2.appendChild(document.createTextNode("分值："));
		var cellScoreText = nextRow.insertCell(2);
		var cellScore = nextRow.insertCell(3);
		cellScoreText.setAttribute("valign", "top");
		cellScoreText.className = "m_left";
		cellScoreText.setAttribute("valign", "top");
		cellScoreText.appendChild(label2);
		var scoreName = "sescore"+textNumber;
		cellScore.innerHTML = "<select name='"+scoreName+"' onchange=getSelect()'"+"' style=\"width:120px;\"/>"+"<option value="+0+" selected>"+0+" </option>"+"<option value= "+1 +" selected>"+1+"</option>"+"<option value="+2 +" selected>"+2+" </option>"+"<option value="+3 +" selected>"+3+" </option>"+"<option value="+4 +" selected>"+4+" </option>";
}
function removeTextBox(form) {
		var myTable = document.getElementById("myTable");
		var rowCnt = myTable.rows.length;
if (rowCnt > 4) {
			myTable.deleteRow(rowCnt-2);
textNumber--;
}
}
    //提交
	function submit(){
	}
	
</script>
</head>
<body topmargin="2">
		<table cellspacing="0" cellpadding="0" width="600" align="center" class="tab">
			<tbody>
				<tr>
					<td height="30"></td>
				</tr>
				<tr>
					<td align="center">
						查看题目设置
					</td>
				</tr>
			</tbody>
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
		<form action="" name="myForm" method="post">
			<table width="600" border="0" align="center" cellpadding="2"  cellspacing="1" id="myTable" class="tab">
				<tr>
					<td width="120px">
						题目：
					</td>
					<td>
						<input type="text" name="content" value="<%=ques.getContent()%>" style="width:300px;"/>
					</td>
					
					<td width="100px">
						主知识点：
					</td>
					
					
					<td>
						<select name="point" onchange=getSelect() style="width:120px;">
						<%
						if (pointList != null && pointList.size() > 0) {
							int selPoint = ques.getPoint();
							for (int i = 0; i < pointList.size(); i++) {
								Point point = (Point) pointList.get(i);
								int sep = point.getPid(); 
								%>
								
							<option value=<%=sep %> <% if(selPoint==sep)out.println("selected");%>>
								<%=point.getContent() %>
							</option>
								<% 	
							}	
						}
						%>
						</select>
					</td>
				</tr>
				
				<tr>
				<td valign="top">
						详细知识点：
					</td>
				<% 
						List<Point> points = ps.Points(oid, seq);
							String pointString = "";
							for (int j=0;j<points.size();j++)
							{
								pointString +=points.get(j).getPid()+"  ";
							}
				%>
				<th >(知识点：<%=ques.getPoint()%> )(详细知识点：<%=pointString%>)</th>
				
				<td>
					<table cellspacing="0" cellpadding="0" width="300" align="center" class="tab">
							<%
								for (int j = 0; j < pointList.size(); j++) {
									Point point = (Point) pointList.get(j);
									String cbxName = "check_" + point.getPid();
							%>
								<tr>
									<td width="200px"
									style="word-break:break-all;" valign="top">
									<input type="checkbox" name="<%=cbxName%>"
											value="<%=point.getPid()%>" />
											<%=point.getContent()%>
									<br/>
					</td>
								<%
								if (j == 3) {
					%>
					</tr>
						<tr>
						<%
						}
						}
						%>
						</tr>
						
						</table>
					</td>
				</tr>
				
				<tr>
					<td valign="top">
						类型：
					</td>
					<%	int qtype=ques.getQtype(); %>
					<td>
						<select name="qtype" onchange=getSelect() style="width:120px;">
							<option value="0" <% if(qtype==0)out.println("selected");%>>
								单选
							</option>
							<option value="1" <% if(qtype==1)out.println("selected");%>>
								多选
							</option>
							<option value="2" <% if(qtype==2)out.println("selected");%>>
								下拉框
							</option>
							<option value="3" <% if(qtype==3)out.println("selected");%>>
								文本框
							</option>
						</select>
					</td>
				</tr>
					<%
					if(selList!=null&&selList.size()>0){
					for(int i=0;i<selList.size();i++){
					Selecter sel=(Selecter)selList.get(i);
					String txtname = String.valueOf("txt" + (i+1));
					%>
				<tr>
					<td valign="top">
						<label>
							选项
							<%= i+1%>:
						</label>
					</td>
					<td>
						<input type="text" name="<%= txtname %>" id="<%= txtname %>"
							value="<%=sel.getContent()%>" style="width:260px;"/>
							<br />
					</td>
					<td valign="top">
						分值：
					</td>
					<%	int score=sel.getScore(); %>
					<td>
					<% String scoreName =  "sescore"+ (i+1);%>
						<select name="<%= scoreName %>" onchange=getSelect() style="width:120px;">
							<option value="0" <% if(score==0)out.println("selected");%>>
								0
							</option>
							<option value="1" <% if(score==1)out.println("selected");%>>
								1
							</option>
							<option value="2" <% if(score==2)out.println("selected");%>>
								2
							</option>
							<option value="3" <% if(score==3)out.println("selected");%>>
								3
							</option>
							<option value="4" <% if(score==4)out.println("selected");%>>
								4
							</option>
						</select>
					</td>
				</tr>
					<% 
					}}
					%>
				<tr>
					<td>
						<input type="hidden" name="listCnt" id="listCnt" value="" />
						<input type="hidden" name="oid" value="<%=oid%>" />
						<input type="hidden" name="seq" value="<%=seq%>" />
						<input type="hidden" id="pointcount" value="<%=pointList.size()%>" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
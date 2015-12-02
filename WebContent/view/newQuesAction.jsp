<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
	<%
	String id = request.getParameter("oid");
	System.out.println("id="+id);
	int oid = Integer.parseInt(id);
	PointService ps = new PointService();
	QuestionService qs = new QuestionService();
	SelecterService ss = new SelecterService();
	int count = ObjectBeanService.getCount(oid);
	int seq = 1;
	String content = request.getParameter("content");
	if(content!=null&&content.trim().length()>0){
		//content=new String(content.getBytes("iso8859-1"),"UTF-8");
		}
	String selCount = request.getParameter("listCnt");
	int listCnt = Integer.parseInt(selCount);
	String point=request.getParameter("point");
	int qpoint = Integer.parseInt(point);
	String type=request.getParameter("qtype");
	int qtype = Integer.parseInt(type);
	if (count == 0) {
		//往题目表中插入题目
		int insertQues = qs.addQues(oid, content, qtype, seq,qpoint);
		if (insertQues > 0) {
			//插入选项数据
			for (int i = 1; i <= listCnt; i++) {
				String name = String.valueOf("txt" + i);
				String value = request.getParameter(name);
				//value=new String(value.getBytes("iso8859-1"),"UTF-8");
				String scoreName = String.valueOf("sescore"+i);
				String scoreValue = request.getParameter(scoreName);
				ss.addSelecter(oid, seq, value, i,Integer.parseInt(scoreValue));
			}
		}
	} else {
		//往题目表中插入题目
		seq = count+1;
		int addQues = qs.addQues(oid, content, qtype, (count + 1),qpoint);
		if (addQues > 0) {
			//插入选项数据
			for (int i = 1; i <= listCnt; i++) {
		String name = String.valueOf("txt" + i);
		String value = request.getParameter(name);
		//value=new String(value.getBytes("iso8859-1"),"UTF-8");
		String scoreName = String.valueOf("sescore"+i);
		String scoreValue = request.getParameter(scoreName);
		ss.addSelecter(oid, (count + 1), value, i,Integer.parseInt(scoreValue));
			}
		}
	}
	//插入知识点序列
		Enumeration e = request.getParameterNames();
		System.out.println(1);
		List lname = new LinkedList();
		ArrayList<Question> questions = new ArrayList<Question>();
		Map map = new HashMap();
		while (e.hasMoreElements()) {//取得所有参数名
			System.out.println(2);
			String key = (String) e.nextElement();
			//if (key.startsWith("sub") || key.startsWith("oid"))
			//	key = (String) e.nextElement();
			String ln2 = key.substring(key.length()-1);//截取参数的后两个字符，以利于参数的正确排序
			map.put(ln2, key);
			lname.add(ln2);
			Collections.sort(lname);
		}
		System.out.println(3);
		for (int i = 0; i < lname.size(); i++) {
			System.out.println(4);
			String name = (String) map.get(lname.get(i));
			System.out.println(name);
			//System.out.println("name:" + name);
			//判断是否为复选框
			if (name.startsWith("check")) {
				String checkbox[] = request.getParameterValues(name);
				if (checkbox != null) {
					int size = checkbox.length;
					String s = "";
					for (int j = 0; j < size; j++) {
					Question que = new Question();
					que.setOid(oid);
					que.setSeq(seq);
					String cValue = checkbox[j];
					//System.out.println(checkbox[j] +cValue);
					int sePoint = Integer.parseInt(cValue);
					que.setPoint(sePoint);
					questions.add(que);
				  }
				}
				//单选或下拉框
			}
		}
		//存储知识点
		ps.intsertPointList(questions);
	
	response.sendRedirect("quesList.jsp?oid=" + oid);
%>

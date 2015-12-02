<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%
	String id=request.getParameter("oid");
	int oid = Integer.parseInt(id);
	String seq = request.getParameter("seq");
	int qseq = Integer.parseInt(seq);
	String point=request.getParameter("point");
	int qpoint = Integer.parseInt(point);
	String content=request.getParameter("content");
	String selCount = request.getParameter("listCnt");
	int listCnt = Integer.parseInt(selCount);
	String type=request.getParameter("qtype");
	int qtype = Integer.parseInt(type);
	PointService ps = new PointService();
	QuestionService qs = new QuestionService();
	SelecterService ss = new SelecterService();
	int count = ObjectBeanService.getCount(oid);
	//如果题目的最大顺序号小于所传进来的顺序号 则先修改顺序号再进行插入 否则直接插入
	//往题目表中插入题目
	qs.deleteQues(qseq, oid);
	int insertQues = qs.addQues(oid,content, qtype, qseq,qpoint);
	ss.deleteSelecter(qseq, oid);
	//插入选项数据
	for (int i = 1; i <= listCnt; i++) {
		String name = String.valueOf("txt"+(i));
		String value = request.getParameter(name);
		String scoreName = String.valueOf("sescore"+i);
		String scoreValue = request.getParameter(scoreName);
		ss.addSelecter(oid, qseq, value, i,Integer.parseInt(scoreValue));
	}
	//插入知识点序列
	Enumeration e = request.getParameterNames();
	List lname = new LinkedList();
	ArrayList<Question> questions = new ArrayList<Question>();
	Map map = new HashMap();
	while (e.hasMoreElements()) {//取得所有参数名
		String key = (String) e.nextElement();
		if (key.startsWith("sub") || key.startsWith("oid"))
			key = (String) e.nextElement();
		String ln2 = key.substring(key.length() - 2);//截取参数的后两个字符，以利于参数的正确排序
		map.put(ln2, key);
		lname.add(ln2);
		Collections.sort(lname);
	}
	
	for (int i = 0; i < lname.size(); i++) {
		String name = (String) map.get(lname.get(i));
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
				que.setSeq(qseq);
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
	ps.deletePoints(qseq, oid);
	ps.intsertPointList(questions);
	response.sendRedirect("quesList.jsp?oid="+ oid);
%>

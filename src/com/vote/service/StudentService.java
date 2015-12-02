package com.vote.service;

import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.vote.bean.ObjectBean;
import com.vote.bean.Question;
import com.vote.bean.Replay;
import com.vote.bean.StudentBean;


public class StudentService {
	
	/**
	 * 
	 * @param username
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public boolean isHas(String username) {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT  count(*) FROM wj_students WHERE username=?";
		int i = -1;
		int count = -1;
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1,username);
			rs=ps.executeQuery();
			if(rs.next()){
				if (rs.getInt(1)>=1)
				{
					count = 1;
				}
			}
		} catch (Exception e)
		{
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} finally {
			//释放资源
			dbcon.closeAll(con, ps, rs);
		}
		if (count == 1)
		{
			return true;
		}
		else return false;
	}
	
	public StudentBean longin(String username,String password) throws Exception {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StudentBean stu=new StudentBean();
		String md5Psw = MD5Util.MD5Encrypt(password);
		String sql = "select * from wj_students where username =? and password =?";//防止SQL注入
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, md5Psw);
			rs = ps.executeQuery();
			if(rs.first())
			{
				String uname=rs.getString("username");
				String pwd=rs.getString("password");
				stu.setPassword(pwd);
				stu.setUsername(uname);
			}
			else {
				String uname="no";
				String pwd="no";
				stu.setPassword(pwd);
				stu.setUsername(uname);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return stu;
	}
	
	public boolean registerUser(String username,String password,String xingming,String major) throws Exception {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String md5Psw = MD5Util.MD5Encrypt(password);
		String sql = "insert into wj_students(username,password,name,major) VALUES(?,?,?,?)";
		int i = -1;
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1,username);
			ps.setString(2,md5Psw);
			ps.setString(3,xingming);
			ps.setInt(4,Integer.parseInt(major));
			i = ps.executeUpdate();
			return i==1?true:false;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			//释放资源
			dbcon.closeAll(con, ps, rs);
		}
	}
	
	public static String getOldPsw(String username){
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String psw ="";
		String	sql = "select * from wj_students where username =?";
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	psw=rs.getString("password");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return psw;
	}
	
	/**
	 * 修改密码
	 * @param username
	 * @param newpsw
	 * @return
	 * @throws Exception 
	 */
	public static boolean updatePassword(String username,String newpsw) throws Exception{
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		String md5Psw = MD5Util.MD5Encrypt(newpsw);
		String	sql = "update wj_students set password = ? where username = ?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, md5Psw);
			ps.setString(2, username);
			ps.executeUpdate();
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return flag;
	}
	
	/**
	 * 获取该学生所有提交的问卷
	 * 
	 */
	public static List<Replay> getReplays (String user)
	{
		List<Replay> replayList=new LinkedList<Replay>();
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_replay where replayCode =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	Replay obj = new Replay();
		    	obj.setoId(rs.getInt("Oid"));
		    	obj.setReplayCode(rs.getString("replayCode"));
		    	obj.setReplayId(rs.getInt("replayId"));
		    	replayList.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return replayList;
	}
	
	
	/**
	 * 获取该学生所有提交的问卷
	 * 
	 */
	public static StudentBean getOne (String user)
	{
		StudentBean me = new StudentBean();
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_students where username = ?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    if(rs.first()){
		    	me.setAdvice(rs.getString("advice")) ;
		    	me.setFeedback(rs.getString("feedback")) ;
		    	me.setName(rs.getString("name")) ;
		    	me.setUsername(rs.getString("username"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return me;
	}
	
	/**
	 * 
	 */
	public static List<StudentBean> getAllStudents ()
	{
		List<StudentBean> studentsList=new LinkedList<StudentBean>();
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_students order  by major asc,username asc";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	StudentBean obj = new StudentBean();
		    	obj.setUsername(rs.getString("username"));
		    	obj.setScore(rs.getInt("score"));
		    	obj.setName(rs.getString("name"));
		    	obj.setAdvice(rs.getString("advice"));
		    	obj.setFeedback(rs.getString("feedback"));
		    	String major = MajorService.getMajor(rs.getInt("major")).getMajorName();
		    	obj.setMajor(major);
		    	List<Replay> replayList = StudentService.getReplays(rs.getString("username"));
		    	obj.setAnsTimes(replayList.size());
		    	studentsList.add(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return studentsList;
	}
	
	/**
	 * 
	 */
	public static boolean updateAdvice(String username,String advice) throws Exception{
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		String	sql = "update wj_students set advice = ? where username = ?";
		System.out.println(sql);
		System.out.println(username+":"+advice);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, advice);
			ps.setString(2, username);
			ps.executeUpdate();
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return flag;
	}
	
	/**
	 * 
	 */
	public static boolean updateScore(String username,int score) throws Exception{
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		String	sql = "update wj_students set score = ? where username = ?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setInt(1, score);
			ps.setString(2, username);
			ps.executeUpdate();
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return flag;
	}
	
	
	/**
	 * 
	 */
	public static boolean updateNameAndFeedback(String username,String feedback) throws Exception{
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		String	sql = "update wj_students set  feedback = ? where username = ?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, feedback);
			ps.setString(2, username);
			ps.executeUpdate();
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return flag;
	}
	
	/**
	 * 获取该学生所有提交的问卷
	 * 
	 */
	public static int getOneAllScore (String user)
	{
		int allScore = 0;
		int thisScore = 0;
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_replay where replayCode =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	Replay obj = new Replay();
		    	obj.setoId(rs.getInt("Oid"));
		    	obj.setReplayCode(rs.getString("replayCode"));
		    	obj.setReplayId(rs.getInt("replayId"));
		    	thisScore = ReplayService.getScoreById(rs.getInt("Oid"),rs.getInt("replayId"));
		    	allScore += thisScore;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return allScore;
	}
	
	/**
	 * 获取学生在某个知识点的得分
	 */
	public static Map getOneAllPointScore (String user)
	{
		int allScore = 0;
		int thisScore = 0;
		Map<Integer, Integer> wordsFren=new HashMap<Integer, Integer>();
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_replay where replayCode =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	PreparedStatement ps1 = null;
		    	ResultSet rs1 = null;
		    	String	sql1 = "select * from wj_question where oid =?";
		    	ps1=con.prepareStatement(sql1);
		    	ps1.setInt(1,rs.getInt("oid"));
		    	rs1 = ps1.executeQuery();
		    	while(rs1.next())
		    	{
		    		PreparedStatement ps2 = null;
			    	ResultSet rs2 = null;
			    	String	sql2 = "select * from wj_qpoints where oid =? and seq = ?";
			    	ps2=con.prepareStatement(sql2);
			    	ps2.setInt(1,rs1.getInt("oid"));
			    	ps2.setInt(2,rs1.getInt("seq"));
			    	rs2 = ps2.executeQuery();
			    	while(rs2.next())
			    	{
			    		int mapKey = rs2.getInt("point");
			    		int mapValue = getOneQestionScore(user,rs1.getInt("oid"),rs1.getInt("seq"));
			                if(mapKey>0){
			                    if(wordsFren.containsKey(mapKey)){
			                        wordsFren.put(mapKey,wordsFren.get(mapKey)+mapValue);
			                    }else {
			                        wordsFren.put(mapKey,mapValue);
			                    }
			            }
			    	}
		    	}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return wordsFren;
	}
	
	/**
	 * 获取该学生某个问卷某个题的得分
	 * 
	 */
	public static int getOneQestionScore (String user,int oid,int seq)
	{
		int allScore = 0;
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_replay where replayCode =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	PreparedStatement ps2 = null;
		    	ResultSet rs2 = null;
		    	String	sql2 = "select * from wj_answer where replayId = ? and oid =? and qSeq = ?";
		    	ps2=con.prepareStatement(sql2);
		    	ps2.setInt(1,rs.getInt("replayId"));
		    	ps2.setInt(2,oid);
		    	ps2.setInt(3,seq);
		    	rs2 = ps2.executeQuery();
		    	while(rs2.next())
		    	{
		    		PreparedStatement ps3 = null;
			    	ResultSet rs3 = null;
			    	String	sql3 = "select * from wj_selecter where oid = ? and qseq =? and selseq = ?";
			    	ps3=con.prepareStatement(sql3);
			    	ps3.setInt(1,oid);
			    	ps3.setInt(2,seq);
			    	ps3.setInt(3,rs2.getInt("seSeq"));
			    	rs3 = ps3.executeQuery();
			    	while(rs3.next())
			    	{
			    		allScore += rs3.getInt("score");
			    	}
		    	}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return allScore;
	}
	
	/**
	 * 获取学生在某个知识点的得分
	 */
	public static Map getAllPointScore (String user)
	{
		int allScore = 0;
		int thisScore = 0;
		Map<Integer, Integer> wordsFren=new HashMap<Integer, Integer>();
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_replay where replayCode =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setString(1, user);
			rs = ps.executeQuery();
		    while(rs.next()){
		    	PreparedStatement ps1 = null;
		    	ResultSet rs1 = null;
		    	String	sql1 = "select * from wj_question where oid =?";
		    	ps1=con.prepareStatement(sql1);
		    	ps1.setInt(1,rs.getInt("oid"));
		    	rs1 = ps1.executeQuery();
		    	while(rs1.next())
		    	{
		    		PreparedStatement ps2 = null;
			    	ResultSet rs2 = null;
			    	String	sql2 = "select * from wj_qpoints where oid =? and seq = ?";
			    	ps2=con.prepareStatement(sql2);
			    	ps2.setInt(1,rs1.getInt("oid"));
			    	ps2.setInt(2,rs1.getInt("seq"));
			    	rs2 = ps2.executeQuery();
			    	while(rs2.next())
			    	{
			    		int mapKey = rs2.getInt("point");
			    		int mapValue = getQestionScore(rs1.getInt("oid"),rs1.getInt("seq"));
			                if(mapKey>0){
			                    if(wordsFren.containsKey(mapKey)){
			                        wordsFren.put(mapKey,wordsFren.get(mapKey)+mapValue);
			                    }else {
			                        wordsFren.put(mapKey,mapValue);
			                    }
			            }
			    	}
		    	}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return wordsFren;
	}
	
	/**
	 * 获取某个问卷某个题的得分
	 * 
	 */
	public static int getQestionScore (int oid,int seq)
	{
		int allScore = 0;
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String	sql = "select * from wj_selecter where oid = ? and qseq =?";
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			ps=con.prepareStatement(sql);
			ps.setInt(1,oid);
	    	ps.setInt(2,seq);
	    	rs = ps.executeQuery();
	    	while(rs.next())
	    	{
	    		if (rs.getInt("score") >= allScore)
	    		{
	    			allScore = rs.getInt("score");
	    		}
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return allScore;
	}
	
}

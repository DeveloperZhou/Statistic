package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.vote.bean.Answer;
import com.vote.bean.Qder;
import com.vote.bean.QianDao;
import com.vote.bean.Question;
import com.vote.bean.Replay;
import com.vote.bean.Selecter;

public class QderService {

	
	public static List<Qder> getQders(int qid)  {
		DBConnection dbcon = new DBConnection();
		Connection con=null;
		Statement stm=null;
		ResultSet rs=null;
		List<Qder> qders = new LinkedList<Qder>();
		String sql = "select * from wj_qdlist where qid='"+ qid + "' order by qdCode asc";
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			 rs = stm.executeQuery(sql);
			 while(rs.next()){
				 Qder qder = new Qder();
				 int qdId = rs.getInt("qdId");
				 String qdCode = rs.getString("qdCode");
				 String qdIp = rs.getString("qdIp");
				 
				 qder.setQdId(qdId);;
				 qder.setQdCode(qdCode);;
				 qder.setQdIp(qdIp);
				 qders.add(qder);
		 }
			return qders;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
	}

	/**
	 * 根据主题ID查询回复总数
	 * @param oid 主题ID
	 * @return
	 */
	public static int getQderCount(int qid) {
		DBConnection db = new DBConnection();
		Connection con=null;
		Statement stm=null;
		ResultSet rs=null;
		String sql = "";
		int rcount = 0;
		try {
			con = db.getConnection();
			stm = con.createStatement();
			sql = "select count(*) from wj_qdlist where qid =" + qid;
			rs = stm.executeQuery(sql);
			while (rs.next()) {
				rcount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			db.closeAll(con, stm, rs);
		}
//		System.out.println("回复人数总数rcount:" + rcount);
		return rcount;
	}
	
	/**
	 * 将回复信息存储到数据库
	 * @param rList
	 * @return 这个一直出错
	 */
	/*
	public static int save(Qder q) {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement st=null;
		ResultSet rs = null;
		String sql = "";
		int r = 0;
		try {
			con = db.getConnection();
			con.setAutoCommit(false);
			sql = "insert into wj_qdlist(qdCode,qdIp,qid) values('"+q.getQdCode()+"','"+q.getQdIp()+"','"+q.getQdId()+"')";
			if (has(q) == 0)
			{
				System.out.println(sql);
				st = con.prepareStatement(sql);
				
				//st.setString(1,q.getQdCode());
				//st.setString(2,q.getQdIp());
				//st.setInt(3,q.getQdId());
				
				r = st.executeUpdate();
				//rs = st.getGeneratedKeys();
				//if(rs.next()) qdId = rs.getInt(1);
				System.out.println("r: "+r+"qdcode"+q.getQdCode()+"ip"+q.getQdIp());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeAll(con, st,rs);
		}
		return r;
	}
	*/
	// 新建
	public static int intsertQder(Qder q) throws Exception {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "";
		int id = 0;
		try {
			con = db.getConnection();
			sql = "insert into wj_qdlist(qdCode,qdIp,qid) values('"+q.getQdCode()+"','"+q.getQdIp()+"','"+q.getQdId()+"')";
			System.out.println(sql);
			stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys();
			if(rs.next()) id = rs.getInt(1);
			System.out.println("id:"+id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.closeAll(con, stmt,rs);
		}
		return id;
	}
	
	public static int has(Qder q) {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt1=null;
		ResultSet rs1=null;
		String sql1 = "";
		int count = 0;
		int qdId = 0;
		int result = 0;
		boolean defaultAutoCommit = true;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		try {
			con = db.getConnection();
			defaultAutoCommit = con.getAutoCommit();
			con.setAutoCommit(false);
			sql1 = "select count(*) from wj_qdlist where qid = ? and qdCode = ?";
			System.out.println(sql1);
			stmt1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
			stmt1.setInt(1, q.getQdId());
			stmt1.setString(2, q.getQdCode());
			rs1 = stmt1.executeQuery();
			
			if (rs1.first()) {
				result = rs1.getInt(1);
			}
			System.out.println("result"+result);
		} catch (Exception e) {
			try {
				if(con!=null){
					con.rollback();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			db.closeAll(con, stmt1, rs1);
		}
		return result;
	}
	
	public static int QianDaoTimes(String stu) {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt1=null;
		ResultSet rs1=null;
		String sql1 = "";
		int count = 0;
		int qdId = 0;
		int result = 0;
		boolean defaultAutoCommit = true;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		try {
			con = db.getConnection();
			defaultAutoCommit = con.getAutoCommit();
			con.setAutoCommit(false);
			sql1 = "select count(*) from wj_qdlist where qdCode = ?";
			System.out.println(sql1);
			stmt1 = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
			stmt1.setString(1, stu);
			rs1 = stmt1.executeQuery();
			
			if (rs1.first()) {
				result = rs1.getInt(1);
			}
			System.out.println("result"+result);
		} catch (Exception e) {
			try {
				if(con!=null){
					con.rollback();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			db.closeAll(con, stmt1, rs1);
		}
		return result;
	}
}

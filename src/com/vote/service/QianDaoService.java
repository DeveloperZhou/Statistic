package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import com.vote.bean.ObjectBean;
import com.vote.bean.QianDao;

public class QianDaoService {
	// 新建签到
	public static int intsertQianDao(QianDao bean) throws Exception {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "";
		int id = 0;
		try {
			con = db.getConnection();
			sql = "insert into wj_qiandao(state,creater) values(?,?)";
			System.out.println(sql);
			stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, bean.getState());
			stmt.setString(2, bean.getCreater());
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

		// 修改状态
		public static int changeQianDao(QianDao bean) throws Exception {
			DBConnection db = new DBConnection();
			Connection con=null;
			PreparedStatement stmt=null;
			ResultSet rs = null;
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			String sql = "";
			int id = 0;
			try {
				con = db.getConnection();
				sql = "UPDATE wj_qiandao SET state = ? WHERE qid = ?;";
				System.out.println(sql);
				stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				stmt.setInt(1, bean.getState());
				stmt.setInt(2, bean.getQid());
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
	
	// 删除签到
	public static boolean delObjectBean(int qid) throws Exception {
		DBConnection dbcon = new DBConnection();
		boolean flag = false;
		Connection conn = dbcon.getConnection();
		conn.setAutoCommit(false);
		String sql1 = "delete from wj_qiandao where qid="+qid;
		String sql2 = "delete from wj_qd where qid="+qid;
		try {
			dbcon.update(sql1, conn);
			dbcon.update(sql2, conn);
			conn.commit();
			flag = true;
		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
				dbcon.closeAll(conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

	public static QianDao getQianDao(int qid) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		QianDao ob = null;
		int result = 0;
		try {
			con = dbcon.getConnection();
			stm = con.createStatement();
			String sql = " select * from wj_object where qid=" + qid;
			System.out.println(sql);
			rs = stm.executeQuery(sql);
			while (rs.next()) {
				ob = new QianDao();
				ob.setQid(qid);
				ob.setState(rs.getInt("state"));
				ob.setCreateTime(rs.getTimestamp("createtime"));
				ob.setCreater(rs.getString("creater"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return ob;
	}
    
	//	 查看签到;
	public static List ListQianDao() {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select qid,createtime,state,creater from wj_qiandao order by qid desc";
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				QianDao ob=new QianDao();
				java.sql.Timestamp createtime=rs.getTimestamp("createtime");
				int state=rs.getInt("state");
				ob.setQid(rs.getInt("qid"));
				ob.setCreateTime(createtime);
				ob.setState(state);
				ob.setCreater(rs.getString("creater"));
				objList.add(ob);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
				dbcon.closeAll(con,stm,rs);
		}
		return objList;
	}
	
//	 查看签到;
	public static List StuListQianDao() {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select qid,createtime,state,creater from wj_qiandao where state=1 order by qid desc";
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				QianDao ob=new QianDao();
				java.sql.Timestamp createtime=rs.getTimestamp("createtime");
				int state=rs.getInt("state");
				ob.setQid(rs.getInt("qid"));
				ob.setCreateTime(createtime);
				ob.setState(state);
				ob.setCreater(rs.getString("creater"));
				objList.add(ob);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
				dbcon.closeAll(con,stm,rs);
		}
		return objList;
	}
}

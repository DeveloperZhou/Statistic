package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.vote.bean.ObjectBean;
import com.vote.bean.Point;
import com.vote.bean.Question;

public class PointService {
	// 新建知识点
	public static int intsertPoint(Point point) throws Exception {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "";
		int id = 0;
		try {
			con = db.getConnection();
			sql = "insert into wj_point(content,valid) values(?,?)";
			System.out.println(sql);
			stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, point.getContent());
			stmt.setInt(2, 1);
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
	
	
	// 新建知识点
		public static int intsertPointList(ArrayList<Question> list) throws Exception {
			DBConnection db = new DBConnection();
			Connection con=null;
			PreparedStatement stmt=null;
			ResultSet rs = null;
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			String sql = "";
			int id = 0;
			try {
				con = db.getConnection();
				sql = "insert into wj_qpoints(oid,seq,point) values(?,?,?)";
				System.out.println(sql);
				stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				for (int i=0;i<list.size();i++)
				{
					stmt.setInt(1, list.get(i).getOid());
					stmt.setInt(2, list.get(i).getSeq());
					stmt.setInt(3, list.get(i).getPoint());
					stmt.executeUpdate();
					rs = stmt.getGeneratedKeys();
					if(rs.next()) id = rs.getInt(1);
					System.out.println("id:"+id);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				db.closeAll(con, stmt,rs);
			}
			return id;
		}

	// 修改问卷
	public static int updatePoint(Point bean) {
		DBConnection dbcon = new DBConnection();
		String sql1 = "update wj_point set content = '" + bean.getContent()+"'";
		try {
			int i = dbcon.update(sql1, dbcon.getConnection());
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				dbcon.closeAll(dbcon.getConnection());
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}
	
	// 删除知识点
	public static boolean delPoint(int pid) throws Exception {
		DBConnection dbcon = new DBConnection();
		boolean flag = false;
		Connection conn = dbcon.getConnection();
		conn.setAutoCommit(false);
		String sql1 = "update wj_point set valid = 0 where pid="+pid;
		try {
			dbcon.update(sql1, conn);
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

	public static Point getPoint(int pid) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		Point ob = null;
		int result = 0;
		try {
			con = dbcon.getConnection();
			stm = con.createStatement();
			String sql = " select * from wj_point where pid=" + pid;
			System.out.println(sql);
			rs = stm.executeQuery(sql);
			while (rs.next()) {
				String content = rs.getString("content");
				ob = new Point();
				ob.setPid(pid);
				ob.setContent(content);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return ob;
	}
    
	//	 查看问卷;
	public static List ListPoint() {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select pid,content,date from wj_point where valid=1 order by pid asc";
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				Point ob=new Point();
				int oid=rs.getInt("pid");
				String content=rs.getString("content");
				java.sql.Timestamp createtime=rs.getTimestamp("date");
				ob.setPid(oid);
				ob.setContent(content);
				ob.setDate(createtime);
				
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
	
//	 查看问卷;
	public static List Points(int oid, int seq) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select point,oid,seq from wj_qpoints where oid="+oid+" and seq="+seq;
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				Point ob=new Point();
				ob.setPid(rs.getInt("point"));
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
	
//	 插入题目前先修改题目表的题目顺序号
	public int updatePointsOrder(int oid, int seq) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		String sql = "update wj_qpoints set seq=(seq + 1) where oid = '" + oid
				+ "'and seq > '" + seq + "'";
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			int i = stm.executeUpdate(sql);
			return i;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
	}
	
//	 根据传进来的问卷编号和题目的序号 修改题目表中题目的顺序
	public int updateQseq(int seq, int oid) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		int count=0;
		String sql = "update wj_qpoints set seq=(seq-1) where oid = " + oid+ " and seq > " + seq ;
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			count = stm.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return count;

	}
	
//	 根据传进来的问卷编号和试题的顺序号 删除题目
	public int deletePoints(int seq, int oid) {
		DBConnection dbcon = null;
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		int count=0;
		String sql = "delete  from wj_qpoints where oid=" + oid + " and seq = "+ seq ;
		System.out.println(sql);
		try {
			dbcon=new DBConnection();
			con=dbcon.getConnection();
			stm=con.createStatement();
			count = stm.executeUpdate(sql);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			dbcon.closeAll(con,stm,rs);
		}
		return count;
	}

}

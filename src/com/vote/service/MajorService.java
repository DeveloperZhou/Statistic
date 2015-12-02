package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.vote.bean.Major;
import com.vote.bean.ObjectBean;
import com.vote.bean.Point;
import com.vote.bean.Question;

public class MajorService {
	// 新建班级
	public static int intsertMajor(Major m) throws Exception {
		DBConnection db = new DBConnection();
		Connection con=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		String sql = "";
		int id = 0;
		try {
			con = db.getConnection();
			sql = "insert into wj_major(name,valid) values(?,?)";
			System.out.println(sql);
			stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, m.getMajorName());
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


	// 删除班级
	public static boolean delMajor(int mid) throws Exception {
		DBConnection dbcon = new DBConnection();
		boolean flag = false;
		Connection conn = dbcon.getConnection();
		conn.setAutoCommit(false);
		String sql1 = "update wj_major set valid = 0 where mid="+mid;
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

	public static Major getMajor(int mid) {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		Major ob = null;
		int result = 0;
		try {
			con = dbcon.getConnection();
			stm = con.createStatement();
			String sql = " select * from wj_major where mid=" + mid;
			System.out.println(sql);
			rs = stm.executeQuery(sql);
			while (rs.next()) {
				String name = rs.getString("name");
				ob = new Major();
				ob.setMid(mid);
				ob.setMajorName(name);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, stm, rs);
		}
		return ob;
	}
    
	//	 查看班级;
	public static List ListMajor() {
		DBConnection dbcon = new DBConnection();
		Connection con = null;
		Statement stm = null;
		ResultSet rs = null;
		List objList=new LinkedList();
		try {
			String sql = "select mid,name,date from wj_major where valid=1 order by mid asc";
			con=dbcon.getConnection();
			stm=con.createStatement();
			rs = stm.executeQuery(sql);
			while(rs.next()){
				Major ob=new Major();
				int mid=rs.getInt("mid");
				String content=rs.getString("name");
				java.sql.Timestamp createtime=rs.getTimestamp("date");
				ob.setMid(mid);
				ob.setMajorName(content);
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
}

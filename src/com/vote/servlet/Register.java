package com.vote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Register extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String username = request.getParameter("search");
		response.setContentType("text/xml;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Connection conn=null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		int count = -1;
		try{
			
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/yeying?useUnicode=true&characterEncoding=utf-8";
				conn=DriverManager.getConnection(url,"root","199212");
				String sql = "SELECT  count(*) FROM wj_students WHERE username=?";
				pst=conn.prepareStatement(sql);
				pst.setString(1,username);
				
				rs=pst.executeQuery();
				if(rs.next()){
					if (rs.getInt(1)>=1)
					{
						count = 1;
					}
				}
				out.print(count);
				out.flush();
			
		}catch(Exception e){
			e.printStackTrace();
			out.print("出错");
		}
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) 
		throws ServletException ,IOException
	{
		doGet(request,response);
	}
}
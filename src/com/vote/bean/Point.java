package com.vote.bean;

import java.sql.Timestamp;

public class Point
{
	private Timestamp date=null;
	private String content=null;
	private int pid;
	public Timestamp getDate()
	{
		return date;
	}
	public void setDate(Timestamp createtime)
	{
		this.date = createtime;
	}
	public String getContent()
	{
		return content;
	}
	public void setContent(String content)
	{
		this.content = content;
	}
	public int getPid()
	{
		return pid;
	}
	public void setPid(int pid)
	{
		this.pid = pid;
	}
}

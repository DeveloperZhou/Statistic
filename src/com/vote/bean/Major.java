package com.vote.bean;

import java.sql.Timestamp;

public class Major
{
	private Timestamp date=null;
	private String mName=null;
	private int mid;
	public Timestamp getDate()
	{
		return date;
	}
	public void setDate(Timestamp createtime)
	{
		this.date = createtime;
	}
	public String getMajorName()
	{
		return mName;
	}
	public void setMajorName(String name)
	{
		this.mName = name;
	}
	public int getMid()
	{
		return mid;
	}
	public void setMid(int mid)
	{
		this.mid = mid;
	}
}

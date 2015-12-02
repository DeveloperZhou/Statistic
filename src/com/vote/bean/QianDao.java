package com.vote.bean;

import java.sql.Timestamp;

public class QianDao {
    private int qid;
    private Timestamp createTime;
    private int state;
    private String creater;

	public QianDao() {
    }

    public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}


    public int getQid() {
		return qid;
	}

	public void setQid(int qid) {
		this.qid = qid;
	}

	
	public String getCreater() {
		return creater;
	}

	public void setCreater(String Creater) {
		this.creater = Creater;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

   
}

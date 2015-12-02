package com.vote.bean;

import java.sql.Timestamp;

public class Qder {
	
	private int qdId; //回复ID
	private String qdCode;//回复者代码
	private String qdIp;//回复者IP
	private int qid;//主题Id
	private Timestamp qdTime;//回复时间
	public int getQdId() {
		return qdId;
	}
	public void setQdId(int replayId) {
		this.qdId = replayId;
	}
	public String getQdCode() {
		return qdCode;
	}
	public void setQdCode(String replayCode) {
		this.qdCode = replayCode;
	}
	public String getQdIp() {
		return qdIp;
	}
	public void setQdIp(String replayIp) {
		this.qdIp = replayIp;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int oId) {
		this.qid = oId;
	}
	public Timestamp getQdTime() {
		return qdTime;
	}
	public void setQdTime(Timestamp replayTime) {
		this.qdTime = replayTime;
	}
}

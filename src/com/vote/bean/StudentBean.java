package com.vote.bean;

public class StudentBean {
	private String username;
	private String password;
	
	private int score;
	private String advice;
	private String name;
	private String major;
	private String feedback;
	private int ansTimes;
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	
	public String getMajor() {
		return major;
	}
	public void setMajor(String m) {
		this.major = m;
	}
	public int getAnsTimes() {
		return ansTimes;
	}
	public void setAnsTimes(int a) {
		this.ansTimes = a;
	}
}

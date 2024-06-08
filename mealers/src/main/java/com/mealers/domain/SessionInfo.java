package com.mealers.domain;

public class SessionInfo {
	private String userId;
	private String userName;
	private String userNum;
	private int userRoll;
	private String fileName;
	
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserRoll() {
		return userRoll;
	}
	public void setUserRoll(int userRoll) {
		this.userRoll = userRoll;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}

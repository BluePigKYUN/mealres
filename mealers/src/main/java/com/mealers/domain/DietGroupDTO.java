package com.mealers.domain;

public class DietGroupDTO {
	private int groupNum;
	private String groupName;
	private String proFile;
	private String reg_Date;
	private String fileName;
	private String userNum;
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	
	public String getProFile() {
		return proFile;
	}
	public void setProFile(String proFile) {
		this.proFile = proFile;
	}
	public String getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(String reg_Date) {
		this.reg_Date = reg_Date;
	}
	

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

}

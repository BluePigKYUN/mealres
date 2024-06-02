package com.mealers.domain;

import java.util.List;

public class MealCmntDTO {
	private long num;
	private String userNum;
	private String mem_Nick;
	private String subject;
	private String content;
	private String reg_date;
	private int hitCount;
	
	private int likeCount;
	private int replyCount;
	private long timeGap;

	private long fileNum;
	private String fileName;
	private List<String> fileList;
	
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public String getMem_Nick() {
		return mem_Nick;
	}
	public void setMem_Nick(String mem_Nick) {
		this.mem_Nick = mem_Nick;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public long getTimeGap() {
		return timeGap;
	}
	public void setTimeGap(long timeGap) {
		this.timeGap = timeGap;
	}
	public long getFileNum() {
		return fileNum;
	}
	public void setFileNum(long fileNum) {
		this.fileNum = fileNum;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public List<String> getFileList() {
		return fileList;
	}
	public void setFileList(List<String> fileList) {
		this.fileList = fileList;
	}
	
	
	
}

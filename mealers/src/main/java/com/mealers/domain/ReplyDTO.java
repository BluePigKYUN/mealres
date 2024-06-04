package com.mealers.domain;

public class ReplyDTO {
	private long replyNum; // 댓글 번호
	private long num; // 본 게시글 번호
	private String userId; 
	private String userName;
	private String userNum;
	private String mem_Nick;
	private String content; 
	private String reg_date;
	
	
	public String getMem_Nick() {
		return mem_Nick;
	}
	public void setMem_Nick(String mem_Nick) {
		this.mem_Nick = mem_Nick;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}
	public long getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(long replyNum) {
		this.replyNum = replyNum;
	}
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
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
	
}

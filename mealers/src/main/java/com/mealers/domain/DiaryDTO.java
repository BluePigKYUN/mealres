package com.mealers.domain;

public class DiaryDTO {
	private long diary_Num;
	private String reg_date_diary;
	private String subject;
	private String content;
	private Long userNum;
	private int status;
	private String memberId;
	
	
	public long getDiary_Num() {
		return diary_Num;
	}
	public void setDiary_Num(long diary_Num) {
		this.diary_Num = diary_Num;
	}
	public String getReg_date_diary() {
		return reg_date_diary;
	}
	public void setReg_date_diary(String reg_date_diary) {
		this.reg_date_diary = reg_date_diary;
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
	public Long getUserNum() {
		return userNum;
	}
	public void setUserNum(Long userNum) {
		this.userNum = userNum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
}

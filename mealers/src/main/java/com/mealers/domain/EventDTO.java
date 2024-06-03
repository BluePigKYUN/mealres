package com.mealers.domain;

public class EventDTO {
	private long event_num;
	private String title;
	private String memo;
	private String color;
	private String event_date;
	private String reg_date_event;
	private String event_start_time;
	private String event_end_time;
	private String userNum;
	
	public String getEvent_date() {
		return event_date;
	}
	public void setEvent_date(String event_date) {
		this.event_date = event_date;
	}
	public long getEvent_num() {
		return event_num;
	}
	public void setEvent_num(long event_num) {
		this.event_num = event_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getReg_date_event() {
		return reg_date_event;
	}
	public void setReg_date_event(String reg_date_event) {
		this.reg_date_event = reg_date_event;
	}
	public String getEvent_start_time() {
		return event_start_time;
	}
	public void setEvent_start_time(String event_start_time) {
		this.event_start_time = event_start_time;
	}
	public String getEvent_end_time() {
		return event_end_time;
	}
	public void setEvent_end_time(String event_end_time) {
		this.event_end_time = event_end_time;
	}
	public String getUserNum() {
		return userNum;
	}
	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

}
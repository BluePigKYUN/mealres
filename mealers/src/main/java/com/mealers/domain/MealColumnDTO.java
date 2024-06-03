package com.mealers.domain;

public class MealColumnDTO {
	private long num;
	private String subject;
	private String content;
	private String reg_date;
	private int hitCount;
	private String userNum; 
	
	private long filenum;
	private String saveFilename;
	private String originalFilename;
	
	private int likeCount;
	
	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}


	public long getNum() {
		return num;
	}

	public void setNum(long num) {
		this.num = num;
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

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public long getFilenum() {
		return filenum;
	}

	public void setFilenum(long filenum) {
		this.filenum = filenum;
	}


	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public String getShortSubject() {
	    if (this.subject != null && this.subject.length() > 12) {
	        return this.subject.substring(0, 12) + "...";
	    }
	    return this.subject;
	}
	
	 // HTML 태그 제거후 텍스트만 추출
    public String getTextOnlyContent() {
        if (this.content != null) {
            // HTML 태그 제거
            String noHtml = this.content.replaceAll("<[^>]*>", " ");
            // 여러 공백을 하나로 줄임
            String normalizedSpaces = noHtml.replaceAll("&nbsp;", " ").replaceAll("\\s+", " ");
            return normalizedSpaces.trim();
        }
        return this.content;
    }

    // 텍스트만 추출하고, 20자로 제한하는 메소드
    public String getShortTextContent() {
        String textOnly = getTextOnlyContent();
        if (textOnly != null && textOnly.length() > 25) {
            return textOnly.substring(0, 25) + "...";
        }
        return textOnly;
    }
	
	


}

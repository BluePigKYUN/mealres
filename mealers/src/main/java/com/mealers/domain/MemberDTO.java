package com.mealers.domain;
public class MemberDTO {
	
    private String userNum;
    private String memberId;
    private String memberPwd;
    private String mem_Nick;
    private String mem_Email;
    private String sign_reg_date;
    private int enabled;
    private String modify_date;
    private String fileName;

    public String getUserNum() {
        return userNum;
    }

    public void setUserNum(String userNum) {
        this.userNum = userNum;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberPwd() {
        return memberPwd;
    }

    public void setMemberPwd(String memberPwd) {
        this.memberPwd = memberPwd;
    }

    public String getMem_Nick() {
        return mem_Nick;
    }

    public void setMem_Nick(String mem_Nick) {
        this.mem_Nick = mem_Nick;
    }

    public String getMem_Email() {
        return mem_Email;
    }

    public void setMem_Email(String mem_Email) {
        this.mem_Email = mem_Email;
    }

    public String getSign_reg_date() {
        return sign_reg_date;
    }

    public void setSign_reg_date(String sign_reg_date) {
        this.sign_reg_date = sign_reg_date;
    }

    public int getEnabled() {
        return enabled;
    }

    public void setEnabled(int enabled) {
        this.enabled = enabled;
    }

    public String getModify_date() {
        return modify_date;
    }

    public void setModify_date(String modify_date) {
        this.modify_date = modify_date;
    }

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}

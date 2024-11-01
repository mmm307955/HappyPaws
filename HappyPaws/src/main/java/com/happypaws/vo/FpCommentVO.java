package com.happypaws.vo;

public class FpCommentVO {
	private int fpSeq;
	private int fpcSeq;
	private String fpcId;
	private String fpcRole;
	private String fpcCode;
	private String fpcContent;
	private String fpcDate;


	public int getFpSeq() {
		return fpSeq;
	}

	public void setFpSeq(int fpSeq) {
		this.fpSeq = fpSeq;
	}

	public int getFpcSeq() {
		return fpcSeq;
	}

	public void setFpcSeq(int fpcSeq) {
		this.fpcSeq = fpcSeq;
	}

	public String getFpcId() {
		return fpcId;
	}

	public void setFpcId(String fpcId) {
		this.fpcId = fpcId;
	}

	public String getFpcRole() {
		return fpcRole;
	}

	public void setFpcRole(String fpcRole) {
		this.fpcRole = fpcRole;
	}

	public String getFpcCode() {
		return fpcCode;
	}

	public void setFpcCode(String fpcCode) {
		this.fpcCode = fpcCode;
	}

	public String getFpcContent() {
		return fpcContent;
	}

	public void setFpcContent(String fpcContent) {
		this.fpcContent = fpcContent;
	}

	public String getFpcDate() {
		return fpcDate;
	}

	public void setFpcDate(String fpcDate) {
		this.fpcDate = fpcDate;
	}

	@Override
	public String toString() {
		return "FpCommentVO [fpSeq=" + fpSeq + ", fpcSeq=" + fpcSeq + ", fpcId=" + fpcId + ", fpcRole=" + fpcRole
				+ ", fpcCode=" + fpcCode + ", fpcContent=" + fpcContent + ", fpcDate=" + fpcDate + "]";
	}

}

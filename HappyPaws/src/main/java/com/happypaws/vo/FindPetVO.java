package com.happypaws.vo;

public class FindPetVO {
	private int fpSeq;
	private String fpId;
	private String fpRole;
	private String fpCode;
	private String fpTitle;
	private String fpPh;
	private String fpImg;
	private String fpPlace;
	private String fpTime;
	private String fpCategory;
	private String fpBreed;
	private String fpContent;
	private int fpDate;
	private int fpCnt;
	private String fpOk;
	private String fpDel;


	public int getFpSeq() {
		return fpSeq;
	}

	public void setFpSeq(int fpSeq) {
		this.fpSeq = fpSeq;
	}

	public String getFpId() {
		return fpId;
	}

	public void setFpId(String fpId) {
		this.fpId = fpId;
	}

	public String getFpRole() {
		return fpRole;
	}

	public void setFpRole(String fpRole) {
		this.fpRole = fpRole;
	}

	public String getFpCode() {
		return fpCode;
	}

	public void setFpCode(String fpCode) {
		this.fpCode = fpCode;
	}

	public String getFpTitle() {
		return fpTitle;
	}

	public void setFpTitle(String fpTitle) {
		this.fpTitle = fpTitle;
	}

	public String getFpPh() {
		return fpPh;
	}

	public void setFpPh(String fpPh) {
		this.fpPh = fpPh;
	}

	public String getFpImg() {
		return fpImg;
	}

	public void setFpImg(String fpImg) {
		this.fpImg = fpImg;
	}

	public String getFpPlace() {
		return fpPlace;
	}

	public void setFpPlace(String fpPlace) {
		this.fpPlace = fpPlace;
	}

	public String getFpTime() {
		return fpTime;
	}

	public void setFpTime(String fpTime) {
		this.fpTime = fpTime;
	}

	public String getFpCategory() {
		return fpCategory;
	}

	public void setFpCategory(String fpCategory) {
		this.fpCategory = fpCategory;
	}

	public String getFpBreed() {
		return fpBreed;
	}

	public void setFpBreed(String fpBreed) {
		this.fpBreed = fpBreed;
	}

	public String getFpContent() {
		return fpContent;
	}

	public void setFpContent(String fpContent) {
		this.fpContent = fpContent;
	}

	public int getFpDate() {
		return fpDate;
	}

	public void setFpDate(int fpDate) {
		this.fpDate = fpDate;
	}

	public int getFpCnt() {
		return fpCnt;
	}

	public void setFpCnt(int fpCnt) {
		this.fpCnt = fpCnt;
	}

	public String getFpOk() {
		return fpOk;
	}

	public void setFpOk(String fpOk) {
		this.fpOk = fpOk;
	}

	public String getFpDel() {
		return fpDel;
	}

	public void setFpDel(String fpDel) {
		this.fpDel = fpDel;
	}

	@Override
	public String toString() {
		return "FindPetVO [fpSeq=" + fpSeq + ", fpId=" + fpId + ", fpRole=" + fpRole + ", fpCode=" + fpCode
				+ ", fpTitle=" + fpTitle + ", fpPh=" + fpPh + ", fpImg=" + fpImg + ", fpPlace=" + fpPlace + ", fpTime="
				+ fpTime + ", fpCategory=" + fpCategory + ", fpBreed=" + fpBreed + ", fpContent=" + fpContent
				+ ", fpDate=" + fpDate + ", fpCnt=" + fpCnt + ", fpOk=" + fpOk + ", fpDel=" + fpDel + "]";
	}

}

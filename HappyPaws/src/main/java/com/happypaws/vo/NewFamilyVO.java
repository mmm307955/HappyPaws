package com.happypaws.vo;

public class NewFamilyVO {
	private int apSeq;
	private String apId;
	private String apTitle;
	private String apPhone;
	private String apImg;
	private String apAge;
	private char apGender;
	private String apCategory;
	private String apBreed;
	private String apContent;
	private String apDate;
	private int apCnt;
	private String apOk;
	private String apDel;


	public int getApSeq() {
		return apSeq;
	}

	public void setApSeq(int apSeq) {
		this.apSeq = apSeq;
	}

	public String getApId() {
		return apId;
	}

	public void setApId(String apId) {
		this.apId = apId;
	}

	public String getApTitle() {
		return apTitle;
	}

	public void setApTitle(String apTitle) {
		this.apTitle = apTitle;
	}

	public String getApPhone() {
		return apPhone;
	}

	public void setApPhone(String apPhone) {
		this.apPhone = apPhone;
	}

	public String getApImg() {
		return apImg;
	}

	public void setApImg(String apImg) {
		this.apImg = apImg;
	}

	public String getApAge() {
		return apAge;
	}

	public void setApAge(String apAge) {
		this.apAge = apAge;
	}

	public char getApGender() {
		return apGender;
	}

	public void setApGender(char apGender) {
		this.apGender = apGender;
	}

	public String getApCategory() {
		return apCategory;
	}

	public void setApCategory(String apCategory) {
		this.apCategory = apCategory;
	}

	public String getApBreed() {
		return apBreed;
	}

	public void setApBreed(String apBreed) {
		this.apBreed = apBreed;
	}

	public String getApContent() {
		return apContent;
	}

	public void setApContent(String apContent) {
		this.apContent = apContent;
	}

	public String getApDate() {
		return apDate;
	}

	public void setApDate(String apDate) {
		this.apDate = apDate;
	}

	public int getApCnt() {
		return apCnt;
	}

	public void setApCnt(int apCnt) {
		this.apCnt = apCnt;
	}

	public String getApOk() {
		return apOk;
	}

	public void setApOk(String apOk) {
		this.apOk = apOk;
	}

	public String getApDel() {
		return apDel;
	}

	public void setApDel(String apDel) {
		this.apDel = apDel;
	}

	@Override
	public String toString() {
		return "NewFamilyVO [apSeq=" + apSeq + ", apId=" + apId + ", apTitle=" + apTitle + ", apPhone=" + apPhone
				+ ", apImg=" + apImg + ", apAge=" + apAge + ", apGender=" + apGender + ", apCategory=" + apCategory
				+ ", apBreed=" + apBreed + ", apContent=" + apContent + ", apDate=" + apDate + ", apCnt=" + apCnt
				+ ", apOk=" + apOk + ", apDel=" + apDel + "]";
	}

}

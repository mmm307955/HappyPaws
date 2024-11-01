package com.happypaws.vo;

public class NfCommentVO {
	private int nfSeq;
	private int nfcSeq;
	private String nfcId;
	private String nfcContent;
	private String nfcDate;

	public int getNfSeq() {
		return nfSeq;
	}

	public void setNfSeq(int nfSeq) {
		this.nfSeq = nfSeq;
	}

	public int getNfcSeq() {
		return nfcSeq;
	}

	public void setNfcSeq(int nfcSeq) {
		this.nfcSeq = nfcSeq;
	}

	public String getNfcId() {
		return nfcId;
	}

	public void setNfcId(String nfcId) {
		this.nfcId = nfcId;
	}

	public String getNfcContent() {
		return nfcContent;
	}

	public void setNfcContent(String nfcContent) {
		this.nfcContent = nfcContent;
	}

	public String getNfcDate() {
		return nfcDate;
	}

	public void setNfcDate(String nfcDate) {
		this.nfcDate = nfcDate;
	}

	@Override
	public String toString() {
		return "NfCommentVO [nfcSeq=" + nfcSeq + ", nfcId=" + nfcId + ", nfcContent=" + nfcContent + ", nfcDate="
				+ nfcDate + "]";
	}
}

package com.happypaws.vo;

public class CmtyCommentVO {
	private int cmty_cmt_seq; // 커뮤니티 댓글 번호
	private int cmty_seq; // 커뮤니티 번호
	private Integer cmty_cmt_parent_seq; // 커뮤니티 부모댓글 번호 (nullable)
	private String cmty_cmt_id; // 커뮤니티 댓글 작성자
	private String cmty_cmt_content; // 커뮤니티 댓글 내용
	private String cmty_cmt_date; // 커뮤니티 댓글 작성날짜
	
	public int getCmty_cmt_seq() {
		return cmty_cmt_seq;
	}
	public void setCmty_cmt_seq(int cmty_cmt_seq) {
		this.cmty_cmt_seq = cmty_cmt_seq;
	}
	public int getCmty_seq() {
		return cmty_seq;
	}
	public void setCmty_seq(int cmty_seq) {
		this.cmty_seq = cmty_seq;
	}
	public Integer getCmty_cmt_parent_seq() {
		return cmty_cmt_parent_seq;
	}
	public void setCmty_cmt_parent_seq(Integer cmty_cmt_parent_seq) {
		this.cmty_cmt_parent_seq = cmty_cmt_parent_seq;
	}
	public String getCmty_cmt_id() {
		return cmty_cmt_id;
	}
	public void setCmty_cmt_id(String cmty_cmt_id) {
		this.cmty_cmt_id = cmty_cmt_id;
	}
	public String getCmty_cmt_content() {
		return cmty_cmt_content;
	}
	public void setCmty_cmt_content(String cmty_cmt_content) {
		this.cmty_cmt_content = cmty_cmt_content;
	}
	public String getCmty_cmt_date() {
		return cmty_cmt_date;
	}
	public void setCmty_cmt_date(String cmty_cmt_date) {
		this.cmty_cmt_date = cmty_cmt_date;
	}
	
	@Override
	public String toString() {
		return "CmtyCommentVO [cmty_cmt_seq=" + cmty_cmt_seq + ", cmty_seq=" + cmty_seq + ", cmty_cmt_parent_seq="
				+ cmty_cmt_parent_seq + ", cmty_cmt_id=" + cmty_cmt_id + ", cmty_cmt_content=" + cmty_cmt_content
				+ ", cmty_cmt_date=" + cmty_cmt_date + "]";
	}
	
	
}

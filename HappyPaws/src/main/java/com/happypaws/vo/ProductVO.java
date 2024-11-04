package com.happypaws.vo;

public class ProductVO {
	// PRODUCTS 테이블 컬럼들
	private int pr_id;                            
	private String pr_name;                     
	private String pr_desc;                                    
	private String pr_detail_desc;                                       
	private String pr_up_date;                                     
	private String pr_status;    
	private String pr_category;                                    
	private String pr_thumbnail;  
	private int pr_price;
	// PRODUCTS_OPTIONS 테이블 컬럼들
	private String us_id;
	private int pr_opt_id;
	private String pr_opt_name;                              
	private int pr_opt_stock;                                      
	private int pr_opt_price;
	// PRODUCTS_COMMENTS 테이블 컬럼들
	private String prc_desc;
	private String prc_image;
	private int prc_rating;
	private String prc_start_date;
	// PRODUCTS_QNA 테이블 컬럼들
	private String prq_desc;
	private String prq_comments;
	private int prq_lock;
	// 페이징, 검색 처리
	private String searchKeyword = "";
	private int rowFirst;
	private int rowSizePerPage;
	
	public int getPr_id() {
		return pr_id;
	}
	
	public void setPr_id(int pr_id) {
		this.pr_id = pr_id;
	}
	
	public String getPr_name() {
		return pr_name;
	}
	
	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}
	
	public String getPr_desc() {
		return pr_desc;
	}
	
	public void setPr_desc(String pr_desc) {
		this.pr_desc = pr_desc;
	}
	
	public String getPr_detail_desc() {
		return pr_detail_desc;
	}
	
	public void setPr_detail_desc(String pr_detail_desc) {
		this.pr_detail_desc = pr_detail_desc;
	}
	
	public String getPr_up_date() {
		return pr_up_date;
	}
	
	public void setPr_up_date(String pr_up_date) {
		this.pr_up_date = pr_up_date;
	}
	
	public String getPr_status() {
		return pr_status;
	}
	
	public void setPr_status(String pr_status) {
		this.pr_status = pr_status;
	}
	
	public String getPr_category() {
		return pr_category;
	}
	
	public void setPr_category(String pr_category) {
		this.pr_category = pr_category;
	}
	
	public String getPr_thumbnail() {
		return pr_thumbnail;
	}
	
	public void setPr_thumbnail(String pr_thumbnail) {
		this.pr_thumbnail = pr_thumbnail;
	}
	
	public int getPr_price() {
		return pr_price;
	}
	
	public void setPr_price(int pr_price) {
		this.pr_price = pr_price;
	}
	
	public String getUs_id() {
		return us_id;
	}

	public void setUs_id(String us_id) {
		this.us_id = us_id;
	}

	public int getPr_opt_id() {
		return pr_opt_id;
	}

	public void setPr_opt_id(int pr_opt_id) {
		this.pr_opt_id = pr_opt_id;
	}

	public String getPr_opt_name() {
		return pr_opt_name;
	}
	
	public void setPr_opt_name(String pr_opt_name) {
		this.pr_opt_name = pr_opt_name;
	}
	
	public int getPr_opt_stock() {
		return pr_opt_stock;
	}
	
	public void setPr_opt_stock(int pr_opt_stock) {
		this.pr_opt_stock = pr_opt_stock;
	}
	
	public int getPr_opt_price() {
		return pr_opt_price;
	}
	
	public void setPr_opt_price(int pr_opt_price) {
		this.pr_opt_price = pr_opt_price;
	}

	public String getPrc_desc() {
		return prc_desc;
	}

	public void setPrc_desc(String prc_desc) {
		this.prc_desc = prc_desc;
	}

	public String getPrc_image() {
		return prc_image;
	}

	public void setPrc_image(String prc_image) {
		this.prc_image = prc_image;
	}

	public int getPrc_rating() {
		return prc_rating;
	}

	public void setPrc_rating(int prc_rating) {
		this.prc_rating = prc_rating;
	}

	public String getPrc_start_date() {
		return prc_start_date;
	}

	public void setPrc_start_date(String prc_start_date) {
		this.prc_start_date = prc_start_date;
	}

	public String getPrq_desc() {
		return prq_desc;
	}

	public void setPrq_desc(String prq_desc) {
		this.prq_desc = prq_desc;
	}

	public String getPrq_comments() {
		return prq_comments;
	}

	public void setPrq_comments(String prq_comments) {
		this.prq_comments = prq_comments;
	}

	public int getPrq_lock() {
		return prq_lock;
	}

	public void setPrq_lock(int prq_lock) {
		this.prq_lock = prq_lock;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getRowFirst() {
		return rowFirst;
	}

	public void setRowFirst(int rowFirst) {
		this.rowFirst = rowFirst;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}
}

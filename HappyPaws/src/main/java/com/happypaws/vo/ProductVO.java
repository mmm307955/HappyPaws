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
	private int prc_no;
	private String prc_desc;
	private String prc_image;
	private int prc_rating;
	private String prc_start_date;
	private String prc_status;
	// PRODUCTS_QNA 테이블 컬럼들
	private int prq_no;
	private String prq_desc;
	private String prq_comments;
	private String prq_lock;
	private String prq_status;
	private String prq_date;
	// PRODUCTS_SHOPPING_CARTS 테이블 컬럼들
	private int prsc_no;
	private int prsc_quantity;
	private int prsc_price;
    // PRODUCTS_ORDERS 테이블 컬럼들
    private int pror_no;                 
    private String pror_date;           
    private String pror_status;          
    private String pror_deli_stat;       
    private int pror_qtt;              
    private String pror_addr;           
    private String pror_addr_detail;     
    private String pror_zipcode;         
    private String pror_recipient;       
    private String pror_phone;          
    private int pror_total_amt;         
    private int pror_ship_cost;          
    private int pror_product_amt;     
    private String pror_pay_method;      
    private int pror_coupon_amt;         
	// 페이징, 검색 처리
	private String searchKeyword = "";
	private int rowFirst;
	private int rowSizePerPage;
	// 이미지 존재 여부 
	private boolean imageExists;
	// 정렬 타입을 저장할 필드
	private String sortType;  
	// 리뷰 개수를 저장할 필드 추가
	private int reviewCount; 
	// 평균 평점
	private double avgRating; 
	
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

	public int getPrc_no() {
		return prc_no;
	}

	public void setPrc_no(int prc_no) {
		this.prc_no = prc_no;
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
	
	public String getPrc_status() {
		return prc_status;
	}

	public void setPrc_status(String prc_status) {
		this.prc_status = prc_status;
	}

	public int getPrq_no() {
		return prq_no;
	}

	public void setPrq_no(int prq_no) {
		this.prq_no = prq_no;
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

	public String getPrq_lock() {
		return prq_lock;
	}

	public void setPrq_lock(String prq_lock) {
		this.prq_lock = prq_lock;
	}
	
	public String getPrq_status() {
		return prq_status;
	}

	public void setPrq_status(String prq_status) {
		this.prq_status = prq_status;
	}

	public String getPrq_date() {
		return prq_date;
	}

	public void setPrq_date(String prq_date) {
		this.prq_date = prq_date;
	}
	
	public int getPrsc_quantity() {
		return prsc_quantity;
	}

	public void setPrsc_quantity(int prsc_quantity) {
		this.prsc_quantity = prsc_quantity;
	}

	public int getPrsc_price() {
		return prsc_price;
	}

	public void setPrsc_price(int prsc_price) {
		this.prsc_price = prsc_price;
	}

	public int getPrsc_no() {
		return prsc_no;
	}

	public void setPrsc_no(int prsc_no) {
		this.prsc_no = prsc_no;
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

	public boolean isImageExists() {
		return imageExists;
	}

	public void setImageExists(boolean imageExists) {
		this.imageExists = imageExists;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public double getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(double avgRating) {
		this.avgRating = avgRating;
	}

	public int getPror_no() {
		return pror_no;
	}

	public void setPror_no(int pror_no) {
		this.pror_no = pror_no;
	}

	public String getPror_date() {
		return pror_date;
	}

	public void setPror_date(String pror_date) {
		this.pror_date = pror_date;
	}

	public String getPror_status() {
		return pror_status;
	}

	public void setPror_status(String pror_status) {
		this.pror_status = pror_status;
	}

	public String getPror_deli_stat() {
		return pror_deli_stat;
	}

	public void setPror_deli_stat(String pror_deli_stat) {
		this.pror_deli_stat = pror_deli_stat;
	}

	public int getPror_qtt() {
		return pror_qtt;
	}

	public void setPror_qtt(int pror_qtt) {
		this.pror_qtt = pror_qtt;
	}

	public String getPror_addr() {
		return pror_addr;
	}

	public void setPror_addr(String pror_addr) {
		this.pror_addr = pror_addr;
	}

	public String getPror_addr_detail() {
		return pror_addr_detail;
	}

	public void setPror_addr_detail(String pror_addr_detail) {
		this.pror_addr_detail = pror_addr_detail;
	}

	public String getPror_zipcode() {
		return pror_zipcode;
	}

	public void setPror_zipcode(String pror_zipcode) {
		this.pror_zipcode = pror_zipcode;
	}

	public String getPror_recipient() {
		return pror_recipient;
	}

	public void setPror_recipient(String pror_recipient) {
		this.pror_recipient = pror_recipient;
	}

	public String getPror_phone() {
		return pror_phone;
	}

	public void setPror_phone(String pror_phone) {
		this.pror_phone = pror_phone;
	}

	public int getPror_total_amt() {
		return pror_total_amt;
	}

	public void setPror_total_amt(int pror_total_amt) {
		this.pror_total_amt = pror_total_amt;
	}

	public int getPror_ship_cost() {
		return pror_ship_cost;
	}

	public void setPror_ship_cost(int pror_ship_cost) {
		this.pror_ship_cost = pror_ship_cost;
	}

	public int getPror_product_amt() {
		return pror_product_amt;
	}

	public void setPror_product_amt(int pror_product_amt) {
		this.pror_product_amt = pror_product_amt;
	}

	public String getPror_pay_method() {
		return pror_pay_method;
	}

	public void setPror_pay_method(String pror_pay_method) {
		this.pror_pay_method = pror_pay_method;
	}

	public int getPror_coupon_amt() {
		return pror_coupon_amt;
	}

	public void setPror_coupon_amt(int pror_coupon_amt) {
		this.pror_coupon_amt = pror_coupon_amt;
	}
}

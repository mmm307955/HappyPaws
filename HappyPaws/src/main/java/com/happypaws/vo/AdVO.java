package com.happypaws.vo;

import java.util.Date;

public class AdVO {
    
    private String ad_id;        // 관리자 ID
    private String ad_password;  // 관리자 비밀번호
    private String ad_name;      // 관리자 이름
    private String ad_email;     // 관리자 이메일
    private Date ad_date;        // 관리자 가입 날짜

    // 기본 생성자
    public AdVO() {}

    // 모든 필드를 포함하는 생성자
    public AdVO(String ad_id, String ad_password, String ad_name, String ad_email, Date ad_date) {
        this.ad_id = ad_id;
        this.ad_password = ad_password;
        this.ad_name = ad_name;
        this.ad_email = ad_email;
        this.ad_date = ad_date;
    }

    // Getter 및 Setter 메서드
    public String getAd_id() {
        return ad_id;
    }

    public void setAd_id(String ad_id) {
        this.ad_id = ad_id;
    }

    public String getAd_password() {
        return ad_password;
    }

    public void setAd_password(String ad_password) {
        this.ad_password = ad_password;
    }

    public String getAd_name() {
        return ad_name;
    }

    public void setAd_name(String ad_name) {
        this.ad_name = ad_name;
    }

    public String getAd_email() {
        return ad_email;
    }

    public void setAd_email(String ad_email) {
        this.ad_email = ad_email;
    }

    public Date getAd_date() {
        return ad_date;
    }

    public void setAd_date(Date ad_date) {
        this.ad_date = ad_date;
    }

    @Override
    public String toString() {
        return "AdVO{" +
                "ad_id='" + ad_id + '\'' +
                ", ad_password='" + ad_password + '\'' +
                ", ad_name='" + ad_name + '\'' +
                ", ad_email='" + ad_email + '\'' +
                ", ad_date=" + ad_date +
                '}';
    }
}

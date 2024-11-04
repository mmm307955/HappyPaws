package com.happypaws.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.ProductVO;

@Repository
public class ProductDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public int getProductListCount(ProductVO vo) {
		return mybatis.selectOne("ProductDAO.getProductListCount", vo);
	}
	
	public List<ProductVO> getProductList(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getProductList", vo);
	}
	
	public List<ProductVO> getProductDetail(int pr_id) {
		return mybatis.selectList("ProductDAO.getProductDetail", pr_id);
	}
	
	public int getProductReviewCount(int pr_id) {
		return mybatis.selectOne("ProductDAO.getProductReviewCount", pr_id);
	}	
	
	public List<ProductVO> getProductReviewRating(int pr_id) {
		return mybatis.selectList("ProductDAO.getProductReviewRating", pr_id);
	}
	
	public List<ProductVO> getProductReview(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getProductReview", vo);
	}
	
	public List<ProductVO> getProductQuestion(int pr_id) {
		return mybatis.selectList("ProductDAO.getProductDetail", pr_id);
	} 
}

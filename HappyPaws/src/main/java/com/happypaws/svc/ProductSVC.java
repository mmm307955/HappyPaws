package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.ProductDAO;
import com.happypaws.vo.ProductVO;

@Service
public class ProductSVC {
	@Autowired
	private ProductDAO dao;
	
	public int getProductListCount(ProductVO vo) {
		return dao.getProductListCount(vo);
	}
	
	public List<ProductVO> getProductList(ProductVO vo) {
		return dao.getProductList(vo);
	}
	
	public List<ProductVO> getProductDetail(int pr_id) {
		return dao.getProductDetail(pr_id);
	}

	public int getProductReviewCount(int pr_id) {
		return dao.getProductReviewCount(pr_id);
	}
	
	public List<ProductVO> getProductReviewRating(int pr_id) {
		return dao.getProductReviewRating(pr_id);
	}	
	
	public List<ProductVO> getProductReview(ProductVO vo) {
		return dao.getProductReview(vo);
	}
	
	public List<ProductVO> getProductQuestion(int pr_id) {
		return dao.getProductQuestion(pr_id);
	}
}

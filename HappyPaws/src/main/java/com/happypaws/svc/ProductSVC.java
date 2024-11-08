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
	
	public int getMyReviewCount(ProductVO vo) {
		return dao.getMyReviewCount(vo);
	}
	
	public int deleteProductReview(int prc_no) {
		return dao.deleteProductReview(prc_no);
	}
	
	public int setProductReview(ProductVO vo) {
		return dao.setProductReview(vo);
	}
	
	public List<ProductVO> getProductQuestion(ProductVO vo) {
		return dao.getProductQuestion(vo);
	}
	
	public int setProductQuestion(ProductVO vo) {
		return dao.setProductQuestion(vo);
	}
	
	public int deleteProductQuestion(int prq_no) {
		return dao.deleteProductQuestion(prq_no);
	}	
	
	public int setProductQuestionComments(ProductVO vo) {
		return dao.setProductQuestionComments(vo);
	}
	
	public int getProductQuestionCount(int pr_id) {
		return dao.getProductQuestionCount(pr_id);
	}
	
	public int addToCart(ProductVO vo) {
		return dao.addToCart(vo);
	}
	
	public List<ProductVO> getCartList(String us_id) {
		return dao.getCartList(us_id);
	}
	
	public int updateCartQuantity(ProductVO vo) {
		return dao.updateCartQuantity(vo);
	}
	
	public int removeFromCart(ProductVO vo) {
		return dao.removeFromCart(vo);
	}
	
	public int checkCartDuplicate(ProductVO vo) {
	    return dao.checkCartDuplicate(vo);
	}
	
	// 주문 등록
	public int setProductOrder(ProductVO vo) {
		return dao.setProductOrder(vo);
	}

	// 주문 상세 조회 
	public ProductVO getProductOrder(int pror_no) {
		return dao.getProductOrder(pror_no);
	}

	// 사용자별 주문 목록 조회
	public List<ProductVO> getProductOrderList(String us_id) {
		return dao.getProductOrderList(us_id);
	}

	// 주문 상태 업데이트
	public int updateOrderStatus(ProductVO vo) {
		return dao.updateOrderStatus(vo); 
	}

	// 주문 완료된 상품 장바구니에서 제거
	public int deleteCartAfterOrder(ProductVO vo) {
		return dao.deleteCartAfterOrder(vo);
	}	
}

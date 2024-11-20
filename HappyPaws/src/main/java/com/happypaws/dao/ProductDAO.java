package com.happypaws.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public int getMyReviewCount(ProductVO vo) {
		return mybatis.selectOne("ProductDAO.getMyReviewCount", vo);
	}	
	
	public int deleteProductReview(int prc_no) {
		return mybatis.update("ProductDAO.deleteProductReview", prc_no);
	}
	
	public int setProductReview(ProductVO vo) {
		return mybatis.insert("ProductDAO.setProductReview", vo);
	}
	
	public List<ProductVO> getProductQuestion(ProductVO vo) {
		return mybatis.selectList("ProductDAO.getProductQuestion", vo);
	} 
	
	public int setProductQuestion(ProductVO vo) {
		return mybatis.insert("ProductDAO.setProductQuestion", vo);
	} 
	
	public int deleteProductQuestion(int prq_no) {
		return mybatis.update("ProductDAO.deleteProductQuestion", prq_no);
	} 
	
	public int setProductQuestionComments(ProductVO vo) {
		return mybatis.update("ProductDAO.setProductQuestionComments", vo);
	}
	
	public int getProductQuestionCount(int pr_id) {
		return mybatis.selectOne("ProductDAO.getProductQuestionCount", pr_id);
	}	
	
	public int addToCart(ProductVO vo) {
		return mybatis.insert("ProductDAO.addToCart", vo);
	}
	
	public List<ProductVO> getCartList(String us_id) {
		return mybatis.selectList("ProductDAO.getCartList", us_id);
	}
	
	public int updateCartQuantity(ProductVO vo) {
		return mybatis.update("ProductDAO.updateCartQuantity", vo);
	}
	
	public int removeFromCart(ProductVO vo) {
		return mybatis.delete("ProductDAO.removeFromCart", vo);
	}
	
	public int checkCartDuplicate(ProductVO vo) {
	    return mybatis.selectOne("ProductDAO.checkCartDuplicate", vo);
	}
	
    // 주문 등록
    public int setProductOrder(ProductVO vo) {
        return mybatis.insert("ProductDAO.setProductOrder", vo);
    }
    
    // 주문 상세 등록
    public int setProductOrderItem(ProductVO vo) {
        return mybatis.insert("ProductDAO.setProductOrderItem", vo);
    }
    
    // 주문 조회 (마스터 + 상세)
    public ProductVO getProductOrder(int prorMasterId) {
        List<ProductVO> results = mybatis.selectList("ProductDAO.getProductOrder", prorMasterId);
        return results != null && !results.isEmpty() ? results.get(0) : null;
    }

    // 사용자별 주문 목록 조회
    public List<ProductVO> getProductOrderList(ProductVO vo) {
        return mybatis.selectList("ProductDAO.getProductOrderList", vo);
    }

    // 주문 상태 업데이트
    public int updateOrderStatus(ProductVO vo) {
        return mybatis.update("ProductDAO.updateOrderStatus", vo);
    }

    // 주문 완료된 상품 장바구니에서 제거
    public int deleteCartAfterOrder(ProductVO vo) {
        return mybatis.delete("ProductDAO.deleteCartAfterOrder", vo);
    }
    
    // 상품 구매 이력 확인 (리뷰 작성 권한 확인용)
    public int checkPurchaseHistory(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.checkPurchaseHistory", vo);
    }

    public int checkReviewHistory(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.checkReviewHistory", vo);
    }
    
    public ProductVO getPurchaseInfo(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getPurchaseInfo", vo);
    }
    
    public int getOrderListCount(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getOrderListCount", vo);
    }
    
    public List<ProductVO> getOrderItems(int prorMasterId) {
        return mybatis.selectList("ProductDAO.getOrderItems", prorMasterId);
    }
    
    public int updateProductStock(ProductVO vo) {
        return mybatis.update("ProductDAO.updateProductStock", vo);
    }

    public int updateProductStatus(int pr_id) {
        return mybatis.update("ProductDAO.updateProductStatus", pr_id);
    }
    
    public int getProductStock(int pr_id, String pr_opt_name) {
        Map<String, Object> params = new HashMap<>();
        params.put("pr_id", pr_id);
        params.put("pr_opt_name", pr_opt_name);
        return mybatis.selectOne("ProductDAO.getProductStock", params);
    }
    
    public ProductVO getExistingReview(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getExistingReview", vo);
    }
    
    // 위시리스트 추가
    public int addToWishlist(ProductVO vo) {
        return mybatis.insert("ProductDAO.addToWishlist", vo);
    }

    // 위시리스트 삭제
    public int removeFromWishlist(ProductVO vo) {
        return mybatis.delete("ProductDAO.removeFromWishlist", vo);
    }

    // 위시리스트 중복 체크
    public int checkWishlistDuplicate(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.checkWishlistDuplicate", vo);
    }

    // 위시리스트 조회
    public List<ProductVO> getWishlist(ProductVO vo) {
        return mybatis.selectList("ProductDAO.getWishlist", vo);
    }

    // 위시리스트 카운트 조회
    public int getWishlistCount(String us_id) {
        return mybatis.selectOne("ProductDAO.getWishlistCount", us_id);
    }
    
    public boolean checkReviewExists(ProductVO vo) {
        int count = mybatis.selectOne("ProductDAO.checkReviewExists", vo);
        return count > 0;
    }
    
    public String getUserEmail(String us_id) {
        return mybatis.selectOne("ProductDAO.getUserEmail", us_id);
    }
    
    public ProductVO getOrderByMerchantUid(String merchantUid) {
        return mybatis.selectOne("ProductDAO.getOrderByMerchantUid", merchantUid);
    }
    
    public ProductVO getNextPurchaseInfo(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getNextPurchaseInfo", vo);
    }
    
    public int getDeliveredOrderCount(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getDeliveredOrderCount", vo);
    }

    public int getReviewCount(ProductVO vo) {
        return mybatis.selectOne("ProductDAO.getReviewCount", vo);
    }
    
    public ProductVO getReviewById(int prc_no) {
        return mybatis.selectOne("ProductDAO.getReviewById", prc_no);
    }
    
    public int deleteExistingReview(ProductVO vo) {
        return mybatis.delete("ProductDAO.deleteExistingReview", vo);
    }
    
    // 인덱스 페이지에 보여주기
    public List<ProductVO> productIndex() {
        return mybatis.selectList("ProductDAO.productIndex");
    }
}
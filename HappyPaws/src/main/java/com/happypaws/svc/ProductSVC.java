package com.happypaws.svc;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.happypaws.dao.ProductDAO;
import com.happypaws.vo.ProductVO;

@Service
public class ProductSVC {
	@Autowired
	private ProductDAO dao;
	
	@Autowired
	private ServletContext servletContext;
	
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
	
	@Transactional
	public int setProductReview(ProductVO vo) {
	    // 기존 리뷰 삭제
	    dao.deleteExistingReview(vo);
	    // 새 리뷰 추가
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
	
    // 주문 등록 (트랜잭션 처리를 위해 @Transactional 추가)
    @Transactional
    public int setProductOrder(ProductVO masterVO, List<ProductVO> orderItems) {
        try {
            // 1. 주문 마스터 등록
            int result = dao.setProductOrder(masterVO);
            if (result <= 0) return 0;
            
            // 2. 주문 상세 등록 및 재고 감소
            for (ProductVO item : orderItems) {
                item.setPror_master_id(masterVO.getPror_master_id());
                item.setUs_id(masterVO.getUs_id());
                
                // 주문 상세 등록
                result = dao.setProductOrderItem(item);
                if (result <= 0) return 0;
                
                // 재고 감소
                result = dao.updateProductStock(item);
                if (result <= 0) return 0;
                
                // 상품 상태 업데이트
                result = dao.updateProductStatus(item.getPr_id());
                if (result <= 0) return 0;
                
                // 장바구니에서 주문된 상품 제거
                dao.deleteCartAfterOrder(item);
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;  // 트랜잭션 롤백을 위해 예외 다시 throw
        }
    }
    
    // 주문 조회
    public ProductVO getProductOrder(int prorMasterId) {
        return dao.getProductOrder(prorMasterId);
    }
    
    // 사용자별 주문 목록 조회
    public List<ProductVO> getProductOrderList(ProductVO vo) {
        return dao.getProductOrderList(vo);
    }
    
    // 주문 상태 업데이트
    public int updateOrderStatus(ProductVO vo) {
        return dao.updateOrderStatus(vo);
    }

	// 주문 완료된 상품 장바구니에서 제거
	public int deleteCartAfterOrder(ProductVO vo) {
		return dao.deleteCartAfterOrder(vo);
	}	
	
    // 구매 이력 확인 (리뷰 작성 권한 확인용)
	public boolean canWriteReview(ProductVO vo) {
	    // 구매 이력 확인 (paid 상태인 주문만)
	    int purchaseCount = dao.checkPurchaseHistory(vo);
	    // 리뷰 작성 이력 확인
	    int reviewCount = dao.checkReviewHistory(vo);
	    
	    return purchaseCount > 0 && reviewCount == 0;
	}
	
	public int checkPurchaseHistory(ProductVO vo) {
	    return dao.checkPurchaseHistory(vo);
	}
	
	public int checkReviewHistory(ProductVO vo) {
	    return dao.checkReviewHistory(vo);
	}
	
	public ProductVO getPurchaseInfo(ProductVO vo) {
	    return dao.getPurchaseInfo(vo);
	}
	
	public int getOrderListCount(ProductVO vo) {
	    return dao.getOrderListCount(vo);
	}
	
    // 주문 상품 목록 조회
    public List<ProductVO> getOrderItems(int prorMasterId) {
        return dao.getOrderItems(prorMasterId);
    }
    
    public int getProductStock(int pr_id, String pr_opt_name) {
        return dao.getProductStock(pr_id, pr_opt_name);
    }
    
    public ProductVO getExistingReview(ProductVO vo) {
        return dao.getExistingReview(vo);
    }
    
    // 위시리스트 관련 메서드 추가
    public int addToWishlist(ProductVO vo) {
        return dao.addToWishlist(vo);
    }

    public int removeFromWishlist(ProductVO vo) {
        return dao.removeFromWishlist(vo);
    }

    public int checkWishlistDuplicate(ProductVO vo) {
        return dao.checkWishlistDuplicate(vo);
    }

    public List<ProductVO> getWishlist(ProductVO vo) {
        List<ProductVO> wishlist = dao.getWishlist(vo);
        // 이미지 존재 여부 체크
        for (ProductVO item : wishlist) {
            if (item.getPr_thumbnail() != null && !item.getPr_thumbnail().isEmpty()) {
                String imagePath = servletContext.getRealPath("/resources/upload/") + item.getPr_thumbnail();
                item.setImageExists(new File(imagePath).exists());
            } else {
                item.setImageExists(false);
            }
        }
        return wishlist;
    }

    // 위시리스트 페이징을 위한 카운트 조회
    public int getWishlistCount(String us_id) {
        return dao.getWishlistCount(us_id);
    }
    
    public boolean checkReviewExists(ProductVO vo) {
        return dao.checkReviewExists(vo);
    }
    
    public String getUserEmail(String us_id) {
        return dao.getUserEmail(us_id);
    }
    
    public ProductVO getOrderByMerchantUid(String merchantUid) {
        return dao.getOrderByMerchantUid(merchantUid);
    }
    
    public ProductVO getNextPurchaseInfo(ProductVO vo) {
        return dao.getNextPurchaseInfo(vo);
    }
    
    public int getReviewCount(ProductVO vo) {
        return dao.getReviewCount(vo);
    }
    
    public int getDeliveredOrderCount(ProductVO vo) {
        return dao.getDeliveredOrderCount(vo);
    }
    
    public ProductVO getReviewById(int prc_no) {
        return dao.getReviewById(prc_no);
    }
    
    // 인덱스 페이지에 보여주기
    public List<ProductVO> productIndex() {
        return dao.productIndex();
    }
}

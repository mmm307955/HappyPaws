package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.ProductSVC;
import com.happypaws.vo.ProductPagingVO;
import com.happypaws.vo.ProductVO;
import com.happypaws.vo.UsersVO;

@Controller
public class ProductController {
	@Autowired
	private ProductSVC svc;
	
	private final String uploadPath = "C:/HappyPaws/HappyPaws/src/main/webapp/resources/upload/";
	
	@RequestMapping("/pr_list")
	public String productList(
	        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	        @RequestParam(value = "category", required = false) String category,
	        @RequestParam(value = "sortType", required = false, defaultValue = "latest") String sortType,
	        ProductVO vo, ProductPagingVO pv, Model model) {
	    
	    // 카테고리와 정렬 타입 설정
	    vo.setPr_category(category);
	    vo.setSortType(sortType);
	    
	    pv.setRowTotalCount(svc.getProductListCount(vo));
	    pv = new ProductPagingVO(pv);
	    
	    vo.setRowFirst(pv.getRowFirst());
	    vo.setRowSizePerPage(pv.getRowSizePerPage());
	    
	    // 상품 목록 가져오기
	    List<ProductVO> products = svc.getProductList(vo);
	    
	    // 각 상품에 대해 평균 평점과 리뷰 수를 계산
	    for (ProductVO product : products) {
	        List<ProductVO> reviews = svc.getProductReviewRating(product.getPr_id());
	        
	        double totalRating = 0.0;
	        for (ProductVO review : reviews) {
	            totalRating += review.getPrc_rating();
	        }
	        
	        // 평균 평점 계산 (소수점 한자리까지)
	        double avgRating = reviews.isEmpty() ? 0.0 : totalRating / reviews.size();
	        product.setAvgRating(Math.round(avgRating * 10.0) / 10.0);
	        
	        // 리뷰 개수 저장
	        product.setReviewCount(reviews.size());
	        
	        // 썸네일 이미지 존재 여부 체크
	        if (product.getPr_thumbnail() != null && !product.getPr_thumbnail().isEmpty()) {
	            String imagePath = uploadPath + product.getPr_thumbnail();
	            product.setImageExists(new File(imagePath).exists());
	        } else {
	            product.setImageExists(false);
	        }
	    }
	    
	    model.addAttribute("productList", products);
	    model.addAttribute("paging", pv);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("category", category);
	    model.addAttribute("sortType", sortType);
	    
	    return "/WEB-INF/product/pr_list.jsp";
	}
	
	@RequestMapping("/pr_detail")
	public String productDetail(@RequestParam(value = "pr_id", required = false) int pr_id, 
	        @RequestParam(value = "sortType", required = false, defaultValue = "latest") String sortType,
	        @RequestParam(value = "reviewPage", required = false, defaultValue = "1") int reviewPage,
	        @RequestParam(value = "inquiryPage", required = false, defaultValue = "1") int inquiryPage,
	        ProductVO vo, ProductPagingVO pv, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	    
	    // 상품 상세 정보 먼저 조회
	    List<ProductVO> productDetail = svc.getProductDetail(pr_id);
	    
	    // 상품 썸네일 이미지 존재 여부 체크
	    if (productDetail.get(0).getPr_thumbnail() != null && !productDetail.get(0).getPr_thumbnail().isEmpty()) {
	        String imagePath = uploadPath + productDetail.get(0).getPr_thumbnail();
	        productDetail.get(0).setImageExists(new File(imagePath).exists());
	    } else {
	        productDetail.get(0).setImageExists(false);
	    }
	    
	    // 평균 평점 계산
	    int averageRating = 0;
	    List<ProductVO> reviewVO = svc.getProductReviewRating(pr_id); 
	    List<Integer> ratingList = new ArrayList<>();
	    
	    for (ProductVO rating : reviewVO) {
	        ratingList.add(rating.getPrc_rating());
	        averageRating += rating.getPrc_rating();
	    }
	    
	    int countRating = ratingList.size();
	    double averageRatingDouble = countRating > 0 ? (double) averageRating / countRating : 0;
	    averageRating = (int) (averageRatingDouble * 20);
	    
	    // 리뷰 페이징 처리
	    ProductPagingVO reviewPaging = new ProductPagingVO();
	    reviewPaging.setBtnCur(reviewPage);  // 현재 페이지 설정
	    reviewPaging.setRowSizePerPage(20); 
	    
	    // 'my' 정렬 시 로그인 체크 및 카운트 설정
	    if ("my".equals(sortType)) {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user != null && !user.getUs_id().trim().isEmpty()) {
	            vo.setUs_id(user.getUs_id());
	            reviewPaging.setRowTotalCount(svc.getMyReviewCount(vo));
	        } else {
	            // 로그인하지 않은 경우 빈 결과만 처리하고 다른 정보는 유지
	            vo.setUs_id("");
	            reviewPaging.setRowTotalCount(0);
	            model.addAttribute("productReview", new ArrayList<>());
	            model.addAttribute("sortType", sortType);
	            model.addAttribute("pr_id", pr_id);
	            model.addAttribute("countRating", countRating);
	            model.addAttribute("averageRating", averageRating);
	            model.addAttribute("productDetail", productDetail);
	            model.addAttribute("reviewPaging", reviewPaging);
	            
	            // 문의 페이징 처리
	            ProductVO inquiryVO = new ProductVO();
	            inquiryVO.setPr_id(pr_id);
	            
	            ProductPagingVO inquiryPaging = new ProductPagingVO();
	            inquiryPaging.setBtnCur(Math.max(1, inquiryPage));
	            inquiryPaging.setRowTotalCount(svc.getProductQuestionCount(pr_id));
	            inquiryPaging.setRowSizePerPage(10);
	            inquiryPaging = new ProductPagingVO(inquiryPaging);
	            
	            inquiryVO.setRowFirst(Math.max(0, inquiryPaging.getRowFirst()));
	            inquiryVO.setRowSizePerPage(inquiryPaging.getRowSizePerPage());
	            
	            model.addAttribute("productQuestion", svc.getProductQuestion(inquiryVO));
	            model.addAttribute("inquiryPaging", inquiryPaging);
	            
	            return "/WEB-INF/product/pr_detail.jsp";
	        }
	    } else {
	        reviewPaging.setRowTotalCount(svc.getProductReviewCount(vo.getPr_id()));
	    }
	    
	    reviewPaging = new ProductPagingVO(reviewPaging);
	    
	    // 리뷰 목록 조회를 위한 파라미터 설정
	    vo.setPr_id(pr_id);
	    vo.setSortType(sortType);
	    vo.setRowFirst(Math.max(0, reviewPaging.getRowFirst()));
	    vo.setRowSizePerPage(reviewPaging.getRowSizePerPage());
	    
	    // 리뷰 목록 조회
	    List<ProductVO> reviews = svc.getProductReview(vo);
	    
	    // 리뷰 이미지 존재 여부 체크
	    for (ProductVO review : reviews) {
	        if (review.getPrc_image() != null && !review.getPrc_image().isEmpty()) {
	            String imagePath = uploadPath + review.getPrc_image();
	            review.setImageExists(new File(imagePath).exists());
	        } else {
	            review.setImageExists(false);
	        }
	    }
	    
	    // 문의 페이징 처리
	    ProductVO inquiryVO = new ProductVO();
	    inquiryVO.setPr_id(pr_id);
	    
	    ProductPagingVO inquiryPaging = new ProductPagingVO();
	    inquiryPaging.setBtnCur(Math.max(1, inquiryPage));
	    inquiryPaging.setRowTotalCount(svc.getProductQuestionCount(pr_id));
	    inquiryPaging.setRowSizePerPage(10);
	    inquiryPaging = new ProductPagingVO(inquiryPaging);
	    
	    inquiryVO.setRowFirst(Math.max(0, inquiryPaging.getRowFirst()));
	    inquiryVO.setRowSizePerPage(inquiryPaging.getRowSizePerPage());
	    
	    // Model에 데이터 추가
	    model.addAttribute("sortType", sortType);
	    model.addAttribute("pr_id", pr_id);
	    model.addAttribute("countRating", countRating);
	    model.addAttribute("averageRating", averageRating);
	    model.addAttribute("productDetail", productDetail);
	    model.addAttribute("productReview", reviews);
	    model.addAttribute("productQuestion", svc.getProductQuestion(inquiryVO));
	    model.addAttribute("reviewPaging", reviewPaging);
	    model.addAttribute("inquiryPaging", inquiryPaging);
	    
	    return "/WEB-INF/product/pr_detail.jsp";
	}
        
    @GetMapping("/getImage/{fileName}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable String fileName) {
        try {
            File file = new File(uploadPath + fileName);
            byte[] imageContent = Files.readAllBytes(file.toPath());
            
            HttpHeaders headers = new HttpHeaders();
            // 파일 확장자에 따라 적절한 MediaType 설정
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            switch (fileExtension) {
                case "jpg":
                case "jpeg":
                    headers.setContentType(MediaType.IMAGE_JPEG);
                    break;
                case "png":
                    headers.setContentType(MediaType.IMAGE_PNG);
                    break;
                case "gif":
                    headers.setContentType(MediaType.IMAGE_GIF);
                    break;
                case "svg":
                    headers.setContentType(MediaType.valueOf("image/svg+xml"));
                    break;
                default:
                    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            }
            return new ResponseEntity<>(imageContent, headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PostMapping("/review_write")
    @ResponseBody
    public ResponseEntity<?> reviewWrite(@RequestParam("review-image") MultipartFile image, ProductVO vo, HttpSession session) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    	String currentDate = sdf.format(new Date());
    	
        try {
            // 1. 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 2. 업로드 디렉토리 생성 및 파일 저장
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            if (!image.isEmpty()) {
            	String originalFileName = image.getOriginalFilename();
            	String fileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
            	String newFileName = UUID.randomUUID().toString() + fileExtension;
            	
            	File destFile = new File(uploadPath + newFileName);
            	
            	image.transferTo(destFile);
            	vo.setPrc_image(newFileName);
            } else {
            	vo.setPrc_image("");
            }
            
            // 3. VO 설정
            vo.setUs_id(us.getUs_id());
            vo.setPrc_start_date(currentDate);
            
            // 4. DB 저장
            int checkSet = svc.setProductReview(vo);
            if (checkSet > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/review_remove")
    @ResponseBody
    public ResponseEntity<?> reviewRemove(@RequestParam("prc_no") int prc_no, HttpSession session) {
        try {
            // 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // 리뷰 삭제
            int checkDelete = svc.deleteProductReview(prc_no);
            if (checkDelete > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/get_reviews")
    @ResponseBody
    public Map<String, Object> getReviews(@RequestParam("pr_id") int pr_id,
                                         @RequestParam("sortType") String sortType,
                                         @RequestParam("currentPage") int currentPage,
                                         HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            ProductVO vo = new ProductVO();
            vo.setPr_id(pr_id);
            vo.setSortType(sortType);
            
            // 페이징 처리
            ProductPagingVO reviewPaging = new ProductPagingVO();
            reviewPaging.setBtnCur(currentPage);
            reviewPaging.setRowSizePerPage(20);
            
            // 'my' 정렬 시 로그인 체크 및 카운트 설정
            if ("my".equals(sortType)) {
                UsersVO user = (UsersVO) session.getAttribute("user");
                if (user != null && !user.getUs_id().trim().isEmpty()) {
                    vo.setUs_id(user.getUs_id());
                    reviewPaging.setRowTotalCount(svc.getMyReviewCount(vo));
                } else {
                    response.put("error", "로그인이 필요합니다.");
                    return response;
                }
            } else {
                reviewPaging.setRowTotalCount(svc.getProductReviewCount(vo.getPr_id()));
            }
            
            reviewPaging = new ProductPagingVO(reviewPaging);
            
            vo.setRowFirst(reviewPaging.getRowFirst());
            vo.setRowSizePerPage(reviewPaging.getRowSizePerPage());
            
            List<ProductVO> reviews = svc.getProductReview(vo);
            
            // 리뷰 이미지 존재 여부 체크
            for (ProductVO review : reviews) {
                if (review.getPrc_image() != null && !review.getPrc_image().isEmpty()) {
                    String imagePath = uploadPath + review.getPrc_image();
                    review.setImageExists(new File(imagePath).exists());
                } else {
                    review.setImageExists(false);
                }
            }
            
            response.put("reviews", reviews);
            response.put("paging", reviewPaging);
            
        } catch (Exception e) {
            response.put("error", "리뷰를 불러오는 중 오류가 발생했습니다.");
        }
        
        return response;
    }
    
    @PostMapping("/question_write")
    @ResponseBody
    public ResponseEntity<?> inquiryWrite(ProductVO vo, HttpSession session) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String currentDate = sdf.format(new Date());
        
        try {
            // 세션 체크
            UsersVO us = (UsersVO) session.getAttribute("user");
            if (us == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // VO 설정
            vo.setUs_id(us.getUs_id());
            vo.setPrq_date(currentDate);
            
            // DB 저장
            int checkSet = svc.setProductQuestion(vo);
            if (checkSet > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/question_remove")
    @ResponseBody
    public ResponseEntity<?> inquiryRemove(@RequestParam("prq_no") int prq_no, HttpSession session) {
        try {
            // 문의글 삭제
            int checkDelete = svc.deleteProductQuestion(prq_no);
            if (checkDelete > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의글 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @PostMapping("/question_answer_write")
    @ResponseBody
    public ResponseEntity<?> answerWrite(ProductVO vo, HttpSession session) {
        try {
            // DB 저장
            int checkSet = svc.setProductQuestionComments(vo);
            if (checkSet > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("답변 등록에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }


    @PostMapping("/add_to_cart")
    @ResponseBody
    public ResponseEntity<String> addToCart(@RequestBody ProductVO productData, HttpSession session) {
        try {
            // 세션에서 사용자 정보 가져오기
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            // ProductVO 객체 설정
            ProductVO cartItem = new ProductVO();
            cartItem.setUs_id(user.getUs_id());
            cartItem.setPr_id(productData.getPr_id());
            cartItem.setPr_thumbnail(productData.getPr_thumbnail());
            cartItem.setPr_name(productData.getPr_name());
            cartItem.setPr_opt_name(productData.getPr_opt_name());
            cartItem.setPr_opt_price(productData.getPr_opt_price());
            cartItem.setPrsc_quantity(productData.getPrsc_quantity());
            cartItem.setPrsc_price(productData.getPr_opt_price() * productData.getPrsc_quantity());

            // 중복 체크
            int duplicateCount = svc.checkCartDuplicate(cartItem);
            if (duplicateCount > 0) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("duplicate");
            }

            // 장바구니에 추가
            int result = svc.addToCart(cartItem);
            
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("장바구니 추가 실패");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
    
    @GetMapping("/pr_cart")
    public String viewCart(HttpSession session, Model model) {
        UsersVO user = (UsersVO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";  // 로그인 페이지로 리다이렉트
        }
        
        // 장바구니 데이터 조회
        List<ProductVO> cartList = svc.getCartList(user.getUs_id());
        if (cartList != null) {
            // 썸네일 이미지 존재 여부 체크
            for (ProductVO item : cartList) {
                if (item.getPr_thumbnail() != null && !item.getPr_thumbnail().isEmpty()) {
                    String imagePath = uploadPath + item.getPr_thumbnail();
                    item.setImageExists(new File(imagePath).exists());
                } else {
                    item.setImageExists(false);
                }
            }
            model.addAttribute("cartList", cartList);
        }
        return "/WEB-INF/product/pr_cart.jsp";
    }

    @PostMapping("/update_cart_quantity")
    @ResponseBody
    public ResponseEntity<String> updateCartQuantity(@RequestBody ProductVO productData, HttpSession session) {
        try {
            UsersVO user = (UsersVO) session.getAttribute("user");
            if (user == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            productData.setUs_id(user.getUs_id());
            productData.setPrsc_price(productData.getPr_opt_price() * productData.getPrsc_quantity());
            
            int result = svc.updateCartQuantity(productData);
            
            if (result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수량 변경 실패");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

	@PostMapping("/remove_from_cart")
	@ResponseBody
	public ResponseEntity<String> removeFromCart(@RequestBody ProductVO productData, HttpSession session) {
	    try {
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
	        }

	        productData.setUs_id(user.getUs_id());
	        
	        int result = svc.removeFromCart(productData);
	        
	        if (result > 0) {
	            return ResponseEntity.ok("success");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
	    }
	}
	
	// 주문 처리
	@PostMapping("/pr_order")
	@ResponseBody
	public ResponseEntity<?> processOrder(@RequestBody List<ProductVO> orderItems, HttpSession session) {
	    try {
	        // 세션에서 사용자 정보 확인
	        UsersVO user = (UsersVO) session.getAttribute("user");
	        if (user == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
	        }

	        // 현재 시간 설정
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	        String orderDate = sdf.format(new Date());

	        // 주문 처리
	        for (ProductVO item : orderItems) {
	            item.setUs_id(user.getUs_id());
	            item.setPror_date(orderDate);
	            
	            // 주문 등록
	            int result = svc.setProductOrder(item);
	            if (result > 0) {
	                // 장바구니에서 해당 상품 제거
	                svc.deleteCartAfterOrder(item);
	            }
	        }

	        // pr_cart로 리다이렉트하도록 수정
	        return ResponseEntity.ok().body(Map.of(
	            "success", true,
	            "redirectUrl", "/pr_cart"  // 변경된 부분
	        ));

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                           .body("주문 처리 중 오류가 발생했습니다.");
	    }
	}

	// 주문 완료 페이지 표시
	@GetMapping("/pr_order_complete")
	public String orderComplete() {
		return "/WEB-INF/product/pr_order_complete.jsp";
	}

	// 주문 목록 조회
	@GetMapping("/pr_order_list")
	public String orderList(HttpSession session, Model model) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		List<ProductVO> orderList = svc.getProductOrderList(user.getUs_id());
		model.addAttribute("orderList", orderList);
       
		return "/WEB-INF/product/pr_order_list.jsp";
	}

	// 주문 상세 조회
	@GetMapping("/pr_order_detail")
	public String orderDetail(@RequestParam("pror_no") int pror_no, 
								HttpSession session, Model model) {
		UsersVO user = (UsersVO) session.getAttribute("user");
		if (user == null) {
			return "redirect:/auth/login";
		}

		ProductVO order = svc.getProductOrder(pror_no);
		model.addAttribute("order", order);
       
		return "/WEB-INF/product/pr_order_detail.jsp";
	}
}

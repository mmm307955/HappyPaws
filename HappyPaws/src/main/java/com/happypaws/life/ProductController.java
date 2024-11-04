package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.ProductSVC;
import com.happypaws.vo.ProductPagingVO;
import com.happypaws.vo.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductSVC svc;
	
	private final String uploadPath = "C:/HappyPaws/HappyPaws/src/main/webapp/resources/upload/";
	
	@RequestMapping("/cookie_test")
	public String cookieTest (HttpServletRequest request, HttpServletResponse response) {
	    Cookie cookie = new Cookie("us_id", "admin");
	    cookie.setPath("/");       
	    response.addCookie(cookie);
	    
		return "index.jsp";
	}
	
	@RequestMapping("/pr_list")
	public String productList(@RequestParam(value = "searchKeyword", required = false) String searchKeyword, ProductVO vo, ProductPagingVO pv, Model model, HttpServletRequest request, HttpServletResponse response) {
		pv.setRowTotalCount(svc.getProductListCount(vo));
		pv = new ProductPagingVO(pv);
		
		vo.setRowFirst(pv.getRowFirst());
		vo.setRowSizePerPage(pv.getRowSizePerPage());
		
		model.addAttribute("productList", svc.getProductList(vo));
		model.addAttribute("paging", pv);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "/WEB-INF/product/pr_list.jsp";
	}
	
	@RequestMapping("/pr_detail")
	public String productDetail(@RequestParam(value = "pr_id", required = false) int pr_id, ProductVO vo, ProductPagingVO pv, Model model, HttpServletRequest request, HttpServletResponse response) {
		int averageRating = 0;
		
		List<ProductVO> reviewVO = svc.getProductReviewRating(pr_id); 
		List<Integer> ratingList = new ArrayList<>();
		
		for (ProductVO rating : reviewVO) {
			ratingList.add(rating.getPrc_rating());
			averageRating += rating.getPrc_rating();
		}
		
		int countRating = ratingList.size();
		double averageRatingDouble = (double) averageRating / countRating;
		averageRating = (int) (averageRatingDouble * 20);
		
		pv.setRowTotalCount(svc.getProductReviewCount(vo.getPr_id()));
		pv.setRowSizePerPage(20);
		pv = new ProductPagingVO(pv);
		
		vo.setPr_id(pr_id);
		vo.setRowFirst(pv.getRowFirst());
		vo.setRowSizePerPage(pv.getRowSizePerPage());		
		
		model.addAttribute("pr_id", pr_id);
		model.addAttribute("countRating", countRating);
		model.addAttribute("averageRating", averageRating);
		model.addAttribute("productDetail", svc.getProductDetail(pr_id));
		model.addAttribute("productReview", svc.getProductReview(vo));
		model.addAttribute("productQuestion", svc.getProductQuestion(pr_id));
		model.addAttribute("reviewPaging", pv);
		
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
}

package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.AdminProductSVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;

//관리자 상품 관리 
@Controller
public class AdminProductController {
	@Autowired
	private AdminProductSVC svc;

	// 관리자 상품 추가 - 링크로 폼에 접근!
	@RequestMapping(value = "/ad_manageProductAdd", method = RequestMethod.GET)
	public String adManageProductAdd() {

		return "/WEB-INF/admin_product/admin_product_add.jsp";
	}

	// 관리자 상품 추가 - 등록 버튼 눌렀을 때!
	@RequestMapping(value = "/ad_manageProductAdd", method = RequestMethod.POST)
	public String adManageProductAdd(@RequestParam("pr_thumbnail_file") MultipartFile file, HttpServletRequest request,
			ProductsVO vo, ProductOptionVO opt, Model model, @RequestParam("pr_opt_name") List<String> prOptNames,
			@RequestParam("pr_opt_stock") List<Integer> prOptStocks,
			@RequestParam("pr_opt_price") List<Integer> prOptPrices, @RequestParam("option_count") int optionCount) {
		try {
			vo.setPr_thumbnail(uploadFile(file, request)); // 썸네일 설정

			// 상품 등록 로직
			if (svc.addProduct(vo) > 0) {
				opt.setPr_id(svc.getProductId(vo));

				for (int i = 0; i < optionCount; i++) {
					opt.setPr_opt_id(i + 1);
					opt.setPr_opt_name(prOptNames.get(i)); // 옵션 이름 설정
					opt.setPr_opt_stock(prOptStocks.get(i)); // 옵션 재고 설정
					opt.setPr_opt_price(prOptPrices.get(i)); // 옵션 가격 설정
					svc.addProductOption(opt);
				}
				model.addAttribute("productsList", svc.adminProductList(vo));
				model.addAttribute("productOption", svc.adminProductList(opt));
//				return "/WEB-INF/admin_product/admin_product_list.jsp";
				return "redirect:ad_manageProductList";
			} else {
				// 이 부분 추가 설정 필요. 일단 동일한 상품명을 등록 시 에러가 발생함...
				return "redirect:ad_manageProductList";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:ad_manageProductList";
		}
	}
	//관리자 상품 리스트!
	@RequestMapping(value = "/ad_manageProductList", method = RequestMethod.GET)
	public String adManageProductListGet(ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {
		
		String cntPerPage = "5";
		if (vo.getSearchCondition() == null)
			vo.setSearchCondition("pr_id");
		else
			vo.setSearchCondition(vo.getSearchCondition());
		if (vo.getSearchKeyword() == null)
			vo.setSearchKeyword("");
		else
			vo.setSearchKeyword(vo.getSearchKeyword());

		if(category != null && !category.isEmpty()) {
			vo.setPr_category(category);
		}
		
		int total = svc.countProducts(vo);
		if (nowPage == null) {
			nowPage = "1";
		}

		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);

		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));

		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category",category);
		
		model.addAttribute("productsList", svc.adminProductList(vo));
		model.addAttribute("productOption", svc.adminProductList(opt));
		//전체 목록에서 옵션을 보이도록 설정
		model.addAttribute("allOpt", svc.allOpts(opt));
		return "/WEB-INF/admin_product/admin_product_list.jsp";
	}
	
	//관리자 상품 리스트!
	@RequestMapping(value = "/ad_manageProductList", method = RequestMethod.POST)
	public String adManageProductListPost(ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {
		
		String cntPerPage = "10";
		if (vo.getSearchCondition() == null)
			vo.setSearchCondition("pr_id");
		else
			vo.setSearchCondition(vo.getSearchCondition());
		if (vo.getSearchKeyword() == null)
			vo.setSearchKeyword("");
		else
			vo.setSearchKeyword(vo.getSearchKeyword());
		
		if(category != null && !category.isEmpty()) {
			vo.setPr_category(category);
		}
		
		int total = svc.countProducts(vo);
		if (nowPage == null) {
			nowPage = "1";
		}
		
		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);
		
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
		vo.setPr_category(category);
		
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category",category);
		
		model.addAttribute("productsList", svc.adminProductList(vo));
		model.addAttribute("productOption", svc.adminProductList(opt));
		//전체 목록에서 옵션을 보이도록 설정
		model.addAttribute("allOpt", svc.allOpts(opt));
		return "/WEB-INF/admin_product/admin_product_list.jsp";
	}

	// 관리자 상품 수정
	@RequestMapping(value = "/ad_manageProductModify", method = RequestMethod.GET)
	public String adManageProductModifyGet(
			ProductsVO vo, PagingVO pv, Model model, ProductOptionVO opt,
			@RequestParam(value = "nowPage", required = false) String nowPage) {
		//상품가져옴
		model.addAttribute("product", svc.productModifyView(vo));
		//옵션리스트 가져옴
		model.addAttribute("productOption", svc.adminProductList(opt));
		
		return "/WEB-INF/admin_product/admin_product_modify.jsp";
	}

	//상품 수정 폼 전송 - 1은 상품 수정, 2는 옵션 수정으로 진행
	@RequestMapping(value = "/ad_manageProductModify", method = RequestMethod.POST)
	public String adManageProductModifyPost(@RequestParam("pr_thumbnail_file") MultipartFile file,
			@RequestParam("existingThumbnail") String existingThumbnail,
			HttpServletRequest request, ProductsVO vo, ProductOptionVO opt, Model model,
			@RequestParam("pr_opt_name") List<String> prOptNames,
			@RequestParam("pr_opt_stock") List<Integer> prOptStocks,
			@RequestParam("pr_opt_price") List<Integer> prOptPrices, @RequestParam("option_count") int optionCount,
			@RequestParam(value = "nowPage", required = false) String nowPage) {
		try {
			//파일이 선택되지 않은 경우 기존 썸네일 경로 사용
			if (file != null && !file.isEmpty()) {
				vo.setPr_thumbnail(uploadFile(file, request)); // New! 파일 경로 설정
			} else {
				vo.setPr_thumbnail(existingThumbnail); //기존 파일 경로 설정
			}
			
			//1. 상품 수정
			svc.modifyProduct(vo);
			
			//2-1. 옵션 삭제
			svc.deleteProductOpt(opt);
			
			//2-2. 옵션 등록	
			for (int i = 0; i < optionCount; i++) {
				opt.setPr_opt_id(i + 1);
				opt.setPr_opt_name(prOptNames.get(i)); // 옵션 이름 설정
				opt.setPr_opt_stock(prOptStocks.get(i)); // 옵션 재고 설정
				opt.setPr_opt_price(prOptPrices.get(i)); // 옵션 가격 설정
				svc.addProductOption(opt);
			}
			model.addAttribute("productsList", svc.adminProductList(vo));
			model.addAttribute("productOption", svc.adminProductList(opt));
			return "redirect:ad_manageProductList";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:ad_manageProductList";
		}
	}
	
	
		// 관리자 상품 삭제! 1은 상품 삭제, 2는 옵션 삭제.
		@RequestMapping(value = "/deleteProduct", method = RequestMethod.GET)
		public String deleteProduct(
				@RequestParam("pr_id") int pr_id,
				ProductsVO vo, HttpServletRequest request, ProductOptionVO opt) {
			// 상대 경로 추가 시 realPath 추가
//			realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
//			if (vo.getFilename() != null) {
//				System.out.println("파일삭제: " + realPath + vo.getFilename());
//				File f = new File(realPath + vo.getFilename());
//				f.delete();
//			}
			
			//1. 상품 삭제
			svc.deleteProduct(vo);
			//2. 옵션 삭제
			svc.deleteProductOpt(opt);
			return "redirect:ad_manageProductList";
		}
	
	

	private String uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
		if (!file.isEmpty()) {
			// 파일 저장 경로 설정
			String realPath = request.getSession().getServletContext().getRealPath("/resources/");
			File uploadDir = new File(realPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			// 파일 이름 생성 (UUID로 중복 방지)
			String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			File destinationFile = new File(realPath + filename);

			// 파일을 서버에 저장
			file.transferTo(destinationFile);

			return "/resources/" + filename;
		}
		return "/resources/images/HappyPawsLogo.png"; // 기본 이미지 경로
	}

}
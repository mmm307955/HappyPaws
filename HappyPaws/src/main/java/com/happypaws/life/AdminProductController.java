package com.happypaws.life;

import com.happypaws.svc.AdminProductSVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class AdminProductController {

    private static final String UPLOAD_DIR = "/resources/upload/";
    private static final String DEFAULT_IMAGE = "HappyPawsLogo.png";
    private static final String PRODUCT_LIST_VIEW = "/WEB-INF/admin_product/admin_product_list.jsp";

    private final AdminProductSVC svc;
    private final ServletContext servletContext;

    @Autowired
    public AdminProductController(AdminProductSVC svc, ServletContext servletContext) {
        this.svc = svc;
        this.servletContext = servletContext;
    }

    @ModelAttribute("conditionMap")
    public Map<String, String> searchConditionMap() {
        return Map.of("내용", "CONTENT", "제목", "TITLE");
    }

    @GetMapping("/ad_manageProductAdd")
    public String showAddForm() {
        return "/WEB-INF/admin_product/admin_product_add.jsp";
    }

    @PostMapping("/ad_manageProductAdd")
    public String addProduct(@RequestParam("pr_thumbnail_file") MultipartFile file,
        HttpServletRequest request,
        ProductsVO vo, ProductOptionVO opt,
        @RequestParam("pr_opt_name") List<String> prOptNames,
        @RequestParam("pr_opt_stock") List<Integer> prOptStocks,
        @RequestParam("pr_opt_price") List<Integer> prOptPrices,
        @RequestParam("pr_opt_status") List<String> prOptStatuses,
        @RequestParam("option_count") int count) {
        try {
            vo.setPr_thumbnail(uploadFile(file, request));
            if (svc.addProduct(vo) > 0) {
                int prId = svc.getProductId(vo);
                addProductOptions(prId, prOptNames, prOptStocks, prOptPrices, prOptStatuses, count,
                    vo.getPr_price());
                return "redirect:ad_manageProductList";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:ad_manageProductList";
    }

    @GetMapping("/ad_manageProductList")
    public String getProductList(ProductsVO vo, PagingVO pv, Model model,
        ProductOptionVO opt,
        @RequestParam(value = "nowPage", required = false) String nowPage,
        @RequestParam(value = "category", required = false) String category) {
        setupSearchConditions(vo, category);
        setupPaging(vo, pv, nowPage, model);
        model.addAttribute("productsList", svc.adminProductList(vo));
        model.addAttribute("productOption", svc.adminProductList(opt));
        model.addAttribute("allOpt", svc.allOpts(opt));
        return PRODUCT_LIST_VIEW;
    }

    @PostMapping("/ad_manageProductList")
    public String postProductList(ProductsVO vo, PagingVO pv, Model model,
        ProductOptionVO opt,
        @RequestParam(value = "nowPage", required = false) String nowPage,
        @RequestParam(value = "category", required = false) String category) {
        return getProductList(vo, pv, model, opt, nowPage, category);
    }

    @PostMapping("/ad_manageProductModify")
    public String adManageProductModify(@RequestParam("pr_thumbnail_file") MultipartFile file,
        @RequestParam("existingThumbnail") String existingThumbnail,
        HttpServletRequest request,
        ProductsVO vo,
        ProductOptionVO opt,
        @RequestParam("pr_opt_name") List<String> prOptNames,
        @RequestParam("pr_opt_stock") List<Integer> prOptStocks,
        @RequestParam("pr_opt_price") List<Integer> prOptPrices,
        @RequestParam("pr_opt_status") List<String> prOptStatuses,
        @RequestParam("option_count") int optionCount,
        @RequestParam(value = "nowPage", required = false) String nowPage) {
        try {
            vo.setPr_thumbnail(
                file != null && !file.isEmpty() ? uploadFile(file, request) : existingThumbnail);
            svc.modifyProduct(vo);
            svc.deleteProductOpt(opt);
            addProductOptions(vo.getPr_id(), prOptNames, prOptStocks, prOptPrices, prOptStatuses, optionCount,
                vo.getPr_price());
            return buildRedirectUrl("ad_manageProductList", nowPage, vo);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:ad_manageProductList?nowPage=" + nowPage;
        }
    }

    @GetMapping("/deleteProduct")
    public String deleteProduct(ProductsVO vo, HttpServletRequest request,
        ProductOptionVO opt, @RequestParam(value = "nowPage", required = false) String nowPage) {
        try {
            deleteThumbnail(vo, request);
            svc.deleteProduct(vo);
            svc.deleteProductOpt(opt);
            return buildRedirectUrl("ad_manageProductList", nowPage, vo);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:ad_manageProductList?nowPage=" + nowPage;
        }
    }

    private void addProductOptions(int prId, List<String> names, List<Integer> stocks,
        List<Integer> prices, List<String> statuses, int count, int basePrice) {
        for (int i = 0; i < count; i++) {
            ProductOptionVO opt = new ProductOptionVO();
            opt.setPr_id(prId);
            opt.setPr_opt_id(i + 1);
            opt.setPr_opt_name(names.get(i));
            opt.setPr_opt_stock(stocks.get(i));
            opt.setPr_opt_price(prices.get(i) + basePrice);
            opt.setPr_opt_status(statuses.get(i));
            svc.addProductOption(opt);
        }
    }

    private void setupSearchConditions(ProductsVO vo, String category) {
        vo.setSearchCondition(vo.getSearchCondition() == null ? "pr_id" : vo.getSearchCondition());
        vo.setSearchKeyword(vo.getSearchKeyword() == null ? "" : vo.getSearchKeyword());
        if (category != null && !category.isEmpty()) {
            vo.setPr_category(category);
        }
    }

    private void setupPaging(ProductsVO vo, PagingVO pv, String nowPage, Model model) {
        int total = svc.countProducts(vo);
        pv = new PagingVO(total, nowPage == null ? 1 : Integer.parseInt(nowPage), 10);
        model.addAttribute("paging", pv);
        vo.setStart(pv.getStart());
        vo.setListcnt(10);
    }

    private String uploadFile(MultipartFile file, HttpServletRequest request) throws IOException {
        if (!file.isEmpty()) {
            String realPath = servletContext.getRealPath(UPLOAD_DIR);
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
            file.transferTo(new File(realPath + filename));
            return filename;
        }
        return DEFAULT_IMAGE;
    }

    private void deleteThumbnail(ProductsVO vo, HttpServletRequest request) {
        if (vo.getPr_thumbnail() != null) {
            String realPath = request.getSession().getServletContext().getRealPath(UPLOAD_DIR);
            File file = new File(realPath + vo.getPr_thumbnail());
            if (file.exists()) {
                file.delete();
            }
        }
    }

    private String buildRedirectUrl(String baseUrl, String nowPage, ProductsVO vo) {
        return "redirect:/" + baseUrl + "?nowPage=" + nowPage
            + "&searchCondition=" + safeEncode(vo.getSearchCondition())
            + "&searchKeyword=" + safeEncode(vo.getSearchKeyword())
            + "&category=" + safeEncode(vo.getPr_category());
    }

    private String safeEncode(String value) {
        String safeValue;
        if (value == null) {
            safeValue = "";
        } else {
            safeValue = value;
        }
        return URLEncoder.encode(safeValue, StandardCharsets.UTF_8);
    }
}

package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.NoticeSVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.NoticeVO;

@Controller
public class BoardController {
	
	@Autowired
	private NoticeSVC notic_SVC;
	
	
	@PostMapping("/upload")
	@ResponseBody
	public Map<String, String> uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
	    String uploadDir = request.getSession().getServletContext().getRealPath("/uploads/");
	    String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	    File targetFile = new File(uploadDir, fileName);
	    
	    try {
	        file.transferTo(targetFile);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    // 클라이언트로 반환할 이미지 URL
	    String fileUrl = request.getContextPath() + "/uploads/" + fileName;
	    
	    Map<String, String> response = new HashMap<>();
	    response.put("url", fileUrl);  // 이미지 URL을 클라이언트로 반환
	    return response;
	}
	
	//공지사항-리스트 페이지이동
	@RequestMapping(value="/board/notice_list",method = RequestMethod.GET)
	public String notice_list(NoticeVO vo ,PagingVO pv ,Model model , 
			@RequestParam(value = "nowPage", required = false) String nowPage) {
		
		String cntPerPage = "10";
		
		if (vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
		if (vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		if (nowPage == null) nowPage = "1"; 
		
		int total = notic_SVC.countNotice(vo);
		
		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);
	
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
		
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("noticeList", notic_SVC.notice_list(vo));
		
		
		return "/WEB-INF/board/notice_list.jsp";
	}
	
	//공지사항-글쓰기 페이지이동
	@RequestMapping(value="/board/notice_write",method = RequestMethod.GET)
	public String notice_write() {
		return "/WEB-INF/board/notice_write.jsp";
	}
	
	//공기사항 - 글쓰기
	@RequestMapping(value="/board/notice_insert", method = RequestMethod.POST)
	public String notice_insert(NoticeVO vo) {
		
		
		notic_SVC.notice_insert(vo);
		
		return "redirect:/board/notice_list";
	}
	
	//공지사항-상세보기
	@RequestMapping(value="/board/notice_view",method = RequestMethod.GET)
	public String notice_view(NoticeVO vo , Model model) {; 
		
		model.addAttribute("noticeview",notic_SVC.notice_view(vo));
		notic_SVC.notice_count(vo);
		
		return "/WEB-INF/board/notice_view.jsp";
	}
	
	//공지사항-글수정페이지로
	@RequestMapping(value = "/board/notice_modify", method = RequestMethod.GET)
	public String notice_modify(NoticeVO vo, Model model) {

		model.addAttribute("noticeview", notic_SVC.notice_view(vo));

		return "/WEB-INF/board/notice_modify.jsp";
	}
	
	//공지사항 - 글수정
	@RequestMapping(value = "/board/notice_modify", method = RequestMethod.POST)
	public String notice_update(NoticeVO vo, Model model) {
		
		notic_SVC.notice_update(vo);
		return "redirect:/board/notice_list";
	}
	
	//공지사항 삭제하기
	@RequestMapping(value = "/board/notice_delete", method = RequestMethod.GET)
	public String notice_delete(NoticeVO vo, Model model) {
		
		notic_SVC.notice_delete(vo);
		return "redirect:/board/notice_list";
	}
}
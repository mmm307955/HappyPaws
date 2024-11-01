package com.happypaws.life;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.CmtySVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.CmtyCommentVO;
import com.happypaws.vo.CommunityVO;
import com.happypaws.vo.QnaCmtVO;

@Controller
public class CmtyController {
	
	@Autowired
	private CmtySVC cmty_SVC;
	
	//커뮤니티-리스트 페이지이동
	@RequestMapping(value="/board/cmty_list",method = RequestMethod.GET)
	public String cmty_list(CommunityVO vo ,PagingVO pv ,Model model , 
			@RequestParam(value = "nowPage", required = false) String nowPage
	) {
			
		String cntPerPage = "10";
			
		if (vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
		if (vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		if (nowPage == null) nowPage = "1"; 
		
		int total = cmty_SVC.countCmty(vo);
			
		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));			model.addAttribute("paging", pv);
	
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
			
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("cmtyList", cmty_SVC.cmty_list(vo));
			
		return "/WEB-INF/board/cmty_list.jsp";
	}

	// 커뮤니티-상세보기
	@RequestMapping(value = "/board/cmty_view", method = RequestMethod.GET)
	public String cmty_view(CommunityVO vo, Model model) {
	
		model.addAttribute("cmtyview", cmty_SVC.cmty_view(vo));
		cmty_SVC.cmty_count(vo);

		return "/WEB-INF/board/cmty_view.jsp";
	}
	
	//커뮤니티-글수정페이지로
	@RequestMapping(value = "/board/cmty_modify", method = RequestMethod.GET)
	public String cmty_modify(CommunityVO vo, Model model) {
		
		model.addAttribute("cmtyview", cmty_SVC.cmty_view(vo));
		
		return "/WEB-INF/board/cmty_modify.jsp";
	}
	
	//커뮤니티 - 글수정
	@RequestMapping(value = "/board/cmty_modify", method = RequestMethod.POST)
	public String cmty_update(CommunityVO vo, Model model) {
		
		cmty_SVC.cmty_update(vo);
		return "redirect:/board/cmty_list";
	}
	
	//커뮤니티-글쓰기 페이지이동
	@RequestMapping(value="/board/cmty_write",method = RequestMethod.GET)
	public String cmty_write() {
		return "/WEB-INF/board/cmty_write.jsp";
	}
	
	
	//커뮤니티 - 글쓰기
	@RequestMapping(value="/board/cmty_insert", method = RequestMethod.POST)
	public String cmty_insert(CommunityVO vo) {
		
		cmty_SVC.cmty_insert(vo);
		
		return "redirect:/board/cmty_list";
	}
	
	//커뮤니티 삭제하기
	@RequestMapping(value = "/board/cmty_delete", method = RequestMethod.GET)
	public String cmty_delete(CommunityVO vo, Model model) {
		
		cmty_SVC.cmty_delete(vo);
		return "redirect:/board/cmty_list";
	}
	
	
    //커뮤니티 댓글추가
	@RequestMapping(value = "/board/c_addComment", method = RequestMethod.POST)
	@ResponseBody
    public String c_addComment(CmtyCommentVO comment) {
    	
		cmty_SVC.c_addComment(comment);
        return "OK";
    }
	
	// 특정 커뮤니티 글에 대한 댓글 목록
	@RequestMapping(value = "/board/c_commentList", method = RequestMethod.GET)
	@ResponseBody
	public List<CmtyCommentVO> commentList(CmtyCommentVO comment) {
		
	    return cmty_SVC.c_commentList(comment); // 해당 qna_seq에 대한 댓글 목록을 반환
	}
	
	// 특정 커뮤니티 글에 대한 대댓글 추가
	@RequestMapping(value="/board/c_addReply",method=RequestMethod.POST)
	@ResponseBody
	public String c_addReply(CmtyCommentVO comment) {
		
		cmty_SVC.c_addReply(comment);
		
		return "OK";  // 해당 qna_seq에 대한 댓글 목록을 반환
	}
}
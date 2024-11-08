package com.happypaws.life;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.QnaSVC;
import com.happypaws.util.PagingVO;
import com.happypaws.vo.QnaCmtVO;
import com.happypaws.vo.QnaVO;

@Controller
public class QnaController {
	
	@Autowired
	private QnaSVC qna_SVC;
	
	//QNA-리스트 페이지이동
	@RequestMapping(value="/board/qna_list",method = RequestMethod.GET)
	public String qna_list(QnaVO vo , QnaCmtVO cmtvo,PagingVO pv ,Model model , 
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "message", required = false) String message
			) {
		
		String cntPerPage = "10";
		
		if (vo.getSearchCondition() == null) vo.setSearchCondition("TITLE");
		if (vo.getSearchKeyword() == null) vo.setSearchKeyword("");
		if (nowPage == null) nowPage = "1"; 
		
		int total = qna_SVC.countQna(vo);
		
		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);
	
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));
		
		model.addAttribute("message", message);
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("qnaList", qna_SVC.qna_list(vo));
		
		
		return "/WEB-INF/board/qna_list.jsp";
	}
	
	//QNA-상세보기
	@RequestMapping(value = "/board/qna_view", method = RequestMethod.GET)
	public String qna_view(QnaVO vo, Model model) {
		
		model.addAttribute("qnaview", qna_SVC.qna_view(vo));
		qna_SVC.qna_count(vo);

		return "/WEB-INF/board/qna_view.jsp";
	}
	
	//QNA-글수정페이지로
	@RequestMapping(value = "/board/qna_modify", method = RequestMethod.GET)
	public String qna_modify(QnaVO vo, Model model) {
		
		model.addAttribute("qnaview", qna_SVC.qna_view(vo));
		
		return "/WEB-INF/board/qna_modify.jsp";
	}
	
	//QNA - 글수정
	@RequestMapping(value = "/board/qna_modify", method = RequestMethod.POST)
	public String qna_update(QnaVO vo, Model model) {
		
		qna_SVC.qna_update(vo);
		return "redirect:/board/qna_list";
	}
	
	//QNA-글쓰기 페이지이동
	@RequestMapping(value="/board/qna_write",method = RequestMethod.GET)
	public String qna_write() {
		return "/WEB-INF/board/qna_write.jsp";
	}
	
	
	//QNA - 글쓰기
	@RequestMapping(value="/board/qna_insert", method = RequestMethod.POST)
	public String qna_insert(QnaVO vo) {
		
		qna_SVC.qna_insert(vo);
		
		return "redirect:/board/qna_list";
	}
	
	//QNA 삭제하기
	@RequestMapping(value = "/board/qna_delete", method = RequestMethod.GET)
	public String qna_delete(QnaVO vo, Model model) {
		
		qna_SVC.qna_delete(vo);
		return "redirect:/board/qna_list";
	}
	
    // 댓글 추가
	@RequestMapping(value = "/board/addComment", method = RequestMethod.POST)
	@ResponseBody
    public String addComment( QnaCmtVO comment) {
    	
    	qna_SVC.addComment(comment);
        return "OK";
    }

	// 특정 QnA 글에 대한 댓글 목록
	@RequestMapping(value = "/board/commentList", method = RequestMethod.GET)
	@ResponseBody
	public List<QnaCmtVO> commentList(QnaCmtVO comment) {
		
	    return qna_SVC.commentList(comment); // 해당 qna_seq에 대한 댓글 목록을 반환
	}
    
    // 댓글 삭제
	@RequestMapping(value = "/board/deleteComment", method = RequestMethod.GET)
	@ResponseBody
    public String deleteComment(QnaCmtVO comment) {
    	qna_SVC.deleteComment(comment);
        return "OK";
    }

}
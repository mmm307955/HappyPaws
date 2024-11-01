package com.happypaws.life;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.happypaws.svc.LpCommentSVC;
import com.happypaws.vo.LpCommentVO;

@Controller
public class LpCommentController {
	int cntChk = 0;

	@Autowired
	private LpCommentSVC LpCommentSVC;

	// 댓글 등록
	@RequestMapping(value = "/insertLpComment.do")
	public String insertLpComment(LpCommentVO vo) throws IllegalStateException, IOException {
		LpCommentSVC.insertLpComment(vo);
		return "redirect:getLostPet.do?seq=" + vo.getLp_seq();
	}

	// 댓글 수정
	@RequestMapping("/updateLpComment.do")
	public String updateLpComment(LpCommentVO vo, HttpSession session) {
		LpCommentSVC.updateLpComment(vo);
		return "redirect:getLostPet.do?seq=" + vo.getLp_seq();
	}

	// 댓글 삭제
	@RequestMapping("/deleteLpComment.do")
	public String deleteLpComment(LpCommentVO vo, HttpServletRequest request) {
		LpCommentSVC.deleteLpComment(vo);
		return "redirect:getLostPet.do?seq=" + vo.getLp_seq();
	}

}
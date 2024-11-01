package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.LostPetSVC;
import com.happypaws.svc.LpCommentSVC;
import com.happypaws.vo.LostPetVO;
import com.happypaws.vo.LpCommentVO;
import com.happypaws.vo.PagingVO;

@Controller
public class LostPetController {
	int cntChk = 0;

	@Autowired
	private LostPetSVC lostPetSVC;

	@Autowired
	private LpCommentSVC lpCommentSVC;

	String realPath = "c:/happyPaws/happyPaws/src/main/webapp/resources/MIA-img/lostPetImg/";

	// 글목록 검색 옵션
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("제목", "TITLE");
		conditionMap.put("내용", "CONTENT");
		conditionMap.put("작성자", "ID");
		conditionMap.put("제목+내용", "TITLE,CONTENT");
		return conditionMap;
	}

	// 글 등록
	@RequestMapping(value = "/insertLostPet.do", method = RequestMethod.GET)
	public String insertView(LostPetVO vo) throws IllegalStateException, IOException {
		return "/WEB-INF/MIA/lostPet/insertLostPet.jsp";
	}

	@RequestMapping(value = "/insertLostPet.do", method = RequestMethod.POST)
	public String insertLostPet(LostPetVO vo) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();

		// UUID를 사용하여 새로운 파일 이름 생성
		String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFilename;
		vo.setLp_img(uniqueFileName);

		// 파일을 지정한 경로에 저장
		uploadFile.transferTo(new File(realPath + uniqueFileName));

		lostPetSVC.insertLostPet(vo);
		return "redirect:getLostPetList.do";
	}

	// 글 수정
	@RequestMapping(value = "/updateLostPet.do", method = RequestMethod.GET)
	public String updateView(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "lp_seq") int seq, LostPetVO vo, Model model) {

		vo.setLp_seq(seq);
		LostPetVO mlostpet = lostPetSVC.getLostPet(vo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			lostPetSVC.updateLostPetCnt(mlostpet);
		} else {
			cntChk = 0;
		}

		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("lostPet", mlostpet);
		return "/WEB-INF/MIA/lostPet/modifyLostPet.jsp";
	}

	@RequestMapping(value = "/updateLostPet.do", method = RequestMethod.POST)
	public String updateLostPet(LostPetVO vo, HttpSession session) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();

		// 기존 파일 이름과 비교하여 중복 여부 확인
		String existingImg = lostPetSVC.getCurrentImage(vo.getLp_seq()); // 현재 이미지 이름을 가져오는 서비스 메서드
		String newFileName;

		if (existingImg != null && existingImg.equals(originalFilename)) {
			// 파일 이름이 동일하면 기존 이름 사용
			newFileName = originalFilename;
		} else {
			// 파일 이름이 다르면 UUID 생성
			newFileName = UUID.randomUUID().toString() + "_" + originalFilename;
		}

		vo.setLp_img(newFileName);

		// 파일을 지정한 경로에 저장
		uploadFile.transferTo(new File(realPath + newFileName));

		// 데이터베이스 업데이트
		lostPetSVC.updateLostPet(vo);

		return "/getLostPet.do?lp_seq=" + vo.getLp_seq();
	}

	// 글 삭제
	@RequestMapping("/deleteLostPet.do")
	public String deleteLostPet(LostPetVO vo, HttpServletRequest request) {
		lostPetSVC.deleteLostPet(vo);
		return "redirect:getLostPetList.do";
	}

	// 글 완전히 삭제
	@RequestMapping("/deleteAllLostPet.do")
	public String deleteAllLostPet(LostPetVO vo, HttpServletRequest request) {
		realPath = request.getSession().getServletContext().getRealPath("/resources/img/");
		if (vo.getLp_img() != null) {
			System.out.println("파일삭제: " + realPath + vo.getLp_img());
			File f = new File(realPath + vo.getLp_img());
			f.delete();
		}
		lostPetSVC.deleteAllLostPet(vo);
		return "redirect:getLostPetList.do";
	}

	// 글 상세 조회 + 댓글 조회
	@RequestMapping("/getLostPet.do")
	public String getLostPet(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "lp_seq") int seq, LostPetVO vo, Model model, LpCommentVO cvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		vo.setLp_seq(seq);
		LostPetVO mlostpet = lostPetSVC.getLostPet(vo);

		cvo.setLp_seq(seq);
		List<LpCommentVO> mlpCommentlist = lpCommentSVC.getLpCommentList(cvo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			lostPetSVC.updateLostPetCnt(mlostpet);
		} else {
			cntChk = 0;
		}

		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("lostPet", mlostpet);
		model.addAttribute("lpComment", mlpCommentlist);
		return "/WEB-INF/MIA/lostPet/getLostPet.jsp";
	}

	// 글 목록
	@RequestMapping("/getLostPetList.do")
	public String getLostPetListPost(PagingVO pv, LostPetVO vo, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		String cntPerPage = "8";

		// 검색 조건 및 키워드 설정
		if (vo.getSearchCondition() == null) {
			vo.setSearchCondition("TITLE");
		} else {
			vo.setSearchCondition(vo.getSearchCondition());
		}

		if (vo.getSearchKeyword() == null) {
			vo.setSearchKeyword("");
		} else {
			vo.setSearchKeyword(vo.getSearchKeyword());
		}

		// 전체 개수 조회
		int total = lostPetSVC.countLostPet(vo);

		// 페이지 번호 설정
		if (nowPage == null) {
			nowPage = "1";
		}

		pv = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", pv);
		vo.setStart(pv.getStart());
		vo.setListcnt(Integer.parseInt(cntPerPage));

		// 모델에 추가
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("lostPetList", lostPetSVC.getLostPetList(vo));

		return "/WEB-INF/MIA/lostPet/getLostPetList.jsp";
	}

}
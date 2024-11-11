package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.NewFamilySVC;
import com.happypaws.svc.NfCommentSVC;
import com.happypaws.vo.NewFamilyVO;
import com.happypaws.vo.NfCommentVO;
import com.happypaws.vo.PagingVO;

@Controller
@RequestMapping("/MIA")
public class NewFamilyController {
	int cntChk = 0;

	@Autowired
	private NewFamilySVC newFamilySVC;

	@Autowired
	private NfCommentSVC nfCommentSVC;

	String realPath = "c:/happyPaws/happyPaws/src/main/webapp/resources/MIA-img/newFamilyImg/";

	// 글 등록
	@RequestMapping(value = "/insertNewFamily", method = RequestMethod.GET)
	public String insertView(NewFamilyVO vo) throws IllegalStateException, IOException {
		return "/WEB-INF/MIA/newFamily/insertNewFamily.jsp";
	}

	@RequestMapping(value = "/insertNewFamily", method = RequestMethod.POST)
	public String insertNewFamily(NewFamilyVO vo) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();

		// UUID를 사용하여 새로운 파일 이름 생성
		String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFilename;
		vo.setNf_img(uniqueFileName);

		// 파일을 지정한 경로에 저장
		uploadFile.transferTo(new File(realPath + uniqueFileName));

		newFamilySVC.insertNewFamily(vo);
		return "redirect:/MIA/getNewFamilyList";
	}

	// 글 수정
	@RequestMapping(value = "/updateNewFamily", method = RequestMethod.GET)
	public String updateView(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "nf_seq") int seq, NewFamilyVO vo, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		vo.setNf_seq(seq);
		NewFamilyVO mnewfamily = newFamilySVC.getNewFamily(vo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			newFamilySVC.updateNewFamilyCnt(mnewfamily);
		} else {
			cntChk = 0;
		}

		model.addAttribute("nowPage", vo.getNowPage());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("newFamily", mnewfamily);
		return "/WEB-INF/MIA/newFamily/modifyNewFamily.jsp";
	}

	@RequestMapping(value = "/updateNewFamily", method = RequestMethod.POST)
	public String updateNewFamily(NewFamilyVO vo, HttpSession session) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadFile();
		String originalFilename = uploadFile.getOriginalFilename();

		// 현재 이미지 이름을 가져오는 서비스 메서드
		String existingImg = newFamilySVC.getCurrentImage(vo.getNf_seq());
		String newFileName;

		if (existingImg != null && !existingImg.isEmpty() && originalFilename.isEmpty()) {
			// 파일을 업로드하지 않았을 때 기존 파일 이름을 그대로 사용
			newFileName = existingImg;
		} else if (existingImg != null && existingImg.equals(originalFilename)) {
			// 파일 이름이 동일하면 기존 이름 사용
			newFileName = existingImg;
		} else {
			// 파일 이름이 다르면 UUID 생성하여 새로운 파일 이름 설정
			newFileName = UUID.randomUUID().toString() + "_" + originalFilename;
		}

		vo.setNf_img(newFileName);

		// 파일이 비어 있지 않다면 지정한 경로에 저장
		if (!uploadFile.isEmpty()) {
			uploadFile.transferTo(new File(realPath + newFileName));
		}

		// 데이터베이스 업데이트
		newFamilySVC.updateNewFamily(vo);

		return "redirect:/MIA/getNewFamily?nf_seq=" + vo.getNf_seq() + "&nowPage=" + vo.getNowPage() + "&category="
				+ vo.getCategory() + "&searchKeyword=" + vo.getSearchKeyword() + "&searchCondition="
				+ vo.getSearchCondition();
	}

	// 글 삭제
	@RequestMapping("/deleteNewFamily")
	public String deleteNewFamily(NewFamilyVO vo, HttpServletRequest request) {
		newFamilySVC.deleteNewFamily(vo);
		return "redirect:/MIA/getNewFamilyList";
	}

	// 글 완전히 삭제
	@RequestMapping("/deleteAllNewFamily")
	public String deleteAllNewFamily(NewFamilyVO vo, HttpServletRequest request) {
		realPath = request.getSession().getServletContext().getRealPath("/resources/img/");
		if (vo.getNf_img() != null) {
			System.out.println("파일삭제: " + realPath + vo.getNf_img());
			File f = new File(realPath + vo.getNf_img());
			f.delete();
		}
		newFamilySVC.deleteAllNewFamily(vo);
		return "redirect:/MIA/getNewFamilyList";
	}

	// 글 상세 조회 + 댓글 조회
	@RequestMapping("/getNewFamily")
	public String getNewFamily(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "nf_seq") int seq, NewFamilyVO vo, Model model, NfCommentVO cvo,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "category", required = false) String category) {

		vo.setNf_seq(seq);
		NewFamilyVO mnewfamily = newFamilySVC.getNewFamily(vo);

		cvo.setNf_seq(seq);

		List<NfCommentVO> mnfCommentlist = nfCommentSVC.getNfCommentList(cvo);

		if (!(error == null || error.equals(""))) {
			cntChk = 0;
		} else if (cntChk <= 0) {
			newFamilySVC.updateNewFamilyCnt(mnewfamily);
		} else {
			cntChk = 0;
		}

		model.addAttribute("nowPage", vo.getNowPage());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", vo.getCategory());
		model.addAttribute("newFamily", mnewfamily);
		model.addAttribute("nfComment", mnfCommentlist);

		return "/WEB-INF/MIA/newFamily/getNewFamily.jsp";
	}

	// 글 목록
	@RequestMapping("/getNewFamilyList")
	public String getNewFamilyListPost(PagingVO pv, NewFamilyVO vo, Model model,
			@RequestParam(value = "nowPage", required = false, defaultValue = "1") Integer nowPage,
			@RequestParam(value = "category", required = false, defaultValue = "") String category) {
		// 페이지당 항목 수 설정
		int cntPerPage = 8;

		// 검색 조건과 키워드가 없을 때 기본값 설정
		if (vo.getSearchCondition() == null) {
			vo.setSearchCondition("TITLE");
		}
		if (vo.getSearchKeyword() == null) {
			vo.setSearchKeyword("");
		}

		// 전체 항목 개수 조회
		int total = newFamilySVC.countNewFamily(vo);

		// 페이징 객체 생성
		pv = new PagingVO(total, nowPage, cntPerPage);
		vo.setStart(pv.getStart());
		vo.setListcnt(cntPerPage);

		// 분실 반려동물 목록 조회
		List<NewFamilyVO> newFamilyList = newFamilySVC.getNewFamilyList(vo);

		// 댓글 수 설정
		newFamilySVC.countNfComment(newFamilyList);

		// 모델에 필요한 데이터 추가
		model.addAttribute("paging", pv);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("category", category);
		model.addAttribute("newFamilyList", newFamilyList);

		return "/WEB-INF/MIA/newFamily/getNewFamilyList.jsp";
	}

}

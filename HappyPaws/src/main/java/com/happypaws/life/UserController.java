package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.happypaws.svc.UserSVC;
import com.happypaws.util.JwtCookieUtil;
import com.happypaws.vo.AdVO;
import com.happypaws.vo.MyPostVO;
import com.happypaws.vo.UsersVO;

@Controller

public class UserController {
    @Autowired
    private UserSVC svc;
    
    @GetMapping("/userList.do")
    public String userSelectAll(
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            Model m) {

        List<UsersVO> userList;
        if (searchType != null && !searchType.isEmpty() && searchKeyword != null && !searchKeyword.isEmpty()) {
            userList = svc.searchUsers(searchType, searchKeyword);
        } else {
            userList = svc.userSelectAll();
        }

        System.out.println("조회된 데이터: " + userList);
        m.addAttribute("userList", userList);
        return "/WEB-INF/mypage/us_list.jsp";
    }

    
    @GetMapping("/userDetail.do")
    public String selectUserDetail(@RequestParam("us_id") String us_id, Model model) {
        UsersVO user = svc.user_detail(us_id);

        // us_is_del 값이 'Y'이면 탈퇴한 회원 알림 메시지 추가
        if (user != null && "Y".equals(user.getUs_is_del())) {
            model.addAttribute("alertMessage", "탈퇴한 회원입니다.");
        }

        model.addAttribute("user", user);
        return "/WEB-INF/mypage/us_detail.jsp";  
    }


        
    @GetMapping("/userUpdate.do")
    public String updateForm(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보를 추출
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 사용자 정보를 모델에 추가
        m.addAttribute("user", user);
        return "/WEB-INF/mypage/us_update.jsp";  
    }

    @PostMapping("/userUpdate.do")
    public String updateUser(HttpServletRequest request, UsersVO vo, Model m) {
        // 쿠키에서 사용자 정보를 추출
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);

        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 기존 사용자 정보 가져오기
        UsersVO existingUser = svc.user_detail(user.getUs_id());

        // 비밀번호가 null이거나 빈 문자열이면 기존 비밀번호 유지
        if (vo.getUs_password() == null || vo.getUs_password().isEmpty()) {
            vo.setUs_password(existingUser.getUs_password());
        }

        // us_id 설정: JWT에서 가져온 사용자 ID로 설정
        vo.setUs_id(user.getUs_id());

        // 사용자 정보 업데이트
        svc.user_update(vo);
        m.addAttribute("message", "수정이 완료되었습니다.");

        // 업데이트된 사용자 목록 가져오기
        List<UsersVO> userList = svc.userSelectAll();
        m.addAttribute("userList", userList);

        return "/WEB-INF/mypage/us_list.jsp"; // 수정된 목록 화면으로 이동
    }
//    @GetMapping("/userDelete.do")
//    public String showDeleteUserPage(HttpServletRequest request, Model m) {
//        // 쿠키에서 사용자 정보를 추출
//        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
//        
//        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
//        if (user == null || user.getUs_id() == null) {
//            m.addAttribute("message", "로그인이 필요합니다.");
//            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
//        }
//        
//        // 사용자 ID와 탈퇴 확인 메시지를 모델에 추가
//        m.addAttribute("us_id", user.getUs_id());
//        m.addAttribute("message", "탈퇴를 원하시면 확인 버튼을 눌러주세요.");
//
//        // 탈퇴 확인 페이지로 이동
//        return "/WEB-INF/mypage/us_list.jsp";
//    }

    @PostMapping("/userDelete.do")
    public String deleteUser(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보를 추출
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 사용자 정보가 없을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }
        
        // 실제 삭제 대신, 탈퇴 처리로 us_is_del 값을 'Y'로 변경
        svc.updateUserToDeleted(user.getUs_id()); // 'Y'로 업데이트하는 메서드 호출
        
        // 탈퇴 완료 메시지를 모델에 추가
        m.addAttribute("message", "회원 탈퇴가 완료되었습니다.");

        // 탈퇴 완료 페이지로 이동
        return "redirect:/userList.do";
    }

    @GetMapping("/us_mainmyPage.do")
    public String us_mainMyPage(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보를 추출합니다.
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 쿠키에서 사용자 정보를 가져오지 못했을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }
        
        // 사용자 정보를 모델에 추가하여 JSP에서 사용할 수 있도록 합니다.
        m.addAttribute("user", user);
        
        // 메인 마이페이지로 이동
        return "/WEB-INF/mypage/us_mainmypage.jsp";  
    }
    @GetMapping("/us_myPage.do")
    public String us_myPage(HttpServletRequest request, Model m) {
        // 쿠키에서 사용자 정보를 추출합니다.
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 쿠키에서 사용자 정보를 가져오지 못했을 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }
        
        // 사용자 정보를 모델에 추가하여 JSP에서 사용할 수 있도록 합니다.
        m.addAttribute("user", user);
        
        // 마이페이지로 이동
        return "/WEB-INF/mypage/us_mypage.jsp";  
    }

    @PostMapping("/us_myPage.do")
    public String updateMyPage(
        HttpServletRequest request,
        HttpServletResponse response,
        @ModelAttribute UsersVO user,
        @RequestParam(value = "us_profile_file", required = false) MultipartFile us_profile_file,
        @RequestParam(value = "postcode", required = false) String postcode,
        Model m) {
        
        // 쿠키에서 사용자 정보를 추출합니다.
        UsersVO userFromCookie = JwtCookieUtil.extractJwtFromCookie(request);
        
        // 쿠키에서 사용자 정보를 가져오지 못했을 경우 로그인 페이지로 리다이렉트
        if (userFromCookie == null || userFromCookie.getUs_id() == null) {
            m.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // JWT에서 추출한 사용자 ID를 설정하여 사용자 정보를 업데이트합니다.
        user.setUs_id(userFromCookie.getUs_id());

        // 프로필 이미지 처리
        if (us_profile_file != null && !us_profile_file.isEmpty()) {
            try {
                // 원래 파일 이름에서 확장자 추출
                String originalFilename = us_profile_file.getOriginalFilename();
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));

                // 고유한 파일 이름 생성 (UUID 사용)
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                // 파일 저장 경로 설정
                String uploadDir = "c:/happyPaws/happyPaws/src/main/webapp/resources/profile_images/";
                File uploadDirFile = new File(uploadDir);
                if (!uploadDirFile.exists()) {
                    uploadDirFile.mkdirs();
                }

                // 파일 저장
                File outputFile = new File(uploadDir + uniqueFileName);
                us_profile_file.transferTo(outputFile);

                // UsersVO에 프로필 이미지 파일 이름 설정
                user.setUs_profile(uniqueFileName);

            } catch (IOException e) {
                e.printStackTrace();
                m.addAttribute("message", "프로필 이미지 업로드 중 오류가 발생했습니다.");
                return "/WEB-INF/mypage/us_mypage.jsp";
            }
        } else {
        	System.out.println("사진 파일이 없습니다.");
        }

        // 우편번호 설정
        user.setPostcode(postcode); // UsersVO에 우편번호 설정

        // 사용자 정보 업데이트
        svc.user_update(user);
        
        user = svc.user_detail(user.getUs_id());
        JwtCookieUtil.createJwtCookie(response, user);
        userFromCookie = JwtCookieUtil.extractJwtFromCookie(request);
        request.getSession().setAttribute("user", userFromCookie);

        // 업데이트된 사용자 정보를 다시 가져와 모델에 추가
        List<UsersVO> userList = svc.userSelectAll(); // 전체 사용자 목록 가져오기
        m.addAttribute("userList", userList); // Model에 목록 추가
        m.addAttribute("message", "정보가 성공적으로 업데이트되었습니다.");

        return "/WEB-INF/mypage/us_list.jsp";  // 수정된 목록 화면으로 이동
    }


    @RequestMapping("/logout")
	public String logout(HttpServletResponse response, HttpSession session) {
		session.removeAttribute("user");
		JwtCookieUtil.deleteJwtCookie(response);
		return "redirect:/userList.do";
	}
    
    @GetMapping("/myPosts")
    public String showMyPosts(HttpServletRequest request, Model model) {
        // 쿠키에서 JWT를 통해 사용자 정보를 추출합니다.
        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);

        // 사용자 정보가 없거나 ID가 없는 경우 로그인 페이지로 리다이렉트
        if (user == null || user.getUs_id() == null) {
            model.addAttribute("message", "로그인이 필요합니다.");
            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
        }

        // 현재 사용자 ID의 게시물 목록 조회
        List<MyPostVO> userPosts;
        try {
            userPosts = svc.getPostsByUserId(user.getUs_id());
        } catch (Exception e) {
            model.addAttribute("error", "게시물을 불러오는 중 오류가 발생했습니다.");
            return "redirect:/auth/login"; // 에러 페이지로 리다이렉트
        }

        // 필터링된 게시물 목록을 모델에 추가
        model.addAttribute("posts", userPosts);
        model.addAttribute("user", user); // 사용자 정보를 모델에 추가

        // 내 게시물 페이지로 이동
        return "/WEB-INF/mypage/mypost.jsp";
    }

//    @GetMapping("/postDetail")
//    public String postDetail(@RequestParam("post_id") int postId, HttpServletRequest request, Model model) {
//        // 쿠키에서 JWT를 통해 사용자 정보를 추출
//        UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
//
//        // 사용자 정보가 없거나 ID가 없는 경우 로그인 페이지로 리다이렉트
//        if (user == null || user.getUs_id() == null) {
//            model.addAttribute("message", "로그인이 필요합니다.");
//            return "redirect:/auth/login"; // 로그인 페이지로 리다이렉트
//        }
//
//        // 현재 로그인한 사용자 ID를 저장
//        String currentUserId = user.getUs_id();
//
//        // `post_id`를 기반으로 게시물 정보를 조회
//        MyPostVO post = svc.getPostById(postId);
//
//        // 게시물이 존재하고, 현재 사용자가 게시물의 작성자인지 확인
//        if (post != null && post.getUs_id().equals(currentUserId)) {
//            model.addAttribute("post", post); // 모델에 게시물 정보 추가
//            return "/WEB-INF/mypage/postDetail.jsp"; // 게시물 상세 페이지로 이동
//        } else {
//            // 게시물이 없거나 접근 권한이 없는 경우 오류 메시지 추가
//            model.addAttribute("errorMessage", "해당 게시물을 찾을 수 없거나 접근 권한이 없습니다.");
//            return "/WEB-INF/mypage/error.jsp"; // 에러 페이지로 이동
//        }
//    }

}

   
    


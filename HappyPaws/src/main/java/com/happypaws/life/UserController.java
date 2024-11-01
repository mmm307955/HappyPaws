package com.happypaws.life;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

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
import com.happypaws.vo.AdVO;
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
    public String selectUserDetail(@RequestParam("us_id") String us_id, Model m) {
    	System.out.println("us_id = " + us_id);
        UsersVO user = svc.user_detail(us_id);
        System.out.println("조회된 사용자 정보: " + user); 
        if (user != null) {
            m.addAttribute("user", user); 
        }
        return "/WEB-INF/mypage/us_detail.jsp";  
    }

        
    @GetMapping("/userUpdate.do")
    public String updateForm(@RequestParam("us_id") String us_id, Model m) {
        UsersVO user = svc.user_detail(us_id); 
        m.addAttribute("user", user);
        return "/WEB-INF/mypage/us_update.jsp";  
    }

    
    @PostMapping("/userUpdate.do")
    public String updateUser(UsersVO vo, Model m) {

        svc.user_update(vo);
        m.addAttribute("message", "수정이 완료되었습니다.");
        
        List<UsersVO> userList = svc.userSelectAll();
        m.addAttribute("userList", userList);
        return "/WEB-INF/mypage/us_list.jsp";  // 수정된 목록 화면으로 이동
    }

   
    @GetMapping("/userDelete.do")
    public String deleteById(@RequestParam("us_id") String us_id, Model m) {
        svc.deleteById(us_id);
        List<UsersVO> userList = svc.userSelectAll();
        m.addAttribute("userList", userList); 
        return "/WEB-INF/mypage/us_list.jsp";
    }

   
    @GetMapping("/us_myPage.do")
    public String us_myPage(@RequestParam("us_id") String us_id, Model m) {
        UsersVO user = svc.user_detail(us_id); 
    	System.out.println("777st user: " + user);
        m.addAttribute("user", user);  
        return "/WEB-INF/mypage/us_mypage.jsp";  
    }
    
    @PostMapping("/us_myPage.do")
    public String updateMyPage(@ModelAttribute 	UsersVO user,@RequestParam(value="us_profile_file", required = false) MultipartFile us_profile_file, 
            Model m, HttpSession session) {
    	System.out.println("1st user: " + user);
        // 세션에서 사용자 ID를 가져옵니다.
//        String sessionUserId = (String) session.getAttribute("us_id");
//        if (sessionUserId == null || !sessionUserId.equals(user.getUs_id())) {
//            // 로그인하지 않았거나 세션 ID와 폼의 ID가 다를 경우
//            m.addAttribute("message", "권한이 없습니다. 다시 로그인해주세요.");
//            return "redirect:/";
//        }
    	
    	 // 프로필 이미지 처리
        if (us_profile_file != null && !us_profile_file.isEmpty()) {
            try {
                // 원래 파일 이름에서 확장자 추출
                String originalFilename = us_profile_file.getOriginalFilename();
                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));

                // 고유한 파일 이름 생성 (UUID 사용)
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                // 파일 저장 경로 설정
                String uploadDir = "src/main/resources/profile_images/";
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
        }

        // 사용자 정보 업데이트
        svc.user_update(user);

        // 업데이트된 사용자 정보를 다시 가져와 모델에 추가
        UsersVO updatedUser = svc.user_detail(user.getUs_id());
        m.addAttribute("user", updatedUser);
        m.addAttribute("message", "정보가 성공적으로 업데이트되었습니다.");

        return "/WEB-INF/mypage/us_mypage.jsp";  // 마이페이지로 이동
    }

    
   
    
}

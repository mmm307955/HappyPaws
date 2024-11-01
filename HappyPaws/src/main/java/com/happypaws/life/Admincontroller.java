package com.happypaws.life;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.happypaws.svc.AdSVC;
import com.happypaws.vo.AdVO;

@Controller
public class Admincontroller {

    @Autowired
    private AdSVC svc;

    @GetMapping("/ad_myPage.do")
    public String ad_myPage(@RequestParam("ad_id") String ad_id, Model m) {
        AdVO admin= svc.ad_detail(ad_id); 
        m.addAttribute("admin", admin);  
        return "/WEB-INF/mypage/ad_myPage.jsp";  
    }
    // 비밀번호 변경 폼으로 이동
    @GetMapping("/updateAdminPassword.do")
    public String updateAdminPasswordForm(HttpSession session, Model model) {
        String ad_id = (String) session.getAttribute("ad_id");
        if (ad_id == null) {
            return "/WEB-INF/mypage/adminLogin.do"; 
        }
        model.addAttribute("ad_id", ad_id);
        return "/WEB-INF/mypage/ad_myPage.jsp"; 
    }

    // 비밀번호 변경 처리
    @PostMapping("/updateAdminPassword.do")
    public String updateAdminPassword(@RequestParam("ad_id") String ad_id,
                                      @RequestParam("currentPassword") String currentPassword,
                                      @RequestParam("newPassword") String newPassword,
                                      Model model) {
        boolean isValid = svc.verifyPassword(ad_id, currentPassword);
        if (!isValid) {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
            return "/WEB-INF/mypage/ad_myPage.jsp";
        }

        svc.updatePassword(ad_id, newPassword);
        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "/WEB-INF/mypage/ad_myPage.jsp";
    }
}

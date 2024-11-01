package com.happypaws.svc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.happypaws.dao.AdDAO;
import com.happypaws.vo.AdVO;


@Service
public class AdSVC {

    @Autowired
    private AdDAO dao;
    
    // 관리자 세부 정보 조회
    public AdVO ad_detail(String ad_id) {
        return dao.getAdminById(ad_id); // AdDAO의 메서드 호출
    }


 // 현재 비밀번호 검증
    public boolean verifyPassword(String ad_id, String currentPassword) {
        String storedPassword = dao.getPasswordById(ad_id);
        return storedPassword != null && storedPassword.equals(currentPassword);
    }

    // 비밀번호 업데이트
    public void updatePassword(String ad_id, String newPassword) {
        dao.updatePassword(ad_id, newPassword);
    }
}

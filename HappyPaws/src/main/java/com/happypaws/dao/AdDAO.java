package com.happypaws.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.AdVO;

@Repository
public class AdDAO {

    @Autowired
    private SqlSession sqlSession;
    
 // 관리자 정보 조회 메서드
    public AdVO getAdminById(String ad_id) {
        return sqlSession.selectOne("com.happypaws.dao.AdDAO.getAdminById", ad_id);
    }


    // 관리자 비밀번호 조회
    public String getPasswordById(String ad_id) {
        return sqlSession.selectOne("com.happypaws.dao.AdDAO.getPasswordById", ad_id);
    }

    // 비밀번호 업데이트
    public void updatePassword(String ad_id, String newPassword) {
        Map<String, Object> params = new HashMap<>();
        params.put("ad_id", ad_id);
        params.put("ad_password", newPassword);
        sqlSession.update("com.happypaws.dao.AdDAO.updatePassword", params);
    }
}

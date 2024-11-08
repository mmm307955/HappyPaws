package com.happypaws.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.UsersVO;


@Component
@Repository
public class UserDAO {
    @Autowired
    private SqlSession sql;

    public List<UsersVO> userSelectAll() {
        return sql.selectList("com.happypaws.dao.UserDAO.userSelectAll");
    }

    public List<UsersVO> searchUsers(String searchType, String searchKeyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);

        return sql.selectList("com.happypaws.dao.UserDAO.searchUsers", params);
    }

    
    public UsersVO user_detail(String us_id) {
        return sql.selectOne("com.happypaws.dao.UserDAO.user_detail", us_id);
    }

    
    public void user_update(UsersVO vo) {
    	
        sql.update("com.happypaws.dao.UserDAO.user_update", vo);
        
    }

//    public void us_is_del(String us_id) {
//        int deletedRows = sql.delete("com.happypaws.dao.UserDAO.us_is_del", us_id);
//        System.out.println("삭제된 행의 수: " + deletedRows);
//    }

    
    public UsersVO myPage(String us_id) {
        return sql.selectOne("com.happypaws.dao.UserDAO.myPage", us_id);
    }
    
    public void updateUserInfo(UsersVO user) {
        sql.update("com.happypaws.dao.UserDAO.updateUserInfo", user);
    }
    public UsersVO getUserById(String userId) {
        return sql.selectOne("com.happypaws.dao.UserDAO.getUserById", userId);
    }

    public void updatePassword(String adminId, String newPassword) {
        UsersVO user = new UsersVO();
        user.setUs_id(adminId);
        user.setUs_password(newPassword);
        sql.update("com.happypaws.dao.UserDAO.updatePassword", user);
    }
    
    public void updateUserToDeleted(String us_id) {
        // MyBatis를 사용하여 us_is_del 필드를 'Y'로 업데이트
        Map<String, Object> params = new HashMap<>();
        params.put("us_id", us_id);
        params.put("us_is_del", "Y");

        sql.update("com.happypaws.dao.UserDAO.updateUserToDeleted", params);
    }

}
package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.happypaws.dao.UserDAO;
import com.happypaws.vo.UsersVO;

@Service
public class UserSVC {

    @Autowired
    private UserDAO dao;
    
    public List<UsersVO> userSelectAll() {
        return dao.userSelectAll();
    }

    public List<UsersVO> searchUsers(String searchType, String searchKeyword) {
        return dao.searchUsers(searchType, searchKeyword);
    }

    
    public UsersVO user_detail(String us_id) {
        return dao.user_detail(us_id);
    }
   
    public void user_update(UsersVO vo) {
    	dao.user_update(vo);
    }
    
    public void deleteById(String us_id) {
    	 dao.us_is_del(us_id);
    }

	public UsersVO getUserById(String us_id) {
		
		  return dao.getUserById(us_id);
    }

	
	 public void updateUserInfo(UsersVO user) {
	        dao.updateUserInfo(user);
	    }
	
	public UsersVO myPage(String us_id) {
        return dao.user_detail(us_id);  
    }

	public boolean verifyPassword(String adminId, String currentPassword) {
		
		  UsersVO admin = dao.getUserById(adminId);
	        return admin != null && admin.getUs_password().equals(currentPassword);
	    }


	public void updatePassword(String adminId, String newPassword) {
		
		 dao.updatePassword(adminId, newPassword);
    }

}

	

	
	

	

	


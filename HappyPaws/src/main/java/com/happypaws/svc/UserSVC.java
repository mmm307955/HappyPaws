package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.UserDAO;
import com.happypaws.vo.MyPostVO;
import com.happypaws.vo.UsersVO;

@Service
public class UserSVC {

    @Autowired
    private  UserDAO dao;
    
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
    
//    public void deleteById(String us_id) {
//    	 dao.us_is_del(us_id);
//    }

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

	public void updateUserToDeleted(String us_id) {
		  dao.updateUserToDeleted(us_id); 

		
	}
	
	  
	// 서비스 메소드 - 사용자 ID로 게시물 목록 조회
	  public List<MyPostVO> getPostsByUserId(String us_id) {
	      try {
	          // DAO 메소드 호출하여 사용자 ID로 게시물 목록 조회
	          return dao.findPostsByUserId(us_id);
	      } catch (Exception e) {
	          e.printStackTrace();
	          throw new RuntimeException("게시물 목록 조회 중 오류가 발생했습니다.");
	      }
	  }


}

	

	
	

	

	


package com.happypaws.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.AuthDAO;
import com.happypaws.vo.UsersVO;

/**
 * @version 0.0.0
 * @since 10.24
 * @author hi
 */
@Service
public class AuthSVC {
	@Autowired
	private AuthDAO dao;
	
	public UsersVO test() {
		return dao.test();
	}
	
	public UsersVO login(UsersVO user) {
		return dao.login(user);
	}
	
	public boolean checkNick(String nick) {
		return dao.checkNick(nick);
	}
	
	public boolean join(UsersVO user) {
		return dao.join(user);
	}
}
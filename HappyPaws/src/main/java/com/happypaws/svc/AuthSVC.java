package com.happypaws.svc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.AuthDAO;
import com.happypaws.vo.UsersVO;

@Service
public class AuthSVC {
	@Autowired
	private AuthDAO dao;

	public UsersVO test(UsersVO vo) {
		return dao.test(vo);
	}

	public UsersVO login(UsersVO user) {
		return dao.login(user);
	}

	public boolean checkId(String id) {
		return dao.checkId(id);
	}

	public boolean checkNick(String nick) {
		return dao.checkNick(nick);
	}

	public boolean join(UsersVO user) {
		return dao.join(user);
	}

	public String findId(UsersVO user) {
		return dao.findId(user);
	}

	public boolean checkUser(UsersVO user) {
		return dao.checkUser(user);
	}

	public boolean findPw(UsersVO user) {
		return dao.findPw(user);
	}
}
package com.happypaws.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.UsersVO;

/**
 * @version 0.0.0
 * @since 10.24
 * @author 강동준
 */
@Repository
public class AuthDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public UsersVO test() {
		return mybatis.selectOne("AuthDAO.test");
	}
	
	public UsersVO login(UsersVO user) {
		return mybatis.selectOne("AuthDAO.login", user);
	}
	
	public boolean checkNick(String nick) {
		return mybatis.selectOne("AuthDAO.checkNick", nick) == null;
	}
	
	public boolean join(UsersVO user) {
		return mybatis.insert("AuthDAO.join", user) > 0;
	}
}
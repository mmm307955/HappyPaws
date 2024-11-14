package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.AuthDAO;
import com.happypaws.vo.UsersVO;

@Service
public class AuthSVC {
	@Autowired
	private AuthDAO dao;

	public UsersVO login(UsersVO user) {
		return dao.login(user);
	}

	public boolean snsJoin(UsersVO user) {
		return dao.snsJoin(user);
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

	public List<String> findId(UsersVO user) {
		List<String> findIds = dao.findId(user);
		findIds.replaceAll(findId -> findId = maskUserName(findId));
		return findIds;
	}
	
	private String maskUserName(String username) {
        int length = username.length();

        if (length <= 4) {
            // 길이가 4자 이하인 경우, 마지막 두 글자 마스킹
            return username.substring(0, 2) + "**";
        } else if (length <= 8) {
            // 길이가 5~8자인 경우, 중간 2~3글자 마스킹
            int start = 2;
            int end = Math.min(length, start + 3);
            return username.substring(0, start) + "*".repeat(end - start) + username.substring(end);
        } else {
            // 길이가 9자 이상인 경우, 중간 4글자 마스킹
            int start = 3;
            int end = Math.min(length, start + 4);
            return username.substring(0, start) + "*".repeat(end - start) + username.substring(end);
        }
    }

	public boolean checkUser(UsersVO user) {
		return dao.checkUser(user);
	}

	public boolean findPw(UsersVO user) {
		return dao.findPw(user);
	}
}
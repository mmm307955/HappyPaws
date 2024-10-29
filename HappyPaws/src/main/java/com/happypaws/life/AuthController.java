package com.happypaws.life;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.AuthSVC;
import com.happypaws.util.Argon2Util;
import com.happypaws.vo.UsersVO;

/**
 * @since 10.24
 * @version 0.0.0
 * @author 강동준
 */
@Controller
public class AuthController {
	@Autowired
	private AuthSVC svc;

	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/authentication/login.jsp";
	}

	@PostMapping("/login")
	public String login(UsersVO user, Model model) {
		String password = user.getUs_password();
		user = svc.login(user);
		if (user == null) {
			model.addAttribute("error", "id");
		} else if (Argon2Util.verifyPassword(user.getUs_password(), password)) {
			// 아이디를 암호화해서 쿠키로 저장하기
			// 저장된 암호화된 아이디는 복호화하여 사용할 수 있다.
			model.addAttribute("nick", user.getUs_nick());
			return "/WEB-INF/authentication/welcome.jsp";
		} else {
			model.addAttribute("error", "password");
		}
		return "/WEB-INF/authentication/login.jsp";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/authentication/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(UsersVO user) {
		if (svc.join(user)) {
			return "redirect:/join";
		} else {

		}
		return "redirect:/";
	}
	
	/**
	 * 닉네임 중복 검사
	 */
	@ResponseBody
	@RequestMapping(value = "/nick_check", produces = "text/plain; charset=UTF-8")
	public String nickCheck(@RequestBody String nick) {
		if (svc.checkNick(nick)) {
			return "true";
		} else {
			return "false";
		}
	}

	/**
	 * 비밀번호 암호화 테스트 함수
	 */
	@GetMapping("/test")
	public String test(Model model) {
		String pass = null;
		String hashPw = null;

		pass = "1111";
		hashPw = Argon2Util.hashPassword(pass);
		System.out.println("1111 암호화: " + hashPw);
		System.out.println("1111 재암호화: " + Argon2Util.hashPassword(pass));
		System.out.println("1111 암호화 문장 길이: " + hashPw.length() + "글자");
		System.out.println("비교: " + Argon2Util.verifyPassword(hashPw, pass));

		UsersVO vo = svc.test();
		if (Argon2Util.verifyPassword(vo.getUs_password(), "1234")) {
			model.addAttribute("testAttribute", svc.test());
			return "/WEB-INF/authentication/test.jsp";
		}
		System.out.println("틀린데요?");
		return "redirect:/";
	}

	/**
	 * id로 불러오기 테스트 함수
	 */
	@GetMapping("/test2")
	public String test2(Model model) {
		UsersVO user = new UsersVO();
		user.setUs_id("test");
		user = svc.login(user);
		System.out.println(user);
		return "redirect:/";
	}
}

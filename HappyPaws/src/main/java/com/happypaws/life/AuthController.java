package com.happypaws.life;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.AuthSVC;
import com.happypaws.util.Argon2Util;
import com.happypaws.util.JwtCookieUtil;
import com.happypaws.util.SNSAuthUtil;
import com.happypaws.vo.UsersVO;

@Controller
@RequestMapping("/auth")
public class AuthController {
	@Autowired
	private AuthSVC svc;

	@Autowired
	private SNSAuthUtil auth;

	@GetMapping("/login")
	public String login(Model model, HttpServletRequest request) {
		if (JwtCookieUtil.extractJwtFromCookie(request) != null) {
			return "redirect:/";
		}
		
		try {
			model.addAttribute("naverLoginUrl", auth.naverLoginUrl());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "/WEB-INF/auth/login.jsp";
	}

	/**
	 * 로그인 기능
	 */
	@PostMapping("/login")
	public String login(UsersVO user, Model model, HttpServletResponse response) {
		String password = user.getUs_password();
		user = svc.login(user);
		if (user == null) {
			model.addAttribute("error", "id");
		} else if (user.getUs_is_del().equals("Y")) {
			model.addAttribute("error", "del");
		} else if (Argon2Util.verifyPassword(user.getUs_password(), password)) {
			JwtCookieUtil.createJwtCookie(response, user);
			model.addAttribute("nick", user.getUs_nick());
			return "/WEB-INF/auth/welcome.jsp";
		} else {
			model.addAttribute("error", "password");
		}
		return "/WEB-INF/auth/login.jsp";
	}

	@RequestMapping("/login/{sns_type}")
	public String snsLogin(@PathVariable("sns_type") String sns_type) {
		return "/WEB-INF/auth/" + sns_type + "Login.jsp";
	}

	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/auth/join.jsp";
	}

	/**
	 * 아이디 중복 검사
	 */
	@ResponseBody
	@RequestMapping(value = "/id_check", produces = "text/plain; charset=UTF-8")
	public String idCheck(@RequestBody String id) {
		System.out.println(id);
		System.out.println(svc.checkId(id));
		if (svc.checkId(id)) {
			return "true";
		} else {
			return "false";
		}
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
	 * 전화번호 인증
	 */
	public void authPhone() {
		// Do SomeThings...
	}

	/**
	 * 회원가입 기능
	 */
	@PostMapping("/join")
	public String join(UsersVO user) {
		user.setUs_password(Argon2Util.hashPassword(user.getUs_password()));
		if (svc.join(user)) {
			return "redirect:/auth/login";
		} else {
			return "redirect:/auth/join";
		}
	}

	@GetMapping("/find_id")
	public String findId() {
		return "/WEB-INF/auth/find_id.jsp";
	}
	
	@PostMapping("/find_id")
	public String findId(UsersVO user, Model model) {
		model.addAttribute("find_id", svc.findId(user));
		return "/WEB-INF/auth/find_id.jsp";
	}

	@GetMapping("/find_password")
	public String findPassword() {
		return "/WEB-INF/auth/find_password.jsp";
	}

	@PostMapping("/find_password")
	public String findPassword(UsersVO user, Model model) {
		model.addAttribute("find_pw", svc.findPw(user));
		return "/WEB-INF/auth/find_password.jsp";
	}

	@PostMapping("/change_password")
	public String changePassword(UsersVO user) {
		user.setUs_password(Argon2Util.hashPassword(user.getUs_password()));
		if (svc.changePw(user)) {
			return "redirect:/auth/login";
		} else {
			return "redirect:/auth/find_password";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpServletResponse response) {
		JwtCookieUtil.deleteJwtCookie(response);
		return "redirect:/";
	}

	/** 로그인 정보 확인 실험용 서블릿 */
	@GetMapping("/testAuth")
	public String test(Model model, HttpServletRequest request) {
		UsersVO user = JwtCookieUtil.extractJwtFromCookie(request);
		model.addAttribute("token", user);
		model.addAttribute("info", svc.test(user));
		return "/WEB-INF/auth/test.jsp";
	}
}
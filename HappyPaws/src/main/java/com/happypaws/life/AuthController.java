package com.happypaws.life;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.happypaws.svc.AuthApiSVC;
import com.happypaws.svc.AuthSVC;
import com.happypaws.util.Argon2Util;
import com.happypaws.util.JwtCookieUtil;
import com.happypaws.vo.UsersVO;

@Controller
@RequestMapping("/auth")
public class AuthController {
	// ===== 전역 필드 ===== //
	@Autowired
	private AuthSVC svc;

	@Autowired
	private AuthApiSVC apiSvc;

	// ===== 로그인 ===== //
	@GetMapping("/login")
	public String login(Model model, HttpServletRequest request) {
		if (JwtCookieUtil.extractJwtFromCookie(request) != null) {
			return "redirect:/";
		}

		try {
			apiSvc.snsLoginUrl(request);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return "/WEB-INF/auth/login.jsp";
	}

	@PostMapping("/login")
	public String login(UsersVO user, HttpServletResponse response, Model model) {
		String password = user.getUs_password();
		user.setUs_sns("default");
		user = svc.login(user);
		if (user == null) {
			model.addAttribute("error", "id");
		} else if (user.getUs_is_del().equals("Y")) {
			model.addAttribute("error", "del");
		} else if (!user.getUs_sns().equals("default")) {
			model.addAttribute("error", "sns");
		} else if (Argon2Util.verifyPassword(user.getUs_password(), password)) {
			user.setUs_profile("/resources/profile_images/" + user.getUs_profile());
			JwtCookieUtil.createJwtCookie(response, user);
			return "redirect:/";
		} else {
			model.addAttribute("error", "password");
		}
		return "/WEB-INF/auth/login.jsp";
	}

	@RequestMapping("/login/{divider}")
	public String naverLogin(@RequestParam(value = "code", required = false) String code,
			@RequestParam(value = "state") String state,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "error_description", required = false) String errorDescription,
			@PathVariable String divider, HttpServletRequest request, HttpServletResponse response) {
		String storedState = (String) request.getSession().getAttribute("oauthState");
		request.getSession().removeAttribute("oauthState");

		if (storedState == null || !storedState.equals(state) || error != null || code == null) {
			return "/WEB-INF/auth/loginError.jsp";
		}

		UsersVO user = null;

		try {
			switch (divider) {
			case "naver":
				user = apiSvc.requestNaverUserDetails(code, state);
				break;
			case "kakao":
				user = apiSvc.requestKakaoUserDetails(code);
				break;
			default:
				return "/WEB-INF/auth/loginError.jsp";
			}
		} catch (Exception e) {
			request.getSession().setAttribute("error", e.getStackTrace());
			return "/WEB-INF/auth/loginError.jsp";
		}

		if (!svc.checkId(user.getUs_id())) {
			user = svc.login(user);
			user.setUs_profile("/resources/profile_images/" + user.getUs_profile());
			JwtCookieUtil.createJwtCookie(response, user);
			return "redirect:/";
		}

		if (svc.checkNick(user.getUs_nick())) {
			apiSvc.saveProfileImage(user);
			svc.snsJoin(user);
			user = svc.login(user);
			user.setUs_profile("/resources/profile_images/" + user.getUs_profile());
			if (user != null && user.getUs_sns().equals(divider)) {
				JwtCookieUtil.createJwtCookie(response, user);
				return "redirect:/";
			}
		}

		request.getSession().setAttribute("snsUser", user);
		return "/WEB-INF/auth/change_nick.jsp";
	}

	@PostMapping("/snsReJoin")
	public String snsReJoin(HttpServletResponse response, HttpSession session, String new_nickname) {
		UsersVO user = (UsersVO) session.getAttribute("snsUser");
		user.setUs_nick(new_nickname);
		apiSvc.saveProfileImage(user);
		svc.snsJoin(user);
		user = svc.login(user);
		user.setUs_profile("/resources/profile_images/" + user.getUs_profile());
		if (user != null && user.getUs_sns().equals("naver")) {
			JwtCookieUtil.createJwtCookie(response, user);
		}
		session.removeAttribute("snsUser");
		return "redirect:/";
	}

	// ===== 회원가입 ===== //
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/auth/join.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/id_check", produces = "text/plain; charset=UTF-8")
	public String idCheck(@RequestBody String id) {
		if (svc.checkId(id)) {
			return "true";
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/nick_check", produces = "text/plain; charset=UTF-8")
	public String nickCheck(@RequestBody String nick) {
		if (svc.checkNick(nick)) {
			return "true";
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/authPhone", method = RequestMethod.GET)
	public boolean authPhone(@RequestParam("us_phone") String phone) {
		String messageId = apiSvc.generateAndSendCode(phone);
		if (messageId != null) {
			return true;
		} else {
			return false;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/authPhone", method = RequestMethod.POST)
	public boolean authPhone(@RequestParam("us_phone") String phone, @RequestParam("us_phone_auth_code") String code) {
		return apiSvc.verifyCode(phone, code);
	}

	@PostMapping("/join")
	public String join(UsersVO user, HttpServletResponse response) {
		user.setUs_password(Argon2Util.hashPassword(user.getUs_password()));
		if (svc.join(user)) {
			user = svc.login(user);
			user.setUs_profile("/resources/profile_images/" + user.getUs_profile());
			JwtCookieUtil.createJwtCookie(response, user);
			return "redirect:/auth/login";
		} else {
			return "redirect:/auth/join";
		}
	}

	// ===== 아이디 찾기 ===== //
	@GetMapping("/find_id")
	public String findId() {
		return "/WEB-INF/auth/find_id.jsp";
	}

	@PostMapping("/find_id")
	public String findId(UsersVO user, Model model) {
		model.addAttribute("find_id", svc.findId(user));
		return "/WEB-INF/auth/find_id.jsp";
	}

	// ===== 비밀번호 찾기 ===== //
	@GetMapping("/find_password")
	public String findPassword() {
		return "/WEB-INF/auth/find_password.jsp";
	}

	@ResponseBody
	@PostMapping("/check_user")
	public String findPassword(UsersVO user, Model model) {
		return svc.checkUser(user) ? "true" : "false";
	}

	@PostMapping("/find_password")
	public String findPassword(UsersVO user) {
		user.setUs_password(Argon2Util.hashPassword(user.getUs_password()));
		if (svc.findPw(user)) {
			return "redirect:/auth/login";
		} else {
			return "redirect:/auth/find_password";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpServletResponse response, HttpSession session) {
		session.removeAttribute("user");
		JwtCookieUtil.deleteJwtCookie(response);
		return "redirect:/";
	}

	@GetMapping("/error")
	public String error() {
		return "/WEB-INF/auth/loginError.jsp";
	}

	@GetMapping("/terms")
	public String terms() {
		return "/WEB-INF/auth/terms.jsp";
	}

	/** 로그인 정보 확인 실험용 서블릿 */
	@GetMapping("/testAuth")
	public String test(Model model, HttpServletRequest request) {
		return "/WEB-INF/auth/testMypage.jsp";
	}
}
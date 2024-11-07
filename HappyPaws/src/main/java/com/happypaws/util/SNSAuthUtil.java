package com.happypaws.util;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

/**
 * 소셜 로그인 Util
 * 아직 기능을 구현하지 않았습니다.
 */
public class SNSAuthUtil {
	private String naverClientId;
	private String naverCallbackUrl;

	public String naverLoginUrl() throws UnsupportedEncodingException {
		String clientId = naverClientId;
		String redirectURI = URLEncoder.encode(naverCallbackUrl, "UTF-8");
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();

		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
			+ "&client_id=" + clientId
			+ "&state=" + state
			+ "&redirect_uri=" + redirectURI;

		return apiURL;
	}
}
package com.happypaws.svc;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.happypaws.util.Argon2Util;
import com.happypaws.vo.UsersVO;

@Service
public class AuthApiSVC {

    @Autowired
    private ServletContext servletContext;
	
	@Value("${spring.security.oauth2.client.registration.naver.client-id}")
	private String naverClientId;

	@Value("${spring.security.oauth2.client.registration.naver.client-secret}")
	private String naverClientSecret;

	@Value("${spring.security.oauth2.client.registration.naver.redirect-uri}")
	private String naverCallbackUrl;

	public String naverLoginUrl(HttpServletRequest request) throws UnsupportedEncodingException {
		String clientId = naverClientId;
		String redirectURI = URLEncoder.encode(naverCallbackUrl, "UTF-8");
		String state = UUID.randomUUID().toString();
		request.getSession().setAttribute("naverOauthState", state);

		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
			+ "&client_id=" + clientId
			+ "&state=" + state
			+ "&redirect_uri=" + redirectURI;

		return apiURL;
	}
	
	public String requestNaverAccessToken(String code, String state) throws JsonMappingException, JsonProcessingException {
		String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
			+ "&client_id=" + naverClientId
			+ "&client_secret=" + naverClientSecret
			+ "&code=" + code
			+ "&state=" + state;
	
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange(
			tokenUrl,
			HttpMethod.GET,
			new HttpEntity<>(new HttpHeaders()),
			String.class
		);
		
		return (new ObjectMapper()).readTree(response.getBody()).path("access_token").asText();
	}

    public UsersVO requestUserProfile(String accessToken) throws JsonMappingException, JsonProcessingException, UnsupportedEncodingException {
		String profileUrl = "https://openapi.naver.com/v1/nid/me";
	
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
	
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange(
			profileUrl,
			HttpMethod.GET,
			new HttpEntity<>(headers),
			String.class
		);

		JsonNode responseNode = (new ObjectMapper()).readTree(response.getBody()).path("response");
		UsersVO user = new UsersVO();
		user.setUs_id(responseNode.path("id").asText());
		user.setUs_sns("naver");
		user.setUs_password(Argon2Util.hashPassword(Argon2Util.hashPassword(accessToken)));
		user.setUs_name(URLDecoder.decode(responseNode.path("name").asText(), "UTF-8"));
		user.setUs_nick(URLDecoder.decode(responseNode.path("nickname").asText(), "UTF-8"));
		user.setUs_email(responseNode.path("email").asText());
		user.setUs_phone(responseNode.path("mobile").asText());
		user.setUs_profile(responseNode.path("profile_image").asText().replaceAll("\\/", "/"));
		return user;
	}

	public void saveProfileImage(UsersVO user) {
		String imageUrl = user.getUs_profile();
		if (imageUrl.isEmpty() || imageUrl == null) {
			user.setUs_profile("default.jpg");
			return;
		}
		
		String fileName = user.getUs_id();

		try {
			// 이미지 URL에서 확장자 추출
			String fileExtension = imageUrl.substring(imageUrl.lastIndexOf('.'));
			if (!fileName.endsWith(fileExtension)) {
				fileName = fileName + fileExtension;
			}

            // webapp/resources/uploads 폴더의 절대 경로 가져오기
            String uploadDirPath = servletContext.getRealPath("/resources/profile_images/");
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 디렉토리가 없으면 생성
            }

            File saveFile = new File(uploadDir, fileName);

			// URL로부터 연결을 생성하여 이미지 다운로드
			URL url = new URL(imageUrl);
			URLConnection connection = url.openConnection();
			BufferedInputStream inputStream = new BufferedInputStream(connection.getInputStream());
			FileOutputStream fileOutputStream = new FileOutputStream(saveFile);

			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = inputStream.read(buffer, 0, 1024)) != -1) {
				fileOutputStream.write(buffer, 0, bytesRead);
			}

			// 스트림 닫기
			inputStream.close();
			fileOutputStream.close();
			user.setUs_profile(fileName);

			System.out.println("프로필 사진이 성공적으로 저장되었습니다: " + saveFile.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("프로필 사진 저장 중 오류 발생.");
		}
	}
}
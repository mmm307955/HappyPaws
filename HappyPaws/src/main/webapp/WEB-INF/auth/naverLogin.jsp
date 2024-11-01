<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>naver login</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<p>네이버 로그인</p>
	<p id="naver_token"></p>
	<p id="naver_id">아이디 출력</p>
	<p id="naver_name"></p>
	<p id="naver_email"></p>
	<p id="naver_nickname"></p>

	<script type="text/javascript">
		var naver_id_login = new naver_id_login("ArFRxA1dutX2EY163j1X", "http://localhost:8090/auth/login/naver");
		// 접근 토큰 값 출력
		alert(naver_id_login.oauthParams.access_token);
		document.querySelector("#naver_token").text = naver_id_login.oauthParams.access_token;
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			alert(naver_id_login.getProfileData('id'));
			alert(naver_id_login.getProfileData('name'));
			alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('nickname'));
		}
	</script>

<!-- 	<script> -->
<!-- 		location.href = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=ArFRxA1dutX2EY163j1X&client_secret=aCs3EjxRpc&access_token=" + naver_id_login.oauthParams.access_token + "&service_provider=NAVER" -->
<!-- 	</script> -->
</body>
</html>
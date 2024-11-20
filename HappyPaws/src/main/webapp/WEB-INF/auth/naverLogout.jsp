<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>행복한 발자국</title>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
</head>
<body>
	<script>
		alert("네이버 로그아웃은 아직 구현되지 않았습니다.");
		window.location.href = "/";
	</script>

	<!-- 아래 임시 코드 -->
	<script defer>
		window.onload = function () {
		}
		var naverLogin = new naver.LoginWithNaverId({
			clientId: "clientId",
			callbackUrl: "네이버에 등록된 url"
		});
		try {
			naverLogin.init();
			naverLogin.logout();
			alert("네이버에서 정상적으로 로그아웃 되었습니다.");
		} catch (error) {
			alert("네이버에서 정상적으로 로그아웃 처리되지 않았습니다.");
		}
		window.location.href = "/";
	</script>
</body>
</html>
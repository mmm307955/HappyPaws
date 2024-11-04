<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>test</title>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<p>아이디: ${user.us_id}</p>
	<p>sns: ${user.us_sns}</p>
    <p>이름: ${user.us_name}</p>
    <p>닉네임: ${user.us_nick}</p>
    <p>프로필 이미지명: ${user.us_profile}</p>
    <p>유저 정보: ${info}</p>
    <a href="/auth/logout">로그아웃</a>
</body>
</html>
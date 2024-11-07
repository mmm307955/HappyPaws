<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
	<title>test</title>
    <style>
        img {
            width: 50px;
        }
    </style>
</head>
<body>
	<%@include file="../../header.jsp"%>
    <main>
        <p>아이디: ${user.us_id}</p>
        <p>sns: ${user.us_sns}</p>
        <p>이름: ${user.us_name}</p>
        <p>닉네임: ${user.us_nick}</p>
        <p>프로필 이미지
            <img src="${user.us_profile}" onerror="this.onerror=null; this.src='/resources/images/favicon.ico';" alt="이미지를 불러오는데 실패하였습니다.">
        </p>
        <p>프로필 이미지 링크: ${user.us_profile}</p>
        <p>유저 정보: ${info}</p>
        <a href="/auth/logout">로그아웃</a>
    </main>
	<%@include file="../../footer.jsp" %>
</body>
</html>
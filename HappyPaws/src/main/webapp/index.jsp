<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>temp title</title>
	<style>
		a {
			display: block;
		}
	</style>
</head>
<body>
	<h1>임시 시작페이지</h1>

	<p>인증 - 동준</p>
	<a href="auth/testAuth">로그인 정보 확인(테스트)</a>
	<a href="auth/login">로그인</a>

	<p>게시판 - 창욱</p>
	<a href="board/notice_list">관리자-공지사항</a>
	<a href="board/qna_list">관리자-Q&amp;A</a>
	<a href="board/cmty_list">관리자 - 커뮤니티</a>

	<p>마이페이지 - ks</p>
	<a href="/userList.do">회원관리</a>
	<a href="/us_myPage.do?us_id=${us_id}">마이페이지-사용자</a>
	<a href="/ad_myPage.do?ad_id=${ad_id}">마이페이지-관리자</a>
</body>
</html>
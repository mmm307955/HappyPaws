<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="./head.jsp"%>
	<style>
		a {
			display: block;
			width: fit-content;
		}

		p {
			margin-top: 1rem;
			margin-bottom: 0;
		}
	</style>
</head>
<body>
	<%@include file="./header.jsp"%>
	<main>
		<h1>임시 시작페이지</h1>
	
		<p>인증 - 동준</p>
		<a href="auth/testAuth">로그인 정보 확인(테스트)</a>
		<a href="auth/login">로그인</a>
		<a href="auth/logout">로그아웃</a>
	
		<p>게시판 - 창욱</p>
		<a href="board/notice_list">관리자-공지사항</a>
		<a href="board/qna_list">관리자-Q&amp;A</a>
		<a href="board/cmty_list">관리자 - 커뮤니티</a>
	
		<p>마이페이지 - ks</p>
		<a href="/userList.do">회원관리</a>
		<a href="/ad_myPage.do?ad_id=${ad_id}">마이페이지-관리자</a>
	
		<p>관리자 상품 관리 - 민지</p>
		<a href="ad_manageProductList">상품 관리 페이지</a>
	
		<p>회원 상품 관리 - 성현</p>
		<a href="pr_list">반려용품</a>

		<p>유기동물 페이지 - 현승</p>
		<a href="/getLostPetList.do">아이를 찾아주세요</a>
		<a href="/getFindPetList.do">아이를 발견했어요</a>
		<a href="/getNewFamilyList.do">새로운 가족을 찾아요</a>
	</main>
	<%@include file="./footer.jsp" %>
</body>
</html>
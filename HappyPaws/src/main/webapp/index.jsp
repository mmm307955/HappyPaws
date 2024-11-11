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
	
		<p>마이페이지 - ks</p>
		<a href="/userList.do">회원관리</a>
		<a href="/ad_myPage.do?ad_id=${ad_id}">마이페이지-관리자</a>
	
		<p>관리자 상품 관리 - 민지</p>
		<a href="ad_manageProductList">상품 관리 페이지</a>

		<p>유기동물 페이지 - 현승</p>
		<a href="/MIA/getLostPetList">아이를 찾아주세요</a>
		<a href="/MIA/getFindPetList">아이를 발견했어요</a>
		<a href="/MIA/getNewFamilyList">새로운 가족을 찾아요</a>
	</main>
	<%@include file="./footer.jsp" %>
</body>
</html>
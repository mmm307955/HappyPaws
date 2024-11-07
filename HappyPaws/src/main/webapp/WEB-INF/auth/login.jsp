<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
	<title>행복한 발자국 - 로그인</title>
</head>
<body>
	<%@include file="../../header.jsp"%>
	<main>
		<form action="/auth/login" method="post">
			<input type="text" name="us_id" placeholder="아이디 입력">
			<input type="password" name="us_password" placeholder="비밀번호 입력">
			<input type="submit" value="로그인">
		</form>
		<c:choose>
			<c:when test='${error == "id" }'>
				<p style="color: red;">아이디가 틀렸습니다.</p>
			</c:when>
			<c:when test='${error == "del" }'>
				<p style="color: red;">삭제된 계정입니다.</p>
			</c:when>
			<c:when test='${error == "password" }'>
				<p style="color: red;">비밀번호가 틀렸습니다.</p>
			</c:when>
			<c:when test='${error == "sns" }'>
				<p style="color: red;">sns 로그인을 이용해주세요.</p>
			</c:when>
		</c:choose>
		<a href="/auth/join">회원가입</a>
		<a href="/auth/find_id">아이디 찾기</a>
		<a href="/auth/find_password">비밀번호 찾기</a>
		<hr>
		<a href="${naverLoginUrl}"><img height="50" src="http://static.nid.naver.com/oauth/big_g.PNG"/></a>
	</main>
	<%@include file="../../footer.jsp" %>
</body>
</html>
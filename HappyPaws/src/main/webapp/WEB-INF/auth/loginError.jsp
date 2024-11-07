<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
	<title>로그인 오류</title>
</head>
<body>
	<%@include file="../../header.jsp"%>
    <main>
        <h1>로그인 오류</h1>
        <a href="/auth/login">로그인 화면으로 돌아가기</a>
        <p>${error}</p>
    </main>
	<%@include file="../../footer.jsp" %>
    <script>
        alert("로그인 기능에 오류가 생겼습니다.");
    </script>
</body>
</html>
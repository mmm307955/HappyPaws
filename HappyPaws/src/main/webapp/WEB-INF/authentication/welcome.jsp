<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>환영합니다.</title>
</head>
<body>
	<p id="nick">${nick}</p>
    <script>
    	let nick = document.querySelector("#nick").getHTML();
        alert("환영합니다, " + nick + "님.");
        location.href = "/";
    </script>
</body>
</html>
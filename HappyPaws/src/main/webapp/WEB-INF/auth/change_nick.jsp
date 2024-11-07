<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
    <title>naver login</title>
    <style>
        form > input[type="text"], form > input[type="password"], form > input[type="email"] {
            display: none;
        }
    </style>
</head>
<body>
	<%@include file="../../header.jsp"%>
    <main>
		<form action="/auth/snsReJoin" method="post" name="change_nick_form" onsubmit="return rejoin_submit();">
			<div>
				<input type="text" name="new_nickname" placeholder="닉네임 입력" value="${snsUser.us_nick}" required>
				<input type="button" value="닉네임 중복 검사">
			</div>
			<input type="submit" value="네이버 회원으로 가입하기">
		</form>
    </main>
	<%@include file="../../footer.jsp" %>

    <script>
        let auth_nick = false;
        function nick_duplicate_check() {
            console.log("닉네임 검사");
            if (document.change_nick_form.new_nickname.value == "") {
                alert("닉네임을 입력해주세요.");
                return false;
            }
            
            fetch('/auth/nick_check', {
                method: "POST",
                headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
                body: document.change_nick_form.new_nickname.value
            }).then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 응답에 문제가 있습니다.');
                }
                return response.text();
            }).then(data => {
                if (data === "true") {
                    alert("사용할 수 있는 닉네임입니다.");
                    auth_nick = true;
                    return true;
                } else {
                    alert("이 닉네임은 이미 사용중입니다.");
                    return false;
                }
            }).catch(error => {
                console.error('닉네임 중복확인 검사 도중 에러가 발생하였습니다.', error);
                return false;
            });
        }

		document.querySelector('[value="닉네임 중복 검사"]').addEventListener('click', nick_duplicate_check);
		document.change_nick_form.new_nickname.addEventListener('change', () => auth_nick = false);

        function rejoin_submit() {
            if (!auth_nick) {
                alert("닉네임 중복검사를 먼저 해주세요.");
                event.preventDefault();
            }
        }
    </script>
</body>
</html>
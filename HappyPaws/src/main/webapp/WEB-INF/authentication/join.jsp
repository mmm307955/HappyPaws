<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
    	form {
    		width: fit-content;
    		margin: auto;
    	}
    	
        input {
			width: 100%;
            display: block;
        }
    </style>
</head>
<body>
    <form action="/join" method="post" name="joinForm" onsubmit="join_submit()">
        <input type="text" name="us_id" id="us_id" placeholder="아이디 입력" required>
        <input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력" required>
        <input type="text" name="us_name" id="us_name" placeholder="이름 입력" required>
        <input type="text" name="us_nick" id="us_nick" placeholder="닉네임 입력" required>
        <input type="button" onclick="nick_duplicate_check()" value="닉네임 중복 검사">
        <input type="email" name="us_email" id="us_email" placeholder="이메일 입력">
        <input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력">
        <input type="button" onclick="phone_number_authentication()" value="전화번호 인증">
        <input type="text" name="us_address" id="us_address" value="주소 입력">
        <input type="submit" value="회원가입하기">
    </form>
    <script>
        // 닉네임 중복 검사
        function nick_duplicate_check() {
            fetch('/nick_check', {
                method: "POST",
                headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
                body: document.querySelector("#us_nick").value
            }).then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 응답에 문제가 있습니다.');
                }
                return response.text();
            }).then(data => {
                if (data === "true") {
                    alert("사용할 수 있는 닉네임입니다.");
                    return true;
                } else {
                    alert("이 닉네임은 이미 사용중입니다.");
                    return false;
                }
            }).catch(error => {
                console.error('닉네임 중복확인 검사 도중 에러가 발생하였습니다.', error)
            });
        }
        
        // 전화번호 onclick 이벤트
        function phone_number_authentication() {
			// 전화번호로 인증하는 기능
		}
        
        // 전화번호 구역 형식 변경되게 만들기
        document.joinForm.us_phone.addEventListener("blur", function () {
        	let phoneNum = event.target.value.split("-").join("");
        	
        	if (phoneNum.length == 11) {
	        	phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
	        	// TODO: phoneNum이 전화번호 형식인지 확인하기
                event.target.value = phoneNum;
            }
        });

        // 유효성 검사
        function join_submit() {
        	event.defaultPrevented();
            return false;
        }
    </script>
</body>
</html>
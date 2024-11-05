<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<style>
		form > input {
			width: 100%;
			display: block;
		}
	</style>
</head>
<body>
	<button type="button" onclick="document.joinForm.onsubmit = null">테스트를 위한 유효성 검사 제거하기</button>

	<form action="/auth/join" method="post" name="joinForm" onsubmit="return join_submit()" style="width: 300px;">
		<div>
			<input type="text" name="us_id" id="us_id" placeholder="아이디 입력" required>
			<input type="button" value="아이디 중복 검사">
		</div>
		<input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력" required>
		<input type="password" name="us_check_password" id="us_check_password" placeholder="비밀번호 확인" required>
		<input type="text" name="us_name" id="us_name" placeholder="이름 입력" required>
		<div>
			<input type="text" name="us_nick" id="us_nick" placeholder="닉네임 입력" required>
			<input type="button" value="닉네임 중복 검사">
		</div>
		<input type="email" name="us_email" id="us_email" placeholder="이메일 입력">
		<div>
			<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력" required>
			<input type="button" onclick="phone_number_authentication()" value="전화번호 인증">
		</div>
		<input type="text" name="us_address" id="us_address" placeholder="주소 입력">
		<input type="submit" value="회원가입하기">
	</form>
	<script>
		let auth_id = false;
		// 아이디 중복 검사
		function id_duplicate_check() {
			if (!/^[a-zA-Z0-9]{6,20}$/.test(document.joinForm.us_id.value)) {
				alert("아이디가 유효하지 않습니다. 6~20글자로 입력해주세요.");
				return false;
			}

			fetch('/auth/id_check', {
				method: "POST",
				headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
				body: document.joinForm.us_id.value
			}).then(response => {
				if (!response.ok) {
					throw new Error('네트워크 응답에 문제가 있습니다.');
				}
				return response.text();
			}).then(data => {
				if (data === "true") {
					alert("사용할 수 있는 아이디입니다.");
					document.querySelector("#us_id").readOnly = true;
					auth_id = true;
					return true;
				} else {
					alert("이 아이디는 이미 사용중입니다.");
					return false;
				}
			}).catch(error => {
				console.error('닉네임 중복확인 검사 도중 에러가 발생하였습니다.', error);
				return false;
			});
		}

		document.querySelector('[value="아이디 중복 검사"]').addEventListener('click', id_duplicate_check);

		let auth_nick = false;
		// 닉네임 중복 검사
		function nick_duplicate_check() {
			if (document.joinForm.us_nick.value == "") {
				alert("닉네임을 입력해주세요.");
				return false;
			}
			
			fetch('/auth/nick_check', {
				method: "POST",
				headers: { 'Content-Type': 'text/plain; charset=UTF-8' },
				body: document.joinForm.us_nick.value
			}).then(response => {
				if (!response.ok) {
					throw new Error('네트워크 응답에 문제가 있습니다.');
				}
				return response.text();
			}).then(data => {
				if (data === "true") {
					alert("사용할 수 있는 닉네임입니다.");
					document.querySelector("#us_nick").readOnly = true;
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
		
		let auth_phone = false;
		// 전화번호 onclick 이벤트
		function phone_number_authentication() {
			// 전화번호로 인증하는 기능
			if (switchPhoneFormat()) {
				auth_phone = true;
				alert("기능구현을 하지 못해 임시적으로 허락해드리겠습니다.");
			} else {
				alert("전화번호 형식을 지켜주세요.");
			}
		}

		document.joinForm.us_phone.addEventListener("blur", switchPhoneFormat);
		
		function switchPhoneFormat() {
			auth_phone = false;
			let phoneNum = document.querySelector("#us_phone").value.split("-").join("");
			
			if (phoneNum.length == 11) {
				phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
				if (/^010-\d{4}-\d{4}$/.test(phoneNum)) {
					document.querySelector("#us_phone").value = phoneNum;
					return true;
				}
			}

			return false;
		}

		// 유효성 검사
		function join_submit() {
			let isValidity = true;

			if (!auth_id) {
				alert("아이디 중복 확인을 해주세요.")
				isValidity = false;
			}

			if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,64}$/.test(document.joinForm.us_password.value)) {
				alert("비밀번호가 유효하지 않습니다.");
				isValidity = false;
			}

			if (document.joinForm.us_password.value != document.joinForm.us_check_password.value) {
				alert("비밀번호가 서로 다릅니다.");
				isValidity = false;
			}

			if (!auth_nick) {
				alert("닉네임 중복 확인을 해주세요.");
				isValidity = false;
			}

			if (!auth_phone) {
				alert("전화번호 인증을 해주세요.");
				isValidity = false;
			}

			if (!isValidity) {
				alert("회원가입을 막습니다.");
				event.preventDefault();
			}
		}
	</script>
</body>
</html>
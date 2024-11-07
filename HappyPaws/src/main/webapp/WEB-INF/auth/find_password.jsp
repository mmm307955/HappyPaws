<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
	<title>비밀번호 찾기</title>
</head>
<body>
	<%@include file="../../header.jsp"%>
	<main>
		<form action="/auth/find_password" method="post" name="findPwForm" onsubmit="return findPwSubmit();">
			<div id="user_authentication">
				<input type="text" name="us_id" id="us_id" placeholder="아이디 입력" required>
				<input type="text" name="us_name" id="us_name" placeholder="이름 입력" required>
				<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력" required>
				<input type="button" value="전화번호 확인" onclick="phone_number_authentication()">
				<input type="button" value="비밀번호 찾기" onclick="check_user()">
			</div>
	
			<div id="password_change" style="display: none;">
				<input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력" required>
				<input type="password" name="us_check_password" id="us_check_password" placeholder="비밀번호 확인" required>
				<input type="submit" value="비밀번호 변경">
			</div>
		</form>
	</main>
	<%@include file="../../footer.jsp" %>

	<script>
		let auth_phone = false;
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

		document.findPwForm.us_phone.addEventListener("blur", switchPhoneFormat);

		function phone_number_authentication() {
			if (switchPhoneFormat()) {
				auth_phone = true;
				alert("임시로 전화번호 인증이 승인되었습니다.");
			}
			else {
				auth_phone = false;
				alert("전화번호 형식을 지켜주세요.");
			}
		}

		async function check_user() {
			if (!auth_phone) {
				alert("전화번호 인증을 먼저 받아주세요.");
				return;
			}

			try {
				const response = await fetch('/auth/check_user', {
					method: 'POST',
					body: new FormData(document.findPwForm)
				});

				if (!response.ok) {
					throw new Error('Error: ${response.status}');
				}

				const isUserData = await response.text();

				if (isUserData == 'true') {
					document.querySelector("#user_authentication").style.display = 'none';
					document.querySelector("#password_change").style.display = 'block';
				} else {

				}
			} catch (error) {
				alert('사용자 정보를 확인하지 못했습니다.');
			}
		}

		function findPwSubmit() {
			let isValidity = true;

			if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,64}$/.test(document.findPwForm.us_password.value)) {
				alert("비밀번호가 유효하지 않습니다.");
				isValidity = false;
			}

			if (document.findPwForm.us_password.value != document.findPwForm.us_check_password.value) {
				alert("비밀번호가 서로 다릅니다.");
				isValidity = false;
			}

			if (!isValidity) {
				alert("비밀번호 변경을 막습니다.");
				event.preventDefault();
			}
		}
	</script>
</body>
</html>
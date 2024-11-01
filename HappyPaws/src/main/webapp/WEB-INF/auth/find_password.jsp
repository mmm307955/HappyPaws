<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 찾기</title>
</head>
<body>
	<p id="temp_p_tag" style="display: none;">${find_pw}</p>

	<form action="/auth/find_password" method="post" name="findPwForm" onsubmit="return findPwSubmit()">
		<input type="text" name="us_id" id="us_id" placeholder="아이디 입력" required>
		<input type="text" name="us_name" id="us_name" placeholder="이름 입력" required>
		<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력" required>
		<input type="submit" value="비밀번호 찾기">
	</form>

	<!-- us_id를 넘겨야 합니다. auth-mapper.xml를 참고해주세요. -->
	<form action="/auth/change_password" method="post" name="changePwForm" onsubmit="return changePwSubmit()" style="display: none;">
		<p>기능 구현이 완료되지 않았습니다. 아래를 이용해주세요.</p>
		<input type="password" name="us_password" id="us_password" placeholder="비밀번호 입력" required>
		<input type="password" name="us_check_password" id="us_check_password" placeholder="비밀번호 확인" required>
		<input type="submit" value="비밀번호 변경" disabled>
	</form>

	<hr>

	<h1>테스트를 할 경우 이용해주세요.</h1>
	<form action="/auth/change_password" method="post">
		<input type="text" name="us_id" placeholder="아이디 입력" required>
		<input type="text" name="us_name" placeholder="이름 입력" required>
		<input type="text" name="us_phone" placeholder="전화번호 입력" onblur="switchPhoneFormat()" required>
		<input type="password" name="us_password" placeholder="비밀번호 입력" required>
		<input type="submit" value="비밀번호 변경">
	</form>

	<script>
		function switchPhoneFormat() {
			let phoneNum = event.target.value.split("-").join("");

			if (phoneNum.length == 11) {
				phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
				if (/^010-\d{4}-\d{4}$/.test(phoneNum)) {
					event.target.value = phoneNum;
					return true;
				}
			}

			return false;
		}
		
		let find_pw = document.querySelector("#temp_p_tag");
		if (find_pw.innerText == "true") {
			document.changePwForm.style.display = 'block';
			document.findPwForm.style.display = 'none';
		}
		find_pw.remove();

		document.findPwForm.us_phone.addEventListener("blur", switchPhoneFormat);

		function findPwSubmit() {
			return switchPhoneFormat();
		}

		function changePwSubmit() {
			return document.findPwForm.us_password.value == document.findPwForm.us_check_password.value;
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../../head.jsp"%>
	<title>아이디 찾기</title>
</head>
<body>
	<%@include file="../../header.jsp"%>
	<main>
		<form action="/auth/find_id" method="post" name="findIdForm" onsubmit="return findIdSubmit()">
			<input type="text" name="us_name" id="us_name" placeholder="이름 입력" required autofocus>
			<div>
				<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력" required>
				<input type="button" value="전화번호 인증">
			</div>
			<div id="us_phone_auth_div" style="display: none;">
				<input type="text" name="us_phone_auth_code" id="us_phone_auth_code" placeholder="인증번호 입력" required>
				<input type="button" value="인증번호 확인">
			</div>
			<input type="submit" value="아이디 찾기">
		</form>
	
		<p>${find_id}</p>
	</main>
	<%@include file="../../footer.jsp" %>

	<script>
		function switchPhoneFormat() {
			let phoneNum = document.querySelector("#us_phone").value.split("-").join("");
			
			if (phoneNum.length == 11) {
				phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
				// TODO: phoneNum이 전화번호 형식인지 확인하기
				if (/^010-\d{4}-\d{4}$/.test(phoneNum)) {
					document.querySelector("#us_phone").value = phoneNum;
					return true;
				}
			}

			return false;
		}

		document.findIdForm.us_phone.addEventListener("blur", switchPhoneFormat);

		let auth_phone = false;
		document.querySelector('[value="전화번호 인증"]').addEventListener('click', function () {
			if (!switchPhoneFormat()) {
				alert("전화번호 형식을 지켜주세요.");
				return;
			}

			$.ajax({
				url: "/auth/authPhone",
				type: "GET",
				data: { 'us_phone': $('#us_phone').val() },
				success: response => {
					// 시간 흘러가게 설정하기
					if (response) {
						$('#us_phone_auth_div').css('display', 'block');
					}
				},
				error: () => alert('인증번호 전송에 실패하였습니다.')
			});
		});

		// 인증번호 확인 버튼 클릭 시 나오는 이벤트
		document.querySelector('[value="인증번호 확인"]').addEventListener('click', function () {
			let us_phone_auth_code = $('#us_phone_auth_code').val();
			if (us_phone_auth_code.length != 6) {
				alert("6자리를 입력해주세요.");
				return;
			}

			$.ajax({
				url: "/auth/authPhone",
				type: "POST",
				data: {
					'us_phone': $('#us_phone').val(),
					'us_phone_auth_code': us_phone_auth_code
				},
				success: response => {
					if (response) {
						auth_phone = true;
						$('#us_phone_auth_div').css('display', 'none');
						document.joinForm.us_phone.readOnly = true;
					}
				},
				error: () => alert('인증번호 확인에 실패하였습니다.')
			});
		});

		function findIdSubmit() {
			return auth_phone;
		}
	</script>
</body>
</html>
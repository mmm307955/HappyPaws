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
			<input type="text" name="us_name" id="us_name" placeholder="이름 입력" required>
			<input type="text" name="us_phone" id="us_phone" placeholder="전화번호 입력" required>
			<input type="submit" value="아이디 찾기">
		</form>
	
		<p>${find_id}</p>
	</main>
	<%@include file="../../footer.jsp" %>

	<script>
		function switchPhoneFormat() {
			let phoneNum = event.target.value.split("-").join("");
			
			if (phoneNum.length == 11) {
				phoneNum = phoneNum.substr(0, 3) + "-" + phoneNum.substr(3, 4) + "-" + phoneNum.substr(7, 4);
				// TODO: phoneNum이 전화번호 형식인지 확인하기
				if (/^010-\d{4}-\d{4}$/.test(phoneNum)) {
					event.target.value = phoneNum;
					return true;
				}
			}

			return false;
		}

		document.findIdForm.us_phone.addEventListener("blur", switchPhoneFormat);

		function findIdSubmit() {
			return switchPhoneFormat();
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 내정보 수정</title>
    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('profilePreview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</head>
<body>
    <h2>마이페이지 - 내정보 수정</h2>
    <form action="us_myPage.do" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>프로필 사진:</td>
                <td>
                    <img id="profilePreview" src="${user.us_profile}" alt="프로필 사진" style="width:100px; height:100px;"><br>
                    <input type="file" name="us_profile_file" accept="image/*" onchange="previewImage(event)">
                </td>
            </tr>
            <tr>
                <td>아이디:</td>
                <td><input type="text" name="us_id" value="${user.us_id}" readonly></td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td><input type="password" name="us_password" value="${user.us_password}" required></td>

            </tr>
            <tr>
                <td>이름:</td>
                <td><input type="text" name="us_name" value="${user.us_name}" required></td>
            </tr>
            <tr>
                <td>닉네임:</td>
                <td><input type="text" name="us_nick" value="${user.us_nick}" required></td>
            </tr>
              <tr>
                <td>이메일:</td>
                <td><input type="email" name="us_email" value="${user.us_email}" required></td>
            </tr>
            <tr>
                <td>주소:</td>
                <td><input type="text" name="us_address" value="${user.us_address}" required></td>
            </tr>
            <tr>
                <td>가입일:</td>
                <td><input type="text" name="us_date" value="${user.us_date}" readonly></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="정보 수정">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

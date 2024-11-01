<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script>
   
    function confirmSubmit() {
        return confirm("수정하시겠습니까?");
    }
</script>
</head>
<body>
<div id="content">
    <h3>회원정보 수정</h3>
    <form action="userUpdate.do" method="post" onsubmit="return confirmSubmit()">
        <table>
            <tr>
                <td>아이디:</td>
                <td><input type="text" name="us_id" value="${user.us_id}" readonly></td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td><input type="password" name="us_password" value="${user.us_password}" readonly></td>
            </tr>
            <tr>
                <td>이름:</td>
                <td><input type="text" name="us_name" value="${user.us_name}"></td>
            </tr>
            <tr>
                <td>닉네임:</td>
                <td><input type="text" name="us_nick" value="${user.us_nick}"></td>
            </tr>
            <tr>
                <td>이메일:</td>
                <td><input type="email" name="us_email" value="${user.us_email}"></td>
            </tr>
            <tr>
                <td>주소:</td>
                <td><input type="text" name="us_address" value="${user.us_address}"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="수정">
                    <input type="button" value="취소" onclick="history.back()">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
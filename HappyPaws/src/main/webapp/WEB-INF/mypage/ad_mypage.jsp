<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 마이페이지 </title>
     <style>
        body {
            font-family: Arial, sans-serif;
        }
        #content {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        h3 {
            font-size: 1.5em;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
    
    <script>
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (newPassword != confirmPassword) {
                alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h2>관리자 마이페이지 </h2>
    <form action="updateAdminPassword.do" method="post" onsubmit="return validateForm()">
        <table>
            <tr>
                <td>아이디:</td>
                <td><input type="text" name="ad_id" value="${admin.ad_id}" readonly></td>
            </tr>
            <tr>
                <td>현재 비밀번호:</td>
                <td><input type="password" name="currentPassword" required></td>
            </tr>
            <tr>
                <td>새 비밀번호:</td>
                <td><input type="password" name="newPassword" id="newPassword" required></td>
            </tr>
            <tr>
                <td>새 비밀번호 확인:</td>
                <td><input type="password" name="confirmPassword" id="confirmPassword" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="비밀번호 변경">
                    <input type="button" value="취소" onclick="history.back()">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
>
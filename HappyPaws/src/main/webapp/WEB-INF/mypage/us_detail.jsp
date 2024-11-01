<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세보기</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    #content {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }
    h2 {
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
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
        font-weight: bold;
        width: 20%;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .button-container {
        margin-top: 20px;
    }
    .button-container button, .button-container input[type="submit"] {
        padding: 5px 10px;
        font-size: 1em;
        margin: 0 5px;
    }
</style>
<script>
    function confirmDelete() {
        return confirm("정말로 회원 정보를 삭제하시겠습니까?");
    }
</script>
</head>
<body>
<div id="content">
    <h2>회원 상세 정보</h2>
    <table>
        <tr>
            <th>아이디</th>
            <td>${user.us_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${user.us_name}</td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td>${user.us_nick}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${user.us_email}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${user.us_address}</td>
        </tr>
        <tr>
            <th>가입일</th>
            <td><fmt:formatDate value="${user.us_date}" pattern="yyyy-MM-dd" /></td>
        </tr>
    </table>
    
   
    <div class="button-container">
        <button onclick="location.href='userUpdate.do?us_id=${user.us_id}'">수정</button>
        <form action="userDelete.do" method="get" onsubmit="return confirmDelete()" style="display:inline;">
            <input type="hidden" name="us_id" value="${user.us_id}">
            <input type="submit" value="삭제">
        </form>
        <button onclick="location.href='userList.do'">목록으로</button>
    </div>
</div>
</body>
</html>

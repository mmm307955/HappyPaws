<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제</title>
<script>
function confirmDelete() {
	  if (confirm("정말로 회원정보를 삭제하시겠습니까?")) {
	        setTimeout(function() {
	            alert("삭제가 되었습니다.");
	        }, 10); // 삭제 메시지를 띄우기 위해 지연 시간 설정
	        return true;
	    }
	    return false;
	}
</script>
</head>
<body>
<div id="content">
    <h3>회원정보 삭제</h3>
   
       <form action="userDelete.do" method="get" onsubmit="return confirmDelete()">
        <input type="hidden" name="us_id" value="${user.us_id}">
        <input type="submit" value="삭제">
        <input type="button" value="취소" onclick="history.back()">
    </form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
<title>회원관리 목록</title>

<style>
    body {
        font-family: Arial, sans-serif;
    }
    #content {
        width: 100%;
        margin: 0 auto;
        text-align: center;
    }
    h3 {
        font-size: 1.5em;
        margin-bottom: 20px;
    }
    .search-bar {
        display: flex;
        justify-content: center;
        margin-top: 15px; 
        margin-bottom: 15px; 
    }
    .search-bar select, .search-bar input[type="text"] {
        padding: 5px;
        margin-right: 10px;
        font-size: 1em;
    }
     .search-bar input[type="submit"] {
        padding: 5px 10px;
        font-size: 1em;
    }
      table {
        width: 100%;
       
        margin: 0 auto;
        border-collapse: collapse;
        margin-top: 10px;
        table-layout: auto;
    }



    th, td {
        border: 1px solid #ddd;
        padding: 8px;
         white-space: nowrap; 
        overflow: hidden;
      
    }
     th {
        background-color: #FFD700;
        font-weight: bold;
        border-radius: 8px;
    }
    
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #ddd;
    }
    .pagination {
     	display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    .pagination button {
        padding: 5px 10px;
        font-size: 1em;
        margin: 2px;
    }
</style>
<script>
if( !('${message}'=='' ||'${message}'==null ) ) alert('${message}');
</script>
</head>
<body>
<%@include file="../../header.jsp" %>
<main>
<div id="content">
    <h3>회원관리 목록</h3>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}" scope="request"/>
    <c:set var="itemsPerPage" value="5" scope="request"/>
    <c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" scope="request"/>
    <c:set var="endIndex" value="${startIndex + itemsPerPage}" scope="request"/>
    

        <table>
        <tr>
        <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
            <th>번호</th>
            <th>아이디</th>
            <th>이름</th>
            <th>닉네임</th>
            <th>이메일</th>
            <th>주소</th>
            <th>가입일</th>
        </tr>
        <c:forEach var="user" items="${userList}" varStatus="status">
        <c:if test="${status.index >= startIndex && status.index < endIndex}">
        
         <tr>             
              <td><input type="checkbox" name="userIds" value="${user.us_id} onclick="event.stopPropagation();"></td>
                 <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${status.index + 1}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_id}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_name}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_nick}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_email}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_address}</td>
        <td onclick="location.href='userDetail.do?us_id=${user.us_id}'">${user.us_date}</td>
    </tr>
    </c:if>
</c:forEach>

    </table>
    
      <div class="search-bar">
        <form action="userList.do" method="get">
            <select name="searchType">
                <option value="us_id">아이디</option>
                <option value="us_name">이름</option>
                <option value="us_email">이메일</option>
            </select>
            <input type="text" name="searchKeyword" placeholder="검색어 입력">
            <input type="submit" value="조회">
        </form>
    </div>
     <div class="pagination">
    <c:set var="totalPages" value="${(fn:length(userList) + itemsPerPage - 1) / itemsPerPage}" />
    <c:forEach begin="1" end="${totalPages}" var="page">
        <button onclick="location.href='userList.do?page=${page}'" <c:if test="${page == currentPage}">disabled</c:if>>${page}</button>
    </c:forEach>
</div>
</div>
</main>
<%@include file="../../footer.jsp" %>  
</body>

</html>


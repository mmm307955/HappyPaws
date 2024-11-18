<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
    <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 등록 게시물</title>
    <style>
        body {
            background-color: #f9f9f9;
        }
        .container {
            width: 80%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            min-width: 600px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #FFD700;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

.search-container {
    display: flex; 
    justify-content: center; 
    align-items: center; 
    margin: 20px auto; 
    width: fit-content; 
}

.search-container select,
.search-container input[type="text"],
.search-container button {
    padding: 5px;
    margin: 5px;
    border: 2px solid #FFD700;
    border-radius: 20px; 
    outline: none;
    background-color: white; 
}



        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 3px;
            text-decoration: none;
            color: #333;
            border-radius: 50%;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        .pagination a:hover {
            background-color: #f0f0f0;
        }
        .pagination .current-page {
            background-color: #FFD700;
            color: #333;
            font-weight: bold;
            border: 1px solid #FFD700;
        }
        .pagination .disabled {
            color: #ccc;
            cursor: default;
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 20px;
            }
            .container {
                width: 90%;
                padding: 10px;
            }
            table {
                font-size: 14px;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 18px;
            }
            table, th, td {
                font-size: 12px;
            }
            .pagination a {
                padding: 5px;
            }
        }
    </style>
    <script>
        function goToDetail(postId, sourceTable) {
            let detailPage;
            if (sourceTable === 'COMMUNITY') {
                location.href = '/board/cmty_view?cmty_seq=' + postId;
            } else if (sourceTable === 'QNA') {
                location.href = '/board/qna_view?qna_seq=' + postId;
            } else if (sourceTable === 'NOTICE') {
                location.href = '/board/notice_view?notice_seq=' + postId;
            } else {
                alert("유효하지 않은 게시물입니다."); // 잘못된 경우 경고 메시지
                return; // 함수 종료하여 페이지 이동 방지
            }
        }
    </script>
</head>
<body>
 <%@include file="../../header.jsp" %>
 <main>
<div class="container">
    <h2>내 등록 게시물</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>등록게시판</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty currentPagePosts}">
                        <c:forEach var="post" items="${currentPagePosts}">
                            <tr onclick="goToDetail(${post.post_id}, '${post.source_table}')">
                                <td>${post.post_id}</td>
                                <td>${post.title}</td>
                                <td>${post.source_table}</td>
                                <td>${post.created_date}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4">등록된 게시물이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="search-container">
    <form action="/myPosts" method="get"> <!-- GET 방식으로 서버에 검색 요청 -->
        <select name="searchField">
            <option value="title" <c:if test="${param.searchField == 'title'}">selected</c:if>>제목</option>
            <option value="source_table" <c:if test="${param.searchField == 'source_table'}">selected</c:if>>등록게시판</option>
        </select>
        <input type="text" name="searchQuery" placeholder="검색어 입력" value="<c:out value='${param.searchQuery}'/>">
        <button type="submit">조회</button>
    </form>
</div>


    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">&laquo;</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <span class="current-page">${i}</span>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">&raquo;</a>
        </c:if>
    </div>
</div>
 </main>
    <%@include file="../../footer.jsp" %> 
</body>
</html>

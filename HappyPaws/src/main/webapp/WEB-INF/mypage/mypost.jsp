<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 등록 게시물</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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
            margin: 20px 0;
            flex-wrap: wrap;
        }
        .search-container select,
        .search-container input[type="text"],
        .search-container button {
            padding: 5px;
            margin: 5px;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: black;
        }
        .pagination a.active {
            background-color: #4CAF50;
            color: white;
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
	    if (sourceTable === 'community') {
	        detailPage = 'communityDetail';
	    } else if (sourceTable === 'qna') {
	        detailPage = 'qnaDetail';
	    } else if (sourceTable === 'notice') {
	        detailPage = 'noticeDetail';
	    } else {
	        alert("유효하지 않은 게시물입니다."); // 잘못된 경우 경고 메시지
	        return; // 함수 종료하여 페이지 이동 방지
	    }
	    location.href = detailPage + '?post_id=' + postId;
	}

</script>

</head>
<body>
<div class="container">
    <h2>내 등록 게시물</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>소스 테이블</th>
                    <th>작성일</th>
                </tr>
            </thead>
           <tbody>
    <c:forEach var="post" items="${posts}">
        <tr onclick="goToDetail(${post.post_id}, '${post.source_table}')">
            <td>${post.post_id}</td>
            <td>${post.title}</td>
            <td>${post.source_table}</td> 
            <td>${post.created_date}</td>
        </tr>
    </c:forEach>
</tbody>

        </table>
    </div>
    
    <div class="search-container">
        <select>
            <option value="title">제목</option>
            <option value="source_table">소스 테이블</option>
        </select>
        <input type="text" placeholder="검색어 입력">
        <button>조회</button>
    </div>
    
    <div class="pagination">
        <a href="#">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">6</a>
        <a href="#">7</a>
    </div>
</div>
</body>
</html>

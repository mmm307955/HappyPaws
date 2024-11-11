<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            width: 60%;
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
        .post-detail {
            margin-top: 20px;
            line-height: 1.6;
        }
        .post-detail label {
            font-weight: bold;
            display: inline-block;
            width: 100px;
        }
        .back-button {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: inline-block;
        }
        .back-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>게시물 상세보기</h2>
    <div class="post-detail">
        <p><label>번호:</label> ${post.post_id}</p>
        <p><label>제목:</label> ${post.title}</p>
        <p><label>작성자:</label> ${post.us_id}</p>
        <p><label>작성일:</label> ${post.created_date}</p>
        <p><label>내용:</label></p>
        <div style="padding: 10px; border: 1px solid #ddd; background-color: #f9f9f9;">
            ${post.content}
        </div>
    </div>
    <button class="back-button" onclick="location.href='myPosts'">목록으로 돌아가기</button>
</div>
</body>
</html>

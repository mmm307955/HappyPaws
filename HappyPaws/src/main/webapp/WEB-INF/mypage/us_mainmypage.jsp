<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사용자 마이페이지-main</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #fefbf6;
    display: flex;
    justify-content: center;
    align-items: flex-start; 
    height: 100vh;
    margin: 0;
    padding-top: 10vh; 
}

.container {
    width: 500px; 
    background-color: #fdf8e5;
    border-radius: 15px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    text-align: center;
    padding: 50px;
    margin: 80px auto;
}

.title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
}

.profile-tabs {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 70px;
}

.profile-tabs button {
    background-color: #ffffff;
    border: 2px solid #000;
    border-radius: 10px;
    padding: 8px 12px;
    font-size: 14px;
    cursor: pointer;
    flex-grow: 1;
    white-space: nowrap;
}

.profile-picture {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background-color: #ccc;
    margin: 0 auto 15px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.profile-picture img {
    max-width: 100%;
    border-radius: 50%;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
    color: #333;
}

.form-group input {
    width: calc(100% - 40px);
    padding: 10px;
    border: none;
    border-bottom: 1px solid #f9d500;
    background-color: transparent;
    font-size: 14px;
    outline: none;
    text-align: left;
    display: inline-block;
}

.edit-button {
    width: 80%;
    background-color: #ffd600;
    color: #000;
    border: none;
    border-radius: 20px;
    padding: 12px;
    font-size: 16px;
    cursor: pointer;
    margin: 10px 0;
}

.logout-button {
    width: 60px;
    background-color: #f0e68c;
    color: #333;
    border: none;
    border-radius: 20px;
    padding: 6px;
    font-size: 12px;
    cursor: pointer;
    margin: 10px 0;
}

 /* 반응형 처리 */
  @media (max-width: 768px) {
    .profile-tabs {
      gap: 8px;
      justify-content: center;
    }

    .profile-tabs button {
      flex-basis: 100%;
      font-size: 12px;
      padding: 6px 8px;
    }

    .profile-picture {
      width: 100px;
      height: 100px;
    }

    .edit-button {
      font-size: 14px;
      padding: 10px;
    }

    .logout-button {
      font-size: 10px;
      padding: 5px;
    }
  }

</style>
</head>
<body>
<%@include file="../../header.jsp" %>

<main>
<div class="container">
    <!-- 타이틀 추가 -->
    <h2 class="title">나의 페이지</h2>
    
    <div class="profile-tabs">
        <button>내 프로필</button>
        <button onclick="location.href='/product/pr_order_list'">상품주문내역</button>
        <button onclick="location.href='/myPosts'">내 등록 게시물</button>
    </div>
    <div class="profile-picture">
        <img src="<c:choose>
                      <c:when test="${user.us_profile == null}">
                        /resources/profile_images/cutecat.jpg
                      </c:when>
                      <c:otherwise>
                       ${user.us_profile}
                      </c:otherwise>
                  </c:choose>" alt="프로필 이미지">
    </div>
    <p style="font-weight: bold; color: #333; margin: 10px 0;">${user.us_nick}</p>

    <button class="edit-button" onclick="location.href='/us_myPage.do'">내 정보 수정</button>
</div>
</main>

<%@include file="../../footer.jsp" %> 
</body>
</html>

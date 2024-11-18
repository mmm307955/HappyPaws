<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../head.jsp" %>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사용자 마이페이지-main</title>
<style>
/* 전체 스타일 초기화 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  background-color: #fefbf6;
  overflow-x: hidden; /* 수평 스크롤 방지 */
  font-size: 16px; /* 기본 폰트 크기 설정 */
}

/* 헤더 스타일 */
header {
  width: 100%;
  max-width: 1200px;
  background-color: #fdf8e5;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 5%;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  flex-wrap: wrap; /* 작은 화면에서 요소들이 줄바꿈 되도록 처리 */
}

/* 컨테이너 */
.container {
  width: 90%;
  max-width: 500px;
  background-color: #fdf8e5;
  border-radius: 15px;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  padding: 2rem;
  margin: 2rem auto;
}

/* 프로필 탭 */
.profile-tabs {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 2rem;
  overflow-x: auto; /* 넘칠 경우 스크롤 허용 */
}

.profile-tabs button {
  background-color: #ffffff;
  border: 2px solid #000;
  border-radius: 10px;
  padding: 0.5rem 1rem;
  font-size: 1rem;
  cursor: pointer;
  white-space: nowrap;
  flex-shrink: 0;
}

/* 프로필 사진 */
.profile-picture {
  width: 20vw;
  height: 20vw;
  max-width: 150px;
  max-height: 150px;
  border-radius: 50%;
  background-color: #ccc;
  margin: 0 auto 1.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.profile-picture img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 이미지 비율을 유지하며 컨테이너에 맞춤 */
  border-radius: 50%;
}

/* 수정 버튼 */
.edit-button {
  width: 80%;
  max-width: 300px;
  background-color: #ffd600;
  color: #000;
  border: none;
  border-radius: 20px;
  padding: 1rem;
  font-size: 1.2rem;
  cursor: pointer;
  margin: 1rem auto;
}

/* 반응형 처리 */
@media screen and (max-width: 768px) {
  header {
    padding: 0.5rem 1rem;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
  }

  .container {
    width: 95%; /* 화면에 맞게 확장 */
    padding: 1.5rem;
  }

  .profile-tabs {
    gap: 0.5rem;
    flex-wrap: wrap; /* 버튼이 화면을 벗어나지 않도록 감싸기 */
  }

  .profile-tabs button {
    font-size: 0.9rem;
    padding: 0.4rem 0.8rem;
  }

  .profile-picture {
    width: 25vw;
    height: 25vw;
    max-width: 120px;
    max-height: 120px;
  }

  .edit-button {
    width: 90%;
    font-size: 1rem;
    padding: 0.8rem;
  }
}

@media screen and (max-width: 480px) {
  .profile-picture {
    width: 30vw;
    height: 30vw;
    max-width: 100px;
    max-height: 100px;
  }

  .edit-button {
    font-size: 0.9rem;
    padding: 0.6rem;
  }

  .profile-tabs button {
    font-size: 0.8rem;
    padding: 0.3rem 0.6rem;
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
        <img src="${user.us_profile}" onerror="this.onerror=null; this.src='/resources/profile_images/default.jpg';" alt="프로필 이미지">
    </div>
    <p style="font-weight: bold; color: #333; margin: 10px 0;">${user.us_nick}</p>

    <button class="edit-button" onclick="location.href='/us_myPage.do'">내 정보 수정</button>
</div>
</main>

<%@include file="../../footer.jsp" %> 
</body>
</html>

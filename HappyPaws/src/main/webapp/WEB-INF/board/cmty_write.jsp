<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<div class="n_write">
		<h1>커뮤니티</h1>
		<div class="n_write_form">
			<form action="/board/cmty_insert" id="cmtyForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">커뮤니티 작성</span>
				</div>
				<label for="category">카테고리 선택:</label>
				<select id="cmty_category" name="cmty_category">
				    <option value="General">자유게시판</option>
				    <option value="AdoptionReview">입양/분양 후기</option>
				    <option value="FoundReview">찾은 후기</option>
				</select>
				<input type="text" name="cmty_title" placeholder="제목을 입력해주세요.">
				<input type="hidden" name="cmty_id" value="user"> <!-- 나중에 유저 받아야함 -->
				<input type="hidden" name="cmty_content" id="cmty_content">
				<div id="editor"></div>
				
				<input type="submit" value="커뮤니티 등록">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	
</body>
</html>
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
		<h1>공지사항</h1>
		<div class="n_write_form">
			<form action="/board/notice_insert" id="noticeForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">공지사항 작성</span>
					<div class="right">					
						<span>중요 공지사항</span>
						<input type="checkbox" name="n_chk" value="Y" >		
					</div>
				</div>
				<input type="text" name="n_title" placeholder="제목을 입력해주세요.">
				<input type="hidden" name="n_id" value="user"> <!-- 나중에 유저 받아야함 -->
				<input type="hidden" name="n_content" id="n_content">
				<div id="editor"></div>
				
				<input type="submit" value="공지등록">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	
</body>
</html>
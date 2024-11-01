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
			<form action="/board/cmty_modify" id="cmtyForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">커뮤니티 수정</span>
				</div>
				<input type="text" name="cmty_category" value="${cmtyview.cmty_category}" >
				<input type="text" name="cmty_title" placeholder="제목을 입력해주세요." value="${cmtyview.cmty_title}">
				<input type="hidden" name="cmty_id" value="${cmtyview.cmty_id}"> <!-- 나중에 유저 받아야함 -->
				<input type="hidden" name="cmty_content" id="cmty_content">
				<input type="hidden" name="cmty_seq" value="${cmtyview.cmty_seq}">
				<div id="editor">
					${cmtyview.cmty_content}
				</div>
				
				<input type="submit" value="수정">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	
</body>
</html>
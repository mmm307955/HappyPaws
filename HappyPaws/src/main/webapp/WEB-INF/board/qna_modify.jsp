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
		<h1>Q&amp;A</h1>
		<div class="n_write_form">
			<form action="/board/qna_modify" id="qnaForm" enctype="multipart/form-data" method="post" >
				<div class="n_write_header">
					<span class="left">Q&amp;A 수정</span>
				</div>
				<input type="text" name="qna_title" placeholder="제목을 입력해주세요." value="${qnaview.qna_title}">
				<input type="hidden" name="qna_id" value="${qnaview.qna_id}"> <!-- 나중에 유저 받아야함 -->
				<input type="hidden" name="qna_content" id="qna_content">
				<input type="hidden" name="qna_seq" value="${qnaview.qna_seq}">
				<div id="editor">
					${qnaview.qna_content}
				</div>
				
				<input type="submit" value="공지 수정">
				<button type="button" class="n_backButton">취소</button>
			</form>
		</div>
	</div>
	
</body>
</html>
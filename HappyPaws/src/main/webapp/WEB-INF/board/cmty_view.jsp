<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="n_view">
		<div class="n_viewform">
			<h1>커뮤니티</h1>
			<div>
				${cmtyview.cmty_category}
			</div>
			<div class="n_title">
				<span class="title">${cmtyview.cmty_title}</span>
				<span class="author" >작성자: ${cmtyview.cmty_id}</span>
			</div>
			<div class="n_date">
				<span>작성일: ${cmtyview.cmty_date}</span>
			</div>
			<div class="n_content">
				${cmtyview.cmty_content}
			</div>
			
			<div class="comments">
			    <div id="commentList"></div>
			    <span>댓글쓰기</span>
			    <div class="comment-input">
				    <textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea>
				    <button id="cmty_comment" value="${param.cmty_seq}">댓글 등록</button>
			    </div>
			</div>
			
			<div class="n_buttons">
			    <div style="flex-grow: 1; text-align: center; margin-left: 140px;">
			        <button id="cmty_list">글 목록</button>
			    </div>
			    <div>
			        <button class="cmty_modify" data-seq="${cmtyview.cmty_seq}">수정</button>
			        <button class="cmty_delete" data-seq="${cmtyview.cmty_seq}">삭제</button>
			    </div>
			</div>
		</div>
	</div>
	 <script>
	    $(function() {
	        c_loadComments(); // 페이지 로드 시 댓글 목록 불러오기
	    });
	</script>
	<form name="hideFrm" style="display:none;">
	  <input type="hidden" name="nowPage" value="${param.nowPage}">
	  <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	  <input type="hidden" name="searchCondition" value="${param.searchCondition}">
  	</form>

</body>
</html>
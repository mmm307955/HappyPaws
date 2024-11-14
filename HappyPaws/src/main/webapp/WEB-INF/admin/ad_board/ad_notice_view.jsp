<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- jQuery library -->
	<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
	<script src="${pageContext.request.contextPath }/resources/js/board.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin_board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/admin/admin_header.jsp" />
	<main>
	<div class="n_view">
		<div class="n_viewform">
			<h1>공지사항</h1>
			<div class="n_title">
				<span class="title">${noticeview.n_title}</span>
				<span class="author" >
					<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${noticeview.us_profile}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';">
					${noticeview.us_nick}
				</span>
			</div>
			<div class="n_date">
				<span>${noticeview.n_date}</span>
			</div>
			<div class="n_content">
				${noticeview.n_content}
			</div>
			
			<div class="n_buttons">
			    <div style="flex-grow: 1; text-align: center; margin-left: 140px;">
			        <button id="notice_list">글 목록</button>
			    </div>
			    <div>
			        <button class="notice_modify" data-seq="${noticeview.n_seq}">수정</button>
			        <button class="notice_delete" data-seq="${noticeview.n_seq}">삭제</button>
			    </div>
			</div>
		</div>
		</div>
	
	<form name="hideFrm" style="display:none;">
	  <input type="hidden" name="nowPage" value="${param.nowPage}">
	  <input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	  <input type="hidden" name="searchCondition" value="${param.searchCondition}">
  	</form>
  	
  	</main>
  	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>
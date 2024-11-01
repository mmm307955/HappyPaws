<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.snow.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/quill@2.0.2/dist/quill.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/board.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/notice.css">
	
</head>
<body>
	<div class="n_list">
		<h1>커뮤니티</h1>
		<div class="n_seachform">
			<form>
				<select name="searchCondition">
					<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
					<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
				</select>
				<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
			</form>
			<button id="cmty_write">글쓰기</button>
		</div>
		<div>
			<ul>
				<li><a>전체</a></li>
				<li><a>자유게시판</a></li>
				<li><a>입양/분양 후기</a></li>
				<li><a>찾은 후기</a></li>
			</ul>
		</div>
		<c:choose>
            <c:when test="${ not empty cmtyList}">
				<c:forEach var="cmty" items="${cmtyList}">
					<div class="cmty_view" data-seq="${cmty.cmty_seq}" data-count="${cmty.cmty_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
					    <h5>${cmty.cmty_category}</h5>
					    <h3>${cmty.cmty_title}<c:if test="${cmty.comment_count != 0}"> [${cmty.comment_count}]</c:if></h3>
					    <div>${cmty.cmty_content}</div>
					    <div>${cmty.cmty_id} / ${cmty.formattedCmtyDate}</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div>등록된 글이 없습니다.</div>
			</c:otherwise>
		</c:choose>
		<ul class="pagination">
			<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
					<c:otherwise><li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/cmty_list?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>
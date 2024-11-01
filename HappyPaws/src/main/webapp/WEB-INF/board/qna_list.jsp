<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		<h1>Q&amp;A</h1>
		<div class="n_seachform">
			<form>
				<select name="searchCondition">
					<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
					<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
				</select>
				<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
			</form>
			<button id="qna_write">글쓰기</button>
		</div>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
					<th>작성자</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
            		<c:when test="${ not empty qnaList}">		
					    <!-- qna 출력 -->
					    <c:forEach var="qna" items="${qnaList}">
					    	<tr class="qna_view" data-seq="${qna.qna_seq}" data-count="${qna.qna_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
					        	<td>${qna.qna_seq}</td>
					            <td>${qna.qna_title}<c:if test="${qna.comment_count != 0}"> [${qna.comment_count}]</c:if></td>
					            <td>${qna.formattedQnaDate}</td>
					            <td>${qna.qna_id}</td>
					        </tr>
					    </c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">등록된 QNA가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<ul class="pagination">
			<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/qna_list?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
					<c:otherwise><li class="page-item"><a class="page-link" href="/board/qna_list?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/qna_list?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>
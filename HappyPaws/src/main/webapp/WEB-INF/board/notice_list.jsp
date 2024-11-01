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
		<h1>공지사항</h1>
		<div class="n_seachform">
			<form>
				<select name="searchCondition">
					<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
					<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
				</select>
				<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
			</form>
			<button id="notice_write">글쓰기</button>
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
            		<c:when test="${ not empty noticeList}">
            			<!-- 중요 공지사항 출력 -->
					    <c:forEach var="notice" items="${noticeList}">
					        <c:if test="${notice.n_chk == 'Y'}">
					            <tr class="notice_view" data-seq="${notice.n_seq}" data-count="${notice.n_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
					                <td>공지</td>
					                <td>${notice.n_title}</td> <!-- 중요 공지사항임을 표시 -->
					                <td>${notice.n_date}</td>
					                <td>${notice.n_id}</td>
					            </tr>
					        </c:if>
					    </c:forEach>
					
					    <!-- 일반 공지사항 출력 -->
					    <c:forEach var="notice" items="${noticeList}">
					        <c:if test="${notice.n_chk != 'Y'}">
					            <tr class="notice_view" data-seq="${notice.n_seq}" data-count="${notice.n_count}" data-nowpage="${paging.nowPage}" data-searchcondition="${searchCondition}" data-searchkeyword="${searchKeyword}">
					                <td>${notice.n_seq}</td>
					                <td>${notice.n_title}</td>
					                <td>${notice.n_date}</td>
					                <td>${notice.n_id}</td>
					            </tr>
					        </c:if>
					    </c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">등록된 공지사항이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<ul class="pagination">
			<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/notice_list?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
					<c:otherwise><li class="page-item"><a class="page-link" href="/board/notice_list?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link" href="/board/notice_list?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
			</c:if>
		</ul>
	</div>
</body>
</html>
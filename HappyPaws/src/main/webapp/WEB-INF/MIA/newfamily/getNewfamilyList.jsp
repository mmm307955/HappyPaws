<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../../header.jsp" %>
<style>
#searchNav{-webkit-justify-content: flex-end; justify-content: flex-end; }
.navbar {padding: 10px 0px !important;}
.pagination {justify-content : center;}
</style>
<body>
<div class="jumbotron">
   <h1>공지 사항 ${userRole }</h1>      
</div>
<div class="container">
	<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
		<form class="form-inline" action="getBoardList.do" method="post">
		<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(시작)  -->
			<select class="form-control" id="sel1" name="searchCondition" style="display:inline-block!important;">
				<c:forEach items="${conditionMap}" var="option">
					<option value="${option.value}" <c:if test="${searchCondition==option.value}">selected</c:if>>${option.key}</option>
				</c:forEach>
			</select>
			
			<div class="input-group mb-3">
				<input class="form-control" type="search" name="searchKeyword" placeholder="검색어를 입력하세요." value="${searchKeyword }">
				<div class="input-group-append">
					<button class="btn btn-success" type="submit">검색</button>
				</div>
				<div class="input-group-append">
					<button type="button" id="conWrite" class="btn btn-outline-primary">글쓰기</button>
				</div>
			</div>
		<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(종료)  -->	
		</form>
	</nav>
	
	<table class="table table-hover">
		<thead class="btn-primary">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(시작)  -->
			<c:forEach items="${boardList}" var="board">
				<tr onclick="selTr(${board.seq}, '${searchCondition}', '${searchKeyword}', ${paging.nowPage})" style="cursor:pointer;">
<%-- 				<tr style="cursor:pointer;"> --%>
					<td class="tdCenter"><a href="getBoard/${board.seq}">${board.seq}</a></td>
					<td>${board.title}</td>
					<td class="tdCenter">${board.writer}</td>
					<td class="tdCenter">${board.regdate}</td>
					<td class="tdCenter">${board.cnt}</td>
				</tr>
			</c:forEach>
			<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(종료)  -->
		</tbody>
	</table>
  
  	<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(시작)  -->
	<ul class="pagination">
		<c:if test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
			<li class="page-item"><a class="page-link" href="getBoardList.do?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
		</c:if>
		<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}" step="1">
			<c:choose>
				<c:when test="${paging.nowPage==i}"><li class="page-item active"><a class="page-link" >${i}</a></li></c:when>
				<c:otherwise><li class="page-item"><a class="page-link" href="getBoardList.do?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li></c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
			<li class="page-item"><a class="page-link" href="getBoardList.do?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
		</c:if>
	</ul>
	<!-- 241017_추가 페이징처리와 목록, 검색 유지 기능 처리(종료)  -->
  
	<br><br>

</div>

</body>
</html>

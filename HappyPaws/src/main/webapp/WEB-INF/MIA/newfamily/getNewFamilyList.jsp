<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../MIA.jsp"%>
<%
java.util.List<String> categories = java.util.Arrays.asList("", "dog", "cat", "small", "etc");
pageContext.setAttribute("categories", categories);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>행복한 발자국</title>
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/resources/css/MIA.css">
<script>
        function selNf(val, val2, val3, val4, nowpage) {
            location.href = "/MIA/getNewFamily?nf_seq=" + val + '&searchCondition=' + val2 + '&searchKeyword=' + val3 + '&category=' + val4 + '&nowPage=' + nowpage;
        }

        $(document).ready(function() {
            $("#nfIns").click(function() {
                location.href = "/MIA/insertNewFamily";
            });
        });
        
        $(document).ready(function() {
            $("#lpIns2").click(function() {
            	alert("로그인이 필요합니다");
            });
        });
    </scrip
    </script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_list">
			<h2><a href="/MIA/getLostPetList">아이를 찾아주세요</a> / <a href="/MIA/getFindPetList">아이를 발견했어요</a> / <span style="color: red;"> 새로운 가족을 찾아요 </span></h2>

			<div class="n_seachform">
				<form>
					<select name="searchCondition">
						<option value="TITLE"
							${searchCondition == 'TITLE' ? 'selected' : ''}>제목</option>
						<option value="CONTENT"
							${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
						<option value="CONTENT"
							${searchCondition == 'ID' ? 'selected' : ''}>작성자</option>
						<option value="CONTENT"
							${searchCondition == 'TITLE,CONTENT' ? 'selected' : ''}>제목+내용</option>
					</select> <input type="search" name="searchKeyword" value="${searchKeyword}"
						placeholder="검색어를 입력해주세요">
				</form>
				<c:if test="${not empty user.us_id}">
				<button id="lpIns">글쓰기</button>
				</c:if>
				<c:if test="${empty user.us_id}">
				<button id="lpIns2">글쓰기</button>
				</c:if>
			</div>
			
			<div class="n_categoryform">
				<c:forEach var="category" items="${categories}">
					<form action="/MIA/getNewFamilyList" method="post"
						style="display: inline;">
						<input type="hidden" name="searchCondition"
							value="${searchCondition}"> <input type="hidden"
							name="searchKeyword" value="${searchKeyword}"> <input
							type="hidden" name="category" value="${category}"> <input
							type="hidden" name="nowPage" value="${paging.nowPage}"> <input
							type="submit"
							value="<c:choose><c:when test="${category == ''}">전체</c:when><c:when test="${category == 'dog'}">강아지</c:when><c:when test="${category == 'cat'}">고양이</c:when><c:when test="${category == 'small'}">소동물</c:when><c:when test="${category == 'etc'}">기타</c:when></c:choose>">
					</form>
				</c:forEach>
			</div>
			
			<div class="n_listform">
				<c:forEach items="${newFamilyList}" var="newFamily">
					<div class="n_list_item"
						onclick="selNf(${newFamily.nf_seq}, '${searchCondition}', '${searchKeyword}', '${category}', ${paging.nowPage})"
						style="cursor: pointer;">
						<a
							href="/MIA/getNewFamily?nf_seq=${newFamily.nf_seq}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}&nowPage=${paging.nowPage}">
							<img
							src="${pageContext.request.contextPath}/resources/MIA-img/newFamilyImg/${newFamily.nf_img}"
							alt="New Family Image" class="pet-image"
							>
						</a>
						<p>${newFamily.nf_title}</p>
						<p>	<c:if test="${lostPet.lp_ok == 'Y'}">
								<span style="color: red; font-weight: bold;">[분앙완료]</span>
							</c:if>
						</p>
						<p>지역: ${newFamily.nf_place}</p>
						<p>${newFamily.nf_date} 댓글:${newFamily.commentCount}</p>
					</div>
				</c:forEach>
			</div>

			<ul class="pagination">
				<c:if
					test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
					<li class="page-item"><a class="page-link"
						href="/MIA/getNewFamilyList?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}"
					step="1">
					<c:choose>
						<c:when test="${paging.nowPage==i}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="/MIA/getNewFamilyList?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${paging.nowPage < paging.lastBtn && paging.lastBtn > paging.viewBtnCnt}">
					<li class="page-item"><a class="page-link"
						href="/MIA/getNewFamilyList?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">다음</a></li>
				</c:if>
			</ul>
			<br> <br>

		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>

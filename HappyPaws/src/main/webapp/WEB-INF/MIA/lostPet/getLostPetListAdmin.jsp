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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/lostPet.js"></script>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>
		<div class="n_list">
			<div class="c_category">
				<ul>
			    	<li><span>아이를 찾아주세요</span></li>
			    	<li><a href="/MIA/getFindPetList">아이를 발견했어요</a></li>
				    <li><a href="/MIA/getNewFamilyList">새로운 가족을 찾아요</a></li>
				</ul>
			</div>

            <div class="n_seachform">
    			<form>
        			<label style="display: none;">
        				<select name="searchCondition">
							<option value="TITLE" ${searchCondition == 'TITLE' ? 'selected' : ''} >제목</option>
							<option value="CONTENT" ${searchCondition == 'CONTENT' ? 'selected' : ''}>내용</option>
						</select>
					</label>
	                <div class="custom-select-display">
	                    <span></span>
	                    <i class="fas fa-chevron-down"></i>
	                </div>
	                <div class="custom-options">
	                    <div data-value="TITLE">제목</div>
	                    <div data-value="CONTENT">내용</div>
	                </div>
        			<label class="search-bar">
	    	        	<input type="search" name="searchKeyword" value="${searchKeyword}" placeholder="검색어를 입력해주세요">
        	    		<button type="submit" class="searchIcon">
            	    	<img src="${pageContext.request.contextPath}/resources/images/searchicon.png" alt="검색" title="검색">
            			</button>
	        		</label>
			    </form>
    			<button class="write_button" id="lpIns">글쓰기</button>
			</div>


            <div class="n_categoryform">
                <c:forEach var="category" items="${categories}">
                    <form action="/MIA/getFindPetList" method="post" style="display: inline;">
                        <input type="hidden" name="searchCondition" value="${searchCondition}">
                        <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                        <input type="hidden" name="category" value="${category}">
                        <input type="hidden" name="nowPage" value="1">
                        <input class="category" type="submit" value="<c:choose><c:when test="${category == ''}">전체</c:when><c:when test="${category == 'dog'}">강아지</c:when><c:when test="${category == 'cat'}">고양이</c:when><c:when test="${category == 'small'}">소동물</c:when><c:when test="${category == 'etc'}">기타</c:when></c:choose>">
                    </form>
                </c:forEach>
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
					<c:forEach items="${lostPetList}" var="lostPet">
				        <c:if test="${notice.n_chk == 'Y'}">
					    	<tr class="n_list_item" onclick="sellp(${lostPet.lp_seq}, '${searchCondition}', '${searchKeyword}', '${category}', ${paging.nowPage})" style="cursor: pointer;">
					        	<td>${lostPet.lp_seq}</td>
					            <td><div class="title-wrapper">${lostPet.lp_title}</div></td>
					            <td>${lostPet.lp_date}</td>
					            <td>
					            	<img class="us_profile" src="${pageContext.request.contextPath}/resources/profile_images/${lostPet.us_profile}" 
					            	onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/profile_images/default.jpg';" alt="프로필">
					               	${lostPet.us_nick}
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>

			<ul class="pagination">
				<c:if
					test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
					<li class="page-item"><a class="page-link"
						href="/MIA/getLostPetList?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}"
					step="1">
					<c:choose>
						<c:when test="${paging.nowPage==i}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="/MIA/getLostPetList?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if
					test="${paging.nowPage < paging.lastBtn && paging.lastBtn > paging.viewBtnCnt}">
					<li class="page-item"><a class="page-link"
						href="/MIA/getLostPetList?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">다음</a></li>
				</c:if>
			</ul>
			<br> <br>

		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>

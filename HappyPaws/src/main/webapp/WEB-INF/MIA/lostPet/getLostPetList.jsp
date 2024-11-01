<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../../header.jsp"%>
<script>
function selLp(val, val2, val3, val4, nowpage){
    location.href = "/getLostPet.do?&lp_seq="+val+'&searchCondition='+val2+'&searchKeyword='+val3+'&category='+val4+'&nowPage='+nowpage;
	}
</script>
<style>
#searchNav {
	-webkit-justify-content: flex-end;
	justify-content: flex-end;
}

.navbar {
	padding: 10px 0px !important;
}

.pagination {
	justify-content: center;
}
</style>
<body>
<%@ include file="../../../menu.jsp"%>
	<div class="jumbotron">
	</div>

	<h2>아이를 찾아주세요 / 아이를 발견했어요 / 새로운 가족을 찾아요</h2>

	<div class="container">
		<nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
			<form class="form-inline" action="getLostPetList.do" method="post">
				<!-- 페이징 처리와 목록, 검색 유지 기능 처리(시작) -->
				<select class="form-control" id="sel1" name="searchCondition"
					style="display: inline-block !important;">
					<c:forEach items="${conditionMap}" var="option">
						<option value="${option.value}"
							<c:if test="${searchCondition==option.value}">selected</c:if>>${option.key}</option>
					</c:forEach>
				</select>

				<div class="input-group mb-3">
					<input class="form-control" type="search" name="searchKeyword"
						placeholder="검색어를 입력하세요." value="${searchKeyword}">
					<div class="input-group-append">
						<button class="btn btn-success" type="submit">검색</button>
					</div>
					<div class="input-group-append">
						<button type="button" id="conWrite"
							class="btn btn-outline-primary">글 등록</button>
					</div>
				</div>
				<input type="hidden" name="category" value="${category}">
				<!-- 페이징 처리와 목록, 검색 유지 기능 처리(종료) -->
			</form>
		</nav>

		<h2>
			<form action="getLostPetList.do" method="post"
				style="display: inline;">
				<input type="hidden" name="searchCondition"
					value="${searchCondition}">
				<!-- 현재 searchCondition 값을 유지 -->
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<!-- 현재 searchKeyword 값을 유지 -->
				<input type="hidden" name="category" value=""> <input
					type="hidden" name="nowPage" value="${paging.nowPage}">
				<!-- 동적으로 nowPage 설정 -->
				<button type="submit">전체</button>
			</form>

			<form action="getLostPetList.do" method="post"
				style="display: inline;">
				<input type="hidden" name="searchCondition"
					value="${searchCondition}">
				<!-- 현재 searchCondition 값을 유지 -->
				<input type="hidden" name="searchKeyword" value="${searchKeyword}">
				<!-- 현재 searchKeyword 값을 유지 -->
				<input type="hidden" name="category" value="dog"> <input
					type="hidden" name="nowPage" value="${paging.nowPage}">
				<!-- 동적으로 nowPage 설정 -->
				<button type="submit">강아지</button>
			</form>

			<form action="getLostPetList.do" method="post"
				style="display: inline;">
				<input type="hidden" name="searchCondition"
					value="${searchCondition}"> <input type="hidden"
					name="searchKeyword" value="${searchKeyword}"> <input
					type="hidden" name="category" value="cat"> <input
					type="hidden" name="nowPage" value="${paging.nowPage}">
				<button type="submit">고양이</button>
			</form>

			<form action="getLostPetList.do" method="post"
				style="display: inline;">
				<input type="hidden" name="searchCondition"
					value="${searchCondition}"> <input type="hidden"
					name="searchKeyword" value="${searchKeyword}"> <input
					type="hidden" name="category" value="small"> <input
					type="hidden" name="nowPage" value="${paging.nowPage}">
				<button type="submit">소동물</button>
			</form>

			<form action="getLostPetList.do" method="post"
				style="display: inline;">
				<input type="hidden" name="searchCondition"
					value="${searchCondition}"> <input type="hidden"
					name="searchKeyword" value="${searchKeyword}"> <input
					type="hidden" name="category" value="etc"> <input
					type="hidden" name="nowPage" value="${paging.nowPage}">
				<button type="submit">기타</button>
			</form>
		</h2>

		<div class="grid-container">
			<c:forEach items="${lostPetList}" var="lostPet">
				<div class="grid-item"
					onclick="selLp(${lostPet.lp_seq}, '${searchCondition}', '${searchKeyword}', '${category}', ${paging.nowPage})"
					style="cursor: pointer;">
					<a
						href="getLostPet.do?lp_seq=${lostPet.lp_seq}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}&nowPage=${paging.nowPage}">
						<img
						src="${pageContext.request.contextPath}/resources/MIA-img/lostPetImg/${lostPet.lp_img}"
						alt="Lost Pet Image" class="pet-image">
					</a>
					<p>${lostPet.lp_title}
						<c:if test="${lostPet.lp_ok == 'Y'}">
							<span style="color: red; font-weight: bold;">[발견]</span>
						</c:if>
					</p>
					<p>지역: ${lostPet.lp_place}</p>
					<p>사례금: ${lostPet.lp_reward}</p>
					<p>댓글 : ${lpCommnt.lpc_cnt}</p>
				</div>
			</c:forEach>
		</div>


		<ul class="pagination">
			<c:if
				test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link"
					href="getLostPetList.do?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">이전</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}"
				step="1">
				<c:choose>
					<c:when test="${paging.nowPage==i}">
						<li class="page-item active"><a class="page-link">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="getLostPetList.do?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if
				test="${paging.nowPage < paging.lastBtn && paging.lastBtn > paging.viewBtnCnt}">
				<li class="page-item"><a class="page-link"
					href="/getLostPetList.do?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&category=${category}">다음</a></li>
			</c:if>
		</ul>
		<br> <br>
	</div>

</body>
</html>

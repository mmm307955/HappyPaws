<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 관리</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.container {
	display: flex;
}

.sidebar {
	width: 200px;
	background-color: #f2f2f2;
	padding: 20px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar li {
	margin-bottom: 15px;
}

.sidebar li a {
	text-decoration: none;
	color: #333;
	font-size: 18px;
}

.sidebar li a.active {
	font-weight: bold;
}

.main-content {
	flex: 1;
	padding: 20px;
}

.main-content h1 {
	text-align: center;
	margin-bottom: 20px;
}

.product-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: 20px;
}

.product-card {
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	text-align: center;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.product-card img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	margin-bottom: 10px;
}

.product-card p {
	font-size: 16px;
	color: #333;
	margin: 0;
}

.product-card button {
	margin-top: 10px;
	padding: 10px 20px;
	background-color: #333;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.product-card button:hover {
	background-color: #555;
}

.product-search {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.product-search select, .product-search input, .product-search button {
	padding: 10px;
	margin-right: 10px;
	font-size: 16px;
}

.product-search button {
	background-color: #333;
	color: #fff;
	border: none;
	cursor: pointer;
}

.product-search button:hover {
	background-color: #555;
}

td {
	padding: 10px;
}

.options-popup {
	display: none; /* 처음에 닫힌 상태로 표시 */
	position: absolute;
	background-color: rgb(202, 202, 202);
}

/*페이지 CSS*/
.pagination {
    display: flex; /* Flexbox를 사용하여 정렬 */
    list-style: none; /* 기본 리스트 스타일 제거 */
    padding: 0; /* 패딩 제거 */
    margin: 0 auto; /* 위아래 여백 설정 */
    text-align: center;
/*     width: 100px; */
    margin-top: 20px;
}

.pagination .page-item {
    margin: 0 5px; /* 페이지 아이템 간 여백 */
    width: 30px;
    height: 30px;
    position: relative; 
}

.pagination .page-link {
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    color: black; /* 기본 링크 색상 */
    width: 100%; /* 전체 너비 사용 */
    height: 100%; /* 전체 높이 사용 */
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    border-radius: 50%; /* 동그라미 모양 만들기 */
}

.pagination .page-link:hover {
    color: black;
    font-weight: bold;
}

.pagination .active {
    position: relative; /* 부모 요소의 위치를 기준으로 설정 */
}

.pagination .active a {
    color: black; /* 글자색을 흰색으로 설정 */
    background-color: #ffeb994d; /* 배경색을 노란색으로 설정 */
    border-radius: 50%; /* 동그라미 모양을 만들기 위해 반경을 설정 */
    border: 2px solid #fcd11e;
    display: inline-block; /* 인라인 블록으로 설정 */
    text-align: center; /* 중앙 정렬 */
}
</style>
</head>
<body>
	<div class="container">

		<!-- Main Content -->
		<div class="main-content">
			<h1>상품 관리</h1>

			 <!-- 검색 및 카테고리 필터 -->
            <nav id="searchNav" class="navbar navbar-expand-sm navbar-dark">
                <form class="form-inline" action="ad_manageProductList" method="post">
                    <!-- 검색 옵션 선택 -->
                    <select class="form-control" id="sel1" name="searchCondition" style="display: inline-block !important;">
                        <c:forEach items="${conditionMap}" var="option">
                            <option value="${option.value}" <c:if test="${searchCondition == option.value}">selected</c:if>>
                                ${option.key}
                            </option>
                        </c:forEach>
                    </select>

				<!-- 검색 입력 -->
				  <div class="input-group mb-3">
                        <input class="form-control" type="search" name="searchKeyword" placeholder="검색어를 입력하세요." value="${searchKeyword}">
                        <div class="input-group-append">
                            <button class="btn btn-success" type="submit">검색</button>
                        </div>
                        <div class="input-group-append">
                            <a href="ad_manageProductAdd" class="btn btn-outline-primary">상품 등록</a>
                        </div>
                    </div>
                    <input type="hidden" name="category" value="${category}">
                </form>
            </nav>
            
            <!-- 카테고리 버튼 -->
            <div>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">전체</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="간식">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">간식</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="매트">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">매트</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="사료">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">사료</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="식기">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">식기</button>
                </form>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="영양제">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">영양제</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="위생">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">위생</button>
                </form>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="이동장">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">이동장</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="장난감">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">장난감</button>
                </form>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="집/하우스">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">집/하우스</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="패션">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">패션</button>
                </form>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="펫가전">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">펫가전</button>
                </form>
                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="하네스/줄">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">하네스/줄</button>
                </form>

                <form action="ad_manageProductList" method="post" style="display: inline;">
                    <input type="hidden" name="searchCondition" value="${searchCondition}">
                    <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                    <input type="hidden" name="category" value="해충방지용품">
                    <input type="hidden" name="nowPage" value="${paging.nowPage}">
                    <button type="submit">해충방지용품</button>
                </form>
            </div>
            
            
				<a href="ad_manageProductAdd">상품 등록하기</a>

				<table class="table table-hover">
					<thead class="btn-primary">
						<tr>
							<th>상품ID</th>
							<th>상품 이미지</th>
							<th>상품명</th>
							<th>가격</th>
							<th>카테고리</th>
							<th>옵션</th>
						</tr>
					</thead>
					<tbody>
					
						<c:forEach items="${productsList}" var="products">
							<tr
								onclick="selTr(${products.pr_id},  '${searchCondition}', '${searchKeyword}', ${paging.nowPage})"
								style="cursor: pointer;">


								<td class="tdCenter">${products.pr_id}</td>
								<td class="tdCenter" style="text-align: center;"><img
									src="${products.pr_thumbnail}" alt="썸네일 이미지"
									style="height: 50px;"></td>
								<td class="tdCenter">${products.pr_name}</td>
								<td class="tdCenter">${products.pr_price}</td>
								<td class="tdCenter">${products.pr_category}</td>
								<td class="tdCenter" onclick="toggleOptions(this)"><span
									class="options-btn">옵션▼</span>
									<div class="options-popup">
										<!-- 각 상품에 맞는 옵션 리스트만 표시 -->
										<c:forEach var="opt" items="${allOpt}">
											<c:if test="${products.pr_id eq opt.pr_id}">
											    <ul style="list-style-type: none; padding: 0;">
											        <li style="font-weight: bold;">옵션명: ${opt.pr_opt_name}</li>
											        <li>재고: ${opt.pr_opt_stock} 개</li>
											        <li>추가금액: ${opt.pr_opt_price} 원</li>
											    </ul>
											</c:if>
										</c:forEach>
									</div></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<script>
			    // 페이지 로드 시 각 옵션 버튼에 클릭 이벤트 리스너 추가
			    document.addEventListener("DOMContentLoaded", function() {
			        // 모든 .options-btn 요소를 선택
			        const optionButtons = document.querySelectorAll(".options-btn");
			
			        // 각 버튼에 클릭 이벤트 추가
			        optionButtons.forEach(button => {
			            button.addEventListener("click", function(event) {
			                // 버튼의 부모 요소에서 .options-popup 요소를 찾음
			                const optionsPopup = button.nextElementSibling;
			
			                // 현재 표시 상태를 토글
			                if (optionsPopup.style.display === "none" || optionsPopup.style.display === "") {
			                    optionsPopup.style.display = "block";
			                } else {
			                    optionsPopup.style.display = "none";
			                }
			
			                // 클릭 이벤트가 부모 요소로 전파되지 않도록 중지
			                event.stopPropagation();
			            });
			        });
			
			        // 페이지의 다른 부분을 클릭했을 때 모든 옵션 팝업 숨기기
			        document.addEventListener("click", function() {
			            document.querySelectorAll(".options-popup").forEach(popup => {
			                popup.style.display = "none";
			            });
			        });
			    });
			</script>


				<!--  페이징처리와 목록, 검색 유지 기능 처리 -->
				<ul class="pagination">
					<c:if
						test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
						<li class="page-item"><a class="page-link"
							href="ad_manageProductList?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
					</c:if>
					<c:forEach var="i" begin="${paging.startBtn}"
						end="${paging.endBtn}" step="1">
						<c:choose>
							<c:when test="${paging.nowPage==i}">
								<li class="page-item active"><a class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="ad_manageProductList?nowPage=${i}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if
						test="${paging.nowPage < paging.lastBtn  && paging.lastBtn > paging.viewBtnCnt}">
						<li class="page-item"><a class="page-link"
							href="ad_manageProductList?nowPage=${paging.nowPage+1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이후</a></li>
					</c:if>
				</ul>
			</form>
		</div>
	</div>
</body>
<script>
	function selTr(pr_id, searchCondition, searchKeyword, nowPage) {
	    location.href = "/ad_manageProductModify?pr_id="+pr_id+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"&nowPage="+nowPage;
// 	    location.href = "/ad_manageProductModify?pr_id="+pr_id;
	}

</script>

</html>

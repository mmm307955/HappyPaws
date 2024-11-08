<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>상품 관리</title>
<jsp:include page="${pageContext.request.contextPath}/head.jsp" />
<style>
* {
	box-sizing: border-box;
	text-align: center;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
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
	 align-items: center; /* 세로 가운데 정렬 */
      gap: 10px; /* 요소 간 간격 */
	margin-bottom: 20px;
}

.product-search input, .product-search button {
	padding: 10px;
	margin-right: 10px;
	font-size: 16px;
}
.product-search select {
        padding: 12px;
        font-size: 16px;
        border: 1px solid #d1d1d1;
/*         background-color: #f0f0f0; */
        border-radius: 5px;
        width: 150px; /* 크기 조절 */
        text-align: center;
    }
    
     .product-search input[type="search"] {
        padding: 12px;
        font-size: 16px;
        border: 1px solid #d1d1d1;
/*         background-color: #f0f0f0; */
        border-radius: 5px;
        width: 300px; /* 검색 입력 크기 조절 */
    }


.product-search button {
 padding: 12px 20px;
        font-size: 16px;
        border: none;
        background-color: #666666;
        color: white;
        border-radius: 5px;
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
	background-color: white;
	border: 2px solid #595959;
    border-radius: 15px;
    padding: 20px;
    transform: translateX(-30%); /* X축 기준으로 중앙 정렬 */
}

/*페이지 CSS*/
.pagination {
	display: flex; /* Flexbox를 사용하여 정렬 */
	list-style: none; /* 기본 리스트 스타일 제거 */
	padding: 0; /* 패딩 제거 */
	margin: 0 auto; /* 위아래 여백 설정 */
	text-align: center;
	width: 100px;
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

.tdCenter {
	text-align: center;
	white-space: nowrap; /* 줄바꿈 방지 */
}

    .product-search {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        margin-bottom: 20px;
    }
    
    .product-search select,
	.product-search input[type="search"],
	.product-search button {
	    height: 49px; /* 높이 동일하게 설정 */
	    line-height: 1.5;
	    font-size: 16px;
	    vertical-align: middle; /* 수직 가운데 정렬 */
	    box-sizing: border-box;
	}
	
	.product-search select {
	    padding: 0 12px;
	    border: 1px solid #d1d1d1;
/* 	    background-color: #f0f0f0; */
	    border-radius: 5px;
	    width: 150px;
	}
    

    .product-search select {
        padding: 12px;
        font-size: 16px;
        height: 49px;
        border: 1px solid #d1d1d1;
/*         background-color: #f0f0f0; */
        border-radius: 5px;
        width: 150px;
        text-align: center;
    }
    
    .product-search input[type="search"] {
        padding: 12px;
        height: 49px;
        font-size: 16px;
        border: 1px solid #d1d1d1;
/*         background-color: #f0f0f0; */
        border-radius: 5px;
        width: 400px;
        text-align: center;
    }

    .product-search button {
        padding: 12px 20px;
        font-size: 16px;
        border: none;
        background-color: #666666;
        color: white;
        border-radius: 5px;
        cursor: pointer;
    }

    .category {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 15px;
        margin-bottom: 25px;
    }
    

    .category button {
    	font-weight: bold;
        background-color: #fcd11e;
        color: #333;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .options-toggle:hover .options-btn {
        color: #FCD11E; /* 호버 시 텍스트 색상 변경 (노란색) */
        transition: color 0.15s ease; /* 텍스트 색상만 부드러운 전환 효과 */
    }

    .category button.active {
	    background-color: #88afea; /* 클릭된 버튼의 색상 */
   	 	color: white; /* 클릭된 상태의 텍스트 색상 */
	}
    .category button:hover {
        background-color: #88afea;
    }
    
    
	.option-group .option-details {
	    display: none; /* 기본적으로 숨김 */
	}
	
	.option-group.open .option-details {
	    display: block; /* open 클래스가 추가되면 내용 보이기 */
	}
    
    
   
</style>


</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
<%-- 	<jsp:include page="${pageContext.request.contextPath}/admin_aside.jsp" /> --%>
	<main>

		<!-- Main Content -->
		<div class="main-content">
			<h1>
				<a href="ad_manageProductList"
					style="text-decoration: none; color: black;">상품 관리</a>
			</h1>

		<div class="product-search">
			<!-- 검색 및 카테고리 필터 -->
				<form class="form-inline" action="ad_manageProductList" method="post">
					<!-- 검색 옵션 선택 -->
						<select name="searchCondition">
							<c:forEach items="${conditionMap}" var="option">
								<option value="${option.value}"
									<c:if test="${searchCondition == option.value}">selected</c:if>>
									${option.key}</option>
							</c:forEach>
						</select>
						<!-- 검색 입력 -->
						<input type="search" name="searchKeyword" placeholder="검색어를 입력하세요." value="${searchKeyword}">
						<button type="submit">검색</button>
				</form>
		</div>
			<!-- 카테고리 버튼 -->
			<div class="category">
				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value=""> <input
						type="hidden" name="nowPage" value="1">
					<button type="submit">전체</button>
				</form>



				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value="식품">
					<%-- 						<input	type="hidden" name="nowPage" value="${paging.nowPage}"> --%>
					<input type="hidden" name="nowPage" value="1">
					<!-- 1페이지로 설정 -->
					<button type="submit">식품</button>
				</form>

				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value="위생"> <input
						type="hidden" name="nowPage" value="1">
					<!-- 1페이지로 설정 -->
					<button type="submit">위생</button>
				</form>
				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value="미용"> <input
						type="hidden" name="nowPage" value="1">
					<button type="submit">미용</button>
				</form>

				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value="의류"> <input
						type="hidden" name="nowPage" value="1">
					<button type="submit">의류</button>
				</form>
				<form action="ad_manageProductList" method="post"
					style="display: inline;">
					<input type="hidden" name="searchCondition"
						value="${searchCondition}"> <input type="hidden"
						name="searchKeyword" value="${searchKeyword}"> <input
						type="hidden" name="category" value="놀이"> <input
						type="hidden" name="nowPage" value="1">
					<button type="submit">놀이</button>
				</form>
			</div>
			<table class="table table-hover">
				<thead class="btn-primary">
					<tr>
						<th>상품ID</th>
						<th>상품 이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>카테고리</th>
						<th>판매 상태</th>
						<th>옵션</th>
<!-- 						<th class="options-toggle">옵션</th> -->
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty productsList}">
							<c:forEach items="${productsList}" var="products">
								<tr
									onclick="selTr(${products.pr_id}, '${searchCondition}', '${searchKeyword}', ${paging.nowPage})"
									style="cursor: pointer;">

									<td class="tdCenter">${products.pr_id}</td>
									<td class="tdCenter" style="text-align: center;"><img src="${pageContext.request.contextPath}/resources/upload/${products.pr_thumbnail}"
										alt="썸네일 이미지" style="height: 50px;" onerror="this.src='../../../resources/images/HappyPawsLogo.png';"></td>
										
									<td class="tdCenter">${products.pr_name}</td>
									<td class="tdCenter">${products.pr_price}</td>
									<td class="tdCenter">${products.pr_category}</td>
									<td class="tdCenter">
										    <c:choose>
										        <c:when test="${products.pr_status == 'available'}">
										            판매중
										        </c:when>
										        <c:when test="${products.pr_status == 'out_of_stock'}">
										            일시 품절
										        </c:when>
										        <c:when test="${products.pr_status == 'discontinued'}">
										            품절
										        </c:when>
										    </c:choose>
										</td>

<!-- 									<td class="tdCenter" onclick="toggleOptions(this)"><span class="options-btn">옵션▼</span> -->
										<td class="tdCenter options-toggle"><span class="options-btn">옵션▼</span>
										<div class="options-popup">
											<!-- 각 상품에 맞는 옵션 리스트만 표시 -->
											<c:forEach var="opt" items="${allOpt}">
												<c:if test="${products.pr_id eq opt.pr_id}">
													<ul style="list-style-type: none; padding: 0; color:black;" >
														<li style="font-weight: bold;">
															옵션명 : ${opt.pr_opt_name}
														</li>
<%-- 														<li>옵션 상태: ${opt.pr_opt_status}</li> --%>
															<li>옵션 상태: 
															    <c:choose>
															        <c:when test="${opt.pr_opt_status == 'available'}">판매중</c:when>
															        <c:when test="${opt.pr_opt_status == 'out_of_stock'}">일시 품절</c:when>
															        <c:when test="${opt.pr_opt_status == 'discontinued'}">품절</c:when>
															        <c:otherwise>알 수 없음</c:otherwise>
															    </c:choose>
															</li>

														<li>재고: ${opt.pr_opt_stock} 개</li>
														<li>추가금액: ${opt.pr_opt_price} 원</li>
													</ul>
												</c:if>
											</c:forEach>
										</div>
										</td>
									</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" style="text-align: center;">일치하는 상품이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<a href="ad_manageProductAdd" >상품 등록하기</a>

			<!--  페이징처리와 목록, 검색 유지 기능 처리 -->
			<ul class="pagination">
				<c:if
					test="${paging.nowPage > 1 && paging.lastBtn > paging.viewBtnCnt}">
					<li class="page-item"><a class="page-link"
						href="ad_manageProductList?nowPage=${paging.nowPage-1}&searchCondition=${searchCondition}&searchKeyword=${searchKeyword}">이전</a></li>
				</c:if>
				<c:forEach var="i" begin="${paging.startBtn}" end="${paging.endBtn}"
					step="1">
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


			<script>
			document.addEventListener("DOMContentLoaded", function () {
			    let currentlyOpenPopup = null; // 현재 열려 있는 팝업을 추적

			    // .options-toggle 클래스가 있는 td에만 이벤트 추가
			    document.querySelectorAll(".options-toggle").forEach(td => {
			        td.addEventListener("click", function (event) {
			            const optionsPopup = td.querySelector(".options-popup");

			            // 현재 열려 있는 팝업이 클릭한 팝업과 다르면 닫기
			            if (currentlyOpenPopup && currentlyOpenPopup !== optionsPopup) {
			                currentlyOpenPopup.style.display = "none";
			            }

			            // 클릭한 팝업의 표시 상태를 토글
			            if (optionsPopup.style.display === "none" || optionsPopup.style.display === "") {
			                optionsPopup.style.display = "block";
			                currentlyOpenPopup = optionsPopup; // 현재 열린 팝업을 업데이트
			            } else {
			                optionsPopup.style.display = "none";
			                currentlyOpenPopup = null; // 모든 팝업이 닫힌 상태
			            }

			            // 이벤트가 부모 요소로 전파되지 않도록 중지
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

		</div>
	</main>
<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
<script>
	function selTr(pr_id, searchCondition, searchKeyword, nowPage) {
	    location.href = "/ad_manageProductModify?pr_id="+pr_id+"&searchCondition="+searchCondition+"&searchKeyword="+searchKeyword+"&nowPage="+nowPage;
	}
	
	
</script>

</html>

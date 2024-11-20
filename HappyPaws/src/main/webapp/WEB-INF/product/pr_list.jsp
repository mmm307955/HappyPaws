<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
   	<jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
    <style>
		* {
		    box-sizing: border-box;
		}
		
		body {
		    margin: 0;
		    padding: 0;
		}
		
		a {
		    text-decoration: none;
		}
		
		ul {
		    list-style-type: none;
		    padding: 0;
		    margin: 0;
		}
		
		.top {
		    max-width: 1000px;
		    margin: 0 auto;
		}
		
		.top-controls {
		    display: flex;
		    justify-content: center;
		    gap: 10px;
		    padding: 10px 20px;
		    background: white;
		}
		
		.control-button {
		    padding: 8px 16px;
		    color: black;
		    border-bottom: 2px solid #fcd11e;
		    cursor: pointer;
		    display: inline-flex;      
		    align-items: center;       
		    justify-content: center;   
		    text-decoration: none;    
		}
		
		.search-container {
		    max-width: 600px;
		    margin: 20px auto;
		    position: relative;
		    padding: 0 15px;
		}
		
		.search-input {
		    width: 100%;
		    padding: 12px 40px 12px 20px;
		    border: 2px solid #fcd11e;
		    border-radius: 25px;
		    font-size: 15px;
		    outline: none;
		}
		
		.search-input:focus {
		    border-color: #fcd11e;
		}
		
		.search-input::placeholder {
			color: black;
		}
		
		.search-input::-webkit-search-cancel-button {
		    -webkit-appearance: none;
		    height: 16px;
		    width: 16px;
		    background: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23777'><path d='M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z'/></svg>") no-repeat 50% 50%;
		    cursor: pointer;
		    margin-right: 10px;
		}
		
		.search-icon {
		    position: absolute;
		    right: 25px;
		    top: 50%;
		    transform: translateY(-90%);
		    color: #868e96;
		}
		
		.nav-menu {
		    display: flex;
		    justify-content: center;
		    gap: 20px;
		    padding: 15px;
		    background: white;
		    margin-bottom: 0;
		    flex-wrap: wrap;
		}
		
		.nav-menu a {
		    text-decoration: none;
		    color: #495057;
		    font-size: 16px;
		    padding: 8px 15px;
		}
		
		.nav-menu a:hover {
		    color: #000;
		}
		
		.nav-menu a.active {
		    color: #000;
		    font-weight: bold;
		    border-bottom: 2px solid #000;
		}
		
		.filter-container {
		    display: flex;
		    justify-content: flex-end;
		    padding: 10px 20px;
		    background: white;
		}
		
		.filter-select {
		    padding: 8px 16px;
		    border: 1px solid #dee2e6;
		    border-radius: 20px;
		    background: white url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3E%3Cpath fill='%23495057' d='M4 6l4 4 4-4'/%3E%3C/svg%3E") no-repeat right 10px center;
		    color: #495057;
		    font-size: 16px;
		    cursor: pointer;
		    outline: none;
		    appearance: none;
		    -webkit-appearance: none;
		    -moz-appearance: none;
		    padding-right: 35px;
		}
		
		.filter-select:hover {
		    border-color: #adb5bd;
		}
		
		.product-grid {
		    display: flex;
		    justify-content: flex-start;
		    flex-wrap: wrap; 
		    gap: 20px;
		    padding: 15px;
		    max-width: 1200px;
		    margin: 0 auto;
		}
		
		.product-card {
		    background: white;
		    border: 1px solid #dee2e6;
		    border-radius: 8px;
		    overflow: hidden;
		    position: relative;
		    flex: 0 0 calc(33.333% - 14px);
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.product-thumbnail {
		    width: 100%;
		    aspect-ratio: 1;
		    background: #f1f3f5;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: #adb5bd;
		    position: relative;
		    border-radius: 15px;
		    margin-bottom: 15px;
		    overflow: hidden;
		}
		
		.thumbnail-item {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.product-top {
		    display: block;
		    padding: 15px;
		    cursor: pointer;
		}
		
		.product-title {
		    font-size: 16px;
		    color: #495057;
		    margin-bottom: 8px;
		}
		
		.product-price {
		    font-weight: bold;
		    font-size: 18px;
		    color: #212529;
		}
		
		.product-bottom {
		    display: flex;
		    justify-content: space-between;
		    padding: 0;
		}
		
		.rating-link {
		    text-decoration: none;
		}
		
		.product-rating {
		    color: #868e96;
		    font-size: 13px;
		    margin: 8px 0 0 12px;
		    padding: 0;
		}
		
		.product-button {
		    display: inline-flex;
		    align-items: center;
		    justify-content: center;
		    padding: 8px 16px;
		    background: #868e96;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    text-decoration: none;
		    font-size: 13px;
		    margin: 10px;
		    height: 33px;
		}
		
		.product-button:hover {
		    background: #495057;
		}
		
		.no-image-text {
		    width: 100%;
		    height: 100%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: #6c757d;
		    font-size: 14px;
		}
		
		.detail-pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 5px;
		    margin: 20px 0;
		    flex-wrap: wrap;
		}
		
		.detail-page-item {
		    min-width: 32px;
		    height: 32px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    cursor: pointer;
		}
		
		.detail-page-item:hover {
		    background-color: #000;
		}
		
		.detail-page-item.active {
		    background: #000;
		}
		
		.detail-page-link {
		    text-decoration: none;
		    color: #000;
		    width: 100%;
		    height: 100%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    font-size: 14px;
		}
		
		.detail-page-link:hover {
		    color: #fff;
		}
		
		.detail-page-item.active .detail-page-link {
		    color: #fff;
		}
		
		.wishlist-btn {
		    background: #6c757d;
		    color: white;
		    font-size: 15px;
		}
		
		.wishlist-btn:hover {
		    background: #495057;
		}
		
		.cart-btn {
		    background: #5e5a14;
		    color: white;
		}
		
		.cart-btn:hover {
		    background: #454311;
		}
		
		.rating-star {
		    color: #e7711b;
		    font-size: 16px;
		}
		
		/* 태블릿 반응형 */
		@media screen and (max-width: 768px) {
		    .product-card {
		        flex: 0 0 calc(50% - 10px);
		    }
		    
		    .nav-menu {
		        gap: 10px;
		        padding: 10px;
		    }
		    
		    .nav-menu a {
		        font-size: 14px;
		        padding: 6px 12px;
		    }
		    
		    .top-controls {
		        padding: 10px;
		    }
		    
		    .control-button {
		        padding: 6px 12px;
		        font-size: 14px;
		    }
		    
		    section {
		    	padding: 10px;
		    }
		}
		
		/* 모바일 반응형 */
		@media screen and (max-width: 480px) {
		    .product-card {
		        flex: 0 0 100%;
		    }
		    
		    .nav-menu {
		        gap: 5px;
		        padding: 8px;
		    }
		    
		    .nav-menu a {
		        font-size: 13px;
		        padding: 5px 10px;
		    }
		    
		    .search-input {
		        font-size: 14px;
		    }
		    
		    .product-title {
		        font-size: 12px;
		    }
		    
		    .product-price {
		        font-size: 14px;
		    }
		    
		    .product-rating {
		        font-size: 12px;
		    }
		    
		    .product-button {
		        font-size: 12px;
		        padding: 6px 12px;
		    }
		    
		    .filter-select {
		        font-size: 12px;
		    }
		    
		    .detail-page-link {
		        font-size: 13px;
		    }
		    
		    section {
		    	padding: 10px;
		    }
		}
    </style>
	<script>
	    $(document).ready(function() {
	        // search-icon 클릭 이벤트 추가
	        $('.search-button').click(function(e) {
	            return validateSearch();
	        });
	
	        // 엔터 키 이벤트 추가
	        $('.search-input').keypress(function(e) {
	            if (e.which == 13) {  // 엔터 키 코드는 13
	                return validateSearch();
	            }
	        });
	        
	        // 위시리스트 버튼 클릭 이벤트
	        $('.product-button.wishlist-btn').click(function(e) {
	            e.preventDefault();
	            
	            // 로그인 체크
	            if ('${user}' === '') {
	                if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
	                    window.location.href = '${pageContext.request.contextPath}/auth/login';
	                }
	                return;
	            }
	            
	            const $product = $(this).closest('.product-card');
	            const productId = $product.data('product-id'); // 상품 ID 가져오기
	            const $thumbnail = $product.find('.thumbnail-item');
	            
	            // 썸네일 경로 가져오기
	            let thumbnailPath = '';
	            if ($thumbnail.length > 0) {
	                // 이미지가 있는 경우
	                thumbnailPath = $thumbnail.attr('src').split('/').pop(); // 파일명만 추출
	            } else {
	                // 이미지가 없는 경우 기본 이미지 설정
	                thumbnailPath = 'no-image.jpg';
	            }
	            
	            const productData = {
	                pr_id: productId,
	                pr_name: $product.find('.product-title').text().trim(),
	                pr_thumbnail: thumbnailPath,
	                pr_opt_name: "기본", // 리스트에서는 기본 옵션으로 설정
	                pr_opt_price: parseInt($product.find('.product-price').text().replace(/[^0-9]/g, ''))
	            };
	            
	            $.ajax({
	                url: '${pageContext.request.contextPath}/product/add_to_wishlist',
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify(productData),
	                success: function(response) {
	                    if (response === 'success') {
	                        alert('위시리스트에 추가되었습니다.');
	                    }
	                },
	                error: function(xhr) {
	                    if (xhr.status === 401) {
	                        if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
	                            window.location.href = '${pageContext.request.contextPath}/auth/login';
	                        }
	                    } else if (xhr.status === 409) {
	                        alert('이미 위시리스트에 있는 상품입니다.');
	                    } else {
	                        alert('위시리스트 추가 중 오류가 발생했습니다.');
	                    }
	                }
	            });
	        });
	    });
	</script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
    <section>
		<div class="top">
		    <div class="top-controls">
		        <a href="/product/pr_order_list" class="control-button">주문내역/위시리스트</a>
		        <a href="/product/pr_cart" class="control-button">장바구니</a>
		    </div>
		</div>
    </section>
    <main>
		<div class="search-container">
		    <form action="/product/pr_list" method="get" onsubmit="return validateSearch()">
		        <input type="search" name="searchKeyword" class="search-input" placeholder="검색어를 입력해주세요." value="${searchKeyword}">
		        <input type="hidden" name="sortType" value="${sortType}">
		        <c:if test="${not empty category}">
		            <input type="hidden" name="category" value="${category}">
		        </c:if>
		        <button type="submit" class="search-button" style="border: none; background: none; cursor: pointer;">
		            <span class="search-icon">🔍</span>
		        </button>
		    </form>
		</div>
		<nav class="nav-menu">
		    <a href="/product/pr_list?sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${empty category ? 'active' : ''}">전체보기</a>
		    <a href="/product/pr_list?category=식품&sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${category eq '식품' ? 'active' : ''}">식품</a>
		    <a href="/product/pr_list?category=위생&sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${category eq '위생' ? 'active' : ''}">위생</a>
		    <a href="/product/pr_list?category=미용&sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${category eq '미용' ? 'active' : ''}">미용</a>
		    <a href="/product/pr_list?category=의류&sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${category eq '의류' ? 'active' : ''}">의류</a>
		    <a href="/product/pr_list?category=놀이&sortType=${sortType}${not empty searchKeyword ? '&searchKeyword='.concat(searchKeyword) : ''}" 
		       class="${category eq '놀이' ? 'active' : ''}">놀이</a>
		</nav>
		<div class="filter-container">
		    <form>
				<select class="filter-select" onchange="location.href='/product/pr_list?searchKeyword=${searchKeyword}${not empty category ? '&category='.concat(category) : ''}&sortType=' + this.value">
				    <option value="latest" ${sortType == 'latest' ? 'selected' : ''}>최신순</option>
				    <option value="rating" ${sortType == 'rating' ? 'selected' : ''}>평점순</option>
				    <option value="price_low" ${sortType == 'price_low' ? 'selected' : ''}>낮은가격순</option>
				    <option value="price_high" ${sortType == 'price_high' ? 'selected' : ''}>높은가격순</option>
				</select>
		    </form>
		</div>
        <ul class="product-grid">
        	<c:forEach var="plist" items="${productList}">
	            <li class="product-card" data-product-id="${plist.pr_id}">
	                <a href="/product/pr_detail?pr_id=${plist.pr_id}" class="product-top">
		                <div class="product-thumbnail" data-thumbnail="${plist.pr_thumbnail}">
	               			<c:if test="${plist.imageExists}">
							    <img class="thumbnail-item" src="${pageContext.request.contextPath}/product/getImage/${plist.pr_thumbnail}" 
							    alt="${plist.pr_thumbnail}">
	                		</c:if>
						    <c:if test="${!plist.imageExists}">
						        <div class="no-image-text">이미지 없음</div>
						    </c:if>
		                </div>
	                    <div class="product-title">${plist.pr_name}</div>
	                    <div class="product-price">
	                    	₩<fmt:formatNumber value="${plist.pr_price}" pattern="#,###"/>
	                    </div>
	                </a>
					<div class="product-bottom">
					    <a href="/product/pr_detail?pr_id=${plist.pr_id}&tab=reviews" class="rating-link">
					        <div class="product-rating"><span class="rating-star">★<fmt:formatNumber value="${plist.avgRating}" pattern="#.#"/> 리뷰 ${plist.reviewCount}</span></div>
					    </a>
					    <button class="product-button wishlist-btn">위시리스트</button>
					</div>
	            </li>
            </c:forEach>
        </ul>
		<div class="detail-pagination">
		    <c:if test="${paging.btnCur > 1}">
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="/product/pr_list?btnCur=1&searchKeyword=${searchKeyword}&sortType=${sortType}">＜＜</a>
		        </div>
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="/product/pr_list?btnCur=${paging.btnCur-1}&searchKeyword=${searchKeyword}&sortType=${sortType}">＜</a>
		        </div>
		    </c:if>
		    <c:forEach var="i" begin="${paging.btnFirst}" end="${paging.btnLast}" step="1">
		        <c:choose>
		            <c:when test="${paging.btnCur == i}">
		                <div class="detail-page-item active">
		                    <a class="detail-page-link">${i}</a>
		                </div>
		            </c:when>
		            <c:otherwise>
		                <div class="detail-page-item">
		                    <a class="detail-page-link" href="/product/pr_list?btnCur=${i}&searchKeyword=${searchKeyword}&sortType=${sortType}">${i}</a>
		                </div>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		    <c:if test="${paging.btnCur < paging.btnTotalCount}">
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="/product/pr_list?btnCur=${paging.btnCur+1}&searchKeyword=${searchKeyword}&sortType=${sortType}">＞</a>
		        </div>
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="/product/pr_list?btnCur=${paging.btnTotalCount}&searchKeyword=${searchKeyword}&sortType=${sortType}">＞＞</a>
		        </div>
		    </c:if>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>
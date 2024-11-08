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
        }
        
		.top {
		    max-width: 1000px;
		    margin: 0 auto;
		}

        .top-controls {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 10px 20px;
            background: white;
            border-bottom: 1px solid #dee2e6;
        }

		.control-button {
		    padding: 8px 16px;
		    background: #868e96;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    display: inline-flex;      
		    align-items: center;       
		    justify-content: center;   
		    text-decoration: none;    
		}
		
		.control-button:hover {
		    background: #495057;      
		}

        .search-container {
            max-width: 600px;
            margin: 20px auto;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 40px 12px 20px;
            border: 2px solid #dee2e6;
            border-radius: 25px;
            font-size: 16px;
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-90%);
            color: #868e96;
        }

        .nav-menu {
            display: flex;
            justify-content: center;
            gap: 30px;
            padding: 20px;
            background: white;
            border-bottom: 1px solid #dee2e6;
            margin-bottom: 0;
        }

		.nav-menu a {
		    text-decoration: none;
		    color: #495057;
		    font-size: 16px;
		    padding: 10px 20px;
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
            border-bottom: 1px solid #dee2e6;
        }

		.filter-select {
		    padding: 8px 16px;
		    border: 1px solid #dee2e6;
		    border-radius: 20px;
		    background: white url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3E%3Cpath fill='%23495057' d='M4 6l4 4 4-4'/%3E%3C/svg%3E") no-repeat right 10px center;  /* 화살표 추가 */
		    color: #495057;
		    font-size: 14px;
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
            gap: 30px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-card {
            background: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            overflow: hidden;
            position: relative;
            flex: 0 0 calc(33.333% - 20px); 
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
            font-size: 14px;
            color: #495057;
            margin-bottom: 8px;
        }

        .product-price {
            font-weight: bold;
            font-size: 16px;
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
		    font-size: 14px;
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
		    font-size: 14px;     
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
		}
		
		.detail-pagination {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 5px;
		    margin-top: 20px;
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
		}
		
		.detail-page-link:hover {
		    color: #fff;
		}
		
		.detail-page-item.active .detail-page-link {
		    color: #fff;
		}
    </style>
	<script>
	    function validateSearch() {
	        var keyword = document.getElementsByName('searchKeyword')[0].value.trim();
	        if (keyword === '') {
	            alert('검색어를 입력해주세요.');
	            return false;
	        }
	        return true;
	    }
	
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
	    });
	</script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
    <section>
		<div class="top">
		    <div class="top-controls">
		        <button class="control-button">주문내역</button>
		        <a href="pr_cart" class="control-button" style="text-decoration: none;">장바구니</a>
		    </div>
		</div>
    </section>
    <main>
		<div class="search-container">
		    <form action="pr_list" method="get" onsubmit="return validateSearch()">
		        <input type="text" name="searchKeyword" class="search-input" placeholder="검색어를 입력해주세요." value="${searchKeyword}">
		        <input type="hidden" name="sortType" value="${sortType}">
		        <button type="submit" class="search-button" style="border: none; background: none; cursor: pointer;">
		            <span class="search-icon">🔍</span>
		        </button>
		    </form>
		</div>
		<nav class="nav-menu">
		    <a href="pr_list" class="${empty category ? 'active' : ''}">전체보기</a>
		    <a href="pr_list?category=식품" class="${category eq '식품' ? 'active' : ''}">식품</a>
		    <a href="pr_list?category=위생" class="${category eq '위생' ? 'active' : ''}">위생</a>
		    <a href="pr_list?category=미용" class="${category eq '미용' ? 'active' : ''}">미용</a>
		    <a href="pr_list?category=의류" class="${category eq '의류' ? 'active' : ''}">의류</a>
		    <a href="pr_list?category=놀이" class="${category eq '놀이' ? 'active' : ''}">놀이</a>
		</nav>
		<div class="filter-container">
		    <form>
		        <select class="filter-select" onchange="location.href='pr_list?searchKeyword=${searchKeyword}&sortType=' + this.value">
		            <option value="latest" ${sortType == 'latest' ? 'selected' : ''}>최신순</option>
		            <option value="rating" ${sortType == 'rating' ? 'selected' : ''}>평점순</option>
		            <option value="price_low" ${sortType == 'price_low' ? 'selected' : ''}>낮은가격순</option>
		            <option value="price_high" ${sortType == 'price_high' ? 'selected' : ''}>높은가격순</option>
		        </select>
		    </form>
		</div>
        <ul class="product-grid">
        	<c:forEach var="plist" items="${productList}">
	            <li class="product-card">
	                <a href="pr_detail?pr_id=${plist.pr_id}" class="product-top">
		                <div class="product-thumbnail" data-thumbnail="${plist.pr_thumbnail}">
	               			<c:if test="${plist.imageExists}">
							    <img class="thumbnail-item" src="${pageContext.request.contextPath}/getImage/${plist.pr_thumbnail}" 
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
					    <a href="pr_detail?pr_id=${plist.pr_id}&tab=reviews" class="rating-link">
					        <div class="product-rating">★<fmt:formatNumber value="${plist.avgRating}" pattern="#.#"/> 리뷰 ${plist.reviewCount}</div>
					    </a>
					    <a href="pr_cart" class="product-button">장바구니</a>
					</div>
	            </li>
            </c:forEach>
        </ul>
		<div class="detail-pagination">
		    <c:if test="${paging.btnCur > 1}">
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="pr_list?btnCur=1&searchKeyword=${searchKeyword}&sortType=${sortType}">＜＜</a>
		        </div>
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="pr_list?btnCur=${paging.btnCur-1}&searchKeyword=${searchKeyword}&sortType=${sortType}">＜</a>
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
		                    <a class="detail-page-link" href="pr_list?btnCur=${i}&searchKeyword=${searchKeyword}&sortType=${sortType}">${i}</a>
		                </div>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		    <c:if test="${paging.btnCur < paging.btnTotalCount}">
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="pr_list?btnCur=${paging.btnCur+1}&searchKeyword=${searchKeyword}&sortType=${sortType}">＞</a>
		        </div>
		        <div class="detail-page-item">
		            <a class="detail-page-link" href="pr_list?btnCur=${paging.btnTotalCount}&searchKeyword=${searchKeyword}&sortType=${sortType}">＞＞</a>
		        </div>
		    </c:if>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>
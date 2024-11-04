<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 목록</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        main {
            margin: 0 20%;
        }
        
        a {
        	text-decoration: none;
        	color: #212529;
        }
        
        ul {
        	list-style-type: none;
        }

        .top {
            margin: 0 20%;
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
            transform: translateY(-50%);
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
            background: white;
            color: #495057;
            font-size: 14px;
            cursor: pointer;
            outline: none;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 1em;
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
		}
		
        .product-rating {
            color: #868e96;
            font-size: 14px;
            margin-top: 8px;
            margin-left: 12px;
        }
        
        .product-button {
        	display: inline-block;
            padding: 8px 16px;
            background: #868e96;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px;
        }
        
        .pagination {
        	display: flex;
        	justify-content: center;
        	border-collapse: collapse;
        }
        
        .page-item {
        	border: 1px solid #adb5bd;
        	text-align: center;
        	width: 30px;
        	height: 30px;
        }
        
        .page-item.active {
        	background: #adb5bd;
        }
    </style>
</head>
<body>
    <section>
        <div class="top">
            <div class="top-controls">
                <button class="control-button">장바구니</button>
                <button class="control-button">주문목록</button>
            </div>
        </div>
    </section>
    <main>
        <div class="search-container">
            <input type="text" class="search-input" placeholder="검색어를 입력해주세요.">
            <span class="search-icon">🔍</span>
        </div>
        <nav class="nav-menu">
            <a href="#">전체보기</a>
            <a href="#">식품</a>
            <a href="#">위생</a>
            <a href="#">미용</a>
            <a href="#">의류</a>
            <a href="#">놀이</a>
        </nav>
        <div class="filter-container">
        	<form>
	            <select class="filter-select">
	                <option value="popularity">인기순</option>
	                <option value="rating">평점순</option>
	                <option value="newest">최신순</option>
	                <option value="price_low">낮은가격순</option>
	                <option value="price_high">높은가격순</option>
	            </select>
            </form>
        </div>
        <ul class="product-grid">
        	<c:forEach var="plist" items="${productList}">
	            <li class="product-card">
	                <a href="pr_detail?pr_id=${plist.pr_id}" class="product-top">
	                	<div class="product-thumbnail" data-thumbnail="${plist.pr_thumbnail}">
						    <img class="thumbnail-item" src="${pageContext.request.contextPath}/getImage/${plist.pr_thumbnail}" alt="${plist.pr_thumbnail}">
	                	</div>
	                    <div class="product-title">${plist.pr_name}</div>
	                    <div class="product-price">
	                    	₩<fmt:formatNumber value="${plist.pr_price}" pattern="#,###"/>
	                    </div>
	                </a>
	                <div class="product-bottom">
	                	<a href="pr_detail?pr_id=${plist.pr_id}">
	               			<div class="product-rating">★5 리뷰 1</div>
	                	</a>
	               		<div class="product-button">장바구니</div>
	                </div>
	            </li>
            </c:forEach>
        </ul>
        <table class="pagination">	
        	<tr>
		        <c:if test="${paging.btnCur > 1}">
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=${paging.btnCur-1}&searchKeyword=${searchKeyword}">←</a>
					</td>
				</c:if>
				<c:if test="${paging.btnCur > 4}">
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=1&searchKeyword=${searchKeyword}">1</a>
					</td>
					<td class="page-item">...</td>
				</c:if>	
				<c:if test="${paging.btnCur == 4}">
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=1&searchKeyword=${searchKeyword}">1</a>
					</td>					
				</c:if>
				<c:forEach var="i" begin="${paging.btnFirst}" end="${paging.btnLast}" step="1">
					<c:choose>
						<c:when test="${paging.btnCur == i}">
							<td class="page-item active">
								<a class="page-link">${i}</a>
							</td>
						</c:when>
						<c:otherwise>
							<td class="page-item">
								<a class="page-link" href="pr_list?btnCur=${i}&searchKeyword=${searchKeyword}">${i}</a>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${paging.btnCur == paging.btnTotalCount - 3}">
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=${paging.btnTotalCount}&searchKeyword=${searchKeyword}">${paging.btnTotalCount}</a>
					</td>				
				</c:if>					
				<c:if test="${paging.btnCur < paging.btnTotalCount - 3}">
					<td class="page-item">...</td>
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=${paging.btnTotalCount}&searchKeyword=${searchKeyword}">${paging.btnTotalCount}</a>
					</td>				
				</c:if>				
				<c:if test="${paging.btnCur < paging.btnTotalCount}">
					<td class="page-item">
						<a class="page-link" href="pr_list?btnCur=${paging.btnCur+1}&searchKeyword=${searchKeyword}">→</a>
					</td>
				</c:if>
			</tr>
        </table>
    </main>
</body>
</html>
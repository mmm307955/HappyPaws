<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세 화면</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
		    background: white;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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

        .header {
            text-align: center;
            padding: 10px 0;
            border-bottom: 2px solid #eee;
            margin-bottom: 20px;
        }

        .product-title {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .product-content {
            display: flex;
            margin-bottom: 20px;
        }

		.product-thumbnail {
		    width: 50%;
		    height: 470px;
		    margin-right: 20px;
		    background-color: #f8f8f8;
		    border: 1px solid #ddd;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    color: #666;
		    position: relative;
		    overflow: hidden;
		}
		
		.thumbnail-item {
		    width: 100%;  
		    height: 100%; 
		    object-fit: cover; 
		}

        .product-details {
            width: 50%;
        }
		
	    .rating-container {
	        display: flex;
	        gap: 12px;
	        margin-bottom: 20px;
	    }
	
	    .star-ratings {
	        unicode-bidi: bidi-override;
	        color: hsl(0, 0%, 80%);
	        font-size: 30px;
	        position: relative;
	        margin: 0;
	        padding: 0;
	        display: inline-block;
	    }
	
	    .fill-ratings {
	        color: #e7711b;
	        padding: 0;
	        position: absolute;
	        z-index: 1;
	        display: block;
	        top: 0;
	        left: 0;
	        overflow: hidden;
	    }
	
	    .fill-ratings span {
	        display: inline-block;
	    }
	
	    .empty-ratings {
	        padding: 0;
	        display: block;
	        z-index: 0;
	    }
	
	    .product-ratings-count {
	        color: black;
	        font-size: 19px;
	        text-decoration: none;
	        white-space: nowrap;
	        margin-top: 2px;
	    }

        .product-info {
            margin: 20px 0;
            padding: 15px;
        }
        
        .product-info p:first-child {
            font-size: 24px;
            font-weight: bold;
        }
        
        .product-info p:last-child {
            font-size: 20px;
            font-weight: bold;
        }

        .option-select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .warning-message {
            padding: 12px;
            margin: 10px 0;
            font-size: 13px;
            color: #666;
            display: flex;
            align-items: center;
        }

        .warning-message::before {
            content: "!";
            color: red;
            border: 1px solid red;
            border-radius: 50%;
            width: 16px;
            height: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 8px;
            font-size: 12px;
        }

        .selected-option {
            background-color: #f8f8f8;
            padding: 15px;
            margin: 10px 0;
            border-radius: 4px;
        }

        .product-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .option-name {
            color: #666;
            margin-bottom: 10px;
        }

        .quantity-control {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        .quantity-adjust {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 3px;
            background: white;
        }

        .quantity-btn {
            width: 28px;
            height: 28px;
            border: none;
            background: white;
            font-size: 16px;
            cursor: pointer;
        }

        .quantity-input {
            width: 40px;
            height: 28px;
            border: none;
            text-align: center;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            outline: none;
        }

        .total-price {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-cart {
            background-color: #6c757d;
            color: white;
        }

        .btn-buy {
            background-color: #495057;
            color: white;
        }

        .tabs {
            display: flex;
            margin: 20px 0;
            border-bottom: 1px solid #ddd;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border: 1px solid transparent;
            margin-bottom: -1px;
        }

        .tab.active {
            border: 1px solid #ddd;
            border-bottom: 1px solid white;
            background: white;
        }

        .tab-content {
            display: none;
            margin-top: 20px;
        }

        .tab-content.active {
            display: block;
        }

        .review-section {
            padding: 20px;
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .write-review-btn {
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .review-item {
            border: 1px solid #dee2e6;
            border-radius: 4px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .review-user {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            align-items: center;
            padding-right: 100px;
        }

        .review-rating {
            position: relative;
            right: -80px;
            top: 0;
            margin: 0;
            padding: 0;
            display: inline-block;
            unicode-bidi: bidi-override;
            font-size: 24px;
            width: auto !important;
        }

        .review-empty-ratings {
            color: #ccc;
            padding: 0;
            display: block;
            z-index: 0;
            position: relative;
        }

        .review-fill-ratings {
            color: #ffd43b;
            padding: 0;
            position: absolute;
            z-index: 1;
            display: block;
            top: 0;
            left: 0;
            overflow: hidden;
        }

        .review-fill-ratings span, .review-empty-ratings span {
            display: inline-block;
        }

        .user-info {
            color: #666;
            font-size: 14px;
            flex-grow: 1;
        }

        .review-content {
            clear: both;
            margin-top: 15px;
            line-height: 1.5;
        }

        .review-image {
            max-width: 100%;
            margin: 10px 0;
            border-radius: 4px;
        }
        
        .stars {
    		cursor: pointer;
		}

		.stars .star {
		    color: #ddd;
		    margin: 0 5px;
		}
		
		.stars .star.active {
		    color: #ffd43b;
		}
		
		.modal {
		    pointer-events: none;
		}
		
		.modal-dialog {
		    pointer-events: all;
		}
		
		.review-star-rating {
			width: 45px; 
			text-align: center; 
			border: 0; 
			background-color: white !important;
			font-size: 32px;
			font-weight: bold;
		}
		
		.review-star-rating:focus {
		    outline: none;
		    border: 0;
		    box-shadow: none;
		}
		
        .detail-pagination {
        	display: flex;
        	justify-content: center;
        	border-collapse: collapse;
        }
        
        .detail-page-item {
        	border: 1px solid #adb5bd;
        	text-align: center;
        	width: 30px;
        	height: 30px;
        }
        
        .detail-page-item.active {
        	background: #adb5bd;
        }
    </style>
    <script>
        $(document).ready(function() {  	
            var initialRating = '5';
            $('#selected-rating').val(initialRating);
            $('#rating-display').val(initialRating);
            highlightStars(initialRating);
            
            var star_rating_width = $('.fill-ratings span').width();
            $('.star-ratings').width(star_rating_width);
            
            var review_rating_width = $('.review-fill-ratings span').width();
            $('.review-rating').width(review_rating_width);
            
            $('.review-fill-ratings').each(function() {
                var rating = $(this).data('rating');
                if (rating) {
                    $(this).css('width', rating + '%');
                }
            });
            
            function showTab(tab) {
                const tabs = document.querySelectorAll('.tab');
                const contents = document.querySelectorAll('.tab-content');
    
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
    
                tab.classList.add('active');
    
                const contentId = tab.getAttribute('data-target');
                document.getElementById(contentId).classList.add('active');
            }
            
            $('.product-ratings-count').click(function() {
                const tabs = document.querySelectorAll('.tab');
                const contents = document.querySelectorAll('.tab-content');
                const selectedTab = document.getElementById('reviewTab');
                
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
    
                selectedTab.classList.add('active');
    
                const contentId = selectedTab.getAttribute('data-target');
                document.getElementById(contentId).classList.add('active');
            });
            
            $('.tab').on('click', function() {
                showTab(this);
            });
            
            $('.option-select').on('change', function() {
                const selectedOption = $(this).find('option:selected');
                const productName = selectedOption.val();
                const optionName = selectedOption.data('option-name');
                const price = selectedOption.data('option-price');

                $('.warning-message').hide();
                $('.selected-option').show();
                $('.product-name').text(productName);
                $('.product-option-name').text(optionName);
                $('.product-option-price').text('₩' + price.toLocaleString());
                updateTotalPrice();
            });

            $('.quantity-btn.plus').click(function() {
                let input = $(this).siblings('.quantity-input');
                input.val(parseInt(input.val()) + 1);
                updateTotalPrice();
            });

            $('.quantity-btn.minus').click(function() {
                let input = $(this).siblings('.quantity-input');
                let value = parseInt(input.val());
                if (value > 1) {
                    input.val(value - 1);
                    updateTotalPrice();
                }
            });

            function updateTotalPrice() {
                const quantity = parseInt($('.quantity-input').val());
                const price = parseInt($('.option-select option:selected').data('option-price'));
                const total = quantity * price;
                $('.total-amount').text('₩' + total.toLocaleString() + '(' + quantity + '개)');
            }

            $('.write-review-btn').click(function() {
                new bootstrap.Modal(document.getElementById('reviewModal')).show();
            });

            $('.stars .star').click(function() {
                var rating = $(this).data('rating');
                $('#selected-rating').val(rating);  
                $('#rating-display').val(rating); 
                highlightStars(rating);
            });

            $('.stars .star').hover(
	       	    function() {
	       	        var hoverRating = $(this).data('rating');
	       	        highlightStars(hoverRating);
	       	        $('#rating-display').val(hoverRating);
	       	    },
	       	    function() {
	       	        var selectedRating = $('#selected-rating').val() || '5';
	       	        highlightStars(selectedRating);
	       	        $('#rating-display').val(selectedRating);
	       	    }
            );
            
            function highlightStars(rating) {
                $('.stars .star').removeClass('active');
                $('.stars .star').each(function() {
                    if ($(this).data('rating') <= rating) {
                        $(this).addClass('active');
                    }
                });
            }
            
            // URL에서 tab 파라미터 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            const tabParam = urlParams.get('tab');
            
            // tab 파라미터가 'reviews'면 리뷰 탭 활성화
            if (tabParam === 'reviews') {
                $('.tab').removeClass('active');
                $('.tab-content').removeClass('active');
                $('#reviewTab').addClass('active');
                $('#reviews').addClass('active');
            }
            
            // 페이징 링크 수정
            $('.pagination a').each(function() {
                const href = $(this).attr('href');
                if (href) {
                    $(this).attr('href', href + '&tab=reviews');
                }
            });
        });
    </script>
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
        <div class="header">
            <h1 class="product-title">${productDetail[0].pr_name}</h1>
        </div>
        <div class="product-content">
            <div class="product-thumbnail">
            	<img class="thumbnail-item" src="${pageContext.request.contextPath}/getImage/${productDetail[0].pr_thumbnail}" alt="${productDetail[0].pr_thumbnail}">
            </div>
            <div class="product-details">
            	<div class="rating-container">
	                <div class="star-ratings">
	                    <div class="fill-ratings" style="width: ${averageRating}%;">
	                        <span>★★★★★</span>
	                    </div>
	                    <div class="empty-ratings">
	                        <span>★★★★★</span>
	                    </div>
	                </div>
	                <a href="#reviews" class="product-ratings-count">(${countRating}개의 고객 상품평)</a>
                </div>
                <div class="product-info">
                    <p>제품 요약 설명</p>
                    <p>${productDetail[0].pr_desc}</p>
                    <p>₩<fmt:formatNumber value="${productDetail[0].pr_price}" pattern="#,###"/></p>
                </div>
                <select class="option-select">
                    <option selected disabled>- [필수] 옵션을 선택해 주세요 -</option>
                    <c:forEach var="options" items="${productDetail}">
                        <option value="${options.pr_name}" data-option-price="${options.pr_opt_price}" data-option-name="${options.pr_opt_name}">${options.pr_opt_name} (${options.pr_opt_stock}개)</option>
                    </c:forEach>
                </select>
                <div class="warning-message">위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</div>
                <div class="selected-option" style="display: none;">
                    <div class="selected-product">
                        <div class="product-name"></div>
                        <div class="product-option-name"></div>
                        <div class="quantity-control">
                            <div class="quantity-adjust">
                                <button class="quantity-btn minus">-</button>
                                <input type="text" class="quantity-input" value="1" readonly>
                                <button class="quantity-btn plus">+</button>
                            </div>
                            <div class="product-option-price"></div>
                        </div>
                    </div>
                    <div class="total-price">
                        <span>총 상품금액(수량)</span>
                        <span class="total-amount"></span>
                    </div>
                </div>
                <div class="button-group">
                    <button class="btn btn-cart">장바구니 담기</button>
                    <button class="btn btn-buy">구매하기</button>
                </div>
            </div>
        </div>
        <div class="tabs">
            <div class="tab active" data-target="detail">상세</div>
            <div class="tab" id="reviewTab" data-target="reviews">상품평</div>
            <div class="tab" data-target="inquiries">문의사항</div>
        </div>
        <div class="tab-content active" id="detail">
            <div class="product-detail-image">${productDetail[0].pr_detail_desc}</div>
        </div>
        <div class="tab-content" id="reviews">
            <div class="review-section">
                <div class="review-header">
                    <button class="write-review-btn">리뷰 작성하기</button>
                </div>
                <c:forEach var="rev" items="${productReview}">
	                <div class="review-item">
	                    <div class="review-user">
	                        <div class="user-info">${rev.us_id} 작성일 - ${rev.prc_start_date}</div>
		                    <div class="review-rating">
		                        <div class="review-fill-ratings" style="width: ${rev.prc_rating * 20}%;">
		                            <span>★★★★★</span>
		                        </div>
		                        <div class="review-empty-ratings">
		                            <span>★★★★★</span>
		                        </div>
		                    </div>
	                    </div>
	                    <div class="review-show">
	                    	<img class="review-show-item" src="${pageContext.request.contextPath}/getImage/${rev.prc_image}" alt="${rev.prc_image}">
	                    </div>
	                    <div class="review-content">${rev.prc_desc}</div>
	                    <div class="review-modify">
		                    <div class="review-edit"></div>
		                    <div class="review-delete"></div>
	                    </div>
	                </div>
                </c:forEach>
		        <table class="detail-pagination">	
		        	<tr>
				        <c:if test="${reviewPaging.btnCur > 1}">
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=${reviewPaging.btnCur-1}&pr_id=${pr_id}&tab=reviews">←</a>
							</td>
						</c:if>
						<c:if test="${reviewPaging.btnCur > 4}">
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=1&pr_id=${pr_id}&tab=reviews">1</a>
							</td>
							<td class="detail-page-item">...</td>
						</c:if>	
						<c:if test="${reviewPaging.btnCur == 4}">
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=1&pr_id=${pr_id}&tab=reviews">1</a>
							</td>					
						</c:if>
						<c:forEach var="i" begin="${reviewPaging.btnFirst}" end="${reviewPaging.btnLast}" step="1">
							<c:choose>
								<c:when test="${reviewPaging.btnCur == i}">
									<td class="detail-page-item active">
										<a class="detail-page-link">${i}</a>
									</td>
								</c:when>
								<c:otherwise>
									<td class="detail-page-item">
										<a class="detail-page-link" href="pr_detail?btnCur=${i}&pr_id=${pr_id}&tab=reviews">${i}</a>
									</td>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${reviewPaging.btnCur == reviewPaging.btnTotalCount - 3}">
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=${reviewPaging.btnTotalCount}&pr_id=${pr_id}&tab=reviews">${reviewPaging.btnTotalCount}</a>
							</td>				
						</c:if>					
						<c:if test="${reviewPaging.btnCur < reviewPaging.btnTotalCount - 3}">
							<td class="detail-page-item">...</td>
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=${reviewPaging.btnTotalCount}&pr_id=${pr_id}&tab=reviews">${reviewPaging.btnTotalCount}</a>
							</td>				
						</c:if>				
						<c:if test="${reviewPaging.btnCur < reviewPaging.btnTotalCount}">
							<td class="detail-page-item">
								<a class="detail-page-link" href="pr_detail?btnCur=${reviewPaging.btnCur+1}&pr_id=${pr_id}&tab=reviews">→</a>
							</td>
						</c:if>
					</tr>
		        </table>                
            </div>
        </div>
        <div class="tab-content" id="inquiries">
            <div class="product-detail-image">문의사항</div>
        </div>
		<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		    <form class="modal-dialog" method="post" action="/">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="reviewModalLabel">리뷰 작성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="text-center mb-3">
		                    <img src="/api/placeholder/100/100" alt="제품 이미지" class="rounded mb-2" />
		                    <div>
		                        <h6 class="mb-1">${productDetail[0].pr_name}</h6>
		                        <p class="text-muted">${productDetail[0].pr_opt_name}</p>
		                    </div>
		                </div>
						<div class="text-center mb-3">
						    <div class="d-flex flex-column align-items-center">
						        <div class="stars mb-2">
						            <span class="star fs-1" data-rating="1">★</span>
						            <span class="star fs-1" data-rating="2">★</span>
						            <span class="star fs-1" data-rating="3">★</span>
						            <span class="star fs-1" data-rating="4">★</span>
						            <span class="star fs-1" data-rating="5">★</span>
						        </div>
						        <input type="text" class="form-control review-star-rating" id="rating-display" value="5" readonly>
						        <input type="hidden" id="selected-rating" value="5">
						    </div>
						</div>
		                <div class="mb-3">
		                    <textarea class="form-control" rows="5" placeholder="리뷰를 작성해주세요."></textarea>
		                </div>
		                <div class="mb-3">
		                    <label for="review-image" class="btn btn-outline-secondary">사진 첨부하기</label>
		                    <input type="file" id="review-image" class="d-none" accept="image/*">
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-dark">등록하기</button>
		            </div>
		        </div>
		    </form>
	    </div>
	</main>
</body>
</html>
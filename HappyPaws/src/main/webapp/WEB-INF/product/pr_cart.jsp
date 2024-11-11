<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="${pageContext.request.contextPath}/head.jsp"/>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		
        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        main {
            max-width: 1000px;
            margin: 0 auto;
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
        }

        .cart-title {
            text-align: center;
            font-size: 40px;
            font-weight: bold;
            margin: 40px 0;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .cart-table a {
		    text-decoration: none;
		    color: inherit;
		}

        .cart-table th {
            padding: 12px;
            background: white;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            font-weight: normal;
            font-size: 13px;
        }

        .cart-table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            vertical-align: middle;
        }

		.product-img {
		    width: 100px;
		    height: auto;
		    transition: opacity 0.2s;
		}
		
		.product-img:hover {
		    opacity: 0.8;
		}

        .product-info {
            text-align: left;
            font-size: 14px;
        }
        
        .product-info a {
		    text-decoration: none;
		    color: inherit;
		}
		
		.product-info a:hover {
		    color: #495057;
		    text-decoration: underline;
		}

        .product-info span {
            display: block;
            color: #666;
            font-size: 14px;
            margin-top: 5px;
        }

        .quantity-wrap {
            display: inline-block;
            width: auto;
            text-align: center;
        }

        .quantity-input-group {
            display: inline-block;
            position: relative;
            width: 50px;
            height: 23px;
            border: 1px solid #ddd;
            margin-bottom: 3px;
        }

        .quantity-input {
            width: 100%;
            height: 100%;
            border: none;
            text-align: center;
            padding: 0 15px 0 5px;
            margin: 0;
        }

        .quantity-buttons {
            position: absolute;
            right: 0;
            top: 0;
            bottom: 0;
            width: 15px;
            display: flex;
            flex-direction: column;
            border-left: 1px solid #ddd;
        }

        .quantity-button {
            height: 50%;
            border: none;
            background: #f8f8f8;
            cursor: pointer;
            padding: 0;
            font-size: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-button:first-child {
            border-bottom: 1px solid #ddd;
        }

        .quantity-btn {
            display: block;
            width: 50px;
            padding: 2px 0;
            border: 1px solid #ddd;
            background: white;
            font-size: 12px;
            cursor: pointer;
            margin: 0 auto;
        }

        .btn-list {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .btn {
            width: 100px;
            padding: 7px 0;
            font-size: 12px;
            cursor: pointer;
        }

        .btn-order {
            background: #5e5a14;
            color: white;
            border: none;
        }

        .btn-normal {
            background: white;
            border: 1px solid #ddd;
        }

        /* 하단부분 스타일 */
        .cart-footer {
            margin-top: 20px;
        }

        .footer-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .delete-selected {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 13px;
        }

        .delete-btn {
            background: #f5f5f5;
            border: 1px solid #ddd;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
        }

        .action-buttons button {
            background: white;
            border: 1px solid #ddd;
            padding: 5px 15px;
            font-size: 12px;
            cursor: pointer;
        }

        .price-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 30px 0;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .price-item {
            flex: 1;
            text-align: center;
        }

        .price-label {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .price-value {
            font-size: 24px;
            font-weight: bold;
        }

        .price-value span {
            font-size: 16px;
            font-weight: normal;
        }

        .price-separator {
            font-size: 20px;
            color: #666;
            padding: 0 20px;
        }

        .price-bonus {
            font-size: 20px;
            color: #666;
            padding: 0 20px;            
        }

        .purchase-buttons {
            text-align: center;
            margin: 30px 0;
        }

        .purchase-btn {
            padding: 15px 40px;
            font-size: 14px;
            cursor: pointer;
            margin: 0 2px;
        }

        .btn-buy-all {
            background: #5e5a14;
            color: white;
            border: none;
        }

        .btn-buy-selected {
            background: white;
            border: 1px solid #ddd;
        }

        .naver-pay {
            text-align: center;
        }

        .naver-pay button {
            background: #03c75a;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-left: 10px;
        }

        .coupon-wrap {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .coupon-input-wrap {
            display: flex;
            gap: 5px;
        }

        .coupon-input {
            width: 200px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 13px;
        }

        .coupon-apply-btn {
            padding: 5px 15px;
            background: #5e5a14;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }

        .coupon-apply-btn:hover {
            background: #4a4710;
        }
    </style>
	<script>
		$(document).ready(function() {
		    // 가격 포맷팅 함수
		    function formatPrice(price) {
		        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    }
		
		    let products = {};
		    let totalPrice = 0;
		    <c:forEach var="item" items="${cartList}" varStatus="status">
		        products['quantity_${item.prsc_no}'] = {  // pr_id를 prsc_no로 변경
		            price: ${item.pr_opt_price},
		            pr_id: ${item.pr_id},
		            pr_opt_name: '${item.pr_opt_name}',
		            quantity: ${item.prsc_quantity},
		            prsc_no: ${item.prsc_no}  // prsc_no 추가
		        };
		        totalPrice += ${item.pr_opt_price * item.prsc_quantity};
		    </c:forEach>
		
		    // 쿠폰 정보 (예시)
		    const coupons = {
		        'SAVE5000': 5000,
		        'SAVE10000': 10000,
		        'PERCENT10': 0.1, // 10% 할인
		        'PERCENT20': 0.2  // 20% 할인
		    };
		
		    let currentCouponDiscount = 0; // 현재 적용된 쿠폰 할인액
		
		    // 상품별 총액 업데이트
			function updateProductTotal(targetId) {
			    const $input = $('#' + targetId);
			    if (!$input.length) return;
			
			    const quantity = parseInt($input.val());
			    const key = targetId;
			    
			    if (products[key]) {
			        const basePrice = products[key].price;
			        const totalPrice = basePrice * quantity;
			        
			        const $row = $input.closest('tr');
			        $row.find('td:eq(3)').text('₩' + formatPrice(basePrice));
			        $row.find('td:nth-last-child(2)').text('₩' + formatPrice(totalPrice));
			
			        products[key].quantity = quantity;
			
			        updateTotalPrice();
			        
			        updateCartQuantity(targetId, quantity);  // 수정된 부분
			    }
			}
		
			// 총 금액 계산 및 업데이트 함수 수정
			function updateTotalPrice() {
			    let totalProductPrice = 0;

			    // 모든 상품의 가격 합산 (체크박스 상관없이)
			    Object.values(products).forEach(product => {
			        const quantity = product.quantity;
			        const price = product.price;
			        totalProductPrice += (price * quantity);
			    });

			    // 배송비 계산
			    const totalShipping = totalProductPrice > 0 ? 3000 : 0;

			    // 쿠폰 할인 계산
			    let couponDiscount = currentCouponDiscount;
			    if (typeof currentCouponDiscount === 'number' && currentCouponDiscount < 1) {
			        couponDiscount = Math.floor(totalProductPrice * currentCouponDiscount);
			    }

			    // 총 상품금액이 0원일 때는 쿠폰 할인도 0원으로 처리
			    if (totalProductPrice === 0) {
			        couponDiscount = 0;
			    }

			    // 화면 업데이트
			    $('.price-summary .price-value').eq(0).html(formatPrice(totalProductPrice) + '<span>원</span>');
			    $('.price-summary .price-value').eq(1).html(formatPrice(totalShipping) + '<span>원</span>');
			    $('.price-summary .price-value').eq(2).html(formatPrice(couponDiscount) + '<span>원</span>');
			    
			    // 최종 금액 계산
			    const finalAmount = Math.max(0, totalProductPrice + totalShipping - couponDiscount);
			    $('.price-summary .price-value').eq(3).html(formatPrice(finalAmount) + '<span>원</span>');
			}
		
		    // 쿠폰 적용 함수
		    function applyCoupon(couponCode) {
		        if (coupons.hasOwnProperty(couponCode)) {
		            currentCouponDiscount = coupons[couponCode];
		            
		            // 알림 메시지 표시
		            const discountText = currentCouponDiscount < 1 ? 
		                `${currentCouponDiscount * 100}% 할인` : 
		                `${currentCouponDiscount.toLocaleString()}원 할인`;
		            alert(`쿠폰이 적용되었습니다. (${discountText})`);
		            
		            updateTotalPrice();
		            return true;
		        } else {
		            alert('유효하지 않은 쿠폰 코드입니다.');
		            return false;
		        }
		    }
		
		    // 장바구니 수량 DB 업데이트
			function updateCartQuantity(targetId, quantity) {
			    const product = products[targetId];
			    if (!product) return;
			
			    $.ajax({
			        url: '${pageContext.request.contextPath}/update_cart_quantity',
			        type: 'POST',
			        contentType: 'application/json',
			        data: JSON.stringify({
			            prsc_no: product.prsc_no,
			            prsc_quantity: quantity,
			            pr_opt_price: product.price,
			            prsc_price: product.price * quantity
			        }),
			        success: function(response) {
			            if (response !== "success") {
			                alert('수량 업데이트에 실패했습니다.');
			                location.reload();
			            }
			        },
			        error: function() {
			            alert('수량 업데이트 중 오류가 발생했습니다.');
			            location.reload();
			        }
			    });
			}
		
		    // 상품 삭제
		    window.removeFromCart = function(prId, prOptName) {
		        if (!confirm('선택하신 상품을 장바구니에서 삭제하시겠습니까?')) {
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/remove_from_cart',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                pr_id: prId,
		                pr_opt_name: prOptName
		            }),
		            success: function(response) {
		                if (response === 'success') {
		                    location.reload();
		                } else {
		                    alert('삭제에 실패했습니다.');
		                }
		            },
		            error: function() {
		                alert('삭제 중 오류가 발생했습니다.');
		            }
		        });
		    };
		
		    // 개별 체크박스
		    $('.product-checkbox').on('change', function() {
		        const allChecked = $('.product-checkbox:not(:checked)').length === 0;
		        $('#selectAll').prop('checked', allChecked);
		    });
		
		    // 선택 상품 삭제
		    $('.delete-btn').on('click', function() {
		        const selectedItems = $('.product-checkbox:checked').map(function() {
		            const $row = $(this).closest('tr');
		            const $input = $row.find('.quantity-input');
		            const inputId = $input.attr('id');
		            return {
		                pr_id: products[inputId].pr_id,
		                pr_opt_name: products[inputId].pr_opt_name
		            };
		        }).get();
		
		        if (selectedItems.length === 0) {
		            alert('삭제할 상품을 선택해주세요.');
		            return;
		        }
		
		        if (confirm('선택한 상품을 삭제하시겠습니까?')) {
		            Promise.all(selectedItems.map(item => 
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/remove_from_cart',
		                    type: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify(item)
		                })
		            )).then(() => {
		                location.reload();
		            }).catch(() => {
		                alert('삭제 중 오류가 발생했습니다.');
		            });
		        }
		    });
		
		    // 장바구니 비우기
		    $('button:contains("장바구니비우기")').on('click', function() {
		        if (!confirm('장바구니를 비우시겠습니까?')) {
		            return;
		        }
		
		        const allItems = Object.values(products).map(product => ({
		            pr_id: product.pr_id,
		            pr_opt_name: product.pr_opt_name
		        }));
		
		        Promise.all(allItems.map(item => 
		            $.ajax({
		                url: '${pageContext.request.contextPath}/remove_from_cart',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify(item)
		            })
		        )).then(() => {
		            location.reload();
		        }).catch(() => {
		            alert('장바구니 비우기 중 오류가 발생했습니다.');
		        });
		    });
		
		    // 쿠폰 입력 이벤트
		    $('.coupon-input').on('keypress', function(e) {
		        if (e.which === 13) { // Enter key
		            applyCoupon($(this).val().toUpperCase());
		            $(this).val('');
		        }
		    });
		
		    // 쿠폰 적용 버튼 클릭
		    $('.coupon-apply-btn').on('click', function() {
		        const couponCode = $('.coupon-input').val().toUpperCase();
		        if (couponCode.trim() === '') {
		            alert('쿠폰 코드를 입력해주세요.');
		            return;
		        }
		        if (applyCoupon(couponCode)) {
		            $('.coupon-input').val('');
		        }
		    });
		
		    // 주문하기 버튼 클릭
		    $('.btn-order, .purchase-btn').on('click', function() {
		        alert('주문 기능은 현재 준비중입니다.');
		    });
		
		    // 초기 총액 계산
		    updateTotalPrice();
		    
		    // 전체 선택 체크박스
		    $('#selectAll').on('change', function() {
		        const isChecked = $(this).prop('checked');
		        $('.product-checkbox').prop('checked', isChecked);
		    });
		    
		    // 수량 증가 버튼 클릭
			$('.quantity-button.plus').on('click', function() {
			    const targetId = $(this).data('target'); 
			    const $input = $('#' + targetId); 
			    let value = parseInt($input.val()) || 1;
			    $input.val(value + 1);
			    updateProductTotal(targetId);
			});

		    // 수량 감소 버튼 클릭
		    $('.quantity-button.minus').on('click', function() {
		        const targetId = $(this).data('target');
		        const $input = $('#' + targetId);
		        let value = parseInt($input.val()) || 2;
		        if (value > 1) {
		            $input.val(value - 1);
		            updateProductTotal(targetId);
		        }
		    });

		    // 수량 직접 입력 처리
		    $('.quantity-input').on('change', function() {
		        const targetId = $(this).attr('id');
		        let value = parseInt($(this).val());
		        if (isNaN(value) || value < 1) {
		            value = 1;
		            $(this).val(value);
		        }
		        updateProductTotal(targetId);
		    });	
		    
		    $('.quantity-input').on('input', function() {
		        let value = $(this).val().replace(/[^0-9]/g, '');
		        $(this).val(value);
		    });
		    
		 	// 체크박스 이벤트 통합 처리
		    function initializeCheckboxes() {
		        // 전체 선택 체크박스
		        $('#selectAll').on('change', function() {
		            const isChecked = $(this).prop('checked');
		            $('.product-checkbox').prop('checked', isChecked);
		        });

		        // 개별 체크박스
		        $('.product-checkbox').on('change', function() {
		            const allChecked = $('.product-checkbox:not(:checked)').length === 0;
		            $('#selectAll').prop('checked', allChecked);
		        });

		        // 초기 상태 설정
		        $('#selectAll').prop('checked', true).trigger('change');
		    }
		 	
		    // 선택 상품 주문하기
		    $('.btn-buy-selected').on('click', function() {
		        const selectedItems = $('.product-checkbox:checked').map(function() {
		            const $row = $(this).closest('tr');
		            return {
		                pr_id: $(this).val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get();

		        if (selectedItems.length === 0) {
		            alert('주문할 상품을 선택해주세요.');
		            return;
		        }

		        processOrder(selectedItems);
		    });
		    
		    // 전체 주문하기
		    $('.btn-buy-all').on('click', function() {
		        const allItems = $('tr').slice(1).map(function() {
		            const $row = $(this);
		            if($row.find('.product-checkbox').length === 0) return null; // 장바구니가 비어있는 경우 처리
		            
		            return {
		                pr_id: $row.find('.product-checkbox').val(),
		                pr_name: $row.find('.product-info a').first().text().trim(),
		                pr_opt_name: $row.find('.product-info span').text().replace('[옵션: ', '').replace(']', ''),
		                pr_opt_price: parseInt($row.find('td:eq(3)').text().replace(/[^0-9]/g, '')),
		                pror_qtt: parseInt($row.find('.quantity-input').val()),
		                pror_product_amt: parseInt($row.find('td:nth-last-child(2)').text().replace(/[^0-9]/g, '')),
		                pror_ship_cost: 3000
		            };
		        }).get().filter(item => item !== null);

		        if (allItems.length === 0) {
		            alert('장바구니가 비어있습니다.');
		            return;
		        }

		        processOrder(allItems);
		    });
		    
		 	// pr_cart.jsp의 JavaScript 수정
		    function processOrder(items) {
		        // 배송정보 입력 모달 표시
		        const shippingModal = new bootstrap.Modal(document.getElementById('shippingModal'));
		        shippingModal.show();

		        // 배송정보 폼 제출 처리
		        $('#shippingForm').off('submit').on('submit', function(e) {
		            e.preventDefault();
		            
		            // 배송정보 가져오기
		            const shippingInfo = {
		                pror_recipient: $('#recipient').val(),
		                pror_phone: $('#phone').val(),
		                pror_addr: $('#addr').val(),
		                pror_addr_detail: $('#addr_detail').val(),
		                pror_zipcode: $('#zipcode').val(),
		                pror_pay_method: $('#pay_method').val()
		            };

		            // 쿠폰 할인 금액 계산
		            const couponAmount = parseInt($('.price-value').eq(2).text().replace(/[^0-9]/g, '')) || 0;
		            
		            // 주문 데이터 생성
		            const orderData = items.map(item => ({
		                ...item,
		                ...shippingInfo,
		                pror_coupon_amt: Math.floor(couponAmount / items.length), // 쿠폰 할인액 균등 분배
		                pror_total_amt: item.pror_product_amt + item.pror_ship_cost - 
		                               Math.floor(couponAmount / items.length) // 총 금액 계산
		            }));

		            // 주문 처리 AJAX 호출
		            $.ajax({
		                url: '${pageContext.request.contextPath}/pr_order',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify(orderData),
		                success: function(response) {
		                    shippingModal.hide();
		                    if (response.success) {
		                        window.location.href = response.redirectUrl;
		                    } else {
		                        alert(response.message || '주문 처리 중 오류가 발생했습니다.');
		                    }
		                },
		                error: function(xhr) {
		                    shippingModal.hide();
		                    if (xhr.status === 401) {
		                        if (confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
		                            window.location.href = '${pageContext.request.contextPath}/auth/login';
		                        }
		                    } else {
		                        alert('주문 처리 중 오류가 발생했습니다.');
		                    }
		                }
		            });
		        });
		    }
		 	
		    // 주소 검색 버튼 클릭 이벤트
		    $('#searchAddrBtn').on('click', function() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                $('#zipcode').val(data.zonecode);
		                $('#addr').val(data.address);
		                $('#addr_detail').focus();
		            }
		        }).open();
		    });
		    
		    initializeCheckboxes();
		});
	</script>  	
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp"/>
    <section>
        <div class="top">
            <div class="top-controls">
                <button class="control-button">주문내역</button>
                <button class="control-button">장바구니</button>
            </div>
        </div>
    </section>
    <main>
        <h1 class="cart-title">장바구니</h1>
        <table class="cart-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"></th>
                    <th>이미지</th>
                    <th>상품정보</th>
                    <th>판매가</th>
                    <th>수량</th>
                    <th>배송구분</th>
                    <th>배송비</th>
                    <th>합계</th>
                    <th>선택</th>
                </tr>
            </thead>
			<tbody>
			    <c:choose>
			        <c:when test="${empty cartList}">
			            <tr>
			                <td colspan="9" class="text-center">장바구니가 비어있습니다.</td>
			            </tr>
			        </c:when>
			        <c:otherwise>
			            <c:forEach var="item" items="${cartList}" varStatus="status">
			                <tr>
			                    <td><input type="checkbox" class="product-checkbox" name="selectedItem" value="${item.pr_id}"></td>
								<td>
								    <a href="pr_detail?pr_id=${item.pr_id}">
								        <c:if test="${item.imageExists}">
								            <img src="${pageContext.request.contextPath}/getImage/${item.pr_thumbnail}" 
								                 alt="${item.pr_name}" class="product-img">
								        </c:if>
								        <c:if test="${!item.imageExists}">
								            <div class="no-image">이미지 없음</div>
								        </c:if>
								    </a>
								</td>
								<td class="product-info">
								    <a href="pr_detail?pr_id=${item.pr_id}">
								        ${item.pr_name}
								        <span>[옵션: ${item.pr_opt_name}]</span>
								    </a>
								</td>
								<td>₩<fmt:formatNumber value="${item.pr_opt_price * item.prsc_quantity}" pattern="#,###"/></td>
								<td>
								    <div class="quantity-wrap">
								        <div class="quantity-input-group">
											<input type="number" value="${item.prsc_quantity}" min="1" 
											       class="quantity-input" id="quantity_${item.prsc_no}" 
											       data-product-id="${item.pr_id}"
											       data-option-name="${item.pr_opt_name}">
											<div class="quantity-buttons">
											    <button type="button" class="quantity-button plus" 
											            data-target="quantity_${item.prsc_no}">▲</button>  
											    <button type="button" class="quantity-button minus" 
											            data-target="quantity_${item.prsc_no}">▼</button> 
											</div>
								        </div>
								    </div>
								</td>
			                    <td>기본배송</td>
			                    <td>3,000원</td>
			                    <td><fmt:formatNumber value="${item.pr_opt_price * item.prsc_quantity}" pattern="#,###"/>원</td>
			                    <td>
			                        <div class="btn-list">
			                            <button class="btn btn-order">주문하기</button>
			                            <button class="btn btn-normal">위시리스트</button>
			                            <button class="btn btn-normal" onclick="removeFromCart(${item.pr_id}, '${item.pr_opt_name}')">× 삭제</button>
			                        </div>
			                    </td>
			                </tr>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</tbody>
        </table>
        <div class="cart-footer">
			<div class="price-summary">
			    <div class="price-item">
			        <div class="price-label">총 상품금액</div>
			        <div class="price-value">
			            <c:set var="totalPrice" value="0"/>
			            <c:forEach var="item" items="${cartList}">
			                <c:set var="itemTotal" value="${item.pr_opt_price * item.prsc_quantity}"/>
			                <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>
			            </c:forEach>
			            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-separator">+</div>
			    <div class="price-item">
			        <div class="price-label">총 배송비</div>
			        <div class="price-value">
			            <c:set var="shippingCost" value="${totalPrice > 0 ? 3000 : 0}"/>
			            <fmt:formatNumber value="${shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			    <div class="price-bonus">-</div>
			    <div class="price-item">
			        <div class="price-label">쿠폰 할인 금액</div>
			        <div class="price-value">0<span>원</span></div>
			    </div>
			    <div class="price-separator">=</div>
			    <div class="price-item">
			        <div class="price-label">결제예정금액</div>
			        <div class="price-value">
			            <fmt:formatNumber value="${totalPrice + shippingCost}" pattern="#,###"/><span>원</span>
			        </div>
			    </div>
			</div>
            <div class="footer-info">
                <div class="delete-selected">
                    <span>선택상품을</span>
                    <button class="delete-btn">× 삭제하기</button>
                </div>
                <div class="coupon-wrap">
                    <label>쿠폰 적용하기</label>
                    <div class="coupon-input-wrap">
                        <input type="text" class="coupon-input" placeholder="쿠폰 코드를 입력하세요">
                        <button class="coupon-apply-btn">적용</button>
                    </div>
                </div>
                <div class="action-buttons">
                    <button>장바구니비우기</button>
                    <button>견적서출력</button>
                </div>
            </div>
			<div class="purchase-buttons">
			    <button class="purchase-btn btn-buy-all">전체 주문하기</button>
			    <button class="purchase-btn btn-buy-selected">선택된 항목 주문하기</button>
			</div>
            <div class="naver-pay">
                <img src="naver-logo.png" alt="네이버페이" height="20">
                <button>N Pay 결제</button>
            </div>
        </div>
		<!-- 배송정보 입력 모달 -->
		<div class="modal fade" id="shippingModal" tabindex="-1" aria-hidden="true">
		    <div class="modal-dialog">
		        <form class="modal-content" id="shippingForm">
		            <div class="modal-header">
		                <h5 class="modal-title">배송 정보 입력</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <div class="mb-3">
		                    <label for="recipient" class="form-label">받는 사람</label>
		                    <input type="text" class="form-control" id="recipient" required>
		                </div>
		                <div class="mb-3">
		                    <label for="phone" class="form-label">연락처</label>
		                    <input type="tel" class="form-control" id="phone" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
		                </div>
		                <div class="mb-3">
		                    <label for="zipcode" class="form-label">우편번호</label>
							<div class="input-group">
							    <input type="text" class="form-control" id="zipcode" readonly required>
							    <button type="button" class="btn btn-secondary" id="searchAddrBtn">주소 찾기</button>
							</div>
		                </div>
		                <div class="mb-3">
		                    <label for="addr" class="form-label">주소</label>
		                    <input type="text" class="form-control" id="addr" readonly required>
		                </div>
		                <div class="mb-3">
		                    <label for="addr_detail" class="form-label">상세주소</label>
		                    <input type="text" class="form-control" id="addr_detail" required>
		                </div>
		                <div class="mb-3">
		                    <label for="pay_method" class="form-label">결제수단</label>
		                    <select class="form-select" id="pay_method" required>
		                        <option value="">선택하세요</option>
		                        <option value="card">신용카드</option>
		                        <option value="bank">무통장입금</option>
		                        <option value="vbank">가상계좌</option>
		                    </select>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		                <button type="submit" class="btn btn-primary">주문하기</button>
		            </div>
		        </form>
		    </div>
		</div>
    </main>
    <jsp:include page="${pageContext.request.contextPath}/footer.jsp"/>
</body>
</html>
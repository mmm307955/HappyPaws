<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
     <title>상품 수정</title>
     <jsp:include page="${pageContext.request.contextPath}/head.jsp" />
    <style>
        .container {
            width: 600px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .title {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .image-upload {
            width: 100%;
            height: 300px;
            background-color: #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
            margin-top: 50px;
        }
        #image-preview {
            max-width: 100%;
            max-height: 100%;
            display: none;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea,
        .form-group select {
        	width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
        .pr_name { 
         width: 500px; 
         padding: 10px; 
         border: 1px solid #ccc; 
         border-radius: 5px; 
         } 
        
        .form-group textarea {
            resize: none;
            height: 150px;
        }
        .options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 15px;
        }
         .option-group {
		        gap: 10px; /* 각 입력 필드 간의 간격 */
		    }
		
		    .option-group input {
		        width : 65%;
		    }
		
		    .option-group button {
		        flex-shrink: 0; /* 버튼이 작게 유지되도록 */
		        padding : 10px;
		    }
        .options input[type="text"],
        .options input[type="number"] {
            padding : 10px;
            width:500px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .buttons {
            display: flex;
            justify-content: center;
        }
        .buttons button {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            background-color: #333;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        .buttons button.cancel {
            background-color: #bbb;
        }
        .buttons button.register {
            background-color: #4CAF50;
        }
        .buttons button.delete {
        background-color: #ff5858;
        }
        
         .option-name_status, .option-stock_price, .pr_name_status {
		    display: flex; /* 요소를 가로로 정렬 */
		    gap: 10px; /* 요소 간의 간격 조정 */
		    align-items: center; /* 세로 정렬 */
		}
		
		.pr_name_status input[type="text"] {
		    flex: 3;
		}
		
		.pr_name_status select {
		    flex: 1;
		}
		
		.option-stock_price button {
		    padding: 10px;
		    width: 40px; /* 버튼 너비 설정 */
		    height: 40px; /* 버튼 높이 설정 */
		    text-align: center;
		    line-height: 20px; /* 버튼 내 텍스트 위치 조정 */
		    font-size: 16px;
		    border: 1px solid #ccc;
		}
		      
		.option-name_status select {
		padding : 10px;
		border: 1px solid #ccc;
	    border-radius: 5px;
	    box-sizing: border-box;
		}
		
		 .add-option,  .remove-option {
		border-radius: 10px;
		background-color:#535353;
		font-weight:bold;
		color:white;
		}
		
		.options input[type="text"], .options input[type="number"] {
	    padding: 10px;
	    width: 500px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
		}
		
    </style>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/header.jsp" />
	<main>

<div class="container">
	<form action="ad_manageProductModify" method="POST" enctype="multipart/form-data">
	<input type="hidden" id="pr_id" name="pr_id" value="${param.pr_id}">
	<input type="hidden" name="nowPage" value="${param.nowPage}">
	<input type="hidden" name="searchCondition" value="${param.searchCondition}">
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
	
    <div class="title">상품 수정</div>
   

<img id="image-preview" src="${pageContext.request.contextPath}/resources/upload/${product.pr_thumbnail}" 
     alt="이미지 미리보기" onerror="this.src='../../../resources/images/HappyPawsLogo.png';" style="display: ${product.pr_thumbnail != null ? 'block' : 'none'};">

	
	<!-- 기존 이미지 경로를 저장하는 hidden 필드 -->
	<input type="hidden" name="existingThumbnail" value="${product.pr_thumbnail}">

    
    <!-- 파일 업로드 필드 -->
    <div class="form-group" style="text-align:center">
        <input type="file" id="pr_thumbnail_file" name="pr_thumbnail_file" accept="image/*">
    </div>

    <div class="form-group">
        상품명
    	<div class="pr_name_status">
        <input type="text" id="pr_name" name="pr_name" value="${product.pr_name}">
        <select id="pr_status" name="pr_status">
		    <option value="available" <c:if test="${product.pr_status == 'available'}">selected</c:if>>판매중</option>
		    <option value="out_of_stock" <c:if test="${product.pr_status == 'out_of_stock'}">selected</c:if>>일시품절</option>
		    <option value="discontinued" <c:if test="${product.pr_status == 'discontinued'}">selected</c:if>>품절</option>
		</select>
		</div>
    </div>

    <div class="form-group">
        <label for="pr_price">대표 가격(원)</label>
        <input type="number" id="pr_price" name="pr_price" value="${product.pr_price}" placeholder="숫자만 입력 가능합니다.">
    </div>

    <div class="form-group">
    <label for="pr_category">카테고리 선택</label>
    <select id="pr_category" name="pr_category">
        <option value="식품" <c:if test="${product.pr_category == '식품'}">selected</c:if>>식품</option>
        <option value="위생" <c:if test="${product.pr_category == '위생'}">selected</c:if>>위생</option>
        <option value="미용" <c:if test="${product.pr_category == '미용'}">selected</c:if>>미용</option>
        <option value="의류" <c:if test="${product.pr_category == '의류'}">selected</c:if>>의류</option>
        <option value="놀이" <c:if test="${product.pr_category == '놀이'}">selected</c:if>>놀이</option>
    </select>
</div>

옵션 입력
<div id="options-container" class="options">
<c:forEach var="option" items="${productOption}">
    <div class="option-group">
        <div class="option-name_status">
            <input type="text" name="pr_opt_name" value="${option.pr_opt_name}" placeholder="옵션명 필수 입력">
            <select id="pr_opt_status" name="pr_opt_status">
                <option value="available" <c:if test="${option.pr_opt_status == 'available'}">selected</c:if>>판매중</option>
                <option value="out_of_stock" <c:if test="${option.pr_opt_status == 'out_of_stock'}">selected</c:if>>일시품절</option>
                <option value="discontinued" <c:if test="${option.pr_opt_status == 'discontinued'}">selected</c:if>>품절</option>
            </select>
        </div>
        <br>
        <div class="option-stock_price">
            <input type="number" name="pr_opt_price" value="${option.pr_opt_price}" placeholder="옵션 추가금 입력">
            <input type="number" name="pr_opt_stock" value="${option.pr_opt_stock}" placeholder="재고 수량 입력">
            <button type="button" class="add-option">+</button>
            <button type="button" class="remove-option">-</button>
        </div>
	       <br>
    </div>
</c:forEach>
</div>

     <div class="form-group">
            <label for="pr_desc">제품 정보</label>
            <textarea id="pr_desc" name="pr_desc">${product.pr_desc}</textarea>
        </div>

        <div class="form-group">
            <label for="pr_detail_desc">상품 상세 설명</label>
            <textarea id="pr_detail_desc" name="pr_detail_desc">${product.pr_detail_desc}</textarea>
        </div>
        
		<input type="hidden" id="option_count" name="option_count" value="1">
		
		<div class="buttons">
				<button type="button" onclick="cancel(${nowPage}, '${searchCondition}', '${searchKeyword}')">취소</button>
				<button type="submit">수정</button>
			    <button onclick="deleteProduct('${product.pr_id }',${nowPage}, '${searchCondition}', '${searchKeyword}', '${param.category}')">삭제</button>
		</div>
		
		<script>
		function cancel(nowPage, searchCondition, searchKeyword) {
			
		    location.href = "/ad_manageProductList?nowPage=" + nowPage + "&searchCondition=" + searchCondition + "&searchKeyword=" + searchKeyword;
		}
		
		
		function deleteProduct(pr_id, nowPage, searchCondition, searchKeyword, category) {
		    if(confirm("정말로 삭제하시겠습니까?")) {
		       location.href = "/deleteProduct?pr_id=" + pr_id + "&nowPage=" + nowPage + "&searchCondition=" + searchCondition + "&searchKeyword=" + searchKeyword + "&pr_category=" + category;
		    }
		}

		    

		</script>

    </form>
</div>
</main>
<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />

<script>
	//옵션 개수 구하는 함수
	function getOptionCount() {
	    const optionGroups = document.querySelectorAll('.option-group');
	    return optionGroups.length;
	}

	//옵션 업데이트 함수
	function updateOptionCount() {
	    const optionCount = getOptionCount();  // 현재 옵션 개수 구하기
	   	document.getElementById('option_count').value = optionCount;  // 숨겨진 필드에 옵션 개수 설정
	}

    document.addEventListener('DOMContentLoaded', function () {
    	updateOptionCount();
        const optionsContainer = document.getElementById('options-container');
		const imagePreview = document.getElementById('image-preview');
		const fileInput = document.getElementById('pr_thumbnail_file');
        // 옵션 추가
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('add-option')) {
                const optionGroup = document.querySelector('.option-group');
                const newOption = optionGroup.cloneNode(true); // 기존 옵션 복사
                newOption.querySelectorAll('input').forEach(input => input.value = ''); // 새 옵션은 빈 값
                optionsContainer.appendChild(newOption);
                updateOptionCount();  // 옵션 개수 업데이트
            }
        });

        // 옵션 삭제
        document.addEventListener('click', function (e) {
            if (e.target.classList.contains('remove-option')) {
                const optionGroups = document.querySelectorAll('.option-group');
                if (optionGroups.length > 1) {
                    e.target.closest('.option-group').remove();
                    updateOptionCount();  // 옵션 개수 업데이트
                } else {
                    alert("최소 옵션 수량은 1개입니다.(옵션 필수 작성)");
                }
            }
        });
        
        //파일 선택 시 이미지 미리보기
        fileInput.addEventListener('change',function(event) {
        	const file = event.target.files[0];
        	if(file){
        		const reader = new FileReader();
        		
        		reader.onload = function(e){
        			imagePreview.src = e.target.result;
        			imagePreview.style.display = 'block'; //이미지 미리보기 표시
        		}
        		reader.readAsDataURL(file);
        	}
        });
        
       
        
    });
</script>

</body>
</html>

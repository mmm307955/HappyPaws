<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../MIA.jsp"%>
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
		<div class="n_write">
			<h1>아이를 찾아주세요</h1>
			<div class="n_writeform">
				<form action="/MIA/insertLostPet" method="post"
					enctype="multipart/form-data" name="boardform">

					<div class="n_write_header">
						<span class="left">글 작성</span>
					</div>

					<div class="n_title">
						<input type="hidden" name="lp_id" value="${user.us_id}"> <input
							type="text" class="form-control" name="lp_title"
							placeholder="제목을 입력하세요." required>
					</div>

					<div class="n_ph">
   						 <input type="text" class="form-control" name="lp_ph" id="lp_ph" placeholder="연락처를 입력하세요" required 
   						 oninput="formatPhoneNumber(this)">
					</div>

					<div class="n_img">
					<label for="file2" class="upload-btn" style="cursor: pointer;">
						<img
							src="${pageContext.request.contextPath}/resources/MIA-img/lostPetImg/기본이미지.png"
							alt="Lost Pet Image" class="lost-pet-image">
						<div class="img_save">
								<input id="file2" type="file" name="uploadFile" accept="image/*"
								style="display: none;" required> <span>사진 첨부</span>
						</div>
						</label>
					</div>

					<div class="n_detail">
						<table class="detail-table">
							<tr class="detail-row">
								<td class="label">실종 장소</td>
								<td class="value"><input type="text" class="form-control"
									name="lp_place" placeholder="실종 장소 입력" required></td>
							</tr>
							<tr class="detail-row">
								<td class="label">실종 날짜</td>
								<td class="value"><input type="date" class="form-control"
									name="lp_time" required></td>
							</tr>
							<tr class="detail-row">
								<td class="label">분류</td>
								<td class="value"><select class="form-control"
									name="lp_category" required>
										<option value="dog">강아지</option>
										<option value="cat">고양이</option>
										<option value="small">소동물</option>
										<option value="etc">기타</option>
								</select></td>
							</tr>
							<tr class="detail-row">
								<td class="label">품종</td>
								<td class="value"><input type="text" class="form-control"
									name="lp_breed" placeholder="품종 입력" required></td>
							</tr>
							<tr class="detail-row">
								<td class="label">사례금</td>
								<td class="value"><input type="number" class="form-control"
									name="lp_reward" placeholder="숫자만 입력해주세요" min="0" required></td>
							</tr>
						</table>

					</div>
					<div class="n_content">
						<textarea class="form-control" rows="5" name="lp_content"
							placeholder="상세 설명을 입력하세요"></textarea>
					</div>
					<input type="hidden" name="lp_ok" value="N"> <input
						type="hidden" name="lp_del" value="N">

					<div class="btn-container">
						<button id="submit" type="submit">글 등록</button>
						<button id="rollback" type="button" onclick="history.back()">취소</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>

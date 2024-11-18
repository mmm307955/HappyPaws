<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="./head.jsp"%>
	<link rel="stylesheet" href="./resources/css/index.css">
</head>
<body>
	<%@include file="./header.jsp"%>
	<main>
		<img src="/resources/images/HappyPawsLogo.png" alt="logo">
		<div id="hero-img">
			<span>안녕하세요 행복한 발자국입니다</span>
			<img src="/resources/images/index.png" alt="메인 이미지">
		</div>
		<section id="notice-section"><!-- Contents Area --></section>
		<div id="contents-bundle">
			<section id="left-contents" class="contents">
				<article id="community-article">
					<a href="/board/cmty_list"><p>커뮤니티</p></a>
					<section>
						<table>
							<colgroup>
								<col style="width: 15%;">
								<col style="width: 65%;">
								<col style="width: 20%;">
							</colgroup>
							<thead>
								<tr>
									<th>분류</th>
									<th>제목</th>
									<th>작성자</th>
								</tr>
							</thead>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
				<article id="shop-article">
					<a href="/pr_list"><p>반려용품</p></a>
					<section>
						<table>
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 55%;">
								<col style="width: 25%;">
							</colgroup>
							<thead>
								<tr>
									<th>사진</th>
									<th>제목</th>
									<th>가격</th>
								</tr>
							</thead>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
			</section>
			<section id="right-contents" class="contents">
				<article id="findPet-article">
					<a href="MIA/getLostPetList"><p>아이를 찾아주세요</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th>사진</th>
									<th>제목</th>
									<th>지역</th>
								</tr>
							</thead>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
				<article id="lostPet-article">
					<a href="MIA/getFindPetList"><p>아이를 발견했어요</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th>사진</th>
									<th>제목</th>
									<th>지역</th>
								</tr>
							</thead>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
				<article id="newFamily-article">
					<a href="MIA/getNewFamilyList"><p>새로운 가족을 찾아요</p></a>
					<section>
						<table>
							<colgroup>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th>사진</th>
									<th>제목</th>
									<th>지역</th>
								</tr>
							</thead>
							<tbody><!-- Contents Area --></tbody>
						</table>
					</section>
				</article>
			</section>
		</div>
	</main>
	<%@include file="./footer.jsp" %>
	<script src="./resources/js/index.js"></script>
</body>
</html>
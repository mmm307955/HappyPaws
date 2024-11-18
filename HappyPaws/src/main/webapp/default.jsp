<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@include file="./head.jsp"%>
	<link rel="stylesheet" href="./resources/css/index.css">
	<style>
		tbody img {
			background-color: lightgray;
		}
	</style>
</head>
<body>
	<%@include file="./header.jsp"%>
	<main>
		<img src="/resources/images/HappyPawsLogo.png" alt="logo">
		<div id="hero-img" style="background-color: transparent; aspect-ratio: auto;">
			<img src="/resources/images/error-page.png" alt="메인 이미지" style="width: 100%;">
		</div>
		<section id="notice-section">
			<a href=""><p>긴급 공지: 시스템 유지보수 안내</p></a>
		</section>
		<div id="contents-bundle">
			<section id="left-contents" class="contents">
				<article id="community">
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
							<tbody>
								<tr>
									<td>후기</td>
									<td>술이 식기 전에</td>
									<td>호영이</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>Lorem</td>
									<td>환양이</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>뿌리 깊은 나무는</td>
									<td>영하별</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>나랏말싸미 듕귁에 달아</td>
									<td>훈이짱</td>
								</tr>
								<tr>
									<td>후기</td>
									<td>이 몸이 죽고 죽어 일백번 고쳐죽어</td>
									<td>영준이</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>무궁화 삼천리 화려강산</td>
									<td>지아링</td>
								</tr>
								<tr>
									<td>후기</td>
									<td>괴로우나</td>
									<td>예슬빛</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>가을 하늘</td>
									<td>수정스타</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>남산 위의 소나무</td>
									<td>백곰</td>
								</tr>
								<tr>
									<td>자유</td>
									<td>동해물과 백두산</td>
									<td>고고</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
				<article id="shop">
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
							<tbody>
								<tr>
									<td><img></td>
									<td>개밥</td>
									<td>5,000원</td>
								</tr>
								<tr>
									<td><img></td>
									<td>개껌</td>
									<td>1,000원</td>
								</tr>
								<tr>
									<td><img></td>
									<td>개껌</td>
									<td>1,000원</td>
								</tr>
								<tr>
									<td><img></td>
									<td>개껌</td>
									<td>1,000원</td>
								</tr>
								<tr>
									<td><img></td>
									<td>개껌</td>
									<td>1,000원</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
			</section>
			<section id="right-contents" class="contents">
				<article id="findPet">
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
							<tbody>
								<tr>
									<td><img></td>
									<td>강아지를 찾아주세요</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td><img></td>
									<td>고양이를 찾아주세요.</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td><img></td>
									<td>호랑이를 찾아주세요</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
				<article id="lostPet">
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
							<tbody>
								<tr>
									<td><img></td>
									<td>강아지를 발견했어요</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td><img></td>
									<td>고양이를 발견했어요.</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td><img></td>
									<td>호랑이를 발견해버렸습니다. 질문 못 받습니다.</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
				<article id="newFamily">
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
							<tbody>
								<tr>
									<td><img></td>
									<td>귀여운 강아지</td>
									<td>가을 하늘</td>
								</tr>
								<tr>
									<td><img></td>
									<td>새끼 고양이</td>
									<td>남산 위의 소나무</td>
								</tr>
								<tr>
									<td><img></td>
									<td>새끼 호랑이</td>
									<td>동해물과 백두산</td>
								</tr>
							</tbody>
						</table>
					</section>
				</article>
			</section>
		</div>
	</main>
	<%@include file="./footer.jsp" %>
</body>
</html>
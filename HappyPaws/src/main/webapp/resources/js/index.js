/** 참고사항
 * 
 * 컬럼 종류는 임의적으로 집어넣은 것이니 만약 바꾸고 싶으시다면 얼마든지 바꾸셔도 상관 없습니다.
 * 
 * 각 기능의 ajax 서블릿은 관련 Controller에서 작성해주시길 바랍니다.
 * @ResponseBody를 사용해서 보내실 경우 Map을 사용하면 자동적으로 json 형태로 바뀝니다. List를 그냥 써도 된다는 말이 있긴 한데 일단 참고해주세요.
 * 
 * 함수 내의 주석이 있는 '주소 입력' 부분만 변경하면 되도록 코드를 작성하였습니다. 문제나 궁금한 점이 생기시면 찾아와주세요.
 * 
 * 추후 주석은 fetch 함수 위나 전역변수 선언 위의 주석을 제외하고는 모두 지울 예정입니다.
 */

// 공지사항
fetch('/notice_index').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let section = document.querySelector("#notice-section");
	section.innerHTML = '';

	const aTag = document.createElement('a');
	const pTag = document.createElement('p');
	pTag.textContent = data.n_title;
	aTag.appendChild(pTag);
	aTag.src = "/board/notice_view?n_seq=" + data.n_seq;  // 글 상세 정보 보기 서블릿 링크
	section.appendChild(aTag);
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 글 분류
const cmtyCategoryList = {
	'General': '자유',
	'FoundReview': '후기',
	'AdoptionReview': '후기'
}
const cmtyColorList = {
	'General': '#3535e9',
	'FoundReview': 'red',
	'AdoptionReview': 'green'
}

// 커뮤니티
fetch('/cmty_index').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#community-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = cmtyCategoryList[item.cmty_category];
		categoryCell.style = "color: " + cmtyColorList[item.cmty_category];
		row.appendChild(categoryCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.cmty_title;
		row.appendChild(titleCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/board/cmty_view?cmty_seq=" + item.cmty_seq + "&cmty_category=all"); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 반려용품
fetch('/product/pr_index').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#shop-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const thumbnailCell = document.createElement('td');
        const thumbnail = document.createElement('img');
		thumbnail.src = "/product/getImage/"+item.pr_thumbnail;
		thumbnail.alt = item.pr_name;
		thumbnailCell.appendChild(thumbnail);
		row.appendChild(thumbnailCell);

		const nameCell = document.createElement('td');
		nameCell.textContent = item.pr_name;
		row.appendChild(nameCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/product/pr_detail?pr_id=" + item.pr_id); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 애완동물 분류
const categoryList = {
	'dog': '강아지',
	'cat': '고양이',
	'small': '소동물',
	'etc': '기타'
}

// 아이를 찾아주세요
fetch('/MIA/getLostPetListIndex').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#lostPet-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = categoryList[item.lp_category];
		row.appendChild(categoryCell);

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = "/resources/MIA-img/lostPetImg/" + item.lp_img;
		img.alt = item.lp_title;
		imgCell.appendChild(img);
		row.appendChild(imgCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.lp_title;
		row.appendChild(titleCell);

		const placeCell = document.createElement('td');
		placeCell.textContent = item.lp_place;
		row.appendChild(placeCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/MIA/getLostPet?lp_seq=" + item.lp_seq + "&searchCondition=TITLE&searchKeyword=&category=&nowPage=1"); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 새로운 가족을 찾아요
fetch('/MIA/getNewFamilyListIndex').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#newFamily-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = categoryList[item.nf_category];
		row.appendChild(categoryCell);

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = "/resources/MIA-img/newFamilyImg/" + item.nf_img;
		img.alt = item.nf_title;
		imgCell.appendChild(img);
		row.appendChild(imgCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.nf_title;
		row.appendChild(titleCell);

		const placeCell = document.createElement('td');
		placeCell.textContent = item.nf_place;
		row.appendChild(placeCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/MIA/getNewFamily?nf_seq=" + item.nf_seq + "&searchCondition=TITLE&searchKeyword=&category=&nowPage=1"); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));
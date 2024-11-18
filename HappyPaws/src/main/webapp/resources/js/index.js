/** 참고사항
 * 
 * 컬럼 종류는 임의적으로 집어넣은 것이니 만약 바꾸고 싶으시다면 얼마든지 바꾸셔도 상관 없습니다.
 * 
 * 각 기능의 ajax 서블릿은 관련 Controller에서 작성해주시길 바랍니다.
 * @ResponseBody를 사용해서 보내실 경우 Map을 사용하면 자동적으로 json 형태로 바뀝니다. List를 그냥 써도 된다는 말이 있긴 한데 일단 참고해주세요.
 * 
 * 함수 내의 주석이 있는 '주소 입력' 부분만 변경하면 되도록 코드를 작성하였습니다. 문제나 궁금한 점이 생기시면 찾아와주세요.
 * 
 * 추후 주석은 fetch 함수 위의 주석을 제외하고는 모두 지울 예정입니다.
 */

// 공지사항
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let section = document.querySelector("#notice-section");
	section.innerHTML = '';

	const aTag = document.createElement('a');
	const pTag = document.createElement('p');
	pTag.textContent = data.n_title;
	aTag.appendChild(pTag);
	aTag.src = "주소 입력" + data.n_seq;  // 글 상세 정보 보기 서블릿 링크
	section.appendChild(aTag);
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 커뮤니티
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#community-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = item.cmty_category;
		row.appendChild(categoryCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.cmty_title;
		row.appendChild(titleCell);

		const authorCell = document.createElement('td');
		authorCell.textContent = item.cmty_id;
		row.appendChild(authorCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "주소 입력" + item.cmty_seq); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 반려용품
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#shop-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const thumbnailCell = document.createElement('td');
        const thumbnail = document.createElement('img');
		thumbnail.src = item.pr_thumbnail;
		thumbnail.alt = item.pr_name;
		thumbnailCell.appendChild(thumbnail);
		row.appendChild(thumbnailCell);

		const nameCell = document.createElement('td');
		nameCell.textContent = item.pr_name;
		row.appendChild(nameCell);

		const priceCell = document.createElement('td');
		priceCell.textContent = item.pr_price;
		row.appendChild(priceCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "주소 입력" + item.pr_id); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 아이를 찾아주세요
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#findPet-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = item.lp_img;
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
		row.addEventListener('click', () => location.href = "주소 입력" + item.lp_seq); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 아이를 발견했어요
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#findPet-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = item.fp_img;
		img.alt = item.fp_title;
		imgCell.appendChild(img);
		row.appendChild(imgCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.fp_title;
		row.appendChild(titleCell);

		const placeCell = document.createElement('td');
		placeCell.textContent = item.fp_place;
		row.appendChild(placeCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "주소 입력" + item.fp_seq); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 새로운 가족을 찾아요
fetch('주소 입력').then(response => response.json()).then(data => { // ajax 서블릿 링크
	let tbody = document.querySelector("#findPet-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = item.nf_img;
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
		row.addEventListener('click', () => location.href = "주소 입력" + item.nf_seq); // 글 상세 정보 보기 서블릿 링크
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));
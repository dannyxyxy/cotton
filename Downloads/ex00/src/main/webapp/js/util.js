/**
 * util.js
 * 
 * 댓글이 페이지네이션
 */
 
 /*
 "pageObject":{"page":1,"perPageNum":10,"startRow":1,"endRow":10,
 "perGroupPageNum":10,"startPage":1,"endPage":1,"totalPage":1,"totalRow":6,"period":"pre"}}
 
 */
 
 // 댓글 리스트픞 표시한 것과 동일하게
 // 댓글 페이지네이션 태그를 만드렁 넘긴다
 
 function replyPagination(pageObject) {
 	let str = "";
 	
 	// 전 페이지 그룹으로 이동 - 시작
 	str += ' <li class="page-item';
 	
 	//이전 페이지가 없으면 disabled 추가
 	if(pageObject.startPage == 1) str += ' disabled ';
 	
 	
 	//전 페이지 이동 - 끝 (이전 페이지를 버튼을 누르면 starPage -1로 이동 하도록)
 	str += '" data-page="' + (pageObject.startPage -1) + '"><a class="page-link" href="#"><</a></li>';
 	
 	// startPage부터 endPage까지 박복 처리하면서 페이지 버튼을 만든다
 	for (let i = pageObject.startPage; i <= pageObject.endPage; i++){	
	 	str += '<li class="page-item';
	 	if (replyPage == i) str += ' active ';
	 	str += '" data-page="' + i + '"><a class="page-link" href="#">' + i + '</a></li>';
 	}
 	
 	// 다음 페이지 이동 (endPage > 10) ->(다음 페이지를 버튼을 누르면 endPage +1로 이동 하도록 data-page에 세팅함
 	str += '<li class="page-item';
 	if(pageObject.endPage >= pageObject.totalPage) { str += ' disabled ';
 	}
 	str += '" data-page="' + (pageObject.endPage +1) + '"><a class="page-link" href="#">></a></li>';
 	
 	return str;



 
 }
 
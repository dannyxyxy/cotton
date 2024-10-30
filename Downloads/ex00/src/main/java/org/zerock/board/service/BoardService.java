	
	package org.zerock.board.service;

	import java.util.List;

	import org.zerock.board.vo.BoardVO;
	import org.zerock.util.page.PageObject;

	public interface BoardService {
		
		
		// 1. 리스트 
		public List<BoardVO> list(PageObject pageObject);
		
		// 2. 글 보기 
		public BoardVO view(Long no, int inc);
		
		// 3-1. 글 등록 
		public Integer write(BoardVO vo);
		
		//4. 글 수정
		public Integer update(BoardVO vo);
		
		//5. 글 삭제
		public Integer delete(BoardVO vo);
	}

	
	


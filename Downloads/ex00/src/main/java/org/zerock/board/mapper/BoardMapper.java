package org.zerock.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.zerock.board.vo.BoardVO;
import org.zerock.boardreply.vo.BoardReplyVO;
import org.zerock.util.page.PageObject;

//1. 드라이버 확인
//2. DB 연결
//3. SQL 작성
//4. 살행 객체에 대이터 세팅
//5. 쿼리 실행
//6. 데이터 담기
//7. DB 닫기 

// 위에 1~7번 단계를 myBatis 가 한번에 해준다  

@Repository
public interface BoardMapper {
	
	// 1. 일반 게시판 리스트 
	//리스트 가져오는 쿼리 실행 
	public List<BoardVO> list(PageObject pageObject);
	//일반게시판 리스트 페이지 처리를 위한 전체 데이터 개수 불러오기
	public Long getTotalRow(PageObject pageObject);

	
	// 2. 글보기
	// 조회수 증가 
	public Integer increase(Long no);
	//글 정보 불러오기
	public BoardVO view(Long no);
	
	//3. 일반 게시판 글쓰기 
	public Integer write(BoardVO vo);
	
	// 글 등록 처리 테스트를 위한 메서드 입니다.
	// public Integer writeTx(BoardVO vo);
	
	//4. 글수정
	public Integer update(BoardVO vo);
	
	//5, 글 삭제
	public Integer delete(BoardVO vo);

	
}

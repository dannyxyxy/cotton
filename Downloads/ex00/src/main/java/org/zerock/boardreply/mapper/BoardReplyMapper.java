package org.zerock.boardreply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.boardreply.vo.BoardReplyVO;
import org.zerock.util.page.PageObject;


@Repository
public interface BoardReplyMapper {
	
	//1-1. getTotalRow
	// myBatis애서 DB 처리로 파라메타를 넘길 때 개수는 1개 입니다. 
	// 2개 넘기고 싶을 떄는 -> @Param 사용
	//@Param은 map(key, value) 형으로 넘어간다
	public Long getTotalRow(@Param("pageObject") PageObject pageObject, @Param("no") Long no);
	
	// 1. list
	public List<BoardReplyVO> list(@Param("pageObject") PageObject pageObject, @Param("no") Long no);
	
	// 2. write
	public Integer write(BoardReplyVO vo); // no, content, id

	// 3. update
	public Integer update(BoardReplyVO vo); // rno, content, id
	
	// 4. delete
	public Integer delete(BoardReplyVO vo); //rno, id
}

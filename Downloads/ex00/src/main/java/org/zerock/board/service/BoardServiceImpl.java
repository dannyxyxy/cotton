package org.zerock.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.board.mapper.BoardMapper;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
@Qualifier("BoardServiceImpl")
public class BoardServiceImpl implements BoardService{
	
	
	//자동 DI
	@Inject
	private BoardMapper mapper;
	
	
	// 1. 리스트 
	@Override
	public List<BoardVO> list(PageObject pageObject) {
		log.info("-----list() 실행-----");
		
	//전체 데이터 수를 구해서 startRow endRow가 세팅 된다 	
	pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject); 
				
	}
	
	// 2. 글보기 
	@Override
	public BoardVO view(Long no, int inc) {
		log.info("------view() 실행-----");
			//조화수 증가
			if (inc ==1) mapper.increase(no);
		//글정보 가져오기 	
		return mapper.view(no);
	}
	
	// 3-1. 글 등록 
	// Transaction 테스트를 위한 annotation 추가
	//@Transactional
	@Override
	public Integer write(BoardVO vo) {
		
	Integer result = mapper.write(vo);
		log.info("-----write() 실행-----");
		
		//vo.setNo(10000L);
		//mapper.writeTx(vo); 
		
		return result;
	}
	
	// 4. 글수정
	@Override
	public Integer update(BoardVO vo) {
		log.info("-----update()실행------");
		
		return mapper.update(vo);
		
	}
	
	// 5. 글 삭제
	@Override
	public Integer delete(BoardVO vo) {
		log.info("-----delete() 실행-----");
		
		return mapper.delete(vo);
	} 


}

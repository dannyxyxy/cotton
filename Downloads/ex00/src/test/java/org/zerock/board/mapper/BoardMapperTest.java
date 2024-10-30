package org.zerock.board.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// mapper 메서드 단위 동작 테스트(쿼리 테스트)
// Test 를 위한 클래스

// 이 클래스는 웹 폼이 갖춰지지 않았을 때 쿼리에 대한 테스트를 진행하는 클래지만 
// DB에는 반영되기 때문에 글 등록, 수정, 삭제 전부 반영이 됩니다. 

@RunWith(SpringJUnit4ClassRunner.class)

//설정 파일 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

//로그 객체 생성
@Log4j
public class BoardMapperTest {
	
	//자동 DI
	// 1. lombok의 setter와 spring의 Autowired이용
	// 2. spring 의 Autowired이용
	// 3. inject이용 
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	// 일반 게시판 리스트 메서드
//	@Test
	public void testList() {
		log.info("==========[일반 게시판 리스트 (list()) 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		PageObject pageObject = new PageObject();
		log.info(mapper.list(pageObject));
	}
	
	//일반 게시판 getTotalRow() 테스트
	//@Test
	public void testGetTotalRow() {
		log.info("==========[일반 게시판 리스트 getTotalRow() 테스트 ]==========");
		
		PageObject pageObject = new PageObject();
		log.info(mapper.getTotalRow(pageObject));
		
	}
	
	//일반 게시판 글 보기 -> 조회수 증가 테스트 성공하면 1
	//@Test
	public void testIncreas() {
		log.info("==========[일반 게시판 글보기 increase() 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		//no = 85
		Long no = 85L;
		log.info(mapper.increase(no));
		
	}
	
	//일반 게시판 글보기 -> 
//	@Test
	public void testView() {
		log.info("==========[일반 게시판 글보기 view() 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		Long no = 85L;
		log.info(mapper.view(no));
	}
	
	//일반 게시판 글등록 -> 
//	@Test 
	public void testWrite() {
		log.info("==========[일반 게시판 글등록 write() 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		BoardVO vo = new BoardVO();
		vo.setTitle("스프링에서 Junit으로 글 등록 테스트 합니덩");
		vo.setContent("스프링에서 하드코딩으로 글 등록 테스트 중입니다.");
		vo.setWriter("김지윤");
		vo.setPw("1111");
		
		log.info(mapper.write(vo));
	}
	
	//일반 게시판 글 수정
	@Test
	public void testUpdate() {
		log.info("==========[일반 게시판 글수정 testUpdate() 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		//no = 85
		BoardVO vo = new BoardVO();
		vo.setNo(86L);
		vo.setPw("1111");
		vo.setTitle("Junit을 이용해 글 수정 테스트 중");
		vo.setContent("스프링에서 하드코딩으로 글 등록 테스트 중입니다.");
		vo.setWriter("김지윤");
		
		log.info(mapper.update(vo));
		
	}

	//일반 게시판 글삭제 성공하면 -> 1
	@Test
	public void testDelete() {
		log.info("==========[일반 게시판 글삭제 testDelete() 테스트 ]==========");
		
		//필요한 데이터 (파라메타로 넘겨지는 테이터)는 하드코딩 한다
		//no = 85
		BoardVO vo = new BoardVO();
		vo.setNo(83L);
		vo.setPw("1111");
		
		log.info(mapper.delete(vo));
		
	}

}

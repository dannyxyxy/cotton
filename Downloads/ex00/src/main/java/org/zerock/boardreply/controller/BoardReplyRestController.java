package org.zerock.boardreply.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.boardreply.service.BoardReplyService;
import org.zerock.boardreply.vo.BoardReplyVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@RestController
//siteMesh애 적용안되는 URI 사용 -> 화면에 구성하는 URI가 아니기떄무넹 
@RequestMapping("/boardreply") 
@Log4j
public class BoardReplyRestController {
	
	@Autowired
	@Qualifier("boardReplyServiceImpl")
	
	// 1. list
	private BoardReplyService service;
	
	@GetMapping(value= "/list.do")
	// return type String(URI)가 JSP에 넘어갈 자료를 생각해야한다
	// 댓글 리스트, 페이지 - 두가지 자료형이 틀릴때 -> map
	public ResponseEntity<Map<String, Object>> list (PageObject pageObject, Long no) {
		log.info("----- list - page :" + pageObject.getPage() + ",no: "+no);
	
		//DB에서 데이터(list) 가져와서 넘겨주기
		List<BoardReplyVO> list = service.list(pageObject, no);
		
		//데이터를 전달할 객체 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageObject", pageObject);
		
		//list와 pageObject의 데이터 확인
		// map 으로 해서 데어터가 나오면 그냥 사용하면 됨
		// 주소가 나오면 각각 출력하도록 작성 : map.list map.pageObject
		log.info("after map: "+ map);
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);  
	}
	
	
	// 2. write 일반게시판 댓글 쓰기
	@PostMapping(value = "/write.do", consumes = "application/json", produces = "text/plain; charset=UTF-8")
		public ResponseEntity<String> write(@RequestBody BoardReplyVO vo, HttpSession session) {
		// URI 와 같이 넘어오는 데어터의 name과 파라메타에 적힌 자료현은 변수이름 또는 클래스의 변수이름과 같으면 자동으로 value가 파라메타에 적용됩니다.
		
			//로그인 필요
			vo.setId(getId(session));
			
			//댓긓 등록
			service.write(vo);
		
			return new ResponseEntity<String>("댓글이 등록되었습니다.", HttpStatus.OK);	
			
	}
	
	
	//3. update 댓글 수정
		@PostMapping(value= "/update.do", consumes = "application/json", produces = "text/plain; charset=UTF-8")
		public ResponseEntity<String> update(@RequestBody BoardReplyVO vo, HttpSession session) {
			log.info("update.do----------");
			
			//로그인해야 사용가능
			vo.setId(getId(session));
			
			//댓글 수정 처리
			Integer result = service.update(vo);
			
			if(result==1) {
				return new ResponseEntity<String>("댓글이 수정되었습니다.", HttpStatus.OK);			
			}
			//else  써도 되고 안써도 됨
			return new ResponseEntity<String>("댓글 수정이 실패하였습니다.", HttpStatus.BAD_REQUEST);	
			
			
		}
		
	//4. delete 댓글 삭제
		@GetMapping(value= "/delete.do", produces = "text/plain; charset=UTF-8")
		// delete는 rno만 넘어오기 때문에 JSON을 사용하지 않아도 됨
		// 어노테이션 필요없음
		public ResponseEntity<String> delete(BoardReplyVO vo, HttpSession session){
			log.info("delete.do---------");
			
			//로그인 해야 사용 가능
			vo.setId(getId(session));
			
			// 댓글 삭제 처리
			Integer result = service.delete(vo);
			
			if(result==1) {
				return new ResponseEntity<String>("댓글이 삭제되었습니다.",HttpStatus.OK);
			}
			
			return new ResponseEntity<String>("댓글 삭제를 실패 하였습니다.",HttpStatus.BAD_REQUEST);
			
		}
	
	
		private String getId(HttpSession sesion) {
			// LoginVO vo = (LoginVO) session.getAttribute("login")
			// String id = vo.getId();
			// 테스트를 위한 강제 로그인 처리
			return "test1";
			
		}
}

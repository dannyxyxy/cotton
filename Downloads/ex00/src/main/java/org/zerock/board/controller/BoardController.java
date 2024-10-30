package org.zerock.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.board.service.BoardService;
import org.zerock.board.vo.BoardVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	//1. 일반 게시판 리스트 
	//자동 DI
	// @Setter(onMethod_ = @Autowired) //@Qualifier 사용시 @setter 오류 
	@Autowired
	@Qualifier("BoardServiceImpl")
	private BoardService service;
	
	@GetMapping("/list.do")
	//1. HttpServletRequest에 자료를 담아서 넘긴다
	// public String list(HttpServletRequest request) {
	
	//2. Model (spring 에서 제공) 을 이용해서 자료넘기기
	 public String list(Model model, HttpServletRequest request) {
		
	//3. ModelAndView -> Model에 담아서 View로 넘긴다 	
		
//	public ModelAndView list(Model model) {	
		log.info("-----list()-----");
		
		//페이지 처리를  위한 객체 생성
		PageObject pageObject = PageObject.getInstance(request);
		
		// 1. 
		// request.setAttribute("list", service.list());
		
		//2. 처리된 데이터를 Model 이라는 객체에 저장해서 넘기기 
		// Model에 담으면 request애 담긴다
		 model.addAttribute("list", service.list(pageObject));
		 model.addAttribute("pageObject", pageObject);
		 return "board/list";
		
		// 3. ModelAndView
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("list",service.list());
//		mav.setViewName("board/list");
//		
//		return mav;
		
	}
	
	
	//2. 글보기
	// uri에 있는 값과 동일한 이름의 변수에 값이 담긴다. (no, inc)
	@GetMapping("/view.do")
	public String view(Model model, Long no, int inc) {
		log.info("-----view() 실행-----");
		
		model.addAttribute("vo",service.view(no,inc));
		return "board/view";
	}
		
	// 3-1. 일반 게시판 글쓰기 폼 
	// class에 있는 mapping 주소 + 메서드 mapping 주소로 접근하게 된다.
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("-----writeForm() 실행-----");
		return "board/write";
	}
	
	// 3-2. 글쓰기 처리 
	@PostMapping("/write.do")
	public String write(BoardVO vo, RedirectAttributes rttr) {
		log.info("-----write() 실행-----");
		service.write(vo);
		
		//모달창 띄우기 RedirectAttributes -> 한번 띄우고 사라져서 remove 필요없음
		rttr.addFlashAttribute("msg", "게시판에 새로운 글이 등록 되었습니다."); 
		
		return "redirect:list.do";
	}
	
	//4-1. 글 수정 폼
	@GetMapping("/updateForm.do")
	//Model은 글번호로 받은 데이터를 update.jsp로 넘길때 사용 
	//no는 URL에 적힌 no값을 가져옵니다.
	public String update(Model model, Long no) {
		log.info("-----updateForm() 실행-----");
		
		model.addAttribute("vo",service.view(no, 0));
		
		// 설정한 페이지로 가게 해주면 됨
		return "board/update";
	}
	
	//4-2. 글 수정 처리
	@PostMapping("/update.do")
	public String update(BoardVO vo, RedirectAttributes rttr) {
		log.info("-----update() 실행-----");
		log.info(vo);
		
		//update가 잘 들어가면 1,안들어가면 0 
		if(service.update(vo) ==1) {
			
			rttr.addFlashAttribute("msg", "게시판" + vo.getNo() +"번 글이 수정되었습니다.");
		}
		else {
			rttr.addFlashAttribute("msg", "수정을 실패 했습니다. 비밀번호를 확인하고 다시 시도해 주세요.");
		}
		//글 수정후 글보기로 돌아간다 조회수 증가 0
		return "redirect:view.do?no="+vo.getNo()+"&inc=0";
	}
	
	
	@PostMapping("/delete.do")
	public String delete(BoardVO vo, RedirectAttributes rttr) {
		log.info("-----delete() 실행-----");

		// delete 가 잘 들어가면 1 아니면 0
		if(service.delete(vo)==1) {
			
			rttr.addFlashAttribute("msg", "게시판"+ vo.getNo()+"번 글이 삭제 되었습니다.");
			return "redirect:list.do"; 
		}
		else {
			rttr.addFlashAttribute("msg", "삭제를 실패 했습니다. 비밀번호를 확인하고 다시 시도해 주세요.");
			return "redirect:view.do?no="+vo.getNo()+"&inc=0"; 
		}
	
		// 삭제가 되면 글이 없어지므로 리스트로 돌아가고 삭제가 되지않으면 원래 글로 돌아감
	}
	
	
	

}
 
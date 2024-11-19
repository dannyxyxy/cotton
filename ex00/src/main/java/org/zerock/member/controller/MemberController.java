package org.zerock.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {

    @Autowired
    @Qualifier("memberServiceImpl")
    private MemberService service;

    // 파일 업로드 디렉토리 경로
    private static final String UPLOAD_DIR = "/upload/member/";

    // 세션에서 로그인 정보를 가져오는 메서드
    private LoginVO getSessionLogin(HttpSession session) {
        return (LoginVO) session.getAttribute("login");
    }

    // 예외 처리 메시지를 설정하는 메서드
    private void setErrorMessage(RedirectAttributes rttr, String message) {
        rttr.addFlashAttribute("errorMessage", message);
    }
    
    //회원 리스트 + 페이징처리
    @GetMapping("/adminPage.do")
    public String list(Model model, HttpServletRequest request) {
        log.info("========= adminPage.do ============");

        PageObject pageObject = PageObject.getInstance(request);
        if (request.getParameter("perPageNum") == null) {
            pageObject.setPerPageNum(3);
        }

        model.addAttribute("list", service.list(pageObject));
        model.addAttribute("pageObject", pageObject);
        return "member/adminPage";
    }

    //회원 상태, 등급 변
    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam("id") String id, 
                               @RequestParam("status") String status, 
                               @RequestParam("gradeNo") int gradeNo, 
                               RedirectAttributes rttr) {
        log.info("ID: " + id + ", Status: " + status + ", Grade No: " + gradeNo);

        try {
            service.updateStatusAndGrade(id, status, gradeNo);
            rttr.addFlashAttribute("msg", "회원 정보 변경이 성공적으로 변경되었습니다.");
        } catch (Exception e) {
            log.error("회원 상태 변경 중 오류 발생", e);
            setErrorMessage(rttr, "회원 상태 변경 중 오류가 발생했습니다. 다시 시도해 주세요.");
        }
        return "redirect:/member/adminPage.do";
    }
    
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("========= loginForm.do ============");
		return "member/loginForm";
	}
	
	// 로그인 처리
    @PostMapping("/login.do")
    public String login(LoginVO vo, HttpSession session, RedirectAttributes rttr) {
        log.info("========= login.do =============");

        LoginVO loginVO = service.login(vo);
        
        // 로그인 정보 틀렸을떄
        if (loginVO == null) {
            rttr.addFlashAttribute("msg", "로그인 정보가 맞지 않습니다. 정보를 확인하시고 다시 시도해 주세요.");
            return "redirect:/member/loginForm.do";
        }
        
        //DB 에서 로그인 하려는 아이디 상태 가져오기
        String status = loginVO.getStatus();
        log.info("회원 상태: " + status);
        
        // 로그인 아이디 상태가 휴면,탈퇴 상태 일때 로그인 못하게 하기
        String statusMsg = null;
        if ("휴면".equals(status)) {
            statusMsg = "계정이 휴면 상태입니다. 관리자에게 문의하세요.";
        } else if ("탈퇴".equals(status)) {
            statusMsg = "이미 탈퇴된 계정입니다.";
        } else if ("강퇴".equals(status)) {
            statusMsg = "강퇴된 계정으로 로그인할 수 없습니다.";
        }

        if (statusMsg != null) {
            rttr.addFlashAttribute("msg", statusMsg);
            return "redirect:/member/loginForm.do";
        }
        
        //정상 로그인 처리
        session.setAttribute("login", loginVO);
        rttr.addFlashAttribute("msg", loginVO.getName() + "님은 " + loginVO.getGradeName() + "(으)로 로그인 되었습니다.");

        return "redirect:/main/main.do";
    }
    
    //로그아웃
    @GetMapping("/logout.do")
    public String logout(HttpSession session, RedirectAttributes rttr) {
        session.removeAttribute("login");
        rttr.addFlashAttribute("msg", "로그아웃 되었습니다");
        return "redirect:/main/main.do";
    }
    
	// 회원가입 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("========= writeForm.do ============");
		return "member/writeForm";
	}
    
    //회원가입 처리
    @PostMapping("/write.do")
    public String write(MemberVO vo, RedirectAttributes rttr) {
        service.write(vo);
        rttr.addFlashAttribute("msg", "회원가입 되었습니다.");
        return "redirect:/main/main.do";
    }
    
    
    // 내정보 수정 폼
    @GetMapping("/updateForm.do")
    public String updateForm(LoginVO vo, HttpSession session, Model model) {
    	log.info("========= updateForm.do ============");
    	
    	   // 세션에서 로그인 정보를 가져옵니다.
        LoginVO login = (LoginVO) session.getAttribute("login");
        
        MemberVO memberVO = new MemberVO();
        
      //회원 정보 보기(페이지 따로 없음)
        memberVO = service.view(login.getId());
        
        model.addAttribute("memberVO",memberVO );
        

    	return "member/updateForm";
    }
    
    
    @PostMapping("/update.do")
    public String update(@RequestParam(value = "profileImage", required = false) MultipartFile file,
                         @RequestParam("existingPhoto") String existingPhoto,
                         MemberVO vo, HttpSession session, RedirectAttributes rttr) {
        log.info("========= update.do ============");

        LoginVO login = getSessionLogin(session);

        if (file != null && !file.isEmpty()) {
            try {
                String uploadDir = session.getServletContext().getRealPath(UPLOAD_DIR);
                File directory = new File(uploadDir);
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                String fileName = login.getId() + "_" + UUID.randomUUID() + "_" + file.getOriginalFilename();
                File newFile = new File(uploadDir + fileName);

                file.transferTo(newFile);
                vo.setPhoto(UPLOAD_DIR + fileName);

            } catch (IOException e) {
                log.error("프로필 사진 업로드 중 오류 발생", e);
                setErrorMessage(rttr, "프로필 사진 업데이트 중 오류가 발생했습니다.");
                return "redirect:/member/updateForm.do";
            }
        } else {
            // 새 파일이 없으면 기존 사진 유지
            vo.setPhoto(existingPhoto);
        }

        vo.setId(login.getId());
        try {
            service.update(vo);
            login.setPhoto(vo.getPhoto());
            session.setAttribute("login", login);
            rttr.addFlashAttribute("msg", "회원정보 수정이 완료되었습니다.");
        } catch (Exception e) {
            log.error("회원정보 업데이트 중 오류 발생", e);
            setErrorMessage(rttr, "회원정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "redirect:/member/updateForm.do";
        }

        return "redirect:/member/updateForm.do";
    }
}
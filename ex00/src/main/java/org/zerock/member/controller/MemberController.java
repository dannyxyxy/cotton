package org.zerock.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("========= loginForm.do ============");
		return "member/loginForm";
	}
	
	// 로그인 처리
	@PostMapping("/login.do")
	public String login(LoginVO vo,
			HttpSession session, RedirectAttributes rttr) {
		log.info("========= login.do =============");
		
		// DB에서 로그인 정보를 가져옵니다. - id, pw를 넘겨서
		LoginVO loginVO = service.login(vo);
		
		if (loginVO == null) {
			rttr.addFlashAttribute("msg",
				"로그인 정보가 맞지 않습니다. 정보를 확인하시고 다시 시도해 주세요");
			
			return "redirect:/member/loginForm.do";
		}
		
		// 로그인 정보를 찾았을때
		session.setAttribute("login", loginVO);
		rttr.addFlashAttribute("msg",
			loginVO.getName() + "님은 " + 
			loginVO.getGradeName() + "(으)로 로그인 되었습니다.");
		
		
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("========== logout.do ==========");
			
		session.removeAttribute("login");
		
		rttr.addFlashAttribute("msg","로그아웃 되었습니다");
		
		
		return "redirect:/main/main.do";
	}
	 	
	// 회원가입 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("========= writeForm.do ============");
		return "member/writeForm";
	}

	// 회원가입 처리
	@PostMapping("/write.do")
	public String write(MemberVO vo,
			HttpSession session, RedirectAttributes rttr) {
		log.info("========= write.do =============");
		
		service.write(vo);
		
		rttr.addFlashAttribute("msg", "회원가입 되었습니다.");
		
		return "redirect:/main/main.do";
	}
	
	/////////////////////////////// 이하 테스트 코드 ////////////////////////////////////
	
    
    
    // 회원정보 수정 폼
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
    public String update(@RequestParam(value = "profileImage") MultipartFile file,
                         MemberVO vo, HttpSession session, RedirectAttributes rttr) {
        log.info("========= update.do ============");

        // 로그인된 사용자 정보 가져오기
        LoginVO login = (LoginVO) session.getAttribute("login");

        // 이미지 파일 처리
        if (file != null && !file.isEmpty()) {
        	log.info("file != null");
            try {
                String uploadDir = session.getServletContext().getRealPath("/upload/member/");
                File directory = new File(uploadDir);
                if (!directory.exists()) {
                    directory.mkdirs(); // 디렉터리 생성
                }

                String fileName = login.getId() + "_" + UUID.randomUUID() + "_" + file.getOriginalFilename();
                File newFile = new File(uploadDir + fileName);

                // 파일 저장
                file.transferTo(newFile);

                // 파일 경로 설정
                String imagePath = "/upload/member/" + fileName;
                vo.setPhoto(imagePath); // MemberVO에 사진 경로 설정

            } catch (IOException e) {
                log.error("프로필 사진 업로드 중 오류 발생", e);
                rttr.addFlashAttribute("errorMessage", "프로필 사진 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.");
                return "redirect:/member/updateForm.do";
            }
        } else {
        	log.info("file == null");
            MemberVO existingMember = service.view(login.getId());
            if (existingMember != null) {
            	log.info(existingMember.getPhoto());
                vo.setPhoto(existingMember.getPhoto());
            }
        }

        // 회원정보 업데이트
        vo.setId(login.getId());
        log.info(vo);
        try {
            service.update(vo);
        } catch (Exception e) {
            log.error("회원정보 업데이트 중 오류 발생", e);
            rttr.addFlashAttribute("errorMessage", "회원정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "redirect:/member/updateForm.do";
        }

        // 세션에 업데이트된 사용자 정보를 다시 저장합니다.
        login.setPhoto(vo.getPhoto()); // 세션에 있는 로그인 객체의 사진 경로도 업데이트
        session.setAttribute("login", login);

        rttr.addFlashAttribute("msg", "회원정보 수정이 완료되었습니다.");
        return "redirect:/member/updateForm.do";
    }

   
}

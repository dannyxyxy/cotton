package org.zerock.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.zerock.member.vo.LoginVO;
import org.zerock.qna.service.QnAService;
import org.zerock.qna.vo.QnAVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qna")
@Log4j
public class QnAController {

    @Autowired
    @Qualifier("qnaServiceImpl") // 소문자로 된 빈 이름 지정
    private QnAService service;

    // 1. QnA 게시판 리스트
    @GetMapping("/list.do")
    public String list(Model model, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        PageObject pageObject = PageObject.getInstance(request);
        if (request.getParameter("perPageNum") == null) {
            pageObject.setPerPageNum(3);
        } else {
            pageObject.setPerPageNum(Integer.parseInt(request.getParameter("perPageNum")));
        }

        if (request.getParameter("page") != null) {
            pageObject.setPage(Integer.parseInt(request.getParameter("page")));
        }

        String userId = login.getId();
        int gradeNo = login.getGradeNo();

        List<QnAVO> qnaList = service.list(userId, gradeNo, pageObject);
        model.addAttribute("userId", userId);
        model.addAttribute("list", qnaList);
        model.addAttribute("pageObject", pageObject);
        return "qna/list";
    }

    // 2. QnA 게시판 보기
    @GetMapping("/view.do")
    public String view(Model model, HttpSession session, Long no, RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        String userId = login.getId();
        model.addAttribute("gradeNo", login.getGradeNo());
        model.addAttribute("userId", userId);
        model.addAttribute("vo", service.view(no));
        return "qna/view";
    }

    // 3. QnA 게시판 글 등록
    @GetMapping("/writeForm.do")
    public String writeForm(HttpSession session, RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }
        return "qna/writeForm";
    }

    @PostMapping("/write.do")
    public String write(QnAVO vo, MultipartFile imageFile, HttpSession session, HttpServletRequest request,
                        RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        vo.setId(login.getId());
        String path = "/upload/qna";

        try {
            if (imageFile != null && !imageFile.isEmpty()) {
                vo.setQna_image_name("/upload/qna/" + imageFile.getOriginalFilename());
            }

            service.write(vo);
            rttr.addFlashAttribute("msg", "문의가 정상 등록되었습니다.");
        } catch (Exception e) {
            log.error("QnA 작성 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "QnA 등록 중 오류가 발생했습니다.");
        }

        return "redirect:list.do";
    }

    // 4. QnA 게시판 글 수정
    @GetMapping("/updateForm.do")
    public String updateForm(Long no, Model model, HttpSession session, RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        QnAVO vo = service.view(no);
        model.addAttribute("vo", vo);
        return "qna/updateForm";
    }

    @PostMapping("/update.do")
    public String update(QnAVO vo, 
                         @RequestParam(value = "imageFile", required = false) MultipartFile imageFile, 
                         HttpServletRequest request, 
                         HttpSession session, 
                         RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        try {
            service.update(vo, imageFile, request); // 모든 로직은 서비스에서 처리
            rttr.addFlashAttribute("msg", "문의 글이 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            log.error("QnA 수정 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "문의 글 수정 중 오류가 발생했습니다.");
            return "redirect:/qna/updateForm.do?no=" + vo.getNo();
        }

        return "redirect:/qna/view.do?no=" + vo.getNo();
    }


    // QnA 글 답변
    @PostMapping("/updateReply.do")
    public String updateReply(QnAVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        service.updateReply(vo);
        rttr.addFlashAttribute("msg", "답변이 정상적으로 등록되었습니다.");
        return "redirect:/qna/view.do?no=" + vo.getNo();
    }

    // QnA 글 삭제
    @GetMapping("/delete.do")
    public String deletePost(@RequestParam("no") Long no, HttpSession session, RedirectAttributes rttr) {
        LoginVO login = (LoginVO) session.getAttribute("login");
        if (login == null) {
            rttr.addFlashAttribute("msg", "로그인이 필요한 페이지입니다.");
            return "redirect:/member/loginForm.do";
        }

        try {
            service.delete(no);
            rttr.addFlashAttribute("msg", "문의 글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            log.error("QnA 삭제 중 오류 발생: ", e);
            rttr.addFlashAttribute("msg", "문의 글 삭제 중 오류가 발생했습니다.");
        }

        return "redirect:/qna/list.do";
    }
}

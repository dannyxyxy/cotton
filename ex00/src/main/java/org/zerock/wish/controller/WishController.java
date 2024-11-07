package org.zerock.wish.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.vo.LoginVO;
import org.zerock.wish.service.WishService;
import org.zerock.wish.vo.WishVO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/wish")
public class WishController {

    @Autowired
    @Qualifier("wishServiceImpl")
    private WishService service;
    
    // 로그인된 사용자의 위시리스트를 가져오는 메서드
    @GetMapping("/list")
    public String getWishList(@RequestParam("id") String userId, Model model) {
        List<WishVO> wishList = service.getWishList(userId);
        model.addAttribute("wishList", wishList);
        return "wishList"; // wishList.jsp로 전달
    }

    // 위시리스트에 상품을 추가하는 메서드
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addWishItem(HttpSession session, 
                                          @RequestParam("goods_no") Long goodsNo, 
                                          @RequestParam("userId") String userId) {
        // 로그인 정보 확인
        LoginVO loginVO = (LoginVO) session.getAttribute("login");

        // 로그인되지 않은 상태일 경우
        if (loginVO == null || !loginVO.getId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                                 .body(Map.of("success", false, "message", "로그인된 사용자만 위시리스트에 상품을 추가할 수 있습니다."));
        }

        // 위시리스트에 상품 추가
        boolean result = service.addWishItem(goodsNo, userId);

        // 결과 반환
        if (result) {
            return ResponseEntity.ok(Map.of("success", true, "message", "위시리스트에 상품이 추가되었습니다."));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("success", false, "message", "상품 추가에 실패했습니다."));
        }
    }

    // 위시리스트에서 상품을 제거하는 메서드
    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<?> removeFromWishlist(@RequestParam("goods_no") Long goodsNo, @RequestParam("userId") String userId) {
        boolean result = service.removeWishItem(goodsNo, userId);
        if (result) {
            return ResponseEntity.ok(Map.of("success", true));
        } else {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }
}

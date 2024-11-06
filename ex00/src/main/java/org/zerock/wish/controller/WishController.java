package org.zerock.wish.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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

    // 위시리스트 조회
    @GetMapping("/list.do")
    public String getWishList(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("loginId"); // 로그인된 ID 가져오기
        if (userId == null) {
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }
        List<WishVO> wishList = service.getWishListByUserId(userId);
        model.addAttribute("wishList", wishList);
        return "wish/list";
    }

    // 위시리스트에 항목 추가
    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> addWishItem(@RequestBody Map<String, Object> params) {
        String userId = (String) params.get("id");
        Long goodsNo = Long.parseLong(params.get("goods_no").toString());

        service.addWishItem(userId, goodsNo);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return result;
    }

    // 위시리스트 항목 삭제
    @PostMapping("/delete/{wish_no}")
    public String deleteWishItem(@PathVariable Long wish_no) {
        service.deleteWishItem(wish_no);
        return "redirect:/wish/list.do";
    }
}

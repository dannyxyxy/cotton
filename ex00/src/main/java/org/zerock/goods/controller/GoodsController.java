package org.zerock.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.file.FileUtil;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/goods")
public class GoodsController {
	
	//파일이저장될 경로
	String path="/upload/goods";
	
	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService service;
	
	@GetMapping("/list.do")
	public String List(Model model, @ModelAttribute(name = "goodsSearchVO") GoodsSearchVO goodsSearchVO,
	                   HttpServletRequest request) {
	    PageObject pageObject = PageObject.getInstance(request);
	    String perPageNum = request.getParameter("perPageNum");
	    String cateCode1 = request.getParameter("cate_code1"); // String으로 받기
	    log.info(perPageNum);
	    
	    if (perPageNum == null) {
	        pageObject.setPerPageNum(8);
	    } else {
	        pageObject.setPerPageNum(Integer.parseInt(perPageNum));
	    }

	    // cate_code1 값을 request에서 가져와서 Integer로 변환하여 goodsSearchVO에 설정
	    if (cateCode1 != null) {
	        try {
	            Integer parsedCateCode1 = Integer.parseInt(cateCode1);
	            goodsSearchVO.setCate_code1(parsedCateCode1); // GoodsSearchVO에 Integer로 설정
	        } catch (NumberFormatException e) {
	            log.warn("Invalid cate_code1 value: " + cateCode1);
	            goodsSearchVO.setCate_code1(null); // or any default value
	        }
	    }

	    // 카테고리 조회
	    List<CategoryVO> listBig = service.listCategory(0);
	    model.addAttribute("listBig", listBig);
	    
	    // 상품 목록 조회
	    List<GoodsVO> list = service.list(pageObject, goodsSearchVO);
	    model.addAttribute("list", list);
	    model.addAttribute("pageObject", pageObject);
	    model.addAttribute("cate_code1", cateCode1);

	    return "goods/list";
	}





	
	@GetMapping("/view.do")
	public String view(Long goods_no, PageObject pageObject,
			@ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO, Model model) {
		
		model.addAttribute("vo",service.view(goods_no));
		model.addAttribute("imageList",service.imageList(goods_no));
		return "goods/view";
	}
	
	@GetMapping("/writeForm.do")
	public String writeForm(Model model) {
		
		java.util.List<CategoryVO> listBig = new ArrayList<CategoryVO>();
		java.util.List<CategoryVO> listMid = new ArrayList<CategoryVO>();
		listBig = service.listCategory(0);
		listMid = service.listCategory(listBig.get(0).getCate_code1());
		model.addAttribute("listBig",listBig);
		model.addAttribute("listMid",listMid);
		
		return "goods/writeForm";
	}
	
	
	@PostMapping("/write.do")
	public String write(GoodsVO vo, MultipartFile imageMain, @RequestParam("imageFiles")
	ArrayList<MultipartFile> imageFiles, HttpServletRequest request ,RedirectAttributes rttr) throws Exception {
		log.info("================== write.do ==================");
		log.info(vo);
		log.info(imageMain.getOriginalFilename());
		for(MultipartFile file : imageFiles) {
			log.info(file.getOriginalFilename());
		}
		vo.setImage_name(FileUtil.upload(path, imageMain, request));
		
		List<String> imageFileNames = new ArrayList<String>();
		for(MultipartFile file : imageFiles) {
			imageFileNames.add(FileUtil.upload(path, file, request));
		}
		//vo.setSale_price(vo.sale_price());
		Integer result = service.write(vo, imageFileNames);
		rttr.addFlashAttribute("msg","상품이 정상등록되었습니다.");
		
		return "redirect:list.do?cate_code1="+ vo.getCate_code1();
	}
	
	// 상품 수정 폼
		@GetMapping("/updateForm.do")
		public String updateForm(
				Long goods_no,
				@ModelAttribute(name="pageObject") PageObject pageObject,
				// @ModelAttribute()를 선언하면 선언된 객체를 model에 담는다. -> JSP전달
				@ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO,
				Model model
				) {
			List<CategoryVO> listBig = new ArrayList<CategoryVO>();
			List<CategoryVO> listMid = new ArrayList<CategoryVO>();
			
			listBig = service.listCategory(0);
			// 대분류 첫번째에 있는 중분류를 가져온다.
			listMid = service.listCategory(listBig.get(0).getCate_code1());
			
			// 상품의 상세정보 가져오기 (상품정보 + 가격정보)
			model.addAttribute("goodsVO", service.view(goods_no));
			// 추가 이미지 정보 리스트
			model.addAttribute("imageList", service.imageList(goods_no));
			model.addAttribute("listBig", listBig);
			model.addAttribute("listMid", listMid);
			
			return "goods/updateForm";
		}
	
		// 상품 수정 처리
		@PostMapping("/update.do")
		public String update(
				@ModelAttribute(name = "goodsVO") GoodsVO goodsVO,
				PageObject pageObject,
			//	@ModelAttribute(name = "goodsSearchVO") GoodsSearchVO goodsSearchVO,
				RedirectAttributes rttr) throws Exception {
			
			log.info("update.do===========");
			// 상품 상세 정보 수정
			log.info(goodsVO);
			//log.info(goodsSearchVO);
			
			service.update(goodsVO);
		
		
			
			return "redirect:view.do?goods_no=" + goodsVO.getGoods_no() +
					"&" + pageObject.getPageQuery();
			
		}
//		@PostMapping("/updateImage.do")
//		public String updateImage(@RequestParam("imageFile") MultipartFile imageFile,
//		                          @RequestParam("goods_no") Long goods_no, HttpServletRequest request,
//		                          @RequestParam("deleteFileName") String deleteFileName,
//		                          RedirectAttributes redirectAttributes) throws Exception {
//		    // 업로드 기본 설정
//		    String savePath = "/upload";  // 실제 경로에 맞게 설정
//		    String realSavePath = request.getServletContext().getRealPath(savePath);
//
//		    // 기존 파일 삭제 및 신규 파일 저장 처리
//		    String newFileName = service.updateImage(goods_no, imageFile, realSavePath, deleteFileName);
//
//		    // 메시지 설정
//		    redirectAttributes.addFlashAttribute("msg", "이미지 바꾸기가 성공했습니다.");
//		    return "redirect:/goods/view?no=" + goods_no;  // 리다이렉트 경로 설정
//		}
//		
//		// 이미지 삭제 처리
//		@PostMapping("/deleteImage.do")
//		public String deleteImage(GoodsVO goodsVO) {
//			return "redirect:update.do?goods_no="+goodsVO.getGoods_no();
//		}

	
	
}

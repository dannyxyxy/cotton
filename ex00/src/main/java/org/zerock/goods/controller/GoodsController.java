package org.zerock.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public String List(Model model,@ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO,
			HttpServletRequest request) {
		
		PageObject pageObject = PageObject.getInstance(request);
		String perPageNum = request.getParameter("perPageNum");
		log.info(perPageNum);
		if(perPageNum==null) {
			pageObject.setPerPageNum(8);
		} else {
			pageObject.setPerPageNum(Integer.parseInt(perPageNum));
		}
		java.util.List<CategoryVO> listBig = new ArrayList<CategoryVO>();
		listBig = service.listCategory(0);
		model.addAttribute("listBig",listBig);
		
		if(goodsSearchVO.getCate_code1()!=null && goodsSearchVO.getCate_code1()!=0) {
			List<CategoryVO> listMid = new ArrayList<CategoryVO>();
			listMid = service.listCategory(goodsSearchVO.getCate_code1());
			model.addAttribute("listMid",listMid);
		}
		
		java.util.List<GoodsVO> list = new ArrayList<GoodsVO>();
		list=service.list(pageObject, goodsSearchVO);
		model.addAttribute("list",list);
		model.addAttribute("pageObject",pageObject);
		
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
		
		return "goods/write";
	}
	// 중분류 가져오기
	@GetMapping(value = "/getCategory.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<CategoryVO>> getCategory(@RequestParam Integer cate_code1) {
	    if (cate_code1 == null) {
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    
	    List<CategoryVO> listMid = service.listCategory(cate_code1);
	    
	    if (listMid == null || listMid.isEmpty()) {
	        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	    }
	    
	    return new ResponseEntity<>(listMid, HttpStatus.OK);
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
		vo.setSale_price(vo.sale_price());
		Integer result = service.write(vo, imageFileNames);
		rttr.addFlashAttribute("msg","상품이 정상등록되었습니다.");
		
		return "redirect:list.do";
	}
	
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long goods_no, PageObject pageObject,
			@ModelAttribute(name="goodsSearchVO") GoodsSearchVO goodsSearchVO) {
		
		java.util.List<CategoryVO> listBig = new ArrayList<CategoryVO>();
		java.util.List<CategoryVO> listMid = new ArrayList<CategoryVO>();
		listBig = service.listCategory(0);
		listMid = service.listCategory(listBig.get(0).getCate_code1());
		model.addAttribute("vo",service.view(goods_no));
		model.addAttribute("imageList",service.imageList(goods_no));
		model.addAttribute("listBig",listBig);
		model.addAttribute("listMid",listMid);
		
		return "goods/update";
	}
	
	@PostMapping("/update.do")
	public String update(GoodsVO vo, GoodsSearchVO goodsSearchVO, PageObject pageObject, RedirectAttributes rttr) {
		service.update(vo);
		return "redirect:view.do?goods_no=";
	}
	@PostMapping("/updateImage.do")
	public String updateImage(GoodsImageVO imageVO) {
		
		return "redirect:update.do";
	}
	@PostMapping("/deleteImage.do")
	public String deleteImage(GoodsImageVO imageVO) {
		
		return "redirect:update.do";
	}
	
	
}

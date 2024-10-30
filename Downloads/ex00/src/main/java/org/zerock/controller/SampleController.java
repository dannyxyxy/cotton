package org.zerock.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.vo.SampleVO;
import org.zerock.vo.SampleVOList;
import org.zerock.vo.TodoVO;

import lombok.extern.log4j.Log4j;



@Controller
//Servlet-context.xml에 base-package가 정의되어있는지 꼭 확인 
@RequestMapping("/sample/*")
@Log4j
public class SampleController { 
	
	// return이 없을시 (void) 들어온 uri 이름으로 생성된다.
	// return이 String 일때
	//1. redirect:가 앞에 있으면 지정한 페이지로 돌아간다.
	//2. redirect:없으면 forward 시킨다. --> 화면에 원래 데이터를 보여준다 
	@RequestMapping("/")
	public void basic() {	
		log.info("-----basic-----");
	}
	
	//URI mapping에 GET, POST를 허용하는 메서드 
	//Default = GET 메서드가 하나만 있을 떄는 {} 생략가능 
	@RequestMapping(value="/basic",method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("-----basic Get or POST-----");
	}
	
	//GET 방식 mapping annotation
	@GetMapping("basicGetOnly")
	public void basicGetOnly() {
		log.info("-----basicGetOnly-----");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleVO vo) {
		log.info("----- get VO : " + vo);
		return "ex01";
		
	}
	@GetMapping("/ex02")
	// @RequestParam(defultValue="") --> 들어온 값이 null 일 때 값을 지정해서 임의로 지정
	public String ex02(String name, 
			@RequestParam(name = "age2", defaultValue = "0") int age) {
		
		log.info("get name = " + name + ",age = " +age);
		return "ex02";
	}

	@GetMapping("/ex03")
	// @RequestParam(defultValue="") --> 들어온 값이 null 일 때 값을 지정해서 임의로 지정
	// defualtValue = 반드시 String 으로 쓰기 
	public String ex03(String name, 
			@RequestParam(name = "age2", defaultValue = "0") int age) {
		
		log.info("get name = " + name + ",age = " +age);
		return "ex03";
	}
	
	@GetMapping("/ex04List")
	//list 타입의 변수는 @RequwtsParam 으로 name 을 정의해 주어야합니다.
	public String ex04List(@RequestParam("ids") ArrayList<String> ids) {
		
		log.info("ex04List:" + ids);
		return "ex04List";
	}
	
	@GetMapping("/ex05Array")
	//String[] 은 @RequestParam이 없으면 name이 같은 곳으로 자동으로 저장된다. 
	public String ex05Array(String[] ids) {
		
		log.info("ex05Array:" + Arrays.toString(ids));
		return "ex05Array";
	}

	@GetMapping("/ex06Bean")
	//b
	public String ex06Bean(SampleVOList list) {
		
		log.info("ex06Bean:" + list);
		return "ex06Bean";
	}
	
	@InitBinder
	// 들어오는 데이터를 변환하고자 할때 사용하는 annotation (주로 날짜 사용)
	// 방법1. InitBinder 로 구현
	// 방법2. @DateTimeFormat(pattern= "yyyy-MM-dd")
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false)); 
	}
	
	@GetMapping("/ex07")
	public String ex07(TodoVO vo) {
		
		log.info("ex07 : TodoVO :" + vo);
		return "ex07"; 
	}
	
	@GetMapping("/ex08")
	public String ex08(SampleVO vo, 
			@ModelAttribute("page") int page) {
		
		log.info("vo :" + vo);
		log.info("page :" + page);
		return "/sample/ex08"; 
	}
	
	@GetMapping("/ex09")
	public @ResponseBody SampleVO ex09() {
		SampleVO vo = new SampleVO();
		vo.setName("홍길동");
		vo.setAge(30);
		
		return vo; 
	}

	//ResponseEntity 타입 
	@GetMapping("/ex10")
	public ResponseEntity<String> ex10() {
		log.info("----------ex10----------");
		
		String msg = "{\"name\":\"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type","application/json;charset=UTF-8");
		
		return new ResponseEntity< >(msg, header, HttpStatus.OK);
	}
	
	//get 방식 - 파일 올리기 폼
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("-----exUpload-----");
		//void 타입은 들어오는 경로로 따라 들어간다
		// /WEB_INF/views/ + sample/exUpload + .jsp
		
		
	}
	
	//Post 방식 - 파일 올리기 처리 (저장 X)
	@PostMapping("/exUploadPost") 
	public void exUploadPost(ArrayList<MultipartFile> files) {
		log.info("-----exUploadPost-----");
		
		for(MultipartFile file: files) {
			log.info("--------------------");
			log.info("name: "+ file.getOriginalFilename());
			log.info("size: "+ file.getSize());
		}

	}
	@GetMapping("/ex11")
	public void ex11() {
		log.info("-----ex11-----");
		int num = 10/0;
	}

	
	
	
	
}

package org.zerock.controller;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;


@RestController // URL 관련된  annotation -> 기본 return이 @ResponseBody이므로 생략한다
@RequestMapping("/sampleRest") //주소값 mapping
@Log4j //로그 출력 annotation
public class SmapleRestController {
// 객체를 JSON, xml 변환하기위한 라이브러리
//jackson-databind(JASON), jackson-dataformat-xml(XML)
//추가로 gson : java 인스턴스를 JASON으로 변환하기 위한 라이브러리  
	
	@GetMapping(value = "/getText", produces = "text/plane; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
//vo 객체를 json과 xml 데이터로 처리 (제공)
	
	
	

}

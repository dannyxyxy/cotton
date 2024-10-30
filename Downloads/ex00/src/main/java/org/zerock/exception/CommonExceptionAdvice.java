package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;



@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	//500 에러
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("Exception...." + ex.getMessage());
		
		//JSP로 ex 전달
		model.addAttribute("exception", ex);
		log.info(model);
		
		//WEB_INF/views/+ error_page + JSP
		return "error/error_page";
		
	}
	
	//404 에러
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		log.error("Exception..... "+ ex.getMessage());
		return  "error/custom404";
	}
}

//web.xml 에 만든 404 error는 
//매핑된 후 JSP 파일로 구햔되어있지 않은 것에 대해 404 error를 주는 페이지 입니다.







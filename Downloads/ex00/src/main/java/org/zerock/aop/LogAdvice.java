package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
@Aspect // AOP 프로그램 으로 지정하는 annotation
public class LogAdvice {
	
	// execute() 
	// ProceedingJoinPoint -> 실행객체 + 넘어가는 데이터
	// 실행 객체: ~~~~ServiceImpl
	// 넘어가는 데이터: (parameter - no, pageObject, VO.....)
	@Around("execution(* org.zerock.*.service.*ServiceImpl.*(..))")  //-> 실행 객체 양쪽에 표시 * : 모든 값을 수용한다
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {  // Throwable -> error, exception 의 상위 클래스
		
		//결과 저장 변수
		Object result = null;
		
		// 시작 시간
		long start = System.currentTimeMillis(); // 단위 : milliseconds
		
		log.info("***************실행전 로그 출력****************");

		
		// 실행 되는 객체의 이름 출력
		log.info("++ 실행객체 : "+ pjp.getTarget());  //getTarget -> 객체 이름 보여주는 함수
		
		
		// 실행 되는 메서드 이름 출력
		log.info("++ 실행메서드 : "+ pjp.getSignature());  //getSignature -> 실행 메서드 불러오는 함수
		
		// 전달 되는 Parameter 출력
		log.info("++ 전달되는 데이터 : "+ Arrays.toString(pjp.getArgs()));  //pjp.getArgs -> 배열로 parameter 가져옴
		
		// 실행 되는 부분
		result = pjp.proceed();
		
		// 실행 결과 출력
		log.info("++ 결과 데이터: "+ result);
		
		// 시작 시간
		long end = System.currentTimeMillis(); // 단위 : milliseconds
		
		// 실행한 시간 출력
		log.info("++ 소요시간: "+ (end-start) + "msec");
		
		log.info("***************실행후 로그 출력****************");
		
		return result;
	}
	
	
}

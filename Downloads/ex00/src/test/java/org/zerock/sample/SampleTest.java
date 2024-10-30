package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//test 에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class) 

// 설정 파일 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

//LomBok 에서 Long 이름으로 처리
@Log4j
public class SampleTest {

	@Setter(onMethod_ = @Autowired)  //@ 두개 이상일 떄는 중괄호 안에 ,로 구분하여 사용
	private Restaurent restaurent;
	
	//JUnit 에서 테스트 한다는 뜻  > @Test < 붙은 것만 테스트 진행, 여러개 사용가능
	@Test
	public void testExist() {
		//not null 확인 객체
		//null 이면 예외 발생시키고테스트 중단 됨
		assertNotNull(restaurent);
		
		// 출력해서 확인
		//log4j.xml 파일 설정에 
		// log.info() -> 모두 출력
		// log.warn() -> warn error 만 출력 
		// log.error() -> error 만 출력
		log.info("---------------------------");
		log.info(restaurent);
		log.info(restaurent.getChef());
		
	}
	
	

}

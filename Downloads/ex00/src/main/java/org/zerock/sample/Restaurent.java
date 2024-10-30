package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

// @Controller @Service @Repository @Component @RestController @~~~Advice

@Component
@Data

public class Restaurent {
	
	// 자동 DI
	// LomBok & spring : @Stter(onMethod = @Autowired)
	// spring : @Autowired
	// JAVA : @Inject
	@Setter(onMethod_ = @Autowired)
	private Chef chef;

}

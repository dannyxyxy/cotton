package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
	
	
	//TimemMapper.xml 과 연결돠어있다
	//org.zerock.mapper.TimeMapper.xml -> resources 에 만든다
	public String getTime2();
	
	
	
	
}

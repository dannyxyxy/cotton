package org.zerock.member.vo;

import lombok.Data;

@Data
public class LoginVO {
	
	//member Table
	private String id;
	private String pw;
	private String name;
	private String photo;
	private Long newMsgCnt ;
	
	//grade Table
	private Integer gradeNo ;
	private String gradeName;

}

package org.zerock.boardreply.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardReplyVO {
	
	private Long rno; //댓글 번호
	private Long no; //글 번호
	private String content; //댓글 내용
	private String id; // 작성자 아이디
	private String name; // 작성자 이름
	private Date writeDate; //댓글 작성일
}

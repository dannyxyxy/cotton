package org.zerock.member.mapper;

import org.springframework.stereotype.Repository;
import org.zerock.member.vo.LoginVO;

import org.zerock.member.vo.MemberVO;

@Repository
public interface MemberMapper {
	
	//login
	public LoginVO login(LoginVO vo);
	
	// checkId (아이디 중복확인)
	public String checkId(String id);

	// write (회원가입)
	public Integer write(MemberVO vo);
	
	//회원 정보 보기(페이지 따로 없음)
	public MemberVO view(String id);

	// update(회원 정보 수정)
	public Integer update(MemberVO vo);



	

}

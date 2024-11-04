package org.zerock.member.service;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;

public interface MemberService {
	
	//로그인
	public LoginVO login(LoginVO vo);
	
	//아이디 중복확인
	public String checkID(String id);

	//회원가입
	public Integer write(MemberVO vo);
	
	//회원 정보 보기(페이지 따로 없음)
	public MemberVO view(String id);
	
	//회원정보 수정
	public Integer update(MemberVO vo);



}

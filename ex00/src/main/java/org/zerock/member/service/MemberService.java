package org.zerock.member.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import org.zerock.notice.vo.NoticeVO;
import org.zerock.util.page.PageObject;

public interface MemberService {
	
	//로그인
	public LoginVO login(LoginVO vo);
	
	//아이디 중복확인
	public String checkID(String id);

	//회원가입
	public Integer write(MemberVO vo);
	
	//회원 정보 보기(페이지 따로 없음)
	public MemberVO view(String id);
	
	//내정보 수정
	public Integer update(MemberVO vo);

	//회원 목록
	public List<MemberVO> list(PageObject pageObject);

	//회원 상태 및 등급 수정
	public void updateStatusAndGrade(String id, String status, int gradeNo) throws Exception;





}

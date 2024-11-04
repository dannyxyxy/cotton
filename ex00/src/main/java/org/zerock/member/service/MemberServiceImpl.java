package org.zerock.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.LoginVO;

import org.zerock.member.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private  MemberMapper mapper;
	
	//로그인
	@Override
	public LoginVO login(LoginVO vo) {	
		return mapper.login(vo);
	}

	//회원가입
	@Override
	public Integer write(MemberVO vo) {		
		return mapper.write(vo);
	}

	
	//아아디 중복체크
	@Override
	public String checkID(String id) {
		return mapper.checkId(id);
	}

	//회원 정보 보기(페이지 따로 없음)
	@Override
	public MemberVO view(String id) {		
		return mapper.view(id);
	}

	//회원정보수정
	@Override
	public Integer update(MemberVO vo) {
	    return mapper.update(vo);
	}
	





}

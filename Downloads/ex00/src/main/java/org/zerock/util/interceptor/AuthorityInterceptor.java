package org.zerock.util.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zerock.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthorityInterceptor extends HandlerInterceptorAdapter {
	
	//권한 정보 들어있는 Map<uri, 등급정보>
	private Map<String, Integer> authMap = new HashMap<String, Integer>();
	
	//권한 정보를 등록하는 초기화 블록
	{
		//등급 1: 로그인 필요 9: 로그인, 관리자 권한	
		//댓글
		authMap.put("/boardreply/wirte.do", 1);
		authMap.put("/boardreply/update.do", 1);
		authMap.put("/boardreply/delete.do", 1);
		
		//화원 관리
		authMap.put("/member/logout.do", 1);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		//권한 처리 진행
		log.info("========== interceptor ==========");
		
		//사용자 권한(등급번호: login<session>), 페이지 권한(AuthMap)
		// 페이지 권한
		String uri = request.getRequestURI();
		Integer pageGrade = authMap.get(uri);
		
		//로그인함
		if(pageGrade != null) {
			HttpSession session = request.getSession();
			LoginVO vo = (LoginVO) session.getAttribute("login");
			
			// 로그인 안함 - 권한 오류 JSP로 이동
			if(vo == null) {
				request.getRequestDispatcher("/WEB-INF/views/error//loginError.jsp").forward(request, response);
				
				return false;
			}
			
			// 로그인 함 - 페이지 권한 확인
			Integer userGrade = vo.getGradeNo();
			
			if(pageGrade > userGrade) {
				request.getRequestDispatcher("/WEB-INF/views/error//authError.jsp").forward(request, response);
				
				return false;
			}
		}
		
		return super.preHandle(request, response, handler);
	
	
}

	}

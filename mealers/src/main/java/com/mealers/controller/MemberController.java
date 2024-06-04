package com.mealers.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.MemberDAO;
import com.mealers.domain.MemberDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@RequestMapping(value = "/member/login", method = RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 로그인 처리
		// 세션객체. 세션 정보는 서버에 저장(로그인 정보, 권한등을 저장)
		HttpSession session = req.getSession();

		MemberDAO dao = new MemberDAO();

		String memberId = req.getParameter("memberId");
		String memberPwd = req.getParameter("memberPwd");

		MemberDTO dto = dao.loginMember(memberId, memberPwd);
		if (dto != null) {
			
			session.setMaxInactiveInterval(20 * 60);

			//세션에 ID와 닉네임, userNum 을 담아줌
			SessionInfo info = new SessionInfo();
			info.setUserId(dto.getMemberId());
			info.setUserName(dto.getMem_Nick());
			info.setUserNum(dto.getUserNum());

			//세션에 member이라는 이름으로 저장
			session.setAttribute("member", info);

			//메인화면으로 리다이렉트
			return new ModelAndView("redirect:/");
		}

		// 로그인 실패인 경우(다시 로그인 폼으로)
		ModelAndView mav = new ModelAndView("member/login");

		String msg = "아이디 또는 패스워드가 일치하지 않습니다.";
		mav.addObject("message", msg);

		return mav;
	}

	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();

		return new ModelAndView("redirect:/");
	}
	
	
	@RequestMapping(value="/member/member",method = RequestMethod.GET)
	public ModelAndView singupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{	
		ModelAndView mav = new ModelAndView("member/login");
		
		mav.addObject("title", "회원 가입");
		mav.addObject("mode", "member");
		
		return mav;
	}
	
	//회원가입
	@RequestMapping(value="/member/member",method = RequestMethod.POST)
	  public ModelAndView memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	      MemberDAO dao = new MemberDAO();
	        String message = "";	     

	        try {
	            MemberDTO dto = new MemberDTO();
	            dto.setMemberId(req.getParameter("memberId"));
	            dto.setMemberPwd(req.getParameter("memberPwd"));
	            dto.setMem_Nick(req.getParameter("nickname"));
	            dto.setMem_Email(req.getParameter("email"));

	            // 디버깅을 위해 로그 추가
	            System.out.println("MEMBERID: " + dto.getMemberId());
	            System.out.println("MEMBERPWD: " + dto.getMemberPwd());
	            System.out.println("MEM_NICK: " + dto.getMem_Nick());
	            System.out.println("MEM_EMAIL: " + dto.getMem_Email());

	            dao.insertMember(dto);

	            return new ModelAndView("redirect:/");

	        } catch (SQLException e) {
	            message = "회원 가입 실패";
	            e.printStackTrace();
	        }

	        ModelAndView mav = new ModelAndView("member/member");
	        mav.addObject("title", "회원 가입");
	        mav.addObject("mode", "member");
	        mav.addObject("message", message);

	        return mav;
	    }

	@ResponseBody
	@RequestMapping(value="/member/userIdCheck",method = RequestMethod.POST)
	public Map<String, Object> userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberDAO dao = new MemberDAO();
		
		String memberId = req.getParameter("memberId");
		MemberDTO dto = dao.findById(memberId);
		
		String passed = "false";
		if(dto==null) {
			passed="true";
		}
		map.put("passed", passed);
		
		return map;
		
	}
	
	@RequestMapping(value = "/member/pwd", method = RequestMethod.POST)
	public ModelAndView pwdSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// 패스워드 확인
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			// DB에서 해당 회원 정보 가져오기
			MemberDTO dto = dao.findById(info.getUserId());
			if (dto == null) {
				session.invalidate();
				return new ModelAndView("redirect:/");
			}

			String userPwd = req.getParameter("memberPwd");
			String mode = req.getParameter("mode");
	        
			if (!dto.getMemberPwd().equals(userPwd)) {
				ModelAndView mav = new ModelAndView("member/mypage");

				mav.addObject("mode", mode);
				mav.addObject("message", "패스워드가 일치하지 않습니다.");

				mav.addObject("dto", dto);

				return mav;
			}

			if (mode.equals("delete")) {
				// 회원탈퇴
				dao.deleteMember(info.getUserId());

				session.removeAttribute("member");
				session.invalidate();

				return new ModelAndView("redirect:/main");
			}

			if (mode.equals("update") || mode.equals("pwdupdate")) {

				dto.setMemberId(req.getParameter("memberId"));

				// if(mode.equals("update"))
				dto.setMemberPwd(req.getParameter("memberPwd"));
				
				if (mode.equals("pwdupdate"))
					dto.setMemberPwd(req.getParameter("confirmpassword"));

				dto.setMem_Nick(req.getParameter("mem_Nick"));
				dto.setMem_Email(req.getParameter("mem_Email"));

				dao.updateMember(dto);

				return new ModelAndView("redirect:/member/mypage");

				// dao.updateMember(dto);
			}

			// 회원정보수정 - 회원수정폼으로 이동
			/*
			 * ModelAndView mav = new ModelAndView("member/member");
			 * 
			 * mav.addObject("title", "회원 정보 수정"); mav.addObject("dto", dto);
			 * mav.addObject("mode", "update");
			 * 
			 * return mav;
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/");
	}

}

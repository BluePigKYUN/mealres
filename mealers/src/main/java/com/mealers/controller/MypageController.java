package com.mealers.controller;

import java.io.IOException;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;

import com.mealers.dao.MemberDAO;
import com.mealers.dao.MypageDAO;
import com.mealers.domain.CmntDTO;
import com.mealers.domain.MemberDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.MyUtil;
import com.mealers.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

	/*
	 * @RequestMapping(value="/member/mypage",method=RequestMethod.GET) public
	 * ModelAndView myPageForm(HttpServletRequest req, HttpServletResponse
	 * resp)throws ServletException,IOException{ ModelAndView mav = new
	 * ModelAndView("member/mypage");
	 * 
	 * return mav; }
	 */

	@RequestMapping(value = "/member/mypage", method = RequestMethod.GET)
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		MemberDTO dto = dao.findById(info.getUserId());
		
		info.setUserId(dto.getMemberId());
		info.setUserName(dto.getMem_Nick());
		info.setUserNum(dto.getUserNum());
		info.setFileName(dto.getFileName());

		ModelAndView mav = new ModelAndView("member/mypage");
		mav.addObject("dto", dto);

		return mav;
	}
	
	//마이페이지 
	@RequestMapping(value = "/member/activity", method = RequestMethod.GET)
	public ModelAndView post(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/activity");

		MypageDAO dao = new MypageDAO();
		MyUtil util = new MyUtilBootstrap();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			String page = req.getParameter("pageNo");
			String mode = req.getParameter("mode");
			
			int current_page = 1;
			if (page != null && !page.isEmpty()) {
				current_page = Integer.parseInt(page);
			}

			// 모드에 따른 총개수
			int dataCount = 0;
			if("2".equals(mode))
			{
				dataCount = dao.getTotalReply(info.getUserNum());
			}else {
				dataCount = dao.getTotalCount(info.getUserNum());
			}
			
			int size = 10;
			
			int total_page = util.pageCount(dataCount, size);
			
			int startPage = ((current_page - 1) / size * size) + 1;
			int endPage = ((current_page - 1) / size * size) + size;
			if (endPage > total_page) {
				endPage = total_page;
			}

			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			//System.out.println("offset: "+offset + "/ current_page: " + current_page + "/ size: " + size + "/ dataCount: " + dataCount);
//			offset: 0current_page: 1size: 10dataCount: 56
//			40/0/10
			
//			offset: -10current_page: 0size: 10dataCount: 0
//			40/-10/10
			
			// 모드에 따른 보여줄 리스트
			List<CmntDTO> list;
			if("2".equals(mode))
			{
				list = dao.listReply(offset, size, info.getUserNum());
			}else {
				list = dao.listPost(offset, size, info.getUserNum());
			}
			
			String cp = req.getContextPath();
			String articleUrl = cp + "/member/activity?mode=" + mode + "&pageNo=" + current_page;

			// ModelAndView에 데이터 전달
			mav.addObject("list", list);
			mav.addObject("pageNo", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("articleUrl", articleUrl);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
	        mav.addObject("mode", mode);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

//	  @RequestMapping(value = "/member/activity", method = RequestMethod.GET)
//	  public ModelAndView post(HttpServletRequest req, HttpServletResponse resp)
//	  throws ServletException, IOException { ModelAndView mav = new
//	  ModelAndView("member/activity");
//	  
//	  try { String mode = req.getParameter("mode"); if (mode == null ||
//	  mode.isEmpty()) { mode = "1"; }
//	  
//	  MypageDAO dao = new MypageDAO();
//	  
//	  int page = 1; int size = 10;
//	  
//	  if (req.getParameter("page") != null) { page =
//	  Integer.parseInt(req.getParameter("page")); }
//	  
//	  int offset = (page - 1) * size;
//	  
//	  HttpSession session = req.getSession(); SessionInfo info = (SessionInfo)
//	  session.getAttribute("member");
//	  
//	  if (info != null) { String userNum = info.getUserNum();
//	  System.out.println("info"+info);
//	  System.out.println("getUserNum"+info.getUserNum()); List<CmntDTO> list =
//	  null;
//	  
//	  if (mode.equals("1")) { list = dao.listPost(userNum, offset, size); } else if
//	  (mode.equals("2")) { list = dao.listReply(userNum, offset, size); } else if
//	  (mode.equals("3")) { // 탭 3의 데이터 불러오기 // list = dao.listLike(userNum, offset,
//	  size); }
//	  
//	  int totalCount = dao.getTotalCount(userNum);
//	  System.out.println("userNum"+userNum);
//	  System.out.println("totalCount"+totalCount);
//	  
//	  // 페이징 처리를 위한 데이터 설정 int pageCount = (int) Math.ceil((double) totalCount /
//	  size); // 총 페이지 수 int startPage = (page - 1) / 10 * 10 + 1; // 시작 페이지 int
//	  endPage = startPage + 9; // 끝 페이지 if (endPage > pageCount) { endPage =
//	  pageCount; }
//	  
//	  // ModelAndView에 데이터 전달 mav.addObject("list", list);
//	  mav.addObject("totalCount", totalCount); mav.addObject("pageCount",
//	  pageCount); mav.addObject("startPage", startPage); mav.addObject("endPage",
//	  endPage); mav.addObject("page", page); mav.addObject("mode", mode); // **현재
//	  모드 정보를 추가**
//	  
//	  System.out.println(mode);
//	  
//	  } else { mav = new ModelAndView("redirect:/login"); }
//	  
//	  } catch (Exception e) { e.printStackTrace(); }
//	  
//	  return mav; }

}
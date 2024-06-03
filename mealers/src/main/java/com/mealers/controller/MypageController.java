package com.mealers.controller;

import java.io.IOException;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.dao.MypageDAO;
import com.mealers.domain.CmntDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {
	

	@RequestMapping(value="/member/mypage",method=RequestMethod.GET)
	public ModelAndView myPageForm(HttpServletRequest req, HttpServletResponse resp)throws ServletException,IOException{
		ModelAndView mav = new ModelAndView("member/mypage");
      
		return mav;
	}


	
	@RequestMapping(value="/member/post", method = RequestMethod.GET)
	public ModelAndView post(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("member/post");

	    try {
	        MypageDAO dao = new MypageDAO();

	       
	        int page = 1; // 기본 페이지는 1로 설정
	        int size = 10; // 한 페이지에 표시할 게시물 수

	        if (req.getParameter("page") != null) {
	            page = Integer.parseInt(req.getParameter("page"));
	        }

	        int offset = (page - 1) * size;

	        
	        HttpSession session = req.getSession();
	        SessionInfo info = (SessionInfo) session.getAttribute("member");

	        if (info != null) {
	            String userNum = info.getUserNum();

	            List<CmntDTO> list = dao.listPost(userNum, offset, size);

	            
	            int totalCount = dao.getTotalCount(userNum);

	            // 페이징 처리를 위한 데이터 설정
	            int pageCount = (int) Math.ceil((double) totalCount / size); // 총 페이지 수
	            int startPage = (page - 1) / 10 * 10 + 1; // 시작 페이지
	            int endPage = startPage + 9; // 끝 페이지
	            if (endPage > pageCount) {
	                endPage = pageCount;
	            }

	            // ModelAndView에 데이터 전달
	            mav.addObject("list", list);
	            mav.addObject("totalCount", totalCount);
	            mav.addObject("pageCount", pageCount);
	            mav.addObject("startPage", startPage);
	            mav.addObject("endPage", endPage);
	            mav.addObject("currentPage", page);
	        } else {
	            mav = new ModelAndView("redirect:/login");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        mav.addObject("error", "데이터를 불러오는 중 오류가 발생했습니다.");
	    }

	    return mav;
	}
}
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
	
	
	//마이페이지,게시글 
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
	
	//마이페이지에서 게시글 삭제 
	@RequestMapping(value = "/member/postDelete", method = RequestMethod.GET)
	public ModelAndView deletePost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		MypageDAO dao = new MypageDAO();
		
		try {
			String type = req.getParameter("type");
			long num = Long.parseLong(req.getParameter("num"));
			
			String tableName="";
			
			switch (type) {
			case "1": tableName="MEALCMNT";
				break;
			case "2": tableName="EXERCMNT";
			break;
			case "3": tableName="FREECMNT";
			break;
			case "4": tableName="OMEMBERCMNT";
			break;
			case "5": tableName="CONCERNCMNT";
			break;
			case "6": tableName="MEALCOLUMN";
			break;
			case "7": tableName="EXRCSCOLUMN";
			break;

			}
			
			dao.deletePost(tableName,num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		String mode = req.getParameter("mode");
		String pageNo = req.getParameter("pageNo");
		
			return new ModelAndView("redirect:/member/activity?mode=" + mode + "&pageNo=" + pageNo);
		
	}
	
	//마이페이지에서 댓글 삭제 
	@RequestMapping(value = "/member/replyDelete", method = RequestMethod.GET)
	public ModelAndView deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		MypageDAO dao = new MypageDAO();
		
		try {
			String type = req.getParameter("type");
			long num = Long.parseLong(req.getParameter("num"));
			
			String tableName="";
			
			switch (type) {
			case "1": tableName="MEALCMNTREPLY";
				break;
			case "2": tableName="EXERCMNTREPLY";
			break;
			case "3": tableName="FREECMNTREPLY";
			break;
			case "4": tableName="OMEMBERCMNTREPLY";
			break;
			case "5": tableName="CONCERNCMNTREPLY";
			break;
			case "6": tableName="MEALCOLUMNREPLY";
			break;
			case "7": tableName="EXRCSCOLUMNREPLY";
			break;

			}
			
			dao.deleteReply(tableName,num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		String mode = req.getParameter("mode");
		String pageNo = req.getParameter("pageNo");
		
			return new ModelAndView("redirect:/member/activity?mode=" + mode + "&pageNo=" + pageNo);
		
	}
}
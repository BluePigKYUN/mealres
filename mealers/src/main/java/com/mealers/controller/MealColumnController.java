package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.dao.MealColumnDAO;
import com.mealers.domain.MealColumnDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.FileManager;
import com.mealers.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MealColumnController {
	@RequestMapping(value = "/mealColumn/list")
	public ModelAndView meallist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealColumn/list");
		
		return mav;
	}
	
	// 글쓰기폼
	@RequestMapping(value = "/mealColumn/write", method = RequestMethod.GET)
	public ModelAndView mealwriteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/mealColumn/list");
		}
		
		ModelAndView mav = new ModelAndView("mealColumn/write");
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	// 글 등록하기
	@RequestMapping(value = "/mealColumn/write", method = RequestMethod.POST)
	public ModelAndView mealwriteSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용 [, 파일]
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(! info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/mealColumn/list");
		}
		
		String path = session.getServletContext().getRealPath("/");
		String pathname = path + "uploads" + File.separator + "mealColumn";
		
		MealColumnDAO dao = new MealColumnDAO();
		FileManager filemanager = new FileManager();
		
		try {
			MealColumnDTO dto = new MealColumnDTO();
			
			dto.setUserNum(info.getUserNum());
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			List<MyMultipartFile> listfile = filemanager.doFileUpload(req.getParts(), pathname);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mealColumn/list");
	}
	
	@RequestMapping(value = "/mealColumn/article")
	public ModelAndView exerslist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealColumn/article");
		
		return mav;
	}
}

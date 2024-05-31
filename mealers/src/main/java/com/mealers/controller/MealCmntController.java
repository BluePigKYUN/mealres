package com.mealers.controller;

// import java.io.File;
import java.io.IOException;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
// import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// import jakarta.servlet.http.HttpSession;

@Controller
public class MealCmntController {
	@RequestMapping(value = "/mealCmnt/list", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealCmnt/list");
		
		return mav;
	}
	
	@RequestMapping(value = "/mealCmnt/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealCmnt/write");
				
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@RequestMapping(value = "/mealCmnt/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용, 파일
		// HttpSession session = req.getSession();
		// SessionInfo info = (SessionInfo)session.getAttribute("userNum");
		
		// String path = session.getServletContext().getRealPath("/");
		// String pathname = path + "files" + File.separator + "mealCmnt";
		
	
		
		
		return new ModelAndView("redirect:/mealCmnt/list");
	}
} 

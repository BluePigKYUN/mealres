package com.mealers.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.DiaryDAO;
import com.mealers.domain.DiaryDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class DiaryController {
	
	@RequestMapping(value = "/log/diary", method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("log/diaryMain");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/log/diaryInsert", method = RequestMethod.POST)
	public Map<String, Object> insertSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		DiaryDAO dao = new DiaryDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		Map<String, Object> model = new HashMap<String, Object>();
		
		String state = "false";
		
		try {
			DiaryDTO dto = new DiaryDTO();
			
			dto.setMemberId(info.getUserId());
			dto.setStatus(req.getParameter("status"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("diary"));
			dto.setUserNum(dao.findByUserNum(info.getUserId()));
			
			dao.insertDiary(dto);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.put("state", state);
		
		return model;
	}
	
}

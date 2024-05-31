package com.mealers.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.DiaryDAO;
import com.mealers.domain.DiaryDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.MyUtil;
import com.mealers.util.MyUtilBootstrap;

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
			dto.setStatus(req.getParameter("emotion"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("diary"));
			dto.setUserNum(info.getUserNum());
			
			dao.insertDiary(dto);
			
			state = "true";
		} catch (Exception e) {
			model.put("state", "false");
		}
		model.put("state", state);
		
		return model;
	}
	
	@ResponseBody
	@RequestMapping(value = "/log/list", method = RequestMethod.GET)
	public Map<String, Object> printList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//화면에 출력
		//[페이지 번호 파라미터]
		Map<String, Object> model = new HashMap<String, Object>();
		
		DiaryDAO dao = new DiaryDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			String page = req.getParameter("pageNo");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			
		 	if(current_page > total_page) {
		 		current_page = total_page;
		 	}
		 	
		 	int offset = (current_page - 1) * size;
		 	
		 	List<DiaryDTO> list = dao.listDiary(offset, size, info.getUserId());
		 	
		 	for(DiaryDTO dto : list) {
		 		dto.setSubject(dto.getSubject().replaceAll(">", "&gt;"));
		 		dto.setSubject(dto.getSubject().replaceAll("<", "&lt;"));
		 	}
		 	
		 	model.put("list", list);
		 	model.put("pageNo", current_page);
		 	model.put("total_page", total_page);
		 	model.put("dataCount", dataCount);
		 	
		 	model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
		}
		
		return model;
	}
	
}

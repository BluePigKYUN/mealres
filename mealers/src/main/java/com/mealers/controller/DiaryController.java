package com.mealers.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

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
	
	@RequestMapping(value = "/log/main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("log/main");
		
		return mav;
	}
	
	@RequestMapping(value = "/log/diary", method = RequestMethod.GET)
	public ModelAndView diaryList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//넘어올 파라미터: 페이지 번호
		ModelAndView mav = new ModelAndView("log/diaryMain");
		
		DiaryDAO dao = new DiaryDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			String page = req.getParameter("pageNo");
			int current_page = 1;
			if(page != null  && ! page.isEmpty()) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount(info.getUserId());
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			
	        int startPage = ((current_page - 1) / size * size) + 1;
	        int endPage = ((current_page - 1) / size * size) + size;
	        if (endPage > total_page) {
	            endPage = total_page;
	        }
			
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			
			List<DiaryDTO> list = dao.listDiary(offset, size, info.getUserId());
			
	        Map<String, Integer> emojiMap = new HashMap<>();
	        for (DiaryDTO dto : list) {
	            String emoji = dto.getEmoji();
	            if (emojiMap.containsKey(emoji)) {
	                emojiMap.put(emoji, emojiMap.get(emoji) + 1);
	            } else {
	                emojiMap.put(emoji, 1);
	            }
	        }
	        List<DiaryDTO> fullList = dao.fullListDiary(info.getUserId());
	        DiaryDTO randomDiary = null;
	        if (! fullList.isEmpty()) {
	            Random random = new Random();
	            randomDiary = fullList.get(random.nextInt(fullList.size()));
	        }
			
			String cp = req.getContextPath();
			//String listUrl = cp + "/log/diary";
			String articleUrl = cp + "/log/diary?pageNo=" + current_page;
			
			mav.addObject("list", list);
			mav.addObject("emojiList", emojiMap);
			mav.addObject("randomDiary", randomDiary);
			mav.addObject("pageNo", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("articleUrl", articleUrl);
	        mav.addObject("startPage", startPage);
	        mav.addObject("endPage", endPage);
		 	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
			dto.setEmoji(req.getParameter("emotion"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("diary"));
			dto.setUserNum(info.getUserNum());
			
			dao.insertDiary(dto);
			
			state = "true";
		} catch (Exception e) {
			model.put("state", "false");
			model.put("error", e.getMessage());
		}
		model.put("state", state);
		
		return model;
	}
 	
 	@RequestMapping(value = "/log/viewDiary", method = RequestMethod.POST)
 	public ModelAndView viewDiary(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 		//넘어올 파라미터: 글번호와 페이지번호
 		ModelAndView mav = new ModelAndView("log/viewDiary");
 		DiaryDAO dao = new DiaryDAO();

 		HttpSession session = req.getSession();
 		SessionInfo info = (SessionInfo)session.getAttribute("member");
 		String diary_num = req.getParameter("diaryNum");
 		String pageNo = req.getParameter("pageNo");
 		String query = "pageNo=" + pageNo;
 		
 		try {
 			if(diary_num.equals("") && pageNo.equals("")) {
 				return new ModelAndView("log/diary");
 			}
 			
 			DiaryDTO dto = dao.oneDiary(info.getUserId(), diary_num);
 			
			String cp = req.getContextPath();
			String listUrl = cp + "/log/diary";
			String articleUrl = cp + "/log/diary?pageNo=" + pageNo;
			
			mav.addObject("dto", dto);
			mav.addObject("pageNo", pageNo);
			mav.addObject("query", query);
			mav.addObject("diaryNum", diary_num);
			mav.addObject("listUrl", listUrl);
			mav.addObject("articleUrl", articleUrl);
 			
		} catch (Exception e) {
			e.printStackTrace();
		}
 		
 		return mav;
 	}
 	
 	@RequestMapping(value = "/log/deleteDiary", method = RequestMethod.GET)
 	public ModelAndView deleteDiary(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
 		//넘어올 파라미터: 글번호, 페이지번호
 		DiaryDAO dao = new DiaryDAO();
 		
 		String pageNo = req.getParameter("pageNo");
 		
 		String query = "pageNo=" + pageNo;
 		
 		try {
 			long num = Long.parseLong(req.getParameter("diaryNum"));
 			
 			dao.deleteDiary(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
 		
 		return new ModelAndView("redirect:/log/diary?" + query );
 	}
	
}

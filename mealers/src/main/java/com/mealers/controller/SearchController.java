package com.mealers.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.dao.SearchDAO;
import com.mealers.domain.SearchDTO;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.MyUtil;
import com.mealers.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class SearchController {
	@RequestMapping(value = "/search/main", method = RequestMethod.GET)
	public ModelAndView searchMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("search/main");
		return mav;
	}
	
	@RequestMapping(value = "/search/main", method = RequestMethod.POST)
	public ModelAndView searchFood(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("search/main");
		
		SearchDAO dao = new SearchDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String kwd = req.getParameter("kwd");
			
			// GET 방식인 경우 디코딩
			if (req.getMethod().equalsIgnoreCase("GET")) {
				kwd = URLDecoder.decode(kwd, "utf-8");
			}
			
			int dataCount = dao.dataCount(kwd);
			
			// 전체 페이지 수
			int size = 8;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<SearchDTO> list = null;
			list = dao.listFood(offset, size, kwd);
			
			String query = "";
			if (kwd.length() != 0) {
				query = "kwd=" + URLEncoder.encode(kwd, "utf-8");
			}
			
			// 페이징 처리
			String cp = req.getContextPath();
			String listUrl = cp + "/search/main";
			String articleUrl = cp + "/search/item?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			// 포워딩할 JSP에 전달할 속성
			mav.addObject("list", list);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("paging", paging);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/search/reg")
	public ModelAndView searchReg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/reg");
		
		return mav;
	}
	
	@RequestMapping(value = "/search/item")
	public ModelAndView searchItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		SearchDAO dao = new SearchDAO();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			
			long num = Long.parseLong(req.getParameter("num"));
			String kwd = req.getParameter("kwd");
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			if (kwd.length() != 0) {
				query += "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			SearchDTO dto = dao.findByNum(num);
			
			ModelAndView mav = new ModelAndView("search/item");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/search/main?" + query);
	}
}
















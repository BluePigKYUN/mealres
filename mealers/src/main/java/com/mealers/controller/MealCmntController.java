package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.http.HttpRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.dao.MealCmntDAO;
import com.mealers.domain.CmntDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.FileManager;
import com.mealers.util.MyMultipartFile;
import com.mealers.util.MyUtil;
import com.mealers.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class MealCmntController {
	@RequestMapping(value = "/mealCmnt/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, [,검색카테고리, 검색값, 정렬카테고리]
		ModelAndView mav = new ModelAndView("mealCmnt/list");
		
		MealCmntDAO dao = new MealCmntDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String mealSort = req.getParameter("mealSort");
			if(mealSort == null) {
				mealSort = "recent";
			}
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(req.getMethod().equals("GET")) {
				schContent = URLDecoder.decode(schContent, "utf-8");
			}
			
			int dataCount;
			if(schContent.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(schCategory, schContent);
			}
			
			int size = 6;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			List<CmntDTO> list = null;
			if(schContent.length() == 0) {
				list = dao.listMeal(offset, size, mealSort);
			} else {
				list = dao.listMeal(offset, size, mealSort, schCategory, schContent);
			}
			
			long timeGap;
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			LocalDateTime today = LocalDateTime.now();
			for(CmntDTO dto : list) {
				LocalDateTime dateTime = LocalDateTime.parse(dto.getReg_date(), formatter);
				
				timeGap = dateTime.until(today, ChronoUnit.MINUTES);
				int timeGaps = Long.valueOf(timeGap).intValue();
				
				
				dto.setTimeGap(timeGaps);	

				
				dto.setReg_date(dto.getReg_date().substring(0,10));
			}
			
			String query = "";
			if(schContent.length() != 0) {
				query = "schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/mealCmnt/list";
			String articleUrl = cp + "/mealCmnt/article?page=" + current_page;
			if(query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("paging", paging);
			mav.addObject("schCategory", schCategory);
			mav.addObject("schContent", schContent);
			mav.addObject("mealSort", mealSort);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/mealCmnt/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealCmnt/write");
				
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@RequestMapping(value = "/mealCmnt/write", method = RequestMethod.POST)
	public ModelAndView writeOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용, 파일
		MealCmntDAO dao = new MealCmntDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mealCmnt";
		
		try {
			CmntDTO dto = new CmntDTO();
			
			dto.setUserNum(info.getUserNum());
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			String filename = null;
			Part p = req.getPart("photoSelect");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if(multipart != null) {
				filename = multipart.getSaveFilename();
			}
			
			if(filename != null) {
				dto.setFileName(filename);
				
				dao.insertMeal(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mealCmnt/list");
	}
	
	@RequestMapping(value = "/mealCmnt/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpRequest resp) throws ServletException, IOException {
		// 페이지, 글번호, [,검색컬럼, 검색값, 정렬컬럼]
		MealCmntDAO dao = new MealCmntDAO();
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			String mealSort = req.getParameter("mealSort");
			
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(mealSort == null) {
				mealSort = "recent";
			}
			
			 schContent = URLDecoder.decode(schContent, "utf-8");
			 if(schContent.length() != 0) {
			 	query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
				if(mealSort.equals("popular") | mealSort.equals("hitcount")) {
					query += "&mealSort=" + mealSort;
				}
			 } else {
				if(mealSort.equals("popular") | mealSort.equals("hitcount")) {
					query += "&mealSort=" + mealSort;
				}
			 }
			
			dao.hitCountCal(num);
			
			CmntDTO dto = dao.findContent(num);
			if(dto == null) {
				return new ModelAndView("/mealCmnt/list?" + query);
			}
			
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			
			// HttpSession session = req.getSession();
			// SessionInfo info = (SessionInfo)session.getAttribute("member");
			// boolean isLikeCmnt = dao.isLikeCmnt(num, info.getUserNum());
			
			ModelAndView mav = new ModelAndView("mealCmnt/article");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			// mav.addObject("isLikeCmnt", isLikeCmnt);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect/mealCmnt/list");
	}
} 

package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
import com.mealers.util.MyUtil;
import com.mealers.util.MyUtilBootstrap;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class MealColumnController {
	
	@RequestMapping(value = "/mealColumn/list")
	public ModelAndView meallist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글리스트
		// 넘어온 파라미터 : [페이지번호, size, 검색컬럼 검색값]
		
		ModelAndView mav = new ModelAndView("mealColumn/list");
		
		MealColumnDAO dao = new MealColumnDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색시
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			if(req.getMethod().equals("GET")) {
				kwd = URLDecoder.decode(kwd, "UTF-8");
			}
			
			
			// 한 화면에 출력할 개수 (size)
			String pageSize = req.getParameter("size");
			int size = pageSize == null ? 9 : Integer.parseInt(pageSize);
			
			int dataCount, total_page;
			if(kwd.length() != 0) {
				dataCount = dao.dataCount(schType, kwd);
			} else {
				dataCount = dao.dataCount();
			}
			total_page = util.pageCount(dataCount, size);
			
			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<MealColumnDTO> list;
			if(kwd.length() == 0 ) {
				list = dao.listMealColumn(offset, size);
			} else {
				list = dao.listMealColumn(offset, size, schType, kwd);
			}
			
			
			// 페이징 처리
			String cp = req.getContextPath();
			String listUrl;
			String articleUrl;
			String query = "size=" + size;
			
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			listUrl = cp + "/mealColumn/list?" + query;
			articleUrl = cp + "/mealColumn/article?page=" + current_page + "&" + query;
			String paging = util.paging(current_page, total_page, listUrl);
			
			// list 전달 속성
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("size", size);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// 글쓰기폼
	@RequestMapping(value = "/mealColumn/write", method = RequestMethod.GET)
	public ModelAndView mealwriteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("mealColumn/write");
		
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	// 글 등록하기
	@RequestMapping(value = "/mealColumn/write", method = RequestMethod.POST)
	public ModelAndView mealwriteSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용 [, 파일]
		MealColumnDAO dao = new MealColumnDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(! "1".equals(info.getUserNum()) ) {
			return new ModelAndView("redirect:/mealColumn/list");
		}
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mealColumn";
		
		FileManager filemanager = new FileManager();
		
		try {
			MealColumnDTO dto = new MealColumnDTO();
			
			dto.setUserNum(info.getUserNum());
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			
			Part p = req.getPart("selectFile");
			MyMultipartFile multiFile = filemanager.doFileUpload(p, pathname);
			if (multiFile != null) {
				String saveFilename = multiFile.getSaveFilename();
				String originalFilename = multiFile.getOriginalFilename();
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
			}
			
			dao.insertMealColumn(dto);
			
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

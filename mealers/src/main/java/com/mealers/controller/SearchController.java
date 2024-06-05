package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.SearchDAO;
import com.mealers.domain.SearchDTO;
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
public class SearchController {
	@RequestMapping(value = "/search/main")
	public ModelAndView searchMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
			if (kwd == null) {
				kwd = "";
			}
			
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
			
			List<SearchDTO> listRank = null;
			listRank = dao.listRank();
			
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
			mav.addObject("listRank", listRank);
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
	
//	@ResponseBody
//	@RequestMapping(value = "/search/main")
//	public Map<String, Object> searchMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		
//		Map<String, Object> model = new HashMap<String, Object>();
//		SearchDAO dao = new SearchDAO();
//		MyUtil util = new MyUtilBootstrap();
//		
//		
//		try {
//			String page = req.getParameter("page");
//			int current_page = 1;
//			if (page != null) {
//				current_page = Integer.parseInt(page);
//			}
//			
//			// 검색
//			String kwd = req.getParameter("kwd");
//			if (kwd == null) {
//				kwd = "";
//			}
//			
//			// GET 방식인 경우 디코딩
//			if (req.getMethod().equalsIgnoreCase("GET")) {
//				kwd = URLDecoder.decode(kwd, "utf-8");
//			}
//			
//			int dataCount = dao.dataCount(kwd);
//			
//			// 전체 페이지 수
//			int size = 8;
//			int total_page = util.pageCount(dataCount, size);
//			if (current_page > total_page) {
//				current_page = total_page;
//			}
//			
//			// 게시물 가져오기
//			int offset = (current_page - 1) * size;
//			if(offset < 0) offset = 0;
//			
//			List<SearchDTO> list = null;
//			list = dao.listFood(offset, size, kwd);
//			
//			List<SearchDTO> listRank = null;
//			listRank = dao.listRank();
//			
//			String query = "";
//			if (kwd.length() != 0) {
//				query = "kwd=" + URLEncoder.encode(kwd, "utf-8");
//			}
//			
//			// 페이징 처리
//			String cp = req.getContextPath();
//			String listUrl = cp + "/search/main";
//			String articleUrl = cp + "/search/item?page=" + current_page;
//			if (query.length() != 0) {
//				listUrl += "?" + query;
//				articleUrl += "&" + query;
//			}
//			
//			String paging = util.paging(current_page, total_page, listUrl);
//			
//			model.put("list", list);
//			model.put("listRank", listRank);
//			model.put("page", current_page);
//			model.put("total_page", total_page);
//			model.put("dataCount", dataCount);
//			model.put("size", size);
//			model.put("articleUrl", articleUrl);
//			model.put("paging", paging);
//			model.put("kwd", kwd);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return model;
//	}
	
	@RequestMapping(value = "/search/reg", method = RequestMethod.GET)
	public ModelAndView searchReg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/reg");
		
		return mav;
	}
	
	@RequestMapping(value = "/search/reg", method = RequestMethod.POST)
	public ModelAndView regFood(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SearchDAO dao = new SearchDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			SearchDTO dto = new SearchDTO();
			
			dto.setFood_name(req.getParameter("food_name"));
			dto.setMaker(req.getParameter("maker"));
			dto.setWeight(req.getParameter("weight"));
			dto.setServing_size(req.getParameter("serving_size"));
			dto.setKcal(req.getParameter("kcal"));
			dto.setTansoo(req.getParameter("tansoo"));
			dto.setProtein(req.getParameter("protein"));
			dto.setFat(req.getParameter("fat"));
			dto.setSugar(req.getParameter("sugar"));
			dto.setSalt(req.getParameter("salt"));
			dto.setCalcium(req.getParameter("calcium"));
			dto.setPotassium(req.getParameter("potassium"));
			dto.setChole(req.getParameter("chole"));
			dto.setPohwa(req.getParameter("pohwa"));
			dto.setBulpohwa(req.getParameter("bulpohwa"));
			dto.setOmega3(req.getParameter("omega3"));
			dto.setCaffeine(req.getParameter("caffeine"));
			dto.setAmino(req.getParameter("amino"));
			dto.setUserNum(Long.parseLong(info.getUserNum()));
			
			dao.insertFood(dto);
			
			ModelAndView mav = new ModelAndView("search/sucess");
			
			long food_num = dao.findByName(req.getParameter("food_name"), Integer.parseInt(info.getUserNum()));
			
			mav.addObject("page", 1);
			mav.addObject("kwd", req.getParameter("food_name"));
			mav.addObject("num", food_num);
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/search/sucess");
	}
	
	@RequestMapping(value = "/search/sucess", method = RequestMethod.GET)
	public ModelAndView regSucess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("search/sucess");
		
		return mav;
	}
	
	@RequestMapping(value = "/search/item", method = RequestMethod.GET)
	public ModelAndView viewItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("search/item");
		
		SearchDAO dao = new SearchDAO();
		MyUtil util = new MyUtilBootstrap();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			long num = Long.parseLong(req.getParameter("num"));
			
			// 조회수 증가
			dao.updateHitcount(num);
			
			// 검색된 음식 사진 개수
			int dataCount = dao.fileCount(num);
			
			// 사진 페이지 수
			int size = 4;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			// 게시글 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<SearchDTO> list = dao.listPhoto(offset, size, num);
			
			// 페이징
			String cp = req.getContextPath();
			String articleUrl = cp + "/photo/article?page=" + current_page;
			
			String kwd = req.getParameter("kwd");
			if (kwd != null) {
				kwd = URLDecoder.decode(kwd, "utf-8");
			}
			
			if (kwd != null) {
				query += "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			SearchDTO dto = dao.findByNum(num);
			
			mav.addObject("dto", dto);
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("kwd", kwd);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/search/main?" + query);
	}
	
	@RequestMapping(value = "/search/item", method = RequestMethod.POST)
	public ModelAndView insertPhoto(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		SearchDAO dao = new SearchDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "photo";
		
		try {
			SearchDTO dto = new SearchDTO();
			
			dto.setUserNum(Integer.parseInt(info.getUserNum()));
			dto.setFood_num(Long.parseLong(req.getParameter("num")));
			
			String filename = null;
			Part p = req.getPart("selectFile");
			
			if(p != null) {
				MyMultipartFile multipartFile = fileManager.doFileUpload(p, pathname);
				if(multipartFile != null) {
					filename = multipartFile.getSaveFilename();
				}
				
				if(filename != null) {
					dto.setFood_file_name(filename);
					
					dao.insertPhoto(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		String page = req.getParameter("page");
		String kwd = req.getParameter("kwd");
		String num = req.getParameter("num");
		
		if (kwd.length() != 0) {
			kwd= URLEncoder.encode(kwd, "utf-8");
		}
		
		return new ModelAndView("redirect:/search/item?page=" + page + "&kwd=" + kwd + "&num=" + num);
	}
}
















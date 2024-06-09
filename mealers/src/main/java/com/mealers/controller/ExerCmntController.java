package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.ExerCmntDAO;
import com.mealers.domain.CmntDTO;
import com.mealers.domain.ReplyDTO;
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
public class ExerCmntController {
	@RequestMapping(value = "/exerCmnt/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, [,검색카테고리, 검색값, 정렬카테고리]
		ModelAndView mav = new ModelAndView("exerCmnt/list");
		
		ExerCmntDAO dao = new ExerCmntDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String exerSort = req.getParameter("exerSort");
			if(exerSort == null) {
				exerSort = "recent";
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
			
			int size = 8;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			List<CmntDTO> list = null;
			if(schContent.length() == 0) {
				list = dao.listExer(offset, size, exerSort);
			} else {
				list = dao.listExer(offset, size, exerSort, schCategory, schContent);
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
			
			String query = "exerSort=" + exerSort ;
			if(schContent.length() != 0) {
				query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/exerCmnt/list?" + query;
			String articleUrl = cp + "/exerCmnt/article?page=" + current_page + "&" + query;
			
			String paging = util.mealersPagingUrl(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("paging", paging);
			mav.addObject("schCategory", schCategory);
			mav.addObject("schContent", schContent);
			mav.addObject("exerSort", exerSort);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/exerCmnt/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("exerCmnt/write");
				
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@RequestMapping(value = "/exerCmnt/write", method = RequestMethod.POST)
	public ModelAndView writeOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용, 파일
		ExerCmntDAO dao = new ExerCmntDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "exerCmnt";
		
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
				
				dao.insertExer(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/exerCmnt/list");
	}
	
	@RequestMapping(value = "/exerCmnt/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, [,검색컬럼, 검색값, 정렬컬럼]
		ExerCmntDAO dao = new ExerCmntDAO();
		String page = req.getParameter("page");
		String exerSort = req.getParameter("exerSort");
		String query = "page=" + page + "&exerSort=" + exerSort;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(exerSort == null) {
				exerSort = "recent";
			}
			
			 schContent = URLDecoder.decode(schContent, "utf-8");
			 if(schContent.length() != 0) {
			 	query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			 }
			
			dao.hitCountCal(num);
			
			int likeCount = dao.likeCount(num);
			
			CmntDTO dto = dao.findContent(num);
			if(dto == null) {
				return new ModelAndView("/exerCmnt/list?" + query);
			}
			
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			boolean isLikeCmnt = dao.isLikeCmnt(num, info.getUserNum());
			
			ModelAndView mav = new ModelAndView("exerCmnt/article");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("isLikeCmnt", isLikeCmnt);
			mav.addObject("likeCount", likeCount);
			mav.addObject("exerSort", exerSort);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect/exerCmnt/list");
	}
	
	@ResponseBody
	@RequestMapping(value = "/exerCmnt/addlikeCmnt", method = RequestMethod.POST)
	public Map<String, Object> addlikeCmnt(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		ExerCmntDAO dao = new ExerCmntDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		
		String state = "false";
		int likeCount = 0;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String isNoLike = req.getParameter("isNoLike");
			
			if(isNoLike.equals("true")) {
				dao.addlikeCmnt(num, info.getUserNum());
			} else {
				dao.deleteLikeCmnt(num, info.getUserNum());
			}
			
			likeCount = dao.likeCount(num);
			
			state = "true";
		} catch (Exception e) {
		}
		
		model.put("state", state);
		model.put("likeCount", likeCount);
			
		return model;
	}
	
	@RequestMapping(value = "/exerCmnt/update", method = RequestMethod.GET)
	public ModelAndView updateExer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, 글번호, 정렬, [, 검색컬럼, 검색값]
		ExerCmntDAO dao = new ExerCmntDAO();
		String page = req.getParameter("page");
		String exerSort = req.getParameter("exerSort");
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			long num = Long.parseLong(req.getParameter("num"));
	
			CmntDTO dto = dao.findContent(num);
			
			if(dto == null || ! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/exerCmnt/list?page="+ page + "&exerSort=" + exerSort);
			}
			
			ModelAndView mav = new ModelAndView("/exerCmnt/write");
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("exerSort", exerSort);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/exerCmnt/list?page=" + page + "&exerSort=" + exerSort);
	}
	
	@RequestMapping(value = "/exerCmnt/update", method = RequestMethod.POST)
	public ModelAndView updateExerOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글번호, 페이지번호, 정렬, 제목, 내용, 파일
		
		HttpSession session = req.getSession();
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "exerCmnt";
		
		String page = req.getParameter("page");
		String exerSort = req.getParameter("exerSort");
		
		ExerCmntDAO dao = new ExerCmntDAO();
		
		try {
			CmntDTO dto = new CmntDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			String fileName = req.getParameter("fileName");
			dto.setFileName(fileName);
			
			Part p = req.getPart("photoSelect");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			
			if(multipart != null) {
				String fileItem = multipart.getSaveFilename();
				dto.setFileName(fileItem);
				
				fileManager.doFiledelete(pathname, fileName);
			}
			
			dao.updateExer(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/exerCmnt/list?page=" + page + "&exerSort=" + exerSort);
	}
	
	@RequestMapping(value = "/exerCmnt/delete", method = RequestMethod.GET)
	public ModelAndView deleteExer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, 정렬
		ExerCmntDAO dao = new ExerCmntDAO();
		
		FileManager fileManager = new FileManager();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "exerCmnt";
		
		String page = req.getParameter("page");
		String exerSort = req.getParameter("exerSort");
		if(exerSort == null) {
			exerSort = "recent";
		}
		String query = "page=" + page + "&exerSort=" + exerSort; 
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			CmntDTO dto = dao.findContent(num);
			
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(schContent.length() != 0) {
				query += "&schCategory=" + schCategory + "&schContent=" + schContent;
			}
			
			
			if(dto == null) {
				return new ModelAndView("redirect:/exerCmnt/list?" + query);
			}
			
			if(! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/exerCmnt/list?" + query);
			}
			
			fileManager.doFiledelete(pathname, dto.getFileName());
			dao.deleteExer(num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/exerCmnt/list?" + query);
	}
	
	@ResponseBody
	@RequestMapping(value = "/exerCmnt/addReply", method = RequestMethod.POST)
	public Map<String, Object> addReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		ExerCmntDAO dao = new ExerCmntDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String state = "false";
		
		try {
			ReplyDTO dto = new ReplyDTO();
			
			long num = Long.parseLong(req.getParameter("num"));
			dto.setNum(num);
			dto.setUserNum(info.getUserNum());
			dto.setContent(req.getParameter("content"));
			
			dao.addReply(dto);
			
			state = "ok";
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value = "/exerCmnt/replyList", method = RequestMethod.GET)
	public ModelAndView replyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ExerCmntDAO dao = new ExerCmntDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 5;
			
			int replyCount = 0;
			replyCount = dao.replyCount(num);
			
			int total_page = 0;
			total_page = util.pageCount(replyCount, size);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<ReplyDTO> replyList = dao.replyList(num, offset, size);
			
			for(ReplyDTO dto : replyList) {
				dto.setContent(dto.getContent().replace("\n", "<br>"));
			}
			
			String paging = util.pagingMethodReply(current_page, total_page, "listPage");
			
			ModelAndView mav = new ModelAndView("exerCmnt/replyList");
			
			mav.addObject("replyList", replyList);
			mav.addObject("pageNo", current_page);
			mav.addObject("replyCount", replyCount);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(400);
			throw e;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/exerCmnt/removeReply", method = RequestMethod.POST)
	public Map<String, Object> removeReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();

		ExerCmntDAO dao = new ExerCmntDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		try {
			long replyNum = Long.parseLong(req.getParameter("replyNum"));
			
			dao.removeReply(replyNum, info.getUserNum());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}
} 
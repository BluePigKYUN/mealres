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
import com.mealers.dao.FreeCmntDAO;
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
public class FreeCmntController {
	@RequestMapping(value = "/freeCmnt/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, [,검색카테고리, 검색값, 정렬카테고리]
		ModelAndView mav = new ModelAndView("freeCmnt/list");
		
		FreeCmntDAO dao = new FreeCmntDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String freeSort = req.getParameter("freeSort");
			if(freeSort == null) {
				freeSort = "recent";
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
				list = dao.listFree(offset, size, freeSort);
			} else {
				list = dao.listFree(offset, size, freeSort, schCategory, schContent);
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
			
			String query = "freeSort=" + freeSort ;
			if(schContent.length() != 0) {
				query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/freeCmnt/list?" + query;
			String articleUrl = cp + "/freeCmnt/article?page=" + current_page + "&" + query;
			
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
			mav.addObject("freeSort", freeSort);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/freeCmnt/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("freeCmnt/write");
				
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@RequestMapping(value = "/freeCmnt/write", method = RequestMethod.POST)
	public ModelAndView writeOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용, 파일
		FreeCmntDAO dao = new FreeCmntDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "freeCmnt";
		
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
				
				dao.insertFree(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/freeCmnt/list");
	}
	
	@RequestMapping(value = "/freeCmnt/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, [,검색컬럼, 검색값, 정렬컬럼]
		FreeCmntDAO dao = new FreeCmntDAO();
		String page = req.getParameter("page");
		String freeSort = req.getParameter("freeSort");
		String query = "page=" + page + "&freeSort=" + freeSort;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(freeSort == null) {
				freeSort = "recent";
			}
			
			 schContent = URLDecoder.decode(schContent, "utf-8");
			 if(schContent.length() != 0) {
			 	query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			 }
			
			dao.hitCountCal(num);
			
			int likeCount = dao.likeCount(num);
			
			CmntDTO dto = dao.findContent(num);
			if(dto == null) {
				return new ModelAndView("/freeCmnt/list?" + query);
			}
			
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			boolean isLikeCmnt = dao.isLikeCmnt(num, info.getUserNum());
			
			ModelAndView mav = new ModelAndView("freeCmnt/article");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("isLikeCmnt", isLikeCmnt);
			mav.addObject("likeCount", likeCount);
			mav.addObject("freeSort", freeSort);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect/freeCmnt/list");
	}
	
	@ResponseBody
	@RequestMapping(value = "/freeCmnt/addlikeCmnt", method = RequestMethod.POST)
	public Map<String, Object> addlikeCmnt(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		FreeCmntDAO dao = new FreeCmntDAO();
		
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
	
	@RequestMapping(value = "/freeCmnt/update", method = RequestMethod.GET)
	public ModelAndView updateFree(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, 글번호, 정렬, [, 검색컬럼, 검색값]
		FreeCmntDAO dao = new FreeCmntDAO();
		String page = req.getParameter("page");
		String freeSort = req.getParameter("freeSort");
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			long num = Long.parseLong(req.getParameter("num"));
	
			CmntDTO dto = dao.findContent(num);
			
			if(dto == null || ! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/freeCmnt/list?page="+ page + "&freeSort=" + freeSort);
			}
			
			ModelAndView mav = new ModelAndView("/freeCmnt/write");
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("freeSort", freeSort);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/freeCmnt/list?page=" + page + "&freeSort=" + freeSort);
	}
	
	@RequestMapping(value = "/freeCmnt/update", method = RequestMethod.POST)
	public ModelAndView updateFreeOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글번호, 페이지번호, 정렬, 제목, 내용, 파일
		
		HttpSession session = req.getSession();
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "freeCmnt";
		
		String page = req.getParameter("page");
		String freeSort = req.getParameter("freeSort");
		
		FreeCmntDAO dao = new FreeCmntDAO();
		
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
			
			dao.updateFree(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/freeCmnt/list?page=" + page + "&freeSort=" + freeSort);
	}
	
	@RequestMapping(value = "/freeCmnt/delete", method = RequestMethod.GET)
	public ModelAndView deleteFree(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, 정렬
		FreeCmntDAO dao = new FreeCmntDAO();
		
		FileManager fileManager = new FileManager();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "freeCmnt";
		
		String page = req.getParameter("page");
		String freeSort = req.getParameter("freeSort");
		if(freeSort == null) {
			freeSort = "recent";
		}
		String query = "page=" + page + "&freeSort=" + freeSort; 
		
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
				return new ModelAndView("redirect:/freeCmnt/list?" + query);
			}
			
			if(! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/freeCmnt/list?" + query);
			}
			
			fileManager.doFiledelete(pathname, dto.getFileName());
			dao.deleteFree(num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/freeCmnt/list?" + query);
	}
	
	@ResponseBody
	@RequestMapping(value = "/freeCmnt/addReply", method = RequestMethod.POST)
	public Map<String, Object> addReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		FreeCmntDAO dao = new FreeCmntDAO();
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
	
	@RequestMapping(value = "/freeCmnt/replyList", method = RequestMethod.GET)
	public ModelAndView replyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FreeCmntDAO dao = new FreeCmntDAO();
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
			
			ModelAndView mav = new ModelAndView("freeCmnt/replyList");
			
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
	@RequestMapping(value = "/freeCmnt/removeReply", method = RequestMethod.POST)
	public Map<String, Object> removeReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();

		FreeCmntDAO dao = new FreeCmntDAO();
		
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
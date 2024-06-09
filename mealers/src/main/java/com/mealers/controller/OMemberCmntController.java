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
import com.mealers.dao.OMemberCmntDAO;
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
public class OMemberCmntController {
	@RequestMapping(value = "/oMemberCmnt/list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, [,검색카테고리, 검색값, 정렬카테고리]
		ModelAndView mav = new ModelAndView("oMemberCmnt/list");
		
		OMemberCmntDAO dao = new OMemberCmntDAO();
		MyUtil util = new MyUtilBootstrap();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String oMemberSort = req.getParameter("oMemberSort");
			if(oMemberSort == null) {
				oMemberSort = "recent";
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
				list = dao.listOMember(offset, size, oMemberSort);
			} else {
				list = dao.listOMember(offset, size, oMemberSort, schCategory, schContent);
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
			
			String level = dao.findLevel(info.getUserNum());
			
			
			String query = "oMemberSort=" + oMemberSort ;
			if(schContent.length() != 0) {
				query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/oMemberCmnt/list?" + query;
			String articleUrl = cp + "/oMemberCmnt/article?page=" + current_page + "&" + query;
			
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
			mav.addObject("oMemberSort", oMemberSort);
			mav.addObject("level", level);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/oMemberCmnt/write", method = RequestMethod.GET)
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("oMemberCmnt/write");
				
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@RequestMapping(value = "/oMemberCmnt/write", method = RequestMethod.POST)
	public ModelAndView writeOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 제목, 내용, 파일
		OMemberCmntDAO dao = new OMemberCmntDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "oMemberCmnt";
		
		try {
			CmntDTO dto = new CmntDTO();
			
			dto.setUserNum(info.getUserNum());
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			String level = dao.findLevel(info.getUserNum());
			dto.setLevel(level);
			
			String filename = null;
			Part p = req.getPart("photoSelect");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if(multipart != null) {
				filename = multipart.getSaveFilename();
			}
			
			if(filename != null) {
				dto.setFileName(filename);
				
				dao.insertOMember(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/oMemberCmnt/list");
	}
	
	@RequestMapping(value = "/oMemberCmnt/article", method = RequestMethod.GET)
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, [,검색컬럼, 검색값, 정렬컬럼]
		OMemberCmntDAO dao = new OMemberCmntDAO();
		String page = req.getParameter("page");
		String oMemberSort = req.getParameter("oMemberSort");
		String query = "page=" + page + "&oMemberSort=" + oMemberSort;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schCategory = req.getParameter("schCategory");
			String schContent = req.getParameter("schContent");
			
			if(schCategory == null) {
				schCategory = "subcon";
				schContent = "";
			}
			
			if(oMemberSort == null) {
				oMemberSort = "recent";
			}
			
			 schContent = URLDecoder.decode(schContent, "utf-8");
			 if(schContent.length() != 0) {
			 	query += "&schCategory=" + schCategory + "&schContent=" + URLEncoder.encode(schContent, "utf-8");
			 }
			
			dao.hitCountCal(num);
			
			int likeCount = dao.likeCount(num);
			
			CmntDTO dto = dao.findContent(num);
			if(dto == null) {
				return new ModelAndView("/oMemberCmnt/list?" + query);
			}
			
			dto.setContent(dto.getContent().replace("\n", "<br>"));
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			boolean isLikeCmnt = dao.isLikeCmnt(num, info.getUserNum());
			
			ModelAndView mav = new ModelAndView("oMemberCmnt/article");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("isLikeCmnt", isLikeCmnt);
			mav.addObject("likeCount", likeCount);
			mav.addObject("oMemberSort", oMemberSort);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect/oMemberCmnt/list");
	}
	
	@ResponseBody
	@RequestMapping(value = "/oMemberCmnt/addlikeCmnt", method = RequestMethod.POST)
	public Map<String, Object> addlikeCmnt(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		OMemberCmntDAO dao = new OMemberCmntDAO();
		
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
	
	@RequestMapping(value = "/oMemberCmnt/update", method = RequestMethod.GET)
	public ModelAndView updateOMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지번호, 글번호, 정렬, [, 검색컬럼, 검색값]
		OMemberCmntDAO dao = new OMemberCmntDAO();
		String page = req.getParameter("page");
		String oMemberSort = req.getParameter("oMemberSort");
		
		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			long num = Long.parseLong(req.getParameter("num"));
	
			CmntDTO dto = dao.findContent(num);
			
			if(dto == null || ! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/oMemberCmnt/list?page="+ page + "&oMemberSort=" + oMemberSort);
			}
			
			ModelAndView mav = new ModelAndView("/oMemberCmnt/write");
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("oMemberSort", oMemberSort);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/oMemberCmnt/list?page=" + page + "&oMemberSort=" + oMemberSort);
	}
	
	@RequestMapping(value = "/oMemberCmnt/update", method = RequestMethod.POST)
	public ModelAndView updateOMemberOk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글번호, 페이지번호, 정렬, 제목, 내용, 파일
		
		HttpSession session = req.getSession();
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "oMemberCmnt";
		
		String page = req.getParameter("page");
		String oMemberSort = req.getParameter("oMemberSort");
		
		OMemberCmntDAO dao = new OMemberCmntDAO();
		
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
			
			dao.updateOMember(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/oMemberCmnt/list?page=" + page + "&oMemberSort=" + oMemberSort);
	}
	
	@RequestMapping(value = "/oMemberCmnt/delete", method = RequestMethod.GET)
	public ModelAndView deleteOMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 페이지, 글번호, 정렬
		OMemberCmntDAO dao = new OMemberCmntDAO();
		
		FileManager fileManager = new FileManager();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "oMemberCmnt";
		
		String page = req.getParameter("page");
		String oMemberSort = req.getParameter("oMemberSort");
		if(oMemberSort == null) {
			oMemberSort = "recent";
		}
		String query = "page=" + page + "&oMemberSort=" + oMemberSort; 
		
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
				return new ModelAndView("redirect:/oMemberCmnt/list?" + query);
			}
			
			if(! dto.getUserNum().equals(info.getUserNum())) {
				return new ModelAndView("redirect:/oMemberCmnt/list?" + query);
			}
			
			fileManager.doFiledelete(pathname, dto.getFileName());
			dao.deleteOMember(num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/oMemberCmnt/list?" + query);
	}
	
	@ResponseBody
	@RequestMapping(value = "/oMemberCmnt/addReply", method = RequestMethod.POST)
	public Map<String, Object> addReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		OMemberCmntDAO dao = new OMemberCmntDAO();
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
	
	@RequestMapping(value = "/oMemberCmnt/replyList", method = RequestMethod.GET)
	public ModelAndView replyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		OMemberCmntDAO dao = new OMemberCmntDAO();
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
			
			String paging = util.pagingMethod(current_page, total_page, "listPage");
			
			ModelAndView mav = new ModelAndView("oMemberCmnt/replyList");
			
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
	@RequestMapping(value = "/oMemberCmnt/removeReply", method = RequestMethod.POST)
	public Map<String, Object> removeReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();

		OMemberCmntDAO dao = new OMemberCmntDAO();
		
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
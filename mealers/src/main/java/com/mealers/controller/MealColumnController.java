package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.MealColumnDAO;
import com.mealers.domain.MealColumnDTO;
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
				long size = multiFile.getSize();
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
				dto.setFileSize(size);
			}
			
			dao.insertMealColumn(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mealColumn/list");
	}
	
	// 글 보기
	@RequestMapping(value = "/mealColumn/article", method = RequestMethod.GET)
	public ModelAndView mealarticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 글 번호, 페이지 번호
		MealColumnDAO dao = new MealColumnDAO();
		
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
		
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			if(kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			dao.updateHitCount(num);
			
			// 게시물 가져오기
			MealColumnDTO dto = dao.findByColumn(num);
			
			if(dto == null) {
				return new ModelAndView("edirect:/mealColumn/list?" + query);
			}
		
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			boolean isUserLike = dao.isUserMealCollike(num, info.getUserNum());
			
			ModelAndView mav = new ModelAndView("mealColumn/article");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("size", size);
			mav.addObject("query", query);
			
			mav.addObject("isUserLike", isUserLike);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/mealColumn/list?" + query);
	}
	
	@RequestMapping(value = "/mealColumn/update", method = RequestMethod.GET)
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정폼
		// 넘어온 파라미터 : 글번호, 페이지번호, size
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(! info.getUserNum().equals("1")) {
			return new ModelAndView("redirect:/mealColumn/list");
		}
		
		MealColumnDAO dao = new MealColumnDAO();
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			MealColumnDTO dto = dao.findByColumn(num);
			
			if(dto == null) {
				return new ModelAndView("redirect:/mealColumn/list?page=" + page + "&size=" + size);
			}
			
			
			ModelAndView mav = new ModelAndView("mealColumn/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("size", size);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// return new ModelAndView("redirect:/mealColumn/list?page=" + page + "&size=" + size);
		return new ModelAndView("redirect:/mealColumn/list?page=" + page);
	}
	
	
	// 컬럼 수정
	@RequestMapping(value = "/mealColumn/update", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 수정 완료
		// 넘어온 폼데이터 : 글번호, 제목, 내용, [, 파일], page, size

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		
		if(!  info.getUserNum().equals("1")) {
			return new ModelAndView("redirect:/mealColumn/list");
		}
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mealColumn";
		
		String page = req.getParameter("page");
	    // String size = req.getParameter("size");
		
		
		MealColumnDAO dao = new MealColumnDAO();
		FileManager fileManager = new FileManager();
		try {
			
			MealColumnDTO dto = new MealColumnDTO();
			
			dto.setNum(Long.parseLong(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setSaveFilename(req.getParameter("saveFilename"));
			dto.setOriginalFilename(req.getParameter("originalFilename"));
			dto.setFileSize(Long.parseLong(req.getParameter("fileSize")));

			dto.setUserNum(info.getUserNum());

			Part p = req.getPart("selectFile");
			MyMultipartFile multiFile = fileManager.doFileUpload(p, pathname);
			if (multiFile != null) {
				if (req.getParameter("saveFilename").length() != 0) {
					// 기존파일 삭제
					fileManager.doFiledelete(pathname, req.getParameter("saveFilename"));
				}

				// 새로운 파일
				String saveFilename = multiFile.getSaveFilename();
				String originalFilename = multiFile.getOriginalFilename();
				long fileSize = multiFile.getSize();
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
				dto.setFileSize(fileSize);
			}

			dao.updateMealColumn(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// return new ModelAndView("redirect:/mealColumn/list?page=" + page + "&size=" + size);
		return new ModelAndView("redirect:/mealColumn/list?page=" + page);
	}
	
	
	// 칼럼 삭제
	@RequestMapping(value = "/mealColumn/delete", method = RequestMethod.GET)
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");   
		String pathname = root + "uploads" + File.separator + "mealColumn";
		
		String page = req.getParameter("page");
		String size = req.getParameter("size");
		String query = "page=" + page + "&size=" + size;
		
		MealColumnDAO dao = new MealColumnDAO();
		FileManager fileManager = new FileManager();

		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = URLDecoder.decode(kwd, "utf-8");

			if (kwd.length() != 0) {
				query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
			}
			
			long num = Long.parseLong(req.getParameter("num"));
			
			MealColumnDTO dto  = dao.findByColumn(num);
			if (dto == null) {
				return new ModelAndView("redirect:/mealColumn/list?" + query);
			}
			
		   // admin 만 삭제 가능
			if ( ! info.getUserNum().equals("1")) {
					return new ModelAndView("redirect:/mealColumn/list?" + query );
			}
			

			if (dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
				fileManager.doFiledelete(pathname, dto.getSaveFilename());
			}
			
			
			dao.deleteMealColumn(num, info.getUserNum());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/mealColumn/list?page=" + page);
	}
	
	@RequestMapping(value = "/mealColumn/download", method = RequestMethod.GET)
	public void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파일 다운로드
		MealColumnDAO dao = new MealColumnDAO();
		HttpSession session = req.getSession();
		
		FileManager fileManager = new FileManager();
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "mealColumn";
		
		boolean b = false;

		try {
			long num = Long.parseLong(req.getParameter("num"));
			
			MealColumnDTO dto = dao.findByColumn(num);
			if (dto != null) {
				b = fileManager.doFiledownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if ( ! b ) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일다운로드가 실패 했습니다.');history.back();</script>");
		}
	}
	
	// 게시물 공감 저장
	@ResponseBody
	@RequestMapping(value = "/mealColumn/insertMealColLike", method = RequestMethod.POST)
	public Map<String, Object> insertMealColLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		MealColumnDAO dao = new MealColumnDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String state = "false";
		int likeCount = 0;
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String isNoLike = req.getParameter("isNoLike");
			
			if(isNoLike.equals("true")) {
				dao.insertMealColLike(num, info.getUserNum());
			} else {
				dao.deleteMealColLike(num, info.getUserNum());
			}
			
			likeCount = dao.countMealColLike(num);
			
			state = "true";
			
		} catch (SQLException e) {
			state = "liked";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.put("state", state);
		model.put("likeCount", likeCount);
		
		return model;
		
	}
	
	// 댓글 저장
	@ResponseBody
	@RequestMapping(value = "/mealColumn/insertReply", method = RequestMethod.POST)
	public Map<String, Object>  insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 넘어온 파라미터 : 칼럼 게시물 번호, 댓글
		Map<String, Object> model = new HashMap<String, Object>();
		
		MealColumnDAO dao = new MealColumnDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String state = "false";
		
		try {
			ReplyDTO dto = new ReplyDTO();
			long num = Long.parseLong(req.getParameter("num")); // 게시물 번호
			
			dto.setNum(num);
			dto.setUserNum(info.getUserNum());
			dto.setContent(req.getParameter("content"));
			
			dao.insertMealColReply(dto);
			
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.put("state", state);
		
		return model;
	}
	
	// 칼럼 댓글 리스트 (AJAX)
	@RequestMapping(value = "/mealColumn/listReply", method = RequestMethod.GET)
	public ModelAndView listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터 : 글번호(num) [, 페이지 번호]
		
		MealColumnDAO dao = new MealColumnDAO();
		MyUtil util = new MyUtilBootstrap();
		
		try {
			long num = Long.parseLong(req.getParameter("num"));
			String pageNo = req.getParameter("pageNo");
			int current_page = 1;
			
			if(pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}
			
			int size = 5;
			int total_page = 0;
			int replyCount = 0;
			
			replyCount = dao.dataCountMealColReply(num);
			total_page = util.pageCount(replyCount, size);
			
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page -1) * size;
			if(offset <0 ) offset  = 0;
			
			List<ReplyDTO> listReply = dao.listMealColReply(num, offset, size);
			
			for(ReplyDTO dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			// 페이징 : 자스 함수 (listPage)를 호출
			String paging = util.pagingMethod(current_page, total_page, "listPage");
			
			ModelAndView mav = new ModelAndView("mealColumn/listReply");
			
			mav.addObject("listReply", listReply);
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
	
	// 댓글 삭제
	
	
}

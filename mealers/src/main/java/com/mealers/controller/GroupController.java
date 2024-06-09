package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.GroupDAO;
import com.mealers.domain.DietGroupDTO;
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
public class GroupController {
	@RequestMapping(value = "/group/list", method = RequestMethod.GET)
	public ModelAndView listGroup(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("group/list");

		int groupNum = Integer.parseInt(req.getParameter("groupNum"));
		
		GroupDAO dao = new GroupDAO();
	    MyUtil util = new MyUtilBootstrap();


	    try {
	        String page = req.getParameter("pageNo");
	        int current_page = 1;
	        if (page != null) {
	            current_page = Integer.parseInt(page);
	        }

	        int dataCount = dao.dataCount(groupNum);
	        int size = 5;
	        int total_page = util.pageCount(dataCount, size);

	        if (current_page > total_page) {
	            current_page = total_page;
	        }

	        int offset = (current_page - 1) * size;

	        List<DietGroupDTO> list = dao.listPost(offset, size, groupNum);

	        for (DietGroupDTO dto : list) {
	            dto.setContent(dto.getContent().replaceAll(">", "&gt;"));
	            dto.setContent(dto.getContent().replaceAll("<", "&lt;"));
	            dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

	        }
	        mav.addObject("groupNum", groupNum);
			mav.addObject("list", list);

	    } catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}

	@RequestMapping(value = "/group/write", method = RequestMethod.GET)
	public ModelAndView groupWrite(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("group/write");

		return mav;
	}

	@RequestMapping(value = "/group/main", method = RequestMethod.GET)
	public ModelAndView groupMain(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("group/main");

		GroupDAO dao = new GroupDAO();

		try {
			List<DietGroupDTO> list;
			list = dao.listGroup();
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 그룹생성 파라미터 : 그룹명,소개글,파일
	@RequestMapping(value = "/group/create", method = RequestMethod.POST)
	public ModelAndView groupCreate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		GroupDAO dao = new GroupDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		FileManager fileManager = new FileManager();

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "group";

		try {
			DietGroupDTO dto = new DietGroupDTO();

			dto.setUserNum(info.getUserNum());
			dto.setGroupName(req.getParameter("groupName"));
			dto.setProFile(req.getParameter("proFile"));

			String filename = null;
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if (multipart != null) {
				filename = multipart.getSaveFilename();
			}

			if (filename != null) {
				dto.setFileName(filename);

				dao.insertGroup(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/group/main");
	}


	// 그룹 게시물 작성
	@ResponseBody
	@RequestMapping(value = "/post/insert", method = RequestMethod.POST)
	public Map<String, Object> insert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    Map<String, Object> model = new HashMap<String, Object>();

	    GroupDAO dao = new GroupDAO();
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    String state = "false";

	    try {
	        DietGroupDTO dto = new DietGroupDTO();

	        dto.setContent(req.getParameter("content"));
	        dto.setUserNum(info.getUserNum());
	        dto.setGroupNum(Integer.parseInt(req.getParameter("groupnum")));

	        dao.insertPost(dto);
	        state = "true";

	        // 수동으로 JSON 문자열 구성
	        StringBuilder postJson = new StringBuilder();
	        postJson.append("{")
	                .append("\"content\":\"").append(dto.getContent()).append("\",")
	                .append("\"userNum\":\"").append(dto.getUserNum()).append("\",")
	                .append("\"groupNum\":").append(dto.getGroupNum())
	                .append("}");

	        model.put("post", postJson.toString());

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    model.put("state", state);

	    return model;
	}

}

package com.mealers.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.dao.GroupDAO;
import com.mealers.domain.DietGroupDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.servlet.ModelAndView;
import com.mealers.util.FileManager;
import com.mealers.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class GroupController {
	@RequestMapping(value = "/group/list", method = RequestMethod.GET)
	public ModelAndView listGroup(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("group/list");
		
		return mav;
	}
	
	@RequestMapping(value="/group/write",method = RequestMethod.GET)
	public ModelAndView groupWrite(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		ModelAndView mav = new ModelAndView("group/write");
		
		return mav;
	}
	
	@RequestMapping(value="/group/main",method = RequestMethod.GET)
	public ModelAndView groupMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		ModelAndView mav = new ModelAndView("group/main");
		
		GroupDAO dao = new GroupDAO();
		
		try {
			List<DietGroupDTO> list;
			list = dao.listGroup();
			mav.addObject("list", list);
			System.out.println("컨트롤러");
			System.out.println(list.get(1).getFileName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	//그룹생성 파라미터 : 그룹명,소개글,파일
	@RequestMapping(value="/group/create",method = RequestMethod.POST)
	public ModelAndView groupCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		GroupDAO dao = new GroupDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		FileManager fileManager = new FileManager();
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "group";
		
		try {
			DietGroupDTO dto = new DietGroupDTO();
			
			dto.setUserNum(info.getUserNum());  
			dto.setGroupName(req.getParameter("groupName"));
			dto.setProFile(req.getParameter("proFile"));
			
			System.out.println("userNum: " + info.getUserNum());  // 디버깅용 출력
			
			String filename = null;
			Part p = req.getPart("selectFile");
			MyMultipartFile multipart = fileManager.doFileUpload(p, pathname);
			if(multipart != null) {
				filename = multipart.getSaveFilename();
			}
			
			if(filename != null) {
				dto.setFileName(filename);
				
				dao.insertGroup(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/group/main");
	}
}
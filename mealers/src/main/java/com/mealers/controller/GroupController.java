package com.mealers.controller;

import java.io.IOException;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GroupController {
	@RequestMapping(value = "/group/list", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
		
		return mav;
	}
} 

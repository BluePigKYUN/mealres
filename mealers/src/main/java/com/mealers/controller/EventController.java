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
public class EventController {
	
	@RequestMapping(value = "/log/event", method = RequestMethod.GET)
	public ModelAndView pageOfEvent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		ModelAndView mav = new ModelAndView("log/dailyEvent");
		
		return mav;
	}
	
	@RequestMapping(value = "/log/main")
	public ModelAndView logOfMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("log/main");
		
		return mav;
	}

}
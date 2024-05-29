package com.mealers.controller;

import java.io.IOException;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ColumnController {
	@RequestMapping(value = "/mealColumn/list")
	public ModelAndView meallist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealColumn/list");
		
		return mav;
	}
	
	@RequestMapping(value = "/exersColumn/list")
	public ModelAndView exerslist(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("exersColumn/list");
		
		return mav;
	}
}

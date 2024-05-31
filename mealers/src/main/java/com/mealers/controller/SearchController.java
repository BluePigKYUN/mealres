package com.mealers.controller;

import java.io.IOException;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class SearchController {
	@RequestMapping(value = "/search/main")
	public ModelAndView searchMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/main");
		
		return mav;
	}
	
	@RequestMapping(value = "/search/reg")
	public ModelAndView searchReg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/reg");
		
		return mav;
	}
	
	@RequestMapping(value = "/search/item")
	public ModelAndView searchItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/item");
		
		return mav;
	}
}

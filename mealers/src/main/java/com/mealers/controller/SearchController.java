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
	@RequestMapping(value = "/search")
	public ModelAndView searchMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("/search/searchMain");
		
		return mav;
	}
}

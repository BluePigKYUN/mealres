package com.mealers.controller;

import java.io.IOException;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MealCmntController {
	@RequestMapping(value = "/mealCmnt/list", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest req, HttpServletRequest resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mealCmnt/list");
		
		return mav;
	}
} 

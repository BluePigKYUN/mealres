package com.mealers.controller;

import java.io.IOException;

import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

@RequestMapping(value = "/oMemberCmnt/list", method = RequestMethod.GET)
public class OMemberCmntController {
	public ModelAndView list(HttpServletRequest req, HttpServletRequest resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("oMemberCmnt/list");
		
		return mav;
	}
}

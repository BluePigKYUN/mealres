package com.mealers.controller;

import java.io.IOException;
import java.util.List;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.dao.MealCmntDAO;
import com.mealers.dao.MealColumnDAO;
import com.mealers.domain.CmntDTO;
import com.mealers.domain.ColumnDTO;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MainController {
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("main/main");
		
		// 칼럼 5개
		MealColumnDAO mealColDAO = new MealColumnDAO();
		List<ColumnDTO> listMealcol = mealColDAO.listMealColumn(0, 2);
		List<ColumnDTO> listMealcol2 = mealColDAO.listMealColumn(3, 3);
		
		// 실시간 인기 커뮤니티(식단)
		MealCmntDAO mealCmntDAO = new MealCmntDAO();
		List<CmntDTO> listMealCmnt = mealCmntDAO.listMeal(0, 10, "hitcount");
		
		
		mav.addObject("listMealcol", listMealcol);
		mav.addObject("listMealcol2", listMealcol2);
		mav.addObject("listMealCmnt", listMealCmnt);
		
		
		return mav;
	}
}

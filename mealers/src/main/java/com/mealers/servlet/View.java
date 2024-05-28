package com.mealers.servlet;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface View {
	public void render(final Map<String, ?> model, final HttpServletRequest req, final HttpServletResponse resp) throws Exception;
}

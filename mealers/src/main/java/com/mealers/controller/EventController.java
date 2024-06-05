package com.mealers.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import com.mealers.annotation.ResponseBody;
import com.mealers.dao.EventDAO;
import com.mealers.domain.EventDTO;
import com.mealers.domain.SessionInfo;
import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.servlet.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class EventController {
	
	@RequestMapping(value = "/log/event", method = RequestMethod.GET)
	public ModelAndView logOfMain(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);
		
		String today = String.format("%04d%02d%02d", year, month, date);
		
		ModelAndView mav = new ModelAndView("log/dailyEvent");
		mav.addObject("today", today);
		return mav;
	}
	
	// AJAX - Text
		@RequestMapping(value = "/log/month", method = RequestMethod.GET)
		public ModelAndView monthSchedule(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			ModelAndView mav = new ModelAndView("log/month");
			
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1; // 0 ~ 11
			int todayYear = year;
			int todayMonth = month;
			int todayDate = cal.get(Calendar.DATE);
			
			try {
				String y = req.getParameter("year");
				String m = req.getParameter("month");

				if (y != null) {
					year = Integer.parseInt(y);
				}
				if (m != null) {
					month = Integer.parseInt(m);
				}

				// 해당년의 해당월의 1일의 요일 구하기
				cal.set(year, month - 1, 1);
				year = cal.get(Calendar.YEAR);
				month = cal.get(Calendar.MONTH) + 1;
				int week = cal.get(Calendar.DAY_OF_WEEK);
				// 1~7 (일~토)

				// 첫주의 해당년도 해당월의 1일 이전 날짜
				Calendar scal = (Calendar) cal.clone();
				scal.add(Calendar.DATE, -(week - 1));
				int syear = scal.get(Calendar.YEAR);
				int smonth = scal.get(Calendar.MONTH) + 1;
				int sdate = scal.get(Calendar.DATE);

				// 마지막주의 year년도 month월 말일주의 토요일 날짜
				Calendar ecal = (Calendar) cal.clone();
				// year년도 month월 말일
				ecal.add(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
				// year년도 month월 말일주의 토요일
				ecal.add(Calendar.DATE, 7 - ecal.get(Calendar.DAY_OF_WEEK));
				int eyear = ecal.get(Calendar.YEAR);
				int emonth = ecal.get(Calendar.MONTH) + 1;
				int edate = ecal.get(Calendar.DATE);

				// 스케쥴 가져오기
				String startDay = String.format("%04d%02d%02d", syear, smonth, sdate);
				String endDay = String.format("%04d%02d%02d", eyear, emonth, edate);
				List<EventDTO> list = dao.listMonth(startDay, endDay, info.getUserId());

				String s;
				String[][] days = new String[cal.getActualMaximum(Calendar.WEEK_OF_MONTH)][7];

				// 해당년도 해당 월의 날짜 및 일정 출력
				int row, n = 0;
				int cnt;

				jump: for (row = 0; row < days.length; row++) {
					for (int i = week - 1; i < 7; i++) {
						n++;
						s = String.format("%04d%02d%02d", year, month, n);

						if (i == 0) {
							days[row][i] = "<span class='textDate sundayDate' data-date='" + s + "' >" + n + "</span>";
						} else if (i == 6) {
							days[row][i] = "<span class='textDate saturdayDate' data-date='" + s + "' >" + n + "</span>";
						} else {
							days[row][i] = "<span class='textDate nowDate' data-date='" + s + "' >" + n + "</span>";
						}

						cnt = 0;
						for (EventDTO dto : list) {
							int sd8 = Integer.parseInt(dto.getEvent_date());
							int sd4 = Integer.parseInt(dto.getEvent_date().substring(4));
							int ed8 = -1;
							//내 DTO 에는 endDay가 없어서 주석처리
							/*if (dto.getEday() != null) {
								ed8 = Integer.parseInt(dto.getEday());
							}*/
							int cn8 = Integer.parseInt(s);
							int cn4 = Integer.parseInt(s.substring(4));

							if (cnt == 4) {
								days[row][i] += "<span class='scheduleMore' data-date='" + s + "' >" + "more..." + "</span>";
								break;
							}

						}

						if (n == cal.getActualMaximum(Calendar.DATE)) {
							week = i + 1;
							break jump;
						}
					}
					week = 1;
				}

				String today = String.format("%04d%02d%02d", todayYear, todayMonth, todayDate);

				mav.addObject("year", year);
				mav.addObject("month", month);
				mav.addObject("todayYear", todayYear);
				mav.addObject("todayMonth", todayMonth);
				mav.addObject("todayDate", todayDate);
				mav.addObject("today", today);
				mav.addObject("days", days);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return mav;
		}

		// AJAX - Text
		@RequestMapping(value = "/log/day", method = RequestMethod.GET)
		public ModelAndView daySchedule(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			ModelAndView mav = new ModelAndView("log/day");
			
			try {
				String date = req.getParameter("date");
				String snum = req.getParameter("num");

				Calendar cal = Calendar.getInstance();

				// 오늘날짜
				String today = String.format("%04d%02d%02d", 
						cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DATE));
				if (date == null || !Pattern.matches("^\\d{8}$", date)) {
					date = today;
				}
				
				// 일일 일정을 출력할 년, 월, 일
				int year = Integer.parseInt(date.substring(0, 4));
				int month = Integer.parseInt(date.substring(4, 6));
				int day = Integer.parseInt(date.substring(6));

				cal.set(year, month - 1, day);
				year = cal.get(Calendar.YEAR);
				month = cal.get(Calendar.MONTH) + 1;
				day = cal.get(Calendar.DATE);

				cal.set(year, month - 1, 1);
				int week = cal.get(Calendar.DAY_OF_WEEK);

				// 테이블에서 일일 전체일정 리스트 가져오기
				date = String.format("%04d%02d%02d", year, month, day);
				List<EventDTO> list = dao.listDay(date, info.getUserId());

				long num = 0;
				EventDTO dto = null;
				if (snum != null) {
					num = Long.parseLong(snum);
					dto = dao.readSchedule(num);
				}
				if (dto == null && list.size() > 0) {
					dto = dao.readSchedule(list.get(0).getEvent_num());
				}

				// 이전달과 다음달 1일의 날짜
				Calendar cal2 = (Calendar) cal.clone();
				cal2.add(Calendar.MONTH, -1);
				cal2.set(Calendar.DATE, 1);
				String preMonth = String.format("%04d%02d%02d", 
						cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH) + 1, cal2.get(Calendar.DATE));

				cal2.add(Calendar.MONTH, 2);
				String nextMonth = String.format("%04d%02d%02d", 
						cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH) + 1, cal2.get(Calendar.DATE));

				// 첫주의 year년도 month월 1일 이전 날짜
				Calendar scal = (Calendar) cal.clone();
				scal.add(Calendar.DATE, -(week - 1));
				int syear = scal.get(Calendar.YEAR);
				int smonth = scal.get(Calendar.MONTH) + 1;
				int sdate = scal.get(Calendar.DATE);

				// 마지막주의 year년도 month월 말일주의 토요일 날짜
				Calendar ecal = (Calendar) cal.clone();
				// year년도 month월 말일
				ecal.add(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
				// year년도 month월 말일주의 토요일
				ecal.add(Calendar.DATE, 7 - ecal.get(Calendar.DAY_OF_WEEK));
				int eyear = ecal.get(Calendar.YEAR);
				int emonth = ecal.get(Calendar.MONTH) + 1;

				String s;
				String[][] days = new String[cal.getActualMaximum(Calendar.WEEK_OF_MONTH)][7];

				// 1일 앞의 전달 날짜
				for (int i = 1; i < week; i++) {
					s = String.format("%04d%02d%02d", syear, smonth, sdate);
					days[0][i - 1] = "<span class='textDate preMonthDate' data-date='" + s + "' >" + sdate + "</span>";
					sdate++;
				}

				// year년도 month월 날짜
				int row, n = 0;
				
				jump:
				for (row = 0; row < days.length; row++) {
					for (int i = week - 1; i < 7; i++) {
						n++;
						s = String.format("%04d%02d%02d", year, month, n);

						if (i == 0) {
							days[row][i] = "<span class='textDate sundayDate' data-date='" + s + "' >" + n + "</span>";
						} else if (i == 6) {
							days[row][i] = "<span class='textDate saturdayDate' data-date='" + s + "' >" + n + "</span>";
						} else {
							days[row][i] = "<span class='textDate nowDate' data-date='" + s + "' >" + n + "</span>";
						}

						if (n == cal.getActualMaximum(Calendar.DATE)) {
							week = i + 1;
							break jump;
						}
					}
					week = 1;
				}

				mav.addObject("year", year);
				mav.addObject("month", month);
				mav.addObject("day", day);
				mav.addObject("date", date);
				mav.addObject("today", today);
				mav.addObject("preMonth", preMonth);
				mav.addObject("nextMonth", nextMonth);

				mav.addObject("days", days);
				mav.addObject("dto", dto);
				mav.addObject("list", list);

			} catch (Exception e) {
				e.printStackTrace();
			}

			return mav;
		}

		// AJAX - Text
		@RequestMapping(value = "/log/year", method = RequestMethod.GET)
		public ModelAndView yearSchedule(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			ModelAndView mav = new ModelAndView("log/year");
			
			try {
				String syear = req.getParameter("year");
				
				Calendar cal = Calendar.getInstance();
				int year = cal.get(Calendar.YEAR);

				int todayYear = cal.get(Calendar.YEAR);
				String today = String.format("%04d%02d%02d", 
						cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DATE));

				if (syear != null) {
					year = Integer.parseInt(syear);
				}
				if (year < 1900) {
					year = cal.get(Calendar.YEAR);
				}

				String days[][][] = new String[12][6][7];

				int row, col, month_of_day;
				String s;
				for (int m = 1; m <= 12; m++) {
					cal.set(year, m - 1, 1);
					row = 0;
					col = cal.get(Calendar.DAY_OF_WEEK) - 1;
					month_of_day = cal.getActualMaximum(Calendar.DATE);
					for (int i = 1; i <= month_of_day; i++) {
						s = String.format("%04d%02d%02d", year, m, i);

						if (col == 0) {
							days[m - 1][row][col] = "<span class='textDate sundayDate' data-date='" + s + "' >" + i + "</span>";
						} else if (col == 6) {
							days[m - 1][row][col] = "<span class='textDate saturdayDate' data-date='" + s + "' >" + i
									+ "</span>";
						} else {
							days[m - 1][row][col] = "<span class='textDate nowDate' data-date='" + s + "' >" + i + "</span>";
						}

						col++;
						if (col > 6) {
							col = 0;
							row++;
						}
					}
				}

				req.setAttribute("year", year);

				req.setAttribute("todayYear", todayYear);
				req.setAttribute("today", today);
				req.setAttribute("days", days);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return mav;
		}

		// AJAX - JSON
		@ResponseBody
		@RequestMapping(value = "/log/insert", method = RequestMethod.POST)
		public Map<String, Object> insertSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			Map<String, Object> model = new HashMap<String, Object>();
			
			String state = "false";
			try {
				EventDTO dto = new EventDTO();
				
				dto.setUserNum(info.getUserNum());
				dto.setTitle(req.getParameter("subject"));
				dto.setColor(req.getParameter("color"));
				dto.setEvent_date(req.getParameter("sday").replaceAll("-", ""));
				dto.setEvent_start_time(req.getParameter("stime").replaceAll(":", ""));
				dto.setEvent_end_time(req.getParameter("etime").replaceAll(":", ""));
				if (req.getParameter("allDay") != null) {
					dto.setEvent_start_time("");
					dto.setEvent_end_time("");
				}

				dto.setMemo(req.getParameter("memo"));

				dao.insertEvent(dto);
				state = "true";
			} catch (Exception e) {
				e.printStackTrace();
			}

			model.put("state", state);

			return model;
		}

		// AJAX-JSON
		@ResponseBody
		@RequestMapping(value = "/log/update", method = RequestMethod.POST)
		public Map<String, Object> updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			Map<String, Object> model = new HashMap<String, Object>();
			
			String state = "false";
			try {
				EventDTO dto = new EventDTO();
				
				dto.setUserNum(info.getUserNum());
				dto.setEvent_num(Long.parseLong(req.getParameter("num")));
				dto.setTitle(req.getParameter("subject"));
				dto.setColor(req.getParameter("color"));
				dto.setEvent_date(req.getParameter("sday").replaceAll("-", ""));
				dto.setEvent_start_time(req.getParameter("stime").replaceAll(":", ""));
				dto.setEvent_end_time(req.getParameter("etime").replaceAll(":", ""));
				
				if (req.getParameter("allDay") != null) {
					dto.setEvent_start_time("");
					dto.setEvent_end_time("");
				}

				dto.setMemo(req.getParameter("memo"));

				dao.updateSchedule(dto);
				state = "true";
			} catch (Exception e) {
				e.printStackTrace();
			}

			model.put("state", state);

			return model;
		}

		// AJAX-JSON
		@ResponseBody
		@RequestMapping(value = "/schedule/delete", method = RequestMethod.POST)
		public Map<String, Object> deleteSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			Map<String, Object> model = new HashMap<String, Object>();
			
			String state = "false";
			try {
				long num = Long.parseLong(req.getParameter("num"));

				dao.deleteSchedule(num, info.getUserId());
				state = "true"; 
			} catch (Exception e) {
				e.printStackTrace();
			}

			model.put("state", state);

			return model;
		}
	}



package com.mealers.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import com.mealers.annotation.Controller;
import com.mealers.annotation.RequestMapping;
import com.mealers.annotation.RequestMethod;
import com.mealers.annotation.ResponseBody;
import com.mealers.dao.EventDAO;
import com.mealers.domain.EventDTO;
import com.mealers.domain.SessionInfo;
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
		mav.addObject("totoday", EventDAO.formatDate(today));
		return mav;
	}
	
    // AJAX - 오늘 일정 가져오기(TEXT)
    @RequestMapping(value = "/log/todaysEvent", method = RequestMethod.GET)
    public ModelAndView getEvents(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("log/todaysEvent");
    	EventDAO dao = new EventDAO();
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        try {
			List<EventDTO> list = dao.getTodayEvents(info.getUserNum());
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
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
			int thisdate = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
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
				String startDate = String.format("%04d%02d%02d", syear, smonth, thisdate);
				String endDay = String.format("%04d%02d%02d", eyear, emonth, edate);
				List<EventDTO> list = dao.listMonth(startDate, endDay, info.getUserNum());
	
				String s;
				String[][] days = new String[cal.getActualMaximum(Calendar.WEEK_OF_MONTH)][7];

				// 해당년도 해당 월의 날짜 및 일정 출력
				int row, n = 0;
				int cnt;

				jump: 
				for (row = 0; row < days.length; row++) {
					for (int i = week - 1; i < 7; i++) {
						n++;
						s = String.format("%04d%02d%02d", year, month, n);
						//달력을 만드는 부분
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
							if (dto.getEvent_date() != null) {
								ed8 = Integer.parseInt(dto.getEvent_date());
							}
							int cn8 = Integer.parseInt(s);
							int cn4 = Integer.parseInt(s.substring(4));

							if (cnt == 2) {
								days[row][i] += "<span class='scheduleMore' data-date='" + s + "' >" + "더보기" + "</span>";
								break;
							}

							if (((sd8 == cn8 || sd8 <= cn8 && ed8 >= cn8))
									|| (sd4 == cn4)) {
								days[row][i] += "<span class='scheduleSubject' "
										+ "style='margin: 1px; max-width: 45px; color: white; display: block; "
										+ "cursor: pointer; font-size: 8px; "
										+ "text-overflow: ellipsis; white-space: nowrap; overflow: hidden; "
										+ "border-radius: 8px; padding: 2px 4px; "
										+ "background-color: " + hexToRGB(dto.getColor(), 0.5) + ";' data-date='" + s + "' data-num='" + dto.getEvent_num()
								+ "' >" + dto.getTitle() + "</span>";
								cnt++;
							} else if (((sd8 > cn8 && ed8 < cn8))
									|| (sd4 > cn4)) {
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
		
		/**
		 * hex 코드로 받아온 색상을 RGBA값으로 반환
		 * @param hex
		 * @param alpha
		 * @return
		 */
		public static String hexToRGB(String hex, double alpha) {
			if (hex.startsWith("#")) {
	            hex = hex.substring(1);
	        }
			
	        if (hex.length() == 3) {
	            hex = "" + hex.charAt(0) + hex.charAt(0)
	                      + hex.charAt(1) + hex.charAt(1)
	                      + hex.charAt(2) + hex.charAt(2);
	        }
	        
	        if (hex.length() != 6) {
	            throw new IllegalArgumentException("잘못된 색상 확인: " + hex);
	        }
	        
	        int r = Integer.parseInt(hex.substring(0, 2), 16);
	        int g = Integer.parseInt(hex.substring(2, 4), 16);
	        int b = Integer.parseInt(hex.substring(4, 6), 16);

	        // RGBA 문자열 반환
	        return String.format("rgba(%d, %d, %d, %.1f)", r, g, b, alpha);
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
				List<EventDTO> list = dao.listDay(info.getUserNum(), date);

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


				// year년도 month월 날짜
				int row, n = 0;
				
				jump:
				for (row = 0; row < days.length; row++) {
					for (int i = week - 1; i < 7; i++) {
						n++;
						s = String.format("%04d%02d%02d", year, month, n);
						
						EventDTO isEvent = dao.findByEvent(info.getUserNum(), s);
						String css = "";
						
		                if (isEvent != null) {
		                	css = "text-warning"; // 일정이 있는 경우 적용할 CSS 클래스
		                }
		                
						if (i == 0) {
							days[row][i] = "<span class='textDate sundayDate " + css + "' data-date='" + s + "' >" + n + "</span>";
						} else if (i == 6) {
							days[row][i] = "<span class='textDate saturdayDate " + css + "'  data-date='" + s + "' >" + n + "</span>";
						} else {
							days[row][i] = "<span class='textDate nowDate " + css + "'  data-date='" + s + "' >" + n + "</span>";
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
				dto.setColor(req.getParameter("bgColor"));
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
				dto.setColor(req.getParameter("bgColor"));
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
		@RequestMapping(value = "/log/delete", method = RequestMethod.POST)
		public Map<String, Object> deleteSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			EventDAO dao = new EventDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			Map<String, Object> model = new HashMap<String, Object>();
			
			String state = "false";
			try {
				long num = Long.parseLong(req.getParameter("num"));

				dao.deleteSchedule(num, info.getUserNum());
				state = "true"; 
			} catch (Exception e) {
				e.printStackTrace();
			}

			model.put("state", state);

			return model;
		}
	}



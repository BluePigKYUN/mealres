package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.EventDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class EventDAO {
	private Connection conn = DBConn.getConnection();

	public void insertEvent(EventDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO event(EVENT_NUM, TITLE, MEMO, COLOR, REG_DATE_EVENT, ";
			sql += "  EVENT_DATE, EVENT_START_TIME, EVENT_END_TIME, USERNUM) ";
			sql += " VALUES(Event_seq.nextVal, ?, ?, ?, sysDate, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getMemo());
			pstmt.setString(3, dto.getColor());
			pstmt.setString(4, dto.getEvent_date());
			pstmt.setString(5, dto.getEvent_start_time());
			pstmt.setString(6, dto.getEvent_end_time());
			pstmt.setString(7, dto.getUserNum());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}

	}
	
	//오늘 일정 가져오기
    public List<EventDTO> getTodayEvents(String userNum) throws SQLException {
        List<EventDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;

        try {
            sql = "SELECT title, EVENT_START_TIME, EVENT_END_TIME, event_num ";
            sql += "FROM event WHERE userNum = ? AND TRUNC(EVENT_DATE) = TRUNC(SYSDATE) ";
            sql += "Order By EVENT_START_TIME ASC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                EventDTO dto = new EventDTO();
                
                dto.setTitle(rs.getString("title"));
                dto.setEvent_start_time(formatTime(rs.getString("EVENT_START_TIME")));
                dto.setEvent_end_time(formatTime(rs.getString("EVENT_END_TIME")));
                dto.setEvent_num(rs.getLong("event_num"));
                
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            DBUtil.close(rs);
            DBUtil.close(pstmt);
        }

        return list;
    }

    public List<EventDTO> listMonth(String startDate, String EndDate, String userNum) {
        List<EventDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sb = new StringBuilder();

        try {
            sb.append("SELECT event_num, title, To_Char(event_date, 'YYYYMMDD') event_date, ");
            sb.append(" event_start_time, event_end_time, ");
            sb.append("color, memo, To_Char(REG_DATE_EVENT, 'YYYYMMDD') REG_DATE_EVENT ");
            sb.append("FROM event ");
            sb.append("WHERE usernum = ? And event_date Between ? And ? ");
            sb.append("ORDER BY event_date ASC, event_num DESC");

            pstmt = conn.prepareStatement(sb.toString());
            
            pstmt.setString(1, userNum);
            pstmt.setString(2, startDate);
            pstmt.setString(3, EndDate);

            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                EventDTO dto = new EventDTO();
                
                dto.setEvent_num(rs.getLong("event_num"));
                dto.setTitle(rs.getString("title"));
                dto.setEvent_date(rs.getString("event_date"));
                dto.setReg_date_event(rs.getString("REG_DATE_EVENT"));
                dto.setEvent_start_time(rs.getString("event_start_time"));
                dto.setEvent_end_time(rs.getString("event_end_time"));
                dto.setColor(rs.getString("color"));
                dto.setMemo(rs.getString("memo"));

                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(pstmt);
        }

        return list;
    }
    
    public EventDTO findByEvent(String userNum, String date) {
    	EventDTO dto = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	StringBuilder sb = new StringBuilder();
    	
    	try {
			sb.append("Select event_num ");
			sb.append("From event ");
			sb.append("Where usernum = ? And TRUNC(EVENT_DATE) = TO_DATE(?, 'YYYYMMDD')");

			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, userNum);
			pstmt.setString(2, date);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new EventDTO();
				
				dto.setUserNum(rs.getString("event_num"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
    	
    	return dto;
    }

    public List<EventDTO> listDay(String userNum, String date) {
        List<EventDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sb = new StringBuilder();

        try {
            sb.append("SELECT event_num, title, event_date, event_start_time, event_end_time, color, memo ");
            sb.append("FROM event ");
            sb.append("WHERE usernum = ? AND ");
            sb.append("TO_CHAR(event_date, 'YYYYMMDD') = TO_DATE(?, 'YYYYMMDD') ");
            sb.append("ORDER BY event_num DESC");

            pstmt = conn.prepareStatement(sb.toString());
            
            pstmt.setString(1, userNum);
            pstmt.setString(2, date);

            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                EventDTO dto = new EventDTO();
                
                dto.setEvent_num(rs.getLong("event_num"));
                dto.setTitle(rs.getString("title"));
                dto.setEvent_date(rs.getString("event_date"));
                dto.setEvent_start_time(rs.getString("event_start_time"));
                dto.setEvent_end_time(rs.getString("event_end_time"));
                dto.setColor(rs.getString("color"));
                dto.setMemo(rs.getString("memo"));

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(pstmt);
        }

        return list;
    }

    public EventDTO readSchedule(long num) {
        EventDTO dto = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;
        //String s;

        try {
            sql = "SELECT event_num, title, event_date, event_start_time, event_end_time, color, memo, reg_date_event "
                + "FROM event "
                + "WHERE event_num = ?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setLong(1, num);

            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                
                dto = new EventDTO();
                dto.setEvent_num(rs.getLong("event_num"));
                dto.setTitle(rs.getString("title"));
                dto.setEvent_date(formatDate(rs.getString("event_date")));
                dto.setEvent_start_time(formatTime(rs.getString("event_start_time")));
                dto.setEvent_end_time(formatTime(rs.getString("event_end_time")));
                dto.setColor(rs.getString("color"));
                dto.setMemo(rs.getString("memo"));
                dto.setReg_date_event(rs.getString("reg_date_event"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs);
            DBUtil.close(pstmt);
        }

        return dto;
    }
    /**
     * 날짜 변환해주는 용도
     * @param date
     * @return
     */
    public static String formatDate(String date) {
        if (date != null && date.length() == 8) {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
        }
        return date;
    }
    /**
     * 시간 변환해주는 용도
     * @param time
     * @return
     */
    public static String formatTime(String time) {
        if (time != null && time.length() == 4) {
            return time.substring(0, 2) + ":" + time.substring(2);
        }
        return time;
    }

    public void updateSchedule(EventDTO dto) throws SQLException {
        PreparedStatement pstmt = null;
        StringBuilder sb = new StringBuilder();

        try {
            sb.append("UPDATE event SET ");
            sb.append("title = ?, color = ?, event_date = ?, event_start_time = ?, ");
            sb.append("event_end_time = ?, memo = ? ");
            sb.append("WHERE event_num = ? AND usernum = ?");

            pstmt = conn.prepareStatement(sb.toString());

            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getColor());
            pstmt.setString(3, dto.getEvent_date());
            pstmt.setString(4, dto.getEvent_start_time());
            pstmt.setString(5, dto.getEvent_end_time());
            pstmt.setString(6, dto.getMemo());
            pstmt.setLong(7, dto.getEvent_num());
            pstmt.setString(8, dto.getUserNum());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(pstmt);
        }
    }

    public void deleteSchedule(long eventNum, String userNum) throws SQLException {
        PreparedStatement pstmt = null;
        String sql;

        try {
            sql = "DELETE FROM event WHERE event_num = ? AND usernum = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, eventNum);
            pstmt.setString(2, userNum);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(pstmt);
        }
    }
}

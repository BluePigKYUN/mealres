package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.DiaryDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class DiaryDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertDiary(DiaryDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		StringBuilder sb = new StringBuilder();
		ResultSet rs = null;
		
		try {
			
			// 이미 오늘의 기록이 있는 경우
			/*
			sb.append("Select Count(*) From Diary Where userNum = ? And to_char(reg_date_diary, 'yyyy-mm-dd') = to_char(sysDate, 'yyyy-mm-dd')");
			
	        pstmt = conn.prepareStatement(sb.toString());
	        pstmt.setString(1, dto.getUserNum());
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next() && rs.getInt(1) > 0) {
	            throw new SQLException("이미 오늘의 일기가 있습니다.");
	        }
	        
	        DBUtil.close(pstmt);
	        */
	        
	        // 새로운 일기 입력
	        sb.setLength(0);
			sb.append("Insert Into Diary(diary_num, reg_date_diary, subject, ");
			sb.append("content, userNum, memberId, emoji) ");
			sb.append("Values(diary_seq.nextval, sysDate, ?, ?, ?, ?, ?)");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getUserNum());
			pstmt.setString(4, dto.getMemberId());
			pstmt.setString(5, dto.getEmoji());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public long findByDiaryNum(String memberId) {
		long num = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select DIARY_NUM From Diary Where memberId = ? Order By Diary_Num Desc");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getLong("DIARY_NUM");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
		
		
		return num;
	}
	
	public List<DiaryDTO> listDiary(int offset, int size, String memberId){
		List<DiaryDTO> list = new ArrayList<DiaryDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select diary_num, To_Char(reg_date_diary, 'yyyy-mm-dd') reg_date_diary, emoji, subject, content, d.userNum, d.memberId ");
			sb.append("From diary d ");
			sb.append("Join Member m On d.userNum = m.userNum ");
			sb.append("Where d.memberId = ? ");
			sb.append("Order By Diary_num Desc ");
			sb.append("Offset ? Rows Fetch First ? Rows only ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DiaryDTO dto = new DiaryDTO();
				
				dto.setDiary_Num(rs.getLong("diary_num"));
				dto.setSubject(rs.getString("subject"));
				dto.setEmoji(rs.getString("emoji"));
				dto.setReg_date_diary(rs.getString("reg_date_diary"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
		
	}
	
	public List<DiaryDTO> fullListDiary(String memberId){
		List<DiaryDTO> list = new ArrayList<DiaryDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select diary_num, To_Char(reg_date_diary, 'yyyy-mm-dd') reg_date_diary, emoji, subject, content, d.userNum, d.memberId ");
			sb.append("From diary d ");
			sb.append("Join Member m On d.userNum = m.userNum ");
			sb.append("Where d.memberId = ? ");
			sb.append("Order By Diary_num Desc ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DiaryDTO dto = new DiaryDTO();
				
				dto.setDiary_Num(rs.getLong("diary_num"));
				dto.setSubject(rs.getString("subject"));
				dto.setEmoji(rs.getString("emoji"));
				dto.setReg_date_diary(rs.getString("reg_date_diary"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
		
	}
	
	public DiaryDTO oneDiary(String memberId, String diaryNum) {
		DiaryDTO dto = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select diary_num, To_Char(reg_date_diary, 'yyyy-mm-dd') reg_date_diary, subject, emoji, content, d.userNum, d.memberId ");
			sb.append("From diary d ");
			sb.append("Join Member m On d.userNum = m.userNum ");
			sb.append("Where d.memberId = ? And diary_num = ? ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			pstmt.setString(2, diaryNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new DiaryDTO();
				
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date_diary(rs.getString("reg_date_diary"));
				dto.setEmoji(rs.getString("emoji"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public int dataCount(String memberId) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "Select Nvl(Count(*), 0) From diary Where MemberId = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return result;
	}
	
	public void deleteDiary(long diaryNum) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "Delete From Diary Where Diary_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, diaryNum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public List<DiaryDTO> emojiList(String date, String memberId) {
		List<DiaryDTO> list = new ArrayList<DiaryDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "Select Nvl(emoji, 0) From diary d";
			sql += "Join Member m On m.memberId = d.memberId ";
			sql += "Where to_char(?, 'yyyy-mm-dd') = To_Char(sysDate, 'yyyy-mm-dd') And d.MemberId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, memberId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DiaryDTO dto = new DiaryDTO();
				
				dto.setEmoji(rs.getString("emoji"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

}

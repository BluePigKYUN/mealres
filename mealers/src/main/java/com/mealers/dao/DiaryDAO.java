package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mealers.domain.DiaryDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class DiaryDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertDiary(DiaryDTO dto) {
		PreparedStatement pstmt = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Insert Into Diary(diary_num, reg_date_diary, subject, ");
			sb.append("content, userNum, memberId) ");
			sb.append("Values(diary_seq.nextval, sysDate, ?, ?, ?, ?)");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getUserNum());
			pstmt.setString(4, dto.getMemberId());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public long findByUserNum(String memberId) {
		long num = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select userNum From member Where memberId = ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getLong("userNum");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
		
		
		return num;
	}

}

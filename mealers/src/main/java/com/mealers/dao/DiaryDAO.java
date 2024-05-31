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
	
	public List<DiaryDTO> listDiary(int offset, int size, String memberId){
		List<DiaryDTO> list = new ArrayList<DiaryDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("Select diary_num, reg_date_diary, subject, content, userNum, memberId ");
			sb.append("From diary d ");
			sb.append("Join Member m On d.userNum = m.userNum ");
			sb.append("Where memberId = ? ");
			sb.append("Offset ? Rows Fetch First ? Rows only");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, memberId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DiaryDTO dto = new DiaryDTO();
				
				dto.setSubject(rs.getString("subject"));
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
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "Select Nvl(Count(*), 0), From diary Where MemberId = ?";
			pstmt = conn.prepareStatement(sql);
			
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

}

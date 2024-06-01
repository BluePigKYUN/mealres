package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mealers.domain.MealColumnDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MealColumnDAO {
	private Connection conn = DBConn.getConnection();
	
	// 식단 칼럼에 데이터 넣기
	public void insertMealColumn(MealColumnDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealColumn(num, subject, content, reg_date, hitCount, userNum  )"
					+ " VALUES(mealCol_seq.NEXTVAL, ?, ?, SYSDATE, 0, ? ) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
		    pstmt.setString(3, dto.getUserNum());
			
			pstmt.executeUpdate();
			DBUtil.close(pstmt);
			pstmt = null;
			
			sql = "INSERT INTO mealColumnFile(fileNum, num, saveFilename, originalFilename ) "
					+ "VALUES(mealColFile_seq.NEXTVAL, mealCol_seq.CURRVAL, ?, ? ) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSaveFilename());
			pstmt.setString(2, dto.getOriginalFilename());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
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

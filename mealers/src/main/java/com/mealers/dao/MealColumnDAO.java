package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
					+ " VALUES(mealCol_seq.NEXTVAL, ?, ?, SYSDATE, 0, ?) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1,  dto.getNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getUserNum());
			
			pstmt.executeUpdate();
			DBUtil.close(pstmt);
			pstmt = null;
			
			sql = "INSERT INTO mealColumnFile(fileNum, fileName, num) "
					+ "VALUES(mealColFile_seq.NEXTVAL, ?, mealCol_seq.CURRVAL) ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFileName());
			pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
		
	}
	
	
}

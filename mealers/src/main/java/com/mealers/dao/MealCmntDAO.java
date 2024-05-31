package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.mealers.domain.MealCmntDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MealCmntDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertMeal(MealCmntDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealCmnt(num, userNum, subject, content, reg_date, hitCount) "
					+ " VALUES (mealCmnt_seq.NEXTVAL, ?, ?, ?, SYSDATE, 0)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getUserNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
}

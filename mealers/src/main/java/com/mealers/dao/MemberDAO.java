package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mealers.domain.MemberDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MemberDAO {
	private Connection conn = DBConn.getConnection();
	
	public MemberDTO loginMember(String memberId, String memberPwd) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = " SELECT userNum, memberId, memberPwd, mem_Nick, mem_Email, sign_reg_date "
					+ " FROM member"
					+ " WHERE memberId = ? AND memberPwd = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setMemberId(rs.getString("memberId"));
				dto.setMemberPwd(rs.getString("memberPwd"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setUserNum(rs.getString("userNum"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}	

}

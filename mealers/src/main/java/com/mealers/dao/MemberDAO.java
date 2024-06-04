package com.mealers.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mealers.domain.MemberDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

import jakarta.servlet.ServletException;

public class MemberDAO {
	private Connection conn = DBConn.getConnection();
	
	/**
	 * 로그인 
	 * @param memberId
	 * @param memberPwd
	 * @return memberDTO
	 */ 
	public MemberDTO loginMember(String memberId, String memberPwd) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT USERNUM, MEMBERID, MEMBERPWD, MEM_NICK, MEM_EMAIL, SIGN_REG_DATE,MODIFY_DATE "
					+" FROM MEMBER"
					+" WHERE MEMBERID = ? AND MEMBERPWD = ? AND ENABLED = 1";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setUserNum(rs.getString("USERNUM"));
				dto.setMemberId(rs.getString("MEMBERID"));
				dto.setMemberPwd(rs.getString("MEMBERPWD"));
				dto.setMem_Nick(rs.getString("MEM_NICK"));
				dto.setMem_Email(rs.getString("MEM_EMAIL"));
				dto.setSign_reg_date(rs.getString("SIGN_REG_DATE"));
				dto.setModify_date(rs.getString("MODIFY_DATE"));
				
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
	 * 회원가입
	 * @param MemberDTO
	 */
	public void insertMember(MemberDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			conn.setAutoCommit(false);
			
			sql = "INSERT INTO MEMBER (USERNUM, MEMBERID, MEMBERPWD, MEM_NICK, MEM_EMAIL, SIGN_REG_DATE, ENABLED, MODIFY_DATE)"
	                + " VALUES (USERNUM_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE, 1, SYSDATE)";
	        pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMemberId());
	        pstmt.setString(2, dto.getMemberPwd());
	        pstmt.setString(3, dto.getMem_Nick());
	        pstmt.setString(4, dto.getMem_Email());
			pstmt.executeUpdate();
			
			conn.commit();
			
		} catch (SQLException e) {
			DBUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
			
			try {
				conn.setAutoCommit(true); // 자동커밋
			} catch (SQLException e2) {
			}
		}
	}
	
	/**
	 * 아이디 존재 여부 
	 * @param memberId
	 * @return
	 */
	public MemberDTO findById(String memberId) {
		MemberDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT * FROM MEMBER WHERE MEMBERID=?";
			pstmt = conn.prepareStatement(sql);  
	        pstmt.setString(1, memberId);
	        rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDTO();
				
				dto.setUserNum(rs.getString("USERNUM"));
				dto.setMemberId(rs.getString("MEMBERID"));
				dto.setMemberPwd(rs.getString("MEMBERPWD"));
				dto.setMem_Nick(rs.getString("MEM_NICK"));
				dto.setMem_Email(rs.getString("MEM_EMAIL"));
				dto.setSign_reg_date(rs.getString("SIGN_REG_DATE"));
				dto.setModify_date(rs.getString("MODIFY_DATE"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	/**
	 * 회원 탈퇴
	 */
	public void deleteMember(String memberId) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "DELETE FROM member WHERE MEMBERID=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, memberId);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}

	}
	
	public void updateMember(MemberDTO dto) throws ServletException,IOException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE MEMBER SET MEMBERPWD=?,MEM_NICK=?,MEM_EMAIL=?,MODIFY_DATE=SYSDATE "
					+ "WHERE MEMBERID=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMemberPwd());
			pstmt.setString(2, dto.getMem_Nick());
			pstmt.setString(3, dto.getMem_Email());
			pstmt.setString(4, dto.getMemberId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(pstmt);
		}
		
	}
	
}

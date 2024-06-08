package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.DietGroupDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;


public class GroupDAO {
	private Connection conn = DBConn.getConnection();
	
	/*
	public void insertGroup(DietGroupDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO DIETGROUP (GROUPNUM, GROUPNAME, PROFILE, REG_DATE, USERNUM, FILENAME)"
					+ "VALUES (GROUPNUM_SEQ.NEXTVAL, ?, ?, SYSDATE, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getGorupName());
			pstmt.setString(2, dto.getProFile());
			pstmt.setString(3, dto.getUserNum());  
			pstmt.setString(4, dto.getFileName());
			
			
			
			System.out.println("test2");
			System.out.println(dto.getGorupName());
			
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	*/
	public void insertGroup(DietGroupDTO dto) throws SQLException {
	    PreparedStatement pstmt = null;
	    String sql;

	    try {
	        sql = "INSERT INTO DIETGROUP (GROUPNUM, GROUPNAME, PROFILE, REG_DATE, USERNUM, FILENAME)"
	                + "VALUES (GROUPNUM_SEQ.NEXTVAL, ?, ?, SYSDATE, ?, ?)";

	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, dto.getGroupName());
	        pstmt.setString(2, dto.getProFile());
	        
	        // USERNUM이 유효한 숫자인지 확인
	        int userNum = Integer.parseInt(dto.getUserNum());
	        pstmt.setInt(3, userNum);
	        pstmt.setString(4, dto.getFileName());

	        System.out.println("test2");
	        System.out.println(dto.getGroupNum());
	        System.out.println(dto.getGroupName());
	        System.out.println(dto.getProFile());
	        System.out.println(dto.getReg_Date());
	        System.out.println(dto.getUserNum());
	        System.out.println(dto.getFileName());

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        DBUtil.close(pstmt);
	    }
	}
	
	public List<DietGroupDTO> listGroup() {
	    List<DietGroupDTO> list = new ArrayList<DietGroupDTO>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql;
	    
	    try {
	        sql = "SELECT GROUPNAME, PROFILE, FILENAME FROM DIETGROUP";
	        
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            DietGroupDTO dto = new DietGroupDTO();
	            
	            dto.setGroupName(rs.getString("GROUPNAME")); // ResultSet에서 실제 값 가져오기
	            dto.setProFile(rs.getString("PROFILE"));
	            dto.setFileName(rs.getString("FILENAME"));
	            
	            System.out.println("DAO");
	            System.out.println(rs.getString("GROUPNAME"));
	            System.out.println(rs.getString("FILENAME"));
	            System.out.println(rs.getString("PROFILE"));
	            
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
}


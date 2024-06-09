package com.mealers.dao;

import java.io.IOException;
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
	
	/**
	 * 그룹 생성 
	 * @param dto
	 * @throws SQLException
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
	        int userNum = Integer.parseInt(dto.getUserNum());
	        pstmt.setInt(3, userNum);
	        pstmt.setString(4, dto.getFileName());

	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        DBUtil.close(pstmt);
	    }
	}
	
	/**
	 * 그룹 리스트 출력
	 * @return
	 */
	public List<DietGroupDTO> listGroup() {
	    List<DietGroupDTO> list = new ArrayList<DietGroupDTO>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql;
	    
	    try {
	        sql = "SELECT GROUPNAME,GROUPNUM,PROFILE, FILENAME FROM DIETGROUP";
	        
	        pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            DietGroupDTO dto = new DietGroupDTO();
	            
	            dto.setGroupName(rs.getString("GROUPNAME"));
	            dto.setGroupNum(rs.getInt("GROUPNUM"));
	            dto.setProFile(rs.getString("PROFILE"));
	            dto.setFileName(rs.getString("FILENAME"));
	       
	            
	            
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
	
	
	//-------------------------POST 관련 DAO
	
	
	/**
	 * 그룹 게시글 작성
	 * @param dto
	 * @throws SQLException
	 * @throws IOException
	 */
	
	public void insertPost(DietGroupDTO dto) throws SQLException,IOException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql ="INSERT INTO GROUPPOST(NUM,CONTENT,REG_DATE,USERNUM,GROUPNUM)"
					+ "VALUES(GPOSTNUM_SEQ.NEXTVAL,?,SYSDATE,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getUserNum());
			pstmt.setInt(3, dto.getGroupNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
	
	 public List<DietGroupDTO> listPost(int offset, int size, int groupNum) {
	        List<DietGroupDTO> list = new ArrayList<DietGroupDTO>();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        StringBuffer sb = new StringBuffer();

	        try {
	            sb.append("SELECT NUM, CONTENT, REG_DATE, USERNUM, GROUPNUM ");
	            sb.append("FROM GROUPPOST ");
	            sb.append("WHERE GROUPNUM = ? ");
	            sb.append("ORDER BY NUM DESC ");
	            sb.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

	            pstmt = conn.prepareStatement(sb.toString());
	            pstmt.setInt(1, groupNum);
	            pstmt.setInt(2, offset);
	            pstmt.setInt(3, size);
	            
	            //System.out.println(groupNum+":"+offset+":"+size);
	            
	            
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                DietGroupDTO dto = new DietGroupDTO();
	                dto.setNum(rs.getInt("NUM"));
	                dto.setContent(rs.getString("CONTENT"));
	                dto.setReg_Date(rs.getString("REG_DATE"));
	                dto.setUserNum(rs.getString("USERNUM"));
	                dto.setGroupNum(rs.getInt("GROUPNUM"));
	                
	                
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
	
	
	/**
	 * 그룹 게시물 갯수 
	 * @param dto
	 * @return
	 */
	/*
	 * public int dataCount() { DietGroupDTO dto = new DietGroupDTO(); int result =
	 * 0; PreparedStatement pstmt = null; ResultSet rs = null; String sql;
	 * 
	 * try { sql = "SELECT NVL(COUNT(*), 0) " + "FROM GROUPPOST " +
	 * "WHERE GROUPNUM = ?"; pstmt = conn.prepareStatement(sql); pstmt.setInt(1,
	 * dto.getGroupNum());
	 * 
	 * rs= pstmt.executeQuery();
	 * 
	 * if(rs.next()) { result = rs.getInt(1); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }finally { DBUtil.close(rs);
	 * DBUtil.close(pstmt); }
	 * 
	 * return result; }
	 */
	
	public int dataCount(int groupNum) {
	    int result = 0;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql;

	    try {
	        sql = "SELECT NVL(COUNT(*), 0) FROM GROUPPOST WHERE GROUPNUM = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, groupNum);

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            result = rs.getInt(1);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBUtil.close(rs);
	        DBUtil.close(pstmt);
	    }

	    return result;
	}

}


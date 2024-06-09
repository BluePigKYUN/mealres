package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.CmntDTO;
import com.mealers.domain.ReplyDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MealCmntDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertMeal(CmntDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealCmnt(num, userNum, subject, content, reg_date, hitCount, fileName) "
					+ " VALUES (mealCmnt_seq.NEXTVAL, ?, ?, ?, SYSDATE, 0, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserNum());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getFileName());
			
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int dataCount() {
		int conCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*),0) FROM mealCmnt";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				conCount = rs.getInt(1);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return conCount;
	}
	
	public int dataCount(String schCategory, String schContent) {
		int conCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM mealCmnt c"
					+ " JOIN member m ON c.userNum = m.userNum ";
			
			if(schCategory.equals("subcon")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			} else {
				sql += " WHERE INSTR(" + schCategory + ", ?) >= 1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, schContent);
			if(schCategory.equals("subcon")) {
				pstmt.setString(2, schContent);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				conCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}		
		return conCount;
	}
	
	public List<CmntDTO> listMeal(int offset, int size, String mealSort) {
		List<CmntDTO> list = new ArrayList<CmntDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("SELECT c.num, m.userNum, mem_Nick, subject, content, reg_date, hitCount, c.fileName ");
			sb.append(" FROM mealCmnt c ");
			sb.append(" JOIN member m ON c.userNum = m.userNum ");
			if(mealSort.equals("recent")) {
				sb.append(" ORDER BY reg_date DESC, num DESC ");				
			} else if(mealSort.equals("hitcount")) {
				sb.append(" ORDER BY hitCount DESC, reg_date DESC ");
			} else {
				sb.append(" LEFT JOIN ( ");	
				sb.append(" 	SELECT num, COUNT(*) AS likeCount ");	
				sb.append(" 	FROM mealCmntLike ");	
				sb.append(" 	GROUP BY num ");	
				sb.append(" ) ml ON c.num = ml.num ");	
				sb.append(" ORDER BY NVL(ml.likeCount,0) DESC, reg_date DESC "); 	
			}
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CmntDTO dto = new CmntDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setFileName(rs.getString("fileName"));
				
				list.add(dto);
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return list;
	}
	
	
	public List<CmntDTO> listMeal(int offset, int size, String mealSort, String schCategory, String schContent) {
		List<CmntDTO> list = new ArrayList<CmntDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("SELECT c.num, m.userNum, mem_Nick, subject, content, reg_date, hitCount, c.fileName");
			sb.append(" FROM mealCmnt c ");
			sb.append(" JOIN member m ON c.userNum = m.userNum ");	
			
			switch(mealSort) {
			case "recent" : 
				switch(schCategory) {
				case "subcon" : sb.append(" WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ORDER BY reg_date DESC, num DESC"); break;
				default : sb.append(" WHERE INSTR(" + schCategory + ", ?) >= 1  ORDER BY reg_date DESC, num DESC "); break;
				}
				break;
			case "hitcount" : 
				switch(schCategory) {
				case "subcon" : sb.append(" WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ORDER BY hitCount DESC, reg_date DESC "); break;
				default : sb.append(" WHERE INSTR(" + schCategory + ", ?) >= 1  ORDER BY hitCount DESC, reg_date DESC "); break;
				}
				break;
			default : 
				sb.append(" LEFT JOIN ( ");	
				sb.append(" 	SELECT num, COUNT(*) AS likeCount ");	
				sb.append(" 	FROM mealCmntLike ");	
				sb.append(" 	GROUP BY num ");	
				sb.append(" ) ml ON c.num = ml.num ");		
				switch(schCategory) {
				case "subcon" : sb.append(" WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ORDER BY NVL(ml.likeCount,0) DESC, reg_date DESC "); break;
				default : sb.append(" WHERE INSTR(" + schCategory + ", ?) >= 1 ORDER BY NVL(ml.likeCount,0) DESC, reg_date DESC "); break;
				}
				break;
			}
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, schContent);
			if(schCategory.equals("subcon")) {
				pstmt.setString(2, schContent);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CmntDTO dto = new CmntDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setFileName(rs.getString("fileName"));
				
				list.add(dto);
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return list;
	}
	
	public void hitCountCal(long num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE mealCmnt SET hitCount = hitCount+1 WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public boolean isLikeCmnt(long num, String userNum) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num, userNum FROM mealCmntLike WHERE num = ? AND userNum = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return result;
	}
	
	
	public void addlikeCmnt(long num, String userNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealCmntLike(num, userNum) VALUES(?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			pstmt.setString(2, userNum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}	
	
	public void deleteLikeCmnt(long num, String userNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM mealCmntLike WHERE num = ? AND userNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			pstmt.setString(2, userNum);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int likeCount(long num) {
		int countLike = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "SELECT NVL(COUNT(*), 0) FROM mealCmntLike WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				countLike = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return countLike;
	}
	
	public CmntDTO findContent(long num) {
		CmntDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num, m.userNum, mem_Nick, subject, content, TO_CHAR(reg_date,'YYYY-MM-DD') reg_date, "
					+ " hitCount, c.fileName "
					+ " FROM mealCmnt c "
					+ " JOIN member m ON c.userNum = m.userNum "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new CmntDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setFileName(rs.getString("fileName"));
			}						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return dto;
	}
	
	public void updateMeal(CmntDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE mealCmnt SET subject=?, content=?, fileName=? "
					+ " WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFileName());
			pstmt.setLong(4, dto.getNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void deleteMeal(long num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM mealCmnt WHERE num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void addReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealCmntReply(replyNum, num, userNum, content, reg_date) "
					+ " VALUES(mealCmntReply_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, dto.getNum());
			pstmt.setString(2, dto.getUserNum());
			pstmt.setString(3, dto.getContent());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int replyCount(long num) {
		int countReply = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM mealCmntReply "
					+ " WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				countReply = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		return countReply;
	}

	public List<ReplyDTO> replyList(long num, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<ReplyDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("SELECT replyNum, num, m.userNum, mem_Nick, content, TO_CHAR(reg_date,'YYYY-MM-DD') reg_date ");
			sb.append(" FROM mealCmntReply c ");
			sb.append(" JOIN member m ON c.userNum = m.userNum ");
			sb.append(" WHERE num = ? ");
			sb.append(" ORDER BY replyNum DESC");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setLong(1, num);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);
			}
	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
	}
	
	
	public ReplyDTO findReply(long replyNum) {
		ReplyDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT replyNum, num, m.userNum, mem_Nick, content, reg_date "
					+ " FROM mealCmntReply c "
					+ " JOIN member m ON c.userNum = m.userNum "
					+ " WHERE replyNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ReplyDTO();
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	
	
	public void removeReply(long replyNum, String userNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		if(! userNum.equals("1")) {
			ReplyDTO dto = findReply(replyNum);
			if(dto == null || (! userNum.equals(dto.getUserNum()))) {
				return;
			}
		}
		
		try {
			sql = "DELETE FROM mealCmntReply WHERE replyNum = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
}

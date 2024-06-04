package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.MealColumnDTO;
import com.mealers.domain.ReplyDTO;
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
	
	// 데이터 개수 세기
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM mealcolumn ";
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
	
	
	// 검색에서의 데이터 개수
	public int dataCount(String schType, String kwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM mealcolumn n "
					+ " JOIN member m ON n.userNum = m.userNum";
			
			if(schType.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			} else if(schType.equals("reg_date")) {
				kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + schType + ", ?) >= 1 ";
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, kwd);
			
			if(schType.equals("all")) {
				pstmt.setString(2, kwd);
			}
			
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
	
	// 리스트
	public List<MealColumnDTO> listMealColumn(int offset, int size) {
		List<MealColumnDTO> list = new ArrayList<MealColumnDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		
		try {
			sql = "SELECT n.num, n.userNum, subject, content, hitCount, saveFilename, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date "
					+ " FROM  mealcolumn n "
					+ " JOIN member m ON n.userNum = m.userNum "
					+ " JOIN mealcolumnFile f ON n.num = f.num "
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MealColumnDTO dto = new MealColumnDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
	}
	
	// 검색했을때 리스트
	public List<MealColumnDTO> listMealColumn(int offset, int size, String schType, String kwd) {
		List<MealColumnDTO> list = new ArrayList<MealColumnDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT n.num, n.userNum, subject, content, hitCount, saveFilename, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date "
					+ " FROM  mealcolumn n "
					+ " JOIN member m ON n.userNum = m.userNum "
					+ " JOIN mealcolumnFile f ON n.num = f.num ";
			
			if(schType.equals("all")) {
				sql += " WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ";
			} else if(schType.equals("reg_date")) {
				kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
				sql += " WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
			} else {
				sql += " WHERE INSTR(" + schType + ", ?) >= 1 ";
			}
			
			sql += " ORDER BY num DESC ";
			sql += " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			
			pstmt = conn.prepareStatement(sql);
			
			if (schType.equals("all")) {
				pstmt.setString(1, kwd);
				pstmt.setString(2, kwd);
				pstmt.setInt(3, offset);
				pstmt.setInt(4, size);
			} else {
				pstmt.setString(1, kwd);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);
			}

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MealColumnDTO dto = new MealColumnDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setReg_date(rs.getString("reg_date"));
				
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
	
	// 조회수 증가하기
	public void updateHitCount(long num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		
		try {
			sql = "UPDATE mealColumn SET hitCount = hitCount+1 WHERE num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	// 해당 칼럼 보기
	public MealColumnDTO findByColumn(long num) {
		MealColumnDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT n.num, n.userNum, subject, content, saveFilename, originalFilename, hitCount, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, "
					+ " NVL(likeCount, 0) likeCount "
					+ " FROM  mealColumn n "
					+ " JOIN member m ON n.userNum = m.userNum "
					+ " JOIN mealcolumnfile f ON n.num = f.num "
					+ " LEFT OUTER JOIN ( SELECT num, COUNT(*) likeCount FROM mealColumnLike GROUP BY num )"
					+ " bc ON n.num = bc.num "
					+ " WHERE n.num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MealColumnDTO();
				
				dto.setNum(rs.getLong("num"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setReg_date(rs.getString("reg_date"));
				
				dto.setLikeCount(rs.getInt("likeCount"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
		
		
	}
	
	// 칼럼 수정
	public void updateMealColumn(MealColumnDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE mealColumn SET subject= ?, content= ?  "
					+ "  WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setLong(3, dto.getNum());
			
			pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;
			
			
			// 파일 정보 수정
	        if (dto.getSaveFilename() != null && !dto.getSaveFilename().isEmpty()) {
	            // 기존 파일 정보가 있다면 삭제
	            sql = "DELETE FROM mealColumnfile WHERE num = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setLong(1, dto.getNum());
	            pstmt.executeUpdate();
	            pstmt.close();
	            pstmt = null;

	            // 새로운 파일 정보 추가
	            sql = "INSERT INTO mealColumnfile(fileNum, num, saveFilename, originalFileName, filesize) "
	                + " VALUES(mealColfile_seq.NEXTVAL, ?, ?, ?, ?)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setLong(1, dto.getNum());
	            pstmt.setString(2, dto.getSaveFilename());
	            pstmt.setString(3, dto.getOriginalFilename());
	            pstmt.setLong(4, dto.getFileSize());
	            pstmt.executeUpdate();    
//			// 파일 수정
//			sql = "INSERT INTO mealColumnfile(fileNum, num, saveFilename, originalFileName, filesize) "
//					+ " VALUES(mealColfile_seq.NEXTVAL, ?, ?, ?, ? )";
//			
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setLong(1, dto.getNum());
//			pstmt.setString(2, dto.getSaveFilename());
//			pstmt.setString(3, dto.getOriginalFilename());
//			pstmt.setLong(4, dto.getFileSize());
//			pstmt.executeUpdate();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	// 게시물 삭제
	public void deleteMealColumn(long num, String userNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			if( userNum.equals("1")) {
				sql = "DELETE FROM mealColumn WHERE num = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	
	// 로그인 유저의 게시글 공감 유무
	public boolean isUserMealCollike(long num, String userNum) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT num, userNum FROM mealColumnlike WHERE num = ? AND userNum = ? ";
			
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
	
	// 게시물 공감 추가
	public void insertMealColLike(long num, String userNum) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealColumnlike(num, userNum) VALUES (?, ?)";
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
	
	// 게시글 공감 삭제
		public void deleteMealColLike(long num, String userNum) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = "DELETE FROM mealColumnlike WHERE num = ? AND userNum = ? ";
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
	
	// 게시물의 공감 개수
		public int countMealColLike(long num) {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				sql = "SELECT NVL(COUNT(*), 0) FROM mealColumnlike WHERE num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
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
	
	// 칼럼 댓글 추가
	public void insertMealColReply(ReplyDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO mealcolumnReply(replyNum, num, userNum , content , reg_date)"
					+ " VALUES(mealColReply_seq.NEXTVAL, ?, ?, ?, SYSDATE )  ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1,  dto.getNum());
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
	
	// 칼럼 댓글 개수 세기
	public int dataCountMealColReply(long num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT NVL(COUNT(*), 0) "
					+ " FROM mealcolumnReply "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
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
	
	// 칼럼 댓글 리스트
	public List<ReplyDTO> listMealColReply(long num, int offset, int size) {
		List<ReplyDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append(" SELECT r.replyNum, r.userNum, m.mem_Nick, num, content, r.reg_date ");
			sb.append(" FROM mealcolumnReply r ");
			sb.append(" JOIN member m ON r.userNum = m.userNum ");
			sb.append(" WHERE num = ? ");
			sb.append(" ORDER BY r.replyNum DESC ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
			
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setLong(1, num);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setNum(rs.getLong("num"));
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
	
	public ReplyDTO findByReplyId(long replyNum) {
		ReplyDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT r.replyNum, r.userNum, m.mem_Nick, num, content, r.reg_date "
					+ " FROM mealcolumnReply r  "
					+ " JOIN member m ON r.userNum = m.userNum   "
					+ " WHERE replyNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, replyNum);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new ReplyDTO();
				
				dto.setReplyNum(rs.getLong("replyNum"));
				dto.setUserNum(rs.getString("userNum"));
				dto.setMem_Nick(rs.getString("mem_Nick"));
				dto.setNum(rs.getLong("num"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}

	// 칼럼의 댓글 삭제
	
	
	public long findByUserNum(String memberId) {
		long num = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			sb.append("SELECT userNum FROM member WHERE memberId = ?");
			
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

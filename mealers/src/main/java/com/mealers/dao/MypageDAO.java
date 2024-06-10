package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.CmntDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MypageDAO {
	private Connection conn = DBConn.getConnection();

	// 전체 게시물
	public List<CmntDTO> listPost(int offset, int size, String userNum) {
		List<CmntDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT * FROM ( ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, mc.subject AS subject, mc.num AS num, TO_CHAR(mc.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'1' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN mealCmnt mc ON m.USERNUM = mc.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, ec.subject AS subject, ec.num AS num, TO_CHAR(ec.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'2' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN exerCmnt ec ON m.USERNUM = ec.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, fc.subject AS subject, fc.num AS num, TO_CHAR(fc.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'3' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN freeCmnt fc ON m.USERNUM = fc.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, oc.subject AS subject, oc.num AS num, TO_CHAR(oc.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'4' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN oMemberCmnt oc ON m.USERNUM = oc.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, cc.subject AS subject, cc.num AS num, TO_CHAR(cc.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'5' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN concernCmnt cc ON m.USERNUM = cc.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, me.subject AS subject, me.num AS num, TO_CHAR(me.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'6' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN MEALCOLUMN me ON m.USERNUM = me.userNum ");
			sb.append("UNION ALL ");
			sb.append(
					"SELECT m.USERNUM, m.MEMBERID, ex.subject AS subject, ex.num AS num, TO_CHAR(ex.reg_date, 'YYYY/MM/DD HH24:MI') AS reg_date, ");
			sb.append("'7' AS type ");
			sb.append("FROM member m ");
			sb.append("INNER JOIN EXRCSCOLUMN ex ON m.USERNUM = ex.userNum ");
			sb.append(") results ");
			sb.append("WHERE results.USERNUM = ? ");
			sb.append("ORDER BY results.num DESC ");
			sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userNum);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CmntDTO dto = new CmntDTO();
				dto.setNum(rs.getInt("num"));
				dto.setType(rs.getString("type"));
				dto.setSubject(rs.getString("subject"));
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

	/**
	 * 게시물 개수
	 * 
	 * @param userNum
	 * @return
	 */
	public int getTotalCount(String userNum) {
		int totalCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT COUNT(*) AS total FROM ( ");
			sb.append("    SELECT m.USERNUM, cc.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN concernCmnt cc ON m.USERNUM = cc.userNum ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, oc.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN oMemberCmnt oc ON m.USERNUM = oc.userNum ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, fc.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN freeCmnt fc ON m.USERNUM = fc.userNum ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, ec.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN exerCmnt ec ON m.USERNUM = ec.userNum ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, mc.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN mealCmnt mc ON m.USERNUM = mc.userNum ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, mc.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN mealColumn mc ON m.USERNUM = mc.USERNUM ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT m.USERNUM, ec.num ");
			sb.append("    FROM member m ");
			sb.append("    INNER JOIN exrcsColumn ec ON m.USERNUM = ec.USERNUM ");
			sb.append(") results ");
			sb.append("WHERE results.USERNUM = ?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("total");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return totalCount;
	}

	/**
	 * 댓글 리스트
	 * 
	 * @param userNum
	 * @param offset
	 * @param size
	 * @return
	 */
	public List<CmntDTO> listReply(int offset, int size, String userNum) {
		List<CmntDTO> list = new ArrayList<CmntDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT * FROM ( ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'1' AS type ");
			sb.append("    FROM mealCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'2' AS type ");
			sb.append("    FROM exerCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'3' AS type ");
			sb.append("    FROM freeCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'4' AS type ");
			sb.append("    FROM oMemberCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'5' AS type ");
			sb.append("    FROM concernCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'6' AS type ");
			sb.append("    FROM mealColumnReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, content, reg_date, num, userNum, ");
			sb.append("'7' AS type ");
			sb.append("    FROM exrcsColumnReply ");
			sb.append(") all_reply ");
			sb.append("WHERE userNum = ? ");
			sb.append("ORDER BY reg_date DESC ");
			sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userNum);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CmntDTO dto = new CmntDTO();
				dto.setNum(rs.getInt("num"));
				dto.setType(rs.getString("type"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setReplyNum(rs.getInt("replyNum"));
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

	// 댓글 개수
	public int getTotalReply(String userNum) {
		int totalCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append("SELECT COUNT(*) AS total ");
			sb.append("FROM ( ");
			sb.append("    SELECT replyNum, userNum FROM mealCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM exerCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM freeCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM oMemberCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM concernCmntReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM exrcsColumnReply ");
			sb.append("    UNION ALL ");
			sb.append("    SELECT replyNum, userNum FROM mealColumnReply ");
			sb.append(") all_replies ");
			sb.append("WHERE userNum = ?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, userNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return totalCount;
	}
	
	public void deletePost(String tableName,long num) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM "+ tableName + " WHERE num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void deleteReply(String tableName,long num)throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		
		try {
			sql = "DELETE FROM "+ tableName + " WHERE REPLYNUM = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
}

package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.CmntDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class MypageDAO {
    private Connection conn = DBConn.getConnection();

    // 전체 게시물
    public List<CmntDTO> listPost(String userNum, int offset, int size) {
        List<CmntDTO> list = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuilder sb = new StringBuilder();

        try {
        	sb.append("SELECT * FROM ( ");
        	sb.append("SELECT  m.USERNUM,  m.MEMBERID,  mc.subject AS subject,  mc.num AS num,  mc.reg_date AS reg_date,   ");
        	sb.append("'1' AS type   ");
        	sb.append("FROM  member m   ");
        	sb.append("INNER JOIN  mealCmnt mc ON m.USERNUM = mc.userNum   ");
        	sb.append("UNION ALL   ");
        	sb.append("SELECT  m.USERNUM,  m.MEMBERID,  ec.subject AS subject, ec.num AS num, ec.reg_date AS reg_date,   ");
        	sb.append("'2' AS type   ");
        	sb.append("FROM  member m   ");
        	sb.append("INNER JOIN  exerCmnt ec ON m.USERNUM = ec.userNum   ");
        	sb.append("UNION ALL   ");
        	sb.append("SELECT  m.USERNUM,  m.MEMBERID,  fc.subject AS subject,  fc.num AS num,  fc.reg_date AS reg_date,   ");
        	sb.append("'3' AS type   ");
        	sb.append("FROM  member m   ");
        	sb.append("INNER JOIN  freeCmnt fc ON m.USERNUM = fc.userNum   ");
        	sb.append("UNION ALL  ");
        	sb.append("SELECT  m.USERNUM,  m.MEMBERID,  oc.subject AS subject,  oc.num AS num,  oc.reg_date AS reg_date,   ");
        	sb.append("'4' AS type   ");
        	sb.append("FROM  member m   ");
        	sb.append("INNER JOIN  oMemberCmnt oc ON m.USERNUM = oc.userNum   ");
        	sb.append("UNION ALL   ");
        	sb.append("SELECT m.USERNUM,m.MEMBERID,cc.subject AS subject,cc.num AS num, cc.reg_date AS reg_date,   ");
        	sb.append("'5' AS type  ");
        	sb.append("FROM  member m   ");
        	sb.append("INNER JOIN  concernCmnt cc ON m.USERNUM = cc.userNum    ");
        	sb.append("UNION ALL ");
        	sb.append("SELECT m.USERNUM,m.MEMBERID,me.subject AS subject,me.num AS num, me.reg_date AS reg_date,  ");
        	sb.append("'6' AS type ");
        	sb.append("FROM member m ");
        	sb.append("INNER JOIN MEALCOLUMN me ON m.USERNUM = me.userNum    ");
        	sb.append("UNION ALL ");
        	sb.append("SELECT m.USERNUM,m.MEMBERID,ex.subject AS subject,ex.num AS num, ex.reg_date AS reg_date,  ");
        	sb.append("'7' AS type ");
        	sb.append("FROM member m ");
        	sb.append("INNER JOIN EXRCSCOLUMN ex ON m.USERNUM = ex.userNum  ");
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
                dto.setNum(rs.getInt("type"));
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
     * 게시물 갯수 
     * @param userNum
     * @return
     */
    public int getTotalCount(String userNum) {
        int totalCount = 0;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql;

        try {
            sql = "SELECT COUNT(*) AS total FROM ( "
                + "    SELECT m.USERNUM, cc.num "
                + "    FROM member m "
                + "    INNER JOIN concernCmnt cc ON m.USERNUM = cc.userNum "
                + "    UNION ALL "
                + "    SELECT m.USERNUM, oc.num "
                + "    FROM member m "
                + "    INNER JOIN oMemberCmnt oc ON m.USERNUM = oc.userNum "
                + "    UNION ALL "
                + "    SELECT m.USERNUM, fc.num "
                + "    FROM member m "
                + "    INNER JOIN freeCmnt fc ON m.USERNUM = fc.userNum "
                + "    UNION ALL "
                + "    SELECT m.USERNUM, ec.num "
                + "    FROM member m "
                + "    INNER JOIN exerCmnt ec ON m.USERNUM = ec.userNum "
                + "    UNION ALL "
                + "    SELECT m.USERNUM, mc.num "
                + "    FROM member m "
                + "    INNER JOIN mealCmnt mc ON m.USERNUM = mc.userNum "
                + ")results WHERE results.USERNUM = ?";
        

            pstmt = conn.prepareStatement(sql);
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
     * @param userNum
     * @param offset
     * @param size
     * @return
     */
    public List<CmntDTO> listReply(String userNum,int offset,int size){
    	List<CmntDTO> list = new ArrayList<CmntDTO>();
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	StringBuilder sb = new StringBuilder();
    	
    	try {
    		sb.append("SELECT * FROM ( ");
    		sb.append("    SELECT replyNum, content, reg_date, num, userNum ");
    		sb.append("    FROM mealCmntReply ");
    		sb.append("    UNION ALL ");
    		sb.append("    SELECT replyNum, content, reg_date, num, userNum ");
    		sb.append("    FROM exerCmntReply ");
    		sb.append("    UNION ALL ");
    		sb.append("    SELECT replyNum, content, reg_date, num, userNum ");
    		sb.append("    FROM freeCmntReply ");
    		sb.append("    UNION ALL ");
    		sb.append("    SELECT replyNum, content, reg_date, num, userNum ");
    		sb.append("    FROM oMemberCmntReply ");
    		sb.append("    UNION ALL ");
    		sb.append("    SELECT replyNum, content, reg_date, num, userNum ");
    		sb.append("    FROM concernCmntReply ");
    		sb.append(") all_reply ");
    		sb.append("WHERE userNum = ? ");
    		sb.append("ORDER BY reg_date DESC ");
    		sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");
    		

    		pstmt=conn.prepareStatement(sb.toString());
    		pstmt.setString(1, userNum);
    		pstmt.setInt(2, offset); 
			pstmt.setInt(3, size);
			 
    		rs=pstmt.executeQuery();
    		
    		while(rs.next()) {
    			CmntDTO dto = new CmntDTO();
    			dto.setNum(rs.getInt("num"));
    			dto.setSubject(rs.getString("content"));
    			dto.setReg_date(rs.getString("reg_date"));
    			list.add(dto);
    			
    			
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

    	return list;
    }
}

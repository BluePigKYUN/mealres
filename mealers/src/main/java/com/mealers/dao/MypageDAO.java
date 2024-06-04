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
            sb.append("    SELECT ");
            sb.append("        m.USERNUM, ");
            sb.append("        m.MEMBERID, ");
            sb.append("        cc.subject AS subject, ");
            sb.append("        cc.num AS num, ");
            sb.append("        cc.reg_date AS reg_date, ");
            sb.append("        '1' AS type ");
            sb.append("    FROM ");
            sb.append("        member m ");
            sb.append("    INNER JOIN ");
            sb.append("        concernCmnt cc ON m.USERNUM = cc.userNum ");
            sb.append("    UNION ALL ");
            sb.append("    SELECT ");
            sb.append("        m.USERNUM, ");
            sb.append("        m.MEMBERID, ");
            sb.append("        oc.subject AS subject, ");
            sb.append("        oc.num AS num, ");
            sb.append("        oc.reg_date AS reg_date, ");
            sb.append("        '2' AS type ");
            sb.append("    FROM ");
            sb.append("        member m ");
            sb.append("    INNER JOIN ");
            sb.append("        oMemberCmnt oc ON m.USERNUM = oc.userNum ");
            sb.append("    UNION ALL ");
            sb.append("    SELECT ");
            sb.append("        m.USERNUM, ");
            sb.append("        m.MEMBERID, ");
            sb.append("        fc.subject AS subject, ");
            sb.append("        fc.num AS num, ");
            sb.append("        fc.reg_date AS reg_date, ");
            sb.append("        '3' AS type ");
            sb.append("    FROM ");
            sb.append("        member m ");
            sb.append("    INNER JOIN ");
            sb.append("        freeCmnt fc ON m.USERNUM = fc.userNum ");
            sb.append("    UNION ALL ");
            sb.append("    SELECT ");
            sb.append("        m.USERNUM, ");
            sb.append("        m.MEMBERID, ");
            sb.append("        ec.subject AS subject, ");
            sb.append("        ec.num AS num, ");
            sb.append("        ec.reg_date AS reg_date, ");
            sb.append("        '4' AS type ");
            sb.append("    FROM ");
            sb.append("        member m ");
            sb.append("    INNER JOIN ");
            sb.append("        exerCmnt ec ON m.USERNUM = ec.userNum ");
            sb.append("    UNION ALL ");
            sb.append("    SELECT ");
            sb.append("        m.USERNUM, ");
            sb.append("        m.MEMBERID, ");
            sb.append("        mc.subject AS subject, ");
            sb.append("        mc.num AS num, ");
            sb.append("        mc.reg_date AS reg_date, ");
            sb.append("        '5' AS type ");
            sb.append("    FROM ");
            sb.append("        member m ");
            sb.append("    INNER JOIN ");
            sb.append("        mealCmnt mc ON m.USERNUM = mc.userNum ");
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
                + ") results WHERE results.USERNUM = ?";

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
}
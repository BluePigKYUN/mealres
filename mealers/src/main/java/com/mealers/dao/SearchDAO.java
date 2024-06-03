package com.mealers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mealers.domain.SearchDTO;
import com.mealers.util.DBConn;
import com.mealers.util.DBUtil;

public class SearchDAO {
	
	Connection conn = DBConn.getConnection();
	
	// 검색에서의 데이터 개수
	public int dataCount(String kwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM nutrient_api "
					+ " WHERE INSTR(food_name_api, ?) >= 1";

			kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
				
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, kwd);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
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
	
	public List<SearchDTO> listFood(int offset, int size, String kwd) {
		List<SearchDTO> list = new ArrayList<SearchDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuilder sb = new StringBuilder();

		try {
			sb.append(" SELECT food_num_api, food_name_api, nvl(maker_api, '제조사정보없음') maker_api, kcal");
			sb.append(" FROM nutrient_api ");
			sb.append(" WHERE INSTR(food_name_api, ?) >= 1 ");
			sb.append(" order by food_name_api ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, kwd);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				SearchDTO dto = new SearchDTO();
				
				dto.setFood_num(rs.getLong("food_num_api"));
				dto.setFood_name(rs.getString("food_name_api"));
				dto.setMaker(rs.getString("maker_api"));
				dto.setKcal(rs.getString("kcal"));
				
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
	
	// 해당 게시물 보기
	public SearchDTO findByNum(long num) {
		SearchDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT food_num_api, food_name_api, maker_api, weight_api, serving_size_api, "
					+ " kcal, tansoo_api, protein_api, fat_api, sugar_api, salt_api, "
					+ " calcium_api, potassium_api, chole_api, pohwa_api, bulpohwa_api, omega3_api, "
					+ " caffeine_api, amino_api "
				+ " FROM nutrient_api "
				+ " WHERE food_num_api = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new SearchDTO();
				
				dto.setFood_num(rs.getLong(1));
				dto.setFood_name(rs.getString(2));
				dto.setMaker(rs.getString(3));
				dto.setWeight(rs.getString(4));
				dto.setServing_size(rs.getString(5));
				dto.setKcal(rs.getString(6));
				dto.setTansoo(rs.getString(7));
				dto.setProtein(rs.getString(8));
				dto.setFat(rs.getString(9));
				dto.setSugar(rs.getString(10));
				dto.setSalt(rs.getString(11));
				dto.setCalcium(rs.getString(12));
				dto.setPotassium(rs.getString(13));
				dto.setChole(rs.getString(14));
				dto.setPohwa(rs.getString(15));
				dto.setBulpohwa(rs.getString(16));
				dto.setOmega3(rs.getString(17));
				dto.setCaffeine(rs.getString(18));
				dto.setAmino(rs.getString(19));
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


























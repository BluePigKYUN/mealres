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
	
	private Connection conn = DBConn.getConnection();
	
	public void insertFood(SearchDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into nutrient (food_num, food_name, maker, weight, serving_size, "
					+ " kcal, tansoo, protein, fat, sugar, salt, calcium, potassium, "
					+ " chole, pohwa, bulpohwa, omega3, caffeine, amino, userNum) "
					+ " values (foodNum_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, "
					+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFood_name());
			pstmt.setString(2, dto.getMaker());
			pstmt.setString(3, dto.getWeight());
			pstmt.setString(4, dto.getServing_size());
			pstmt.setString(5, dto.getKcal());
			pstmt.setString(6, dto.getTansoo());
			pstmt.setString(7, dto.getProtein());
			pstmt.setString(8, dto.getFat());
			pstmt.setString(9, dto.getSugar());
			pstmt.setString(10, dto.getSalt());
			pstmt.setString(11, dto.getCalcium());
			pstmt.setString(12, dto.getPotassium());
			pstmt.setString(13, dto.getChole());
			pstmt.setString(14, dto.getPohwa());
			pstmt.setString(15, dto.getBulpohwa());
			pstmt.setString(16, dto.getOmega3());
			pstmt.setString(17, dto.getCaffeine());
			pstmt.setString(18, dto.getAmino());
			pstmt.setLong(19, dto.getUserNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	// 검색에서의 데이터 개수
	public int dataCount(String kwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM nutrient "
					+ " WHERE INSTR(food_name, ?) >= 1";

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
			sb.append(" SELECT food_num, food_name, nvl(maker, '제조사정보없음') maker, kcal, nvl(userNum, 0) userNum");
			sb.append(" FROM nutrient ");
			sb.append(" WHERE INSTR(food_name, ?) >= 1 ");
			sb.append(" order by food_name ");
			sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

			kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, kwd);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				SearchDTO dto = new SearchDTO();
				
				dto.setFood_num(rs.getLong("food_num"));
				dto.setFood_name(rs.getString("food_name"));
				dto.setMaker(rs.getString("maker"));
				dto.setKcal(rs.getString("kcal"));
				dto.setUserNum(rs.getLong("userNum"));
				
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
	
	public List<SearchDTO> listRank() {
		List<SearchDTO> list = new ArrayList<SearchDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = " select n.food_num, food_name, maker, kcal, count(*) 이번주조회수 "
				+ " from foodSearchNum f "
				+ " join nutrient n on f.food_num = n.food_num "
				+ " where search_date between trunc(sysdate, 'iw') and trunc(sysdate, 'iw')+6 "
				+ " group by n.food_num, food_name, maker, kcal "
				+ " order by count(*) desc "
				+ " OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				SearchDTO dto = new SearchDTO();
				
				dto.setFood_num(rs.getLong("n.food_num"));
				dto.setFood_name(rs.getString("n.food_name"));
				dto.setMaker(rs.getString("maker"));
				dto.setKcal(rs.getString("kcal"));
				dto.setUserNum(rs.getLong("userNum"));
				
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
	
	// 해당 게시물 보기
	public SearchDTO findByNum(long num) {
		SearchDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = " SELECT food_num, food_name, maker, weight, serving_size, "
					+ " kcal, tansoo, protein, fat, sugar, salt, "
					+ " calcium, potassium, chole, pohwa, bulpohwa, omega3, "
					+ " caffeine, amino "
				+ " FROM nutrient "
				+ " WHERE food_num = ? ";
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
	
	public long findByName(String food_name, int userNum) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		long food_num = 0;

		try {
			sql = " SELECT food_num "
				+ " FROM nutrient "
				+ " WHERE INSTR(food_name, ?) >= 1 and userNum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, food_name);
			pstmt.setLong(2, userNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				food_num = rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return food_num;
	}
	
	public void insertPhoto(SearchDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO foodfile(file_num, food_file_name, reg_date, food_num, userNum) "
					+ " VALUES(foodFile_seq.NEXTVAL, ?, sysdate, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFood_file_name());
			pstmt.setLong(2, dto.getFood_num());
			pstmt.setLong(3, dto.getUserNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int fileCount(long food_num) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM foodFile where food_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, food_num);
			
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
	
	public List<SearchDTO> listPhoto(int offset, int size, long num) {
		List<SearchDTO> list = new ArrayList<SearchDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT file_num, food_file_name, food_num, "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, userNum "
					+ " FROM foodfile "
					+ " where food_num = ?"
					+ " ORDER BY file_num DESC " 
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SearchDTO dto = new SearchDTO();
				
				dto.setFile_num(rs.getLong(1));
				dto.setFood_file_name(rs.getString(2));
				dto.setFood_num(rs.getLong(3));
				dto.setFile_reg_date(rs.getString(4));
				dto.setUserNum(rs.getLong(5));
				
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
	
	public void updateHitcount(long num) {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "insert into foodSearchNum (search_num, search_date, food_num) "
					+ " values (searchNum_seq.NEXTVAL, sysdate, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}

}


























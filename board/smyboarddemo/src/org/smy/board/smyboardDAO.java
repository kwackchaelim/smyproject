package org.smy.board;

import java.sql.*;
import java.util.ArrayList;

import org.smy.board.smyboardDTO;

public class smyboardDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	
	String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb?useSSL=true&verifyServerCertificate=false&serverTimezone=UTC";
	
	/**
	 *
	 * @fn 		connect()
	 * 
	 * @brief 	DB 연결 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	jdbc_url,"jspbook","1234"
	 *
	 * @remark 	DB 연결을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 *
	 * @fn 		disconnect()
	 * 
	 * @brief 	DB 연결해제 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	null
	 *
	 * @remark 	DB 연결해제을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 *
	 * @fn 		insertDB(smyboardDTO smyboardDTO)
	 * 
	 * @brief 	DB 입력을 위한 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	userName, title, content
	 *
	 * @remark 	DB 입력을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	public boolean insertDB(smyboardDTO smyboardDTO) {
		
		connect();
		
			String sql ="insert into Board(userName, title, content) values(?,?,?)";		
		try {
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1,smyboardDTO.getUserName());
			pstmt.setString(2,smyboardDTO.getTitle());
			pstmt.setString(3,smyboardDTO.getContent());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	/**
	 *
	 * @fn 		ArrayList<smyboardDTO> getDBList()
	 * 
	 * @brief 	DB 조회을 위한 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	id, userName, title, content
	 *
	 * @remark 	DB 조회을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	public ArrayList<smyboardDTO> getDBList() {
		
		connect();
		
		ArrayList<smyboardDTO> boardList = new ArrayList<smyboardDTO>();
		
		String sql = "select id, userName, title, content from Board";

		try {
			
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				
				smyboardDTO smyboardDTO = new smyboardDTO();
				
				smyboardDTO.setId(rs.getInt("id"));
				smyboardDTO.setUserName(rs.getString("userName"));
				smyboardDTO.setTitle(rs.getString("title"));
				smyboardDTO.setContent(rs.getString("content"));

				boardList.add(smyboardDTO);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardList;
	}
	/**
	 *
	 * @fn 		smyboardDTO getDB(int id)
	 * 
	 * @brief 	DB 상세페이지 을 위한 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	* 입력된 데이터의 모든 것을 조회하기 위해 param = *
	 *
	 * @remark 	DB 상제페이지를 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	public smyboardDTO getDB(int id) {
		
		connect();
		
		smyboardDTO smyboardDTO = new smyboardDTO();
		
		String sql = "select * from Board where id = ?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,id);

			ResultSet rs = pstmt.executeQuery();

			rs.next();
			
			smyboardDTO.setId(rs.getInt("id"));
			smyboardDTO.setUserName(rs.getString("userName"));
			smyboardDTO.setTitle(rs.getString("title"));
			smyboardDTO.setContent(rs.getString("content"));
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return smyboardDTO;
	}
	/**
	 *
	 * @fn 		updateDB(smyboardDTO smyboardDTO)
	 * 
	 * @brief 	DB 수정을 위한 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	userName=?, title=?, content=? where id=?
	 *
	 * @remark 	DB 수정을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	public boolean updateDB(smyboardDTO smyboardDTO) {
		
		connect();
				
		String sql ="update Board set userName=?, title=?, content=? where id=?";

		try {
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1,smyboardDTO.getUserName());
			pstmt.setString(2,smyboardDTO.getTitle());
			pstmt.setString(3,smyboardDTO.getContent());
			pstmt.setInt(4,smyboardDTO.getId());
		
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	/**
	 *
	 * @fn 		deleteDB(int id) 
	 * 
	 * @brief 	DB 삭제을 위한 메서드
	 *
	 * @author 	김설규
	 * @date 	2019-10-16
	 *
	 * @param 	id=? 해당하는 id을 기준으로 삭제 하기 때문에 param = id=?
	 *
	 * @remark 	DB 삭제을 위한 선언		[2019-10-16; 김설규]
	 * 
	 */
	public boolean deleteDB(int id) {
		
		
		connect();
					
			String sql ="delete from Board where id=?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1,id);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
		}
		return true;
	}
	
	
}
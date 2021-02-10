package com.sist.music;

import java.sql.*;

public class MusicDAO {
	private Connection conn;  // connect oracle
	private PreparedStatement ps;   // send SQL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// Driver ���
	public MusicDAO(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {}
	}
	
	// ����Ŭ ����
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {}
	}
	
	// ����Ŭ �ݱ�
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {}
	}
	// ���(�������߰�)
	public void genieMusicInsert(GenieMusicVO vo) {
		try {
			getConnection();
			String sql = "INSERT INTO genie_music VALUES (?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, vo.getNo()); //TO_NUBER()
			ps.setInt(2, vo.getCno());
			ps.setString(3, vo.getTitle());
			ps.setString(4, vo.getSinger());
			ps.setString(5, vo.getAlbum());
			ps.setString(6, vo.getPoster());
			ps.setString(7, vo.getState());
			ps.setInt(8, vo.getIdcrement());
			
			// ����
			ps.executeUpdate();

			
		}catch(Exception e) {
			e.getMessage();
			
		}finally {
			disConnection();
		}
	}
}

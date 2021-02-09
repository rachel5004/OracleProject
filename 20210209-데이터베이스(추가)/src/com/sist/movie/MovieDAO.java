package com.sist.movie;
// ����Ŭ ����
import java.sql.*;
public class MovieDAO {
	private Connection conn;  // connect oracle
	private PreparedStatement ps;   // send SQL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// Driver ��� -> �ѹ��� ����
	public MovieDAO(){
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
	public void movieInsert(MovieVO vo) {
		try {
			getConnection();
			String sql = "INSERT INTO movie VALUES (?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getMno()); //TO_NUBER()
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getGenre());
			ps.setString(4, vo.getPoster());
			ps.setString(5, vo.getActor());
			ps.setString(6, vo.getRegdate());
			ps.setString(7, vo.getGrade());
			ps.setString(8, vo.getDirector());
			
			// ����
			ps.executeUpdate();

			
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			disConnection();
		}
	}
}

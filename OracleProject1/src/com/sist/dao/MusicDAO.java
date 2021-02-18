package com.sist.dao;
import java.util.*;
import java.sql.*;
public class MusicDAO {
	private Connection conn;  // connect oracle
	private PreparedStatement ps;   // send SQL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
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
			if(ps!=null) ps.close();  // ���(�۽�:OutputStream,����:BufferReader)
			if(conn!=null) conn.close();  // ������: Socket
		}catch(Exception e) {}
	}
	// 4. ��� => ���������� 50���� �޾Ƽ� ���� ==> ����� ������ ���������� �о ���
	public ArrayList<MusicVO> musicListData(){
		ArrayList<MusicVO> list = new ArrayList<MusicVO>();
		try {
			getConnection();
			String sql = "SELECT no,title,poster,singer,album,state,idcrement "
					+"FROM genie_music "
				     +"ORDER BY 1";
			ps = conn.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			// ������� ArrayList�� ���� 
			   /*
			    *    =================
			    *     no title...
			    *    =================
			    *     1    ==          | next()
			    *    =================
			    *     2    ==          | next()
			    *    =================
			    *     3    ==          | next()
			    *    =================
			    *     4    ==          | next()
			    *    =================
			    *                      | next() => false
			    *    
			    */
			while(rs.next()) {
				MusicVO vo = new MusicVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setPoster(rs.getString(3));
				vo.setSinger(rs.getString(4));
				vo.setAlbum(rs.getString(5));
				vo.setState(rs.getString(6));
				vo.setIdcrement(rs.getInt(7));
				list.add(vo);
			}
			rs.close();
			// ������ 
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			disConnection();  // �ݱ� (����/���� => ������ ����Ŭ�� �ݴ´�)
		}
		return list;
	}
}

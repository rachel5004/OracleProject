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
	
	// 오라클 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception e) {}
	}
	
	// 오라클 닫기
	public void disConnection() {
		try {
			if(ps!=null) ps.close();  // 통신(송신:OutputStream,수신:BufferReader)
			if(conn!=null) conn.close();  // 연결기기: Socket
		}catch(Exception e) {}
	}
	// 4. 기능 => 뮤직데이터 50개를 받아서 저장 ==> 저장된 데이터 브라우저에서 읽어서 출력
	public ArrayList<MusicVO> musicListData(){
		ArrayList<MusicVO> list = new ArrayList<MusicVO>();
		try {
			getConnection();
			String sql = "SELECT no,title,poster,singer,album,state,idcrement "
					+"FROM genie_music "
				     +"ORDER BY 1";
			ps = conn.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			// 결과값을 ArrayList에 저장 
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
			// 대기상태 
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			disConnection();  // 닫기 (오류/정상 => 무조건 오라클을 닫는다)
		}
		return list;
	}
}

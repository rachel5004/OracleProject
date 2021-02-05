package com.sist.dao;
import java.sql.*;

public class MainClass {
	public static void main(String[] args) {
		try {
			// 1. Driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2. CONNECT
			String url = "jdbc:oracle:thin:@localhost:1521:XE";  //oracle 주소
			Connection conn = DriverManager.getConnection(url,"hr","happy");
			
			// 3. SQL
			
			String sql = "select empno,ename,job,hiredate,sal from emp where empno=7788";
			PreparedStatement ps = conn.prepareStatement(sql);
			
			// 4. result
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {  //한줄씩 읽어옴, rs.previous = 역순
				System.out.println(
						rs.getInt(1)+" "+
						rs.getString(2)+" "+
						rs.getString(3)+" "+
						rs.getDate(4)+" "+
						rs.getInt(5)
						);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}

package com.sist.dao;
import java.sql.*;
//VO , DAO
/*
*    SQL 
*     = DML (데이터 조작언어)
*         = SELECT : 데이터 검색 
*             = JOIN
*             = SUBQUERY
*         = INSERT : 데이터 추가
*         = UPDATE : 데이터 수정 
*         = DELETE : 데이터 삭제 
*     = DDL (데이터 선언언어) => 제약조건 (PRIMARY KEY , FOREIGN KEY , CHECK , UNIQUE , DEFAULT)
*         = CREATE : 생성
*            TABLE , VIEW , INDEX , SEQUENCE , PROCEDURE , FUNCTION , TRIGGER
*         = ALTER : 수정
*         = DROP : 삭제
*         = TRUNCATE : 잘라내기
*         = RENAME : 이름변경 
*     = DCL (데이터 제어언어)
*         = GRENT : 권한 부여
*         = REVOKE : 권한 해제 
*     = TCL (트랜잭션 제어언어)
*         = COMMIT
*         = ROLLBACK
*         
*    PL/SQL 
*       ===
*    ==
*    함수를 만드는 언어 : 재사용
*/
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

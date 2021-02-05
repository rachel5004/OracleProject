package com.sist.dao;
import java.sql.*;
//VO , DAO
/*
*    SQL 
*     = DML (������ ���۾��)
*         = SELECT : ������ �˻� 
*             = JOIN
*             = SUBQUERY
*         = INSERT : ������ �߰�
*         = UPDATE : ������ ���� 
*         = DELETE : ������ ���� 
*     = DDL (������ ������) => �������� (PRIMARY KEY , FOREIGN KEY , CHECK , UNIQUE , DEFAULT)
*         = CREATE : ����
*            TABLE , VIEW , INDEX , SEQUENCE , PROCEDURE , FUNCTION , TRIGGER
*         = ALTER : ����
*         = DROP : ����
*         = TRUNCATE : �߶󳻱�
*         = RENAME : �̸����� 
*     = DCL (������ ������)
*         = GRENT : ���� �ο�
*         = REVOKE : ���� ���� 
*     = TCL (Ʈ����� ������)
*         = COMMIT
*         = ROLLBACK
*         
*    PL/SQL 
*       ===
*    ==
*    �Լ��� ����� ��� : ����
*/
public class MainClass {
	public static void main(String[] args) {
		try {
			// 1. Driver ���
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2. CONNECT
			String url = "jdbc:oracle:thin:@localhost:1521:XE";  //oracle �ּ�
			Connection conn = DriverManager.getConnection(url,"hr","happy");
			
			// 3. SQL
			
			String sql = "select empno,ename,job,hiredate,sal from emp where empno=7788";
			PreparedStatement ps = conn.prepareStatement(sql);
			
			// 4. result
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {  //���پ� �о��, rs.previous = ����
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

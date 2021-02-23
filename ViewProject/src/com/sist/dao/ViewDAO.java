package com.sist.dao;

import java.sql.*;
import java.util.*;

public class ViewDAO {
	private Connection conn;
	   private PreparedStatement ps;
	   private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	   public ViewDAO() {
		   try {
			   Class.forName("oracle.jdbc.driver.OracleDriver");
			   // Class.forName() => 등록된 클래스의 메모리 할당 (new) => 클래스 정보를 읽어서 관리 : 리플렉션
				// 메소드 제어 , 멤버변수,생성자, 매개변수를 제어 할 수 있다 
				// 예외처리(CheckException:컴파일시 검사=반드시 예외 처리) => ClassNotFoundException
		   }catch(Exception ex) {
			   System.out.println(ex.getMessage());
		   }
	   }
	   public void getConnection() {
		   try {
			   conn=DriverManager.getConnection(URL,"hr","happy");
		   }catch(Exception ex) {}
	   }
	   public void disConnection() {
		   try {
			   if(ps!=null) ps.close();
			   if(conn!=null) conn.close();
		   }catch(Exception ex) {}
	   }
	   public void empAllData() {
			try {
				getConnection();
//				String sql = "select empno,job,hiredate,dname,loc,grade "
//						+ "from emp,dept,grade where emp.deptno=dept.deptno "
//						+ "and sal between losal and hisal";
				
				String sql="SELECT * FROM emp_dept_view ORDER BY empno ASC";
						
				ps=conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()) {
					System.out.println(rs.getInt(1)+" "
							+rs.getString(2)+" "
							+rs.getString(3)+" "
							+rs.getDate(4)+" "
							+rs.getInt(5)+" "
							+rs.getString(6)+" "
							+rs.getString(7)+" "
							+rs.getInt(8));
				}
				rs.close();
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}finally {
				disConnection();
			}
		}
	   public void empDetailData(int empno) {
			try {
				// 1. 연결
				getConnection();
				// 2. SQL문장 제작
				/*String sql="SELECT empno,ename,job,hiredate,sal,dname,loc,grade "
						+ "FROM emp,dept,salgrade "
						+ "WHERE emp.deptno=dept.deptno "
						+ "AND sal BETWEEN losal AND hisal "
						+ "AND empno=?";*/
				String sql="SELECT * FROM emp_dept_view "
						  +"WHERE empno=?";
				// View => SELECT의 모든 기능을 사용 할 수 있다 (GROUP BY,WHERE,ORDER BY)
				// View도 일반 테이블처럼 사용이 된다 
				ps=conn.prepareStatement(sql);
				// ?에 값을 채운다 
				ps.setInt(1, empno);
				
				ResultSet rs=ps.executeQuery();
				// 커서위치 변경 => 데이터가 있는 위치로 지정 => next()
				rs.next();
				System.out.println(rs.getInt(1)+" "
		    			+rs.getString(2)+" "
		    			+rs.getString(3)+" "
		    			+rs.getDate(4)+" "
		    			+rs.getInt(5)+" "
		    			+rs.getString(6)+" "
		    			+rs.getString(7)+" "
		    			+rs.getInt(8));
				rs.close();
			}catch(Exception ex) {
				System.out.println(ex.getMessage());
			}finally {
				disConnection();
			}
		}
		// 페이지 나누기 => movie 
		public void movieListData(int page) { // 사용자가 보내준 페이지를 받아서 해당 페이지만 전송 
			try {
				getConnection();
				String sql="SELECT mno,title,num "
						  +"FROM (SELECT mno,title,rownum as num "
						  +"FROM (SELECT mno,title "
						  +"FROM movie ORDER BY mno ASC)) "
						  +"WHERE num BETWEEN ? AND ?";
				ps=conn.prepareStatement(sql);

				int rowSize=20;
				int start=(page*rowSize)-(rowSize-1);
				int end=rowSize*page;
				
				/*
				 *   1page : 1~20
				 *   2page : 21~40  ==> rownum은 1번 시작 
				 *   ..
				 *   ..
				 */
				ps.setInt(1, start);
				ps.setInt(2, end);
				
				ResultSet rs=ps.executeQuery();
				while(rs.next()) {
					System.out.println(rs.getInt(1)+". "+rs.getString(2));
				}
				rs.close();
			}catch(Exception ex) {
				System.out.println(ex.getMessage());
			}finally {
				disConnection();
			}
		}
	   public static void main(String[] args) {
			ViewDAO dao = new ViewDAO();
			dao.empAllData();
			//dao.empDetailData(7788);
			Scanner sc = new Scanner(System.in);
			System.out.print("페이지 설정:");
	        int page=sc.nextInt();
	        dao.movieListData(page);
			
	}

}

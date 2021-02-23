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
			   // Class.forName() => ��ϵ� Ŭ������ �޸� �Ҵ� (new) => Ŭ���� ������ �о ���� : ���÷���
				// �޼ҵ� ���� , �������,������, �Ű������� ���� �� �� �ִ� 
				// ����ó��(CheckException:�����Ͻ� �˻�=�ݵ�� ���� ó��) => ClassNotFoundException
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
				// 1. ����
				getConnection();
				// 2. SQL���� ����
				/*String sql="SELECT empno,ename,job,hiredate,sal,dname,loc,grade "
						+ "FROM emp,dept,salgrade "
						+ "WHERE emp.deptno=dept.deptno "
						+ "AND sal BETWEEN losal AND hisal "
						+ "AND empno=?";*/
				String sql="SELECT * FROM emp_dept_view "
						  +"WHERE empno=?";
				// View => SELECT�� ��� ����� ��� �� �� �ִ� (GROUP BY,WHERE,ORDER BY)
				// View�� �Ϲ� ���̺�ó�� ����� �ȴ� 
				ps=conn.prepareStatement(sql);
				// ?�� ���� ä��� 
				ps.setInt(1, empno);
				
				ResultSet rs=ps.executeQuery();
				// Ŀ����ġ ���� => �����Ͱ� �ִ� ��ġ�� ���� => next()
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
		// ������ ������ => movie 
		public void movieListData(int page) { // ����ڰ� ������ �������� �޾Ƽ� �ش� �������� ���� 
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
				 *   2page : 21~40  ==> rownum�� 1�� ���� 
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
			System.out.print("������ ����:");
	        int page=sc.nextInt();
	        dao.movieListData(page);
			
	}

}

package com.sist.dao;
import java.util.*;
import java.sql.*;
public class ZipcodeDAO {
   // 1. ����Ŭ ���� Ŭ����
   private Connection conn;
   // 2. SQL���� ���� Ŭ���� 
   private PreparedStatement ps;
   // 3. ����Ŭ �ּ� 
   private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
   
   // 4. ����̹� ��� 
   public ZipcodeDAO()
   {
	   try
	   {
		   Class.forName("oracle.jdbc.driver.OracleDriver");
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
   }
   // 5. ����Ŭ ���� �޼ҵ�
   public void getConnection()
   {
	   try
	   {
		   // conn hr/happy
		   conn=DriverManager.getConnection(URL,"hr","happy");
	   }catch(Exception ex) {}
   }
   // 6. ����Ŭ ���� �޼ҵ�
   public void disConnection()
   {
	   try
	   {
		   // exit
		   if(ps!=null) ps.close();
		   if(conn!=null) conn.close();
	   }catch(Exception ex) {}
   }
   //--------------------------------------------------------- DAO���� �ʼ��� ��� 
   // 7. ��ɼ��� (�����ȣ ã��) => �޼ҵ� : ������(����� ��û ó�� �����) , �Ű�����(����ڰ� �����ִ� ��)
   public ArrayList<ZipcodeVO> postFind(String dong)
   {
	   ArrayList<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
	   try
	   {
		   // ����
		   getConnection();
		   // SQL���� ���� 
		   String sql="SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') "
				     +"FROM zipcode "
				     +"WHERE dong LIKE '%'||?||'%'";
		   ps=conn.prepareStatement(sql);
		   ps.setString(1, dong);
		   // ����=> ����� �б�
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
			   ZipcodeVO vo=new ZipcodeVO();
			   vo.setZipcode(rs.getString(1));
			   vo.setSido(rs.getString(2));
			   vo.setGugun(rs.getString(3));
			   vo.setDong(rs.getString(4));
			   vo.setBunji(rs.getString(5));
			   
			   list.add(vo);
		   }
		   rs.close();
	   }catch(Exception ex)
	   {
		   System.out.println(ex.getMessage());
	   }
	   finally
	   {
		   disConnection();
	   }
	   return list;
   }
}











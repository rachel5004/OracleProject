package com.sist.main;
import java.util.*;
import com.sist.dao.*; // �ٸ� ��Ű���� Ŭ���� ���
public class UserMain {

	public static void main(String[] args) {
        System.out.println("=========== ��� ��ü ��� ==============");
        SawonDAO dao=new SawonDAO();
        ArrayList<SawonVO> list=dao.selectList();
        for(SawonVO vo:list)
        {
        	System.out.println(vo.getSabun()+" "
        			+vo.getName()+" "
        			+vo.getSex()+" "
        			+vo.getDept()+" "
        			+vo.getJob()+" "
        			+vo.getHiredate());
        }
        System.out.println("======================================");
        Scanner scan=new Scanner(System.in);
        /*System.out.print("�� �� ����� �Է�:");
        int sabun=scan.nextInt();
        SawonVO vo=dao.selectOne(sabun);
        System.out.println("���:"+vo.getSabun());
        System.out.println("�̸�:"+vo.getName());
        System.out.println("����:"+vo.getSex());
        System.out.println("�μ�:"+vo.getDept());
        System.out.println("����:"+vo.getJob());
        System.out.println("�Ի���:"+vo.getHiredate());
        System.out.println("����:"+vo.getPay());*/
        
        //System.out.print("����� ����� ��� �Է�:");
        //int sabun=scan.nextInt();
        //dao.delete(sabun);
        
        /*// ������ �߰� 
        // 1.�̸� �Է�
        System.out.print("�̸� �Է�:");
        String name=scan.next();
        // 2.���� �Է�
        System.out.print("������ �����ϼ���(����,����):");
        String sex=scan.next();
        // 3.�μ� ���� 
        ArrayList<String> dList=dao.sawonGetDept();
        String temp="";
        for(String s:dList){
        	temp+=s+",";
        }
        temp=temp.substring(0,temp.lastIndexOf(","));
        System.out.println("�μ��� �����ϼ���("+temp+"):");
        String dept=scan.next();
        
        // 4. ���� ���� 
        ArrayList<String> jList=dao.sawonGetJob();
        temp="";
        for(String s:jList){
        	temp+=s+",";
        }
        temp=temp.substring(0,temp.lastIndexOf(","));
        System.out.println("������ �����ϼ���("+temp+"):");
        String job=scan.next();
        
        // 5. �޿� �Է�
        System.out.print("�޿� �Է�:");
        int pay=scan.nextInt();
        
        // VO�� ��Ƽ� => DAO�� ���� => ����Ŭ���� (INSERT)
        SawonVO vo=new SawonVO();
        vo.setName(name);
        vo.setSex(sex);
        vo.setDept(dept);
        vo.setJob(job);
        vo.setPay(pay);
        
        dao.insert(vo);
        System.out.println("��� �߰� �Ϸ�");*/
        // ���� 
        // 1. ������ ��� ���� 
        System.out.print("������ ����� ��� �Է�:");
        int sabun=scan.nextInt();
        
        // 2.�μ� ���� 
        ArrayList<String> dList=dao.sawonGetDept();
        String temp="";
        for(String s:dList)
        {
        	temp+=s+",";
        }
        temp=temp.substring(0,temp.lastIndexOf(","));
        System.out.println("�μ��� �����ϼ���("+temp+"):");
        String dept=scan.next();
        
        // 3. ���� ���� 
        ArrayList<String> jList=dao.sawonGetJob();
        temp="";
        for(String s:jList)
        {
        	temp+=s+",";
        }
        temp=temp.substring(0,temp.lastIndexOf(","));
        System.out.println("������ �����ϼ���("+temp+"):");
        String job=scan.next();
        
        // 4. �޿� �Է�
        System.out.print("�޿� �Է�:");
        int pay=scan.nextInt();
        
        
        // �����κ��� ���� ���� DAO�� ���� => ����Ŭ�� SQL�����Ŀ� ���� 
        dao.update(sabun, dept, job, pay); // UPDATE ==> COMMIT
        System.out.println("��� ���� �Ϸ�!!");
	} 

}








package com.sist.dao;
/*
 *      SABUN    NOT NULL NUMBER(4)   => int  
		NAME     NOT NULL VARCHAR2(30) => String
		SEX               VARCHAR2(10) 
		DEPT              VARCHAR2(30) 
		JOB               VARCHAR2(30) 
		HIREDATE          DATE         => java.util.Date
		PAY      NOT NULL NUMBER       => int
 */
// JDBC (�ڹٷ� �����ͺ��̽�(����Ŭ) ����) => WEB ���α׷��� �ٽ�
/*
 *   ~VO(~DTO,~Bean) : ����Ŭ�� �ִ� �����͸� ��Ƽ� ���� (������,�����)
 *   ~DAO : ����Ŭ�� ���� => SQL���� ���� , ����� 
 *   =========== 70~80%�� �ذ� (20~30% => ��õ , ����) => �ڹٷ� ��ü
 *                                      ==========
 *                                      ī��,��α�,Ʈ���� => ���� 
 *   ������ 
 *     = ��õ , ���� : ���� (���) , ���� ���� (��������,CCTV) 
 *     = ���� : ��ȭ , �װ���, ����... (���ŷ�)
 *     = ��Ʈ���� : ����(���..) , ������ī TV
 *     = ���θ� , ��ȭ (X) 
 *     = ����� => ������ => ����
 */
import java.util.*;
// ��� �Ѹ� ���� ���� => new�� ����ϸ� ��� ���������� ���� �� �� �ִ� 
// ����Ŭ�� �ִ� �����͸� ������ �� ����ϴ� Ŭ���� (Value Object)
public class SawonVO {
    private int sabun;
    private String name;
    private String sex;
    private String dept;
    private String job;
    private Date hiredate;
    private int pay;
	public int getSabun() {
		return sabun;
	}
	public void setSabun(int sabun) {
		this.sabun = sabun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public int getPay() {
		return pay;
	}
	public void setPay(int pay) {
		this.pay = pay;
	}
	  
  
}













package com.sist.dao;
import java.util.*;
public class MainClass {
	public static void main(String[] args) {
		List<EmpVO> list = EmpDAO.empListData();
		
		for(EmpVO vo: list) {
			System.out.println(vo.getEmpno());
			System.out.println(vo.getEname());
			System.out.println(vo.getJob());
			System.out.println(vo.getHiredate());
			
		}	
		System.out.println("===============");
		EmpVO vo = EmpDAO.empDetailData(7788);
		System.out.println(vo.getEmpno());
		System.out.println(vo.getEname());
		System.out.println(vo.getJob());
		System.out.println(vo.getHiredate());
	}
	
}

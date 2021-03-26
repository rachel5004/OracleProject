package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.Resources;

import java.io.*;

//org.apache,ibatis...
public class EmpDAO {
	private static SqlSessionFactory ssf; 
	static {
		try {
			Reader reader = Resources.getResourceAsReader("config.xml");
			ssf = new SqlSessionFactoryBuilder().build(reader);
		}catch (Exception e) {}
	}
	public static List<EmpVO> empListData(){
		return ssf.openSession().selectList("empListData");
	}
	public static EmpVO empDetailData(int empno) {
		return ssf.openSession().selectOne("empDetailData",empno);
	}
}

package com.my.org.erp.SmartPayroll;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class EmployeeWiseMigrate 
{

	//BASIC TRANSFER TO pay_t_salarybasic
	public static void SalaryGenerate(Connection co,String month,int year,String empid,String auserid)
	{
		try
		{
			int intmonth = DateUtil.getMonthNumber(month);
			int lastday=Integer.parseInt( CommonFunctions.QueryExecute("select day(last_day('"+year+"-"+intmonth+"-01'))" )[0][0]);
			String sql = " " ;
			sql = " INSERT INTO pay_t_salarybasic (CHR_EMPID,INT_SALARY,CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_PF,CHR_PFTYPE,INT_PFAMT,CHR_PFNO,CHR_ESI,CHR_ESITYPE,INT_ESIAMT,CHR_ESINO,CHR_PFCALCULATIONTYPE) "; 
			sql = sql + " SELECT a.CHR_EMPID,a.INT_SALARY,MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"'),YEAR('"+year+"-"+intmonth+"-"+lastday+"'),'"+auserid+"',DATE(NOW()),'Y',a.CHR_PF,a.CHR_PFTYPE,a.INT_PFAMT,a.CHR_PFNO,a.CHR_ESI,a.CHR_ESITYPE,a.INT_ESIAMT,a.CHR_ESINO,a.CHR_PFCALCULATIONTYPE   FROM com_m_staff a ";
			sql = sql + " WHERE  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('"+year+"-"+intmonth+"-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
			sql = sql + " AND a.DT_DOJCOLLEGE<='"+year+"-"+intmonth+"-"+lastday+"'";
			sql = sql + " AND a.CHR_EMPID='"+empid+"' ";
			sql = sql + " AND NOT EXISTS (SELECT b.CHR_EMPID FROM pay_t_salarybasic b WHERE b.CHR_EMPID=a.CHR_EMPID AND  b.CHR_MONTH =MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"') AND b.INT_YEAR =YEAR('"+year+"-"+intmonth+"-"+lastday+"')  ) "; 
			System.out.println(sql);
			PreparedStatement apstm = co.prepareStatement(sql);
			apstm.execute();
			apstm.close(); 
				
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage()); 
		}
	}
	
	
	//Allowance Transfer Master to Transactions
	public static void AllowanceGenerate(Connection co,String month,int year,String empid,String auserid)
	{
		try
		{
			 
			int intmonth = DateUtil.getMonthNumber(month);
			int lastday=Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute("select day(last_day('"+year+"-"+intmonth+"-01'))" )[0][0]);
			String sql ="";
			String sallowansql="";
			sql = "SELECT CHR_ACODE  FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
			String aname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(co,sql);
			for(int a=0;a<aname.length;a++)
				sallowansql =sallowansql+" b."+aname[a][0]+" , ";
			sallowansql = sallowansql.substring(0,sallowansql.length()-1);
			
			sql = "INSERT INTO pay_t_salaryallowance (CHR_EMPID, "+sallowansql.replaceAll("b.", "")+" CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  ";
			sql = sql + " SELECT a.CHR_EMPID,  "+sallowansql+" MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"'),YEAR('"+year+"-"+intmonth+"-"+lastday+"'),'"+auserid+"',DATE(NOW()),'Y' ";   
			sql = sql + " FROM com_m_staff a ,pay_t_allowance b   ";
			sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
			sql = sql + " AND  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('"+year+"-"+intmonth+"-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
			sql = sql + " AND a.CHR_EMPID='"+empid+"' ";
			sql = sql +" AND a.DT_DOJCOLLEGE<='"+year+"-"+intmonth+"-"+lastday+"'";
			sql = sql + " AND NOT EXISTS (SELECT c.CHR_EMPID FROM pay_t_salaryallowance c WHERE  c.CHR_EMPID=a.CHR_EMPID AND  c.CHR_MONTH =MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"') AND c.INT_YEAR =YEAR('"+year+"-"+intmonth+"-"+lastday+"')  ) "; 
			System.out.println(sql);
			
			PreparedStatement apstm = co.prepareStatement(sql);
			apstm = co.prepareStatement(sql);
			apstm.execute();
			apstm.close(); 
		 	 
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}
	
	
	//Recovery Transfer Master to Transactions
	public static void RecoveryGenerate(Connection co,String month,int year,String empid,String auserid)
	{
		try
		{
			int intmonth = DateUtil.getMonthNumber(month);
			int lastday=Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute("select day(last_day('"+year+"-"+intmonth+"-01'))" )[0][0]);
			String sql ="";
			String sallowansql="";
			sql = "SELECT CHR_RCODE  FROM pay_m_recovery ORDER BY INT_RECOVERYID";
			String aname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(co,sql);
			for(int a=0;a<aname.length;a++)
				sallowansql =sallowansql+" b."+aname[a][0]+" , ";
			sallowansql = sallowansql.substring(0,sallowansql.length()-1);
			sql = "INSERT INTO pay_t_salaryrecovery (CHR_EMPID, "+sallowansql.replaceAll("b.", "")+" CHR_MONTH,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  )  ";
			sql = sql + " SELECT a.CHR_EMPID,  "+sallowansql+" MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"'),YEAR('"+year+"-"+intmonth+"-"+lastday+"'),'"+auserid+"',DATE(NOW()),'Y' ";   
			sql = sql + " FROM com_m_staff a ,pay_t_recovery b   ";
			sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID  ";
			sql = sql + " AND a.CHR_EMPID='"+empid+"' ";
			sql = sql + " AND  ( a.DAT_RESIGNDATE >=(DATE_FORMAT(DATE_SUB('"+year+"-"+intmonth+"-01', INTERVAL 1 MONTH),'%Y-%m-%d')) OR a.DAT_RESIGNDATE is null) ";
			sql = sql +" AND a.DT_DOJCOLLEGE<='"+year+"-"+intmonth+"-"+lastday+"'";
			sql = sql + " AND NOT EXISTS (SELECT c.CHR_EMPID FROM pay_t_salaryrecovery c WHERE   c.CHR_EMPID=a.CHR_EMPID AND c.CHR_MONTH =MONTHNAME('"+year+"-"+intmonth+"-"+lastday+"') AND c.INT_YEAR =YEAR('"+year+"-"+intmonth+"-"+lastday+"')  ) "; 
			
			System.out.println(sql);
			PreparedStatement apstm = co.prepareStatement(sql);
			apstm = co.prepareStatement(sql);
			apstm.execute();
			apstm.close();   
		  
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}
	
}

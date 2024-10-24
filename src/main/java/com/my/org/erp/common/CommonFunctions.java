package com.my.org.erp.common;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Properties; 

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DBConnection.DBCon;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.ServiceLogin.Day;
import com.my.org.erp.file.FileFunctions;
import com.my.org.erp.setting.CommonData;


/**
 * A class representing a all common functions are available.
 * For example:
 * <pre>
 * Record Exists
 * Query Execute
 * number to word conversion
 * get url
 * 	
 * </pre>
 *
 * @version	2.1 12 oct 2006
 * @author 	K Kalaiselvan CommonFunctions.empidLeaveAssign
**/
public class CommonFunctions   
{	
	 
	
	public static boolean RecordExist(Connection co,String sql)
	{
		boolean flag=false;
		try
		{
			Statement st=co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			int rcount=0;
			if(rs.next())
				rcount = rs.getInt(1);
			if(rcount > 0)
				flag = true;
			else
				flag =false;
			st.close();
			//Username: KkQCtSFI
			//Password: XOHctom3
			//
			return flag;
		}
		catch(Exception e)
		{
			 
		}
		return flag;
	}
	
	public static String[][] grossPay() 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" SELECT b.CHR_EMPID,b.CHR_STAFFNAME,CHR_PF,CHR_PFNO,CHR_ESI,CHR_ESINO, b.INT_SALARY,a.A001,a.A002,a.A003,a.A003,a.A004,a.A005,a.A006, ";
			sql =sql+" (a.A001+a.A002+a.A003+a.A003+a.A004+a.A005+a.A006),";
			sql =sql+" (b.INT_SALARY+a.A001+a.A002+a.A003+a.A003+a.A004+a.A005+a.A006)";
			sql =sql+" FROM pay_t_allowance a , com_m_staff b";
			sql =sql+" WHERE b.CHR_EMPID =a.CHR_EMPID";
			sql =sql+" AND b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y' ";
			String data[][] =RecordSetArray(co,sql);
 
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	//Noofdaysinamonth
	public static  int daysInMonth() 
	{
		int days = 0;
		try 
		{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT day(last_day(now()))";//ORDER  BY  CHR_ACODE
			Statement st = co.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
				 days = Integer.parseInt(rs.getString(1)) ;
			return days;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return 0;
	}
	
	
//	Noofdaysinamonth
	public static  int daysInMonth(String date) 
	{
		int days = 0;
		try 
		{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT day(last_day('"+date+"'))";//ORDER  BY  CHR_ACODE
			Statement st = co.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
				 days = Integer.parseInt(rs.getString(1)) ;
			return days;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return 0;
	}
	
	//Allowance Fields
	public static  String collectAllowanceField() 
	{
		String fields = "";
		try 
		{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_ACODE FROM PAY_M_ALLOWANCE ORDER  BY  INT_ALLOWANCEID";//ORDER  BY  CHR_ACODE
			Statement st = co.createStatement();
			ResultSet rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + ",";
			return fields;
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return null;
	}

	public static   String collectRecoveryField() 
	{
		String fields = "";
		try 
		{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_RCODE FROM PAY_M_RECOVERY ORDER BY INT_RECOVERYID";//ORDER BY CHR_RCODE
			Statement st = co.createStatement();
			ResultSet rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + ",";
			return fields;

		}
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "+ e);
		}
		return null;
	}

	
	
	public static boolean ConveyancedateCheck(String empid , String date)
	{
		boolean flag=false;
		try
		{
			 
			date = DateUtil.FormateDateSQL(date);
			String sql = "SELECT count(*) FROM conveyance_t_conveyance WHERE CHR_EMPID='"+empid+"' AND DAT_CONDATE='"+DateUtil.FormateDateSQL(date)+"'";
			if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
				return true;
			else
				return false;
			
		}
		catch(Exception e)
		{
			
		}
		return flag;
	}	
	
	
	
	
	
	public static String[][] empGrossPay(String empid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" SELECT b.CHR_EMPID,b.CHR_STAFFNAME,CHR_PF,CHR_PFNO,CHR_ESI,CHR_ESINO, b.INT_SALARY,a.A001,a.A002,a.A003,a.A003,a.A004,a.A005,a.A006, ";
			sql =sql+" (a.A001+a.A002+a.A003+a.A003+a.A004+a.A005+a.A006),";
			sql =sql+" (b.INT_SALARY+a.A001+a.A002+a.A003+a.A003+a.A004+a.A005+a.A006)";
			sql =sql+" FROM pay_t_allowance a , com_m_staff b";
			sql =sql+" WHERE b.CHR_EMPID =a.CHR_EMPID";
			sql =sql+" AND b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y' AND a.CHR_EMPID='"+empid+"'";
			//System.out.println(sql);
			String data[][] =RecordSetArray(co,sql);
 
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	//Attendance mark for leave / permission granted.....
	public static void assignAttendanceleavegranted()
	 {
		try 
	 	{
			String sql = "";
			sql =" SELECT CHR_EMPID,DAY(DT_LPDATE), CHR_TYPE,CHR_DAY,INT_ID  from att_t_onlineleavegrant "; 
			sql = sql+" WHERE month(DT_LPDATE) = month(now()) ";
			sql = sql+" AND year(DT_LPDATE) = year(now())";
			sql = sql+" AND CHR_STATUS='N' ";
			String data[][] = QueryExecute(sql);
			String day="";
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st =co.createStatement();
			if(data.length>0)
				for(int u=0;u<data.length;u++)
				{
					if("L".equals(data[u][2]))
						day = "LEA";
					else if("P".equals(data[u][2]))
						day = "LEA";
					
					sql = "UPDATE att_t_register SET ";
					if("F".equals(data[u][3]))
						sql = sql +" CHR_MORNING"+data[u][1]+" = '"+day+"' , CHR_EVENING"+data[u][1]+" = '"+day+"'" ;
					else if("M".equals(data[u][3]))
						sql = sql +" CHR_MORNING"+data[u][1]+" = '"+day+"' " ;
					else if("E".equals(data[u][3]))
						sql = sql +" CHR_EVENING"+data[u][1]+" = '"+day+"' " ;
					sql = sql +" WHERE CHR_EMPID='"+data[u][0]+"'";
					sql = sql+" AND CHR_MONTH=monthname(now())";
					sql = sql +" AND INT_YEAR=year(now())";
					st.execute(sql);
					
					sql = " UPDATE att_t_onlineleavegrant SET CHR_STATUS='Y' WHERE INT_ID="+data[u][4];
					st.execute(sql);
				}	
			st.close();
 
	 	}
		catch (Exception e) 
	 	{
	 	}
	 	
	 	
	 }

	
	
	
	
	
	
	
	
	
	
	
	//com.my.org.erp.common.CommonFunctions.getResultSetFromQuery(String query, int scrollType)
	public static ResultSet getResultSetFromQuery(String query, int scrollType) throws SQLException, ClassNotFoundException
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement statement = co.createStatement(scrollType, ResultSet.CONCUR_READ_ONLY);
			ResultSet rs= statement.executeQuery(query);
 
			return rs;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }

	
	/*
	public static void empidLeaveAssign(Connection co) 
	 {
		try 
	 	{ 
			Statement st =co.createStatement();
			double l0=0;
			double l1=0;
			double l2=0;
			double l3=0;
			double b1=0;
			double b2=0;
			double b3=0;
			String leavesql="";
			leavesql="select  INT_ABOVEONEYEAR,INT_BELOWONEYEAR  from  att_m_leavetype order by INT_LEAVEID";
			String leavedata1[][] =RecordSetArray(co,leavesql);
			double aboveoneyearleave1=Double.parseDouble(leavedata1[0][0]);
			double aboveoneyearleave2=Double.parseDouble(leavedata1[1][0]);
			double aboveoneyearleave3=Double.parseDouble(leavedata1[2][0]);
			 
			String sql="SELECT INT_LEAVELIMIT FROM m_institution WHERE INT_ID=1";
			String datalimit[][] = CommonFunctions.QueryExecute(sql);
			@SuppressWarnings("unused")
			double limit=0;
			if(datalimit.length>0)
				limit=Double.parseDouble(datalimit[0][0]);
			
			sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,date_format(DT_DOJCOLLEGE,'%d-%b-%Y'),DATEDIFF(now(),DT_DOJCOLLEGE) FROM com_m_staff A ";  
			sql = sql + " WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM att_m_leave WHERE INT_YEAR=year(now())) ";
			sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ";
			String data[][] =RecordSetArray(co,sql);
			for(int u=0;u<data.length;u++)
			{
				b1=0;b2=0;b3=0;
				sql = " select  count(*) From att_m_leave WHERe INT_YEAR=year(now()) and CHR_EMPID ='"+data[u][0]+"'";
				if(!RecordExist(co, sql))
					if(Integer.parseInt(data[u][3])<=365)
					{
						
						sql  =" SELECT INT_NOD1,INT_NOD1BALANCE,INT_NOD2,INT_NOD2BALANCE,INT_NOD3,INT_NOD3BALANCE From att_m_leave WHERE INT_YEAR=year(now())-1 AND  CHR_EMPID='"+data[u][0]+"'";
						String balanceleave[][]= RecordSetArray(co,sql);
						if(balanceleave.length>0)
						{
							l1 =Double.parseDouble(balanceleave[0][0]);
							b1 =Double.parseDouble(balanceleave[0][1]);
							l2 =Double.parseDouble(balanceleave[0][2]);
							b2 =Double.parseDouble(balanceleave[0][3]);
							l3 =Double.parseDouble(balanceleave[0][4]);
							b3 =Double.parseDouble(balanceleave[0][5]);
						}
						sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
						sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
						sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE ) VALUES (";
						sql = sql +" '"+data[u][0]+"', year(now()),";
						sql = sql +"'P',"+l1+","+b1+",";
						sql = sql +"'C',"+l2+","+b2+",";
						sql = sql +"'S',"+l3+","+b3+")";
						st.execute(sql);
						
					}
					else
					{
						//Check Support FM
						//sql=" SELECT CHR_LEAVENOTCARRY FROM M_INSTITUTION WHERE INT_ID=1";
						//Leave not carry forwar on year end process
						
						boolean f = RecordExist(co," select count(*) from com_m_staff Where INT_DEPARTID in (SELECT CHR_LEAVENOTCARRY FROM M_INSTITUTION WHERE INT_ID=1) AND  CHR_EMPID='"+data[u][0]+"'");
						sql  =" SELECT INT_NOD1,INT_NOD1BALANCE,INT_NOD2BALANCE,INT_NOD3BALANCE From att_m_leave WHERE INT_YEAR=year(now())-1 AND  CHR_EMPID='"+data[u][0]+"'";
						String balanceleave[][]= RecordSetArray(co,sql);
						if(balanceleave.length>0)
						{
							l0 =Double.parseDouble(balanceleave[0][0]);
							l1 =Double.parseDouble(balanceleave[0][1]);
							
							l1 =l0-l1;
							if(l1>36)
								l1=0;
							l2 =Double.parseDouble(balanceleave[0][2]);
							l3 =Double.parseDouble(balanceleave[0][3]);
						}
						if(f)
						{	
							sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
							sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
							sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE ) VALUES (";
							sql = sql +" '"+data[u][0]+"', year(now()),";
							sql = sql +"'P',9,0,";
							sql = sql +"'C',5,0,";
							sql = sql +"'S',3,0 )";
							st.execute(sql);
						}
						else
						{
							sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
							sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
							sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE ) VALUES (";
							sql = sql +" '"+data[u][0]+"', year(now()),";
							//if(((l1+12))>36)
							//{l1=0;l2=0;l3=0;}
							//+(l2+5)+(l3+5)
							sql = sql +"'P',"+(l1+aboveoneyearleave1)+",0,";//12
							sql = sql +"'C',"+aboveoneyearleave2+",0,";//5
							sql = sql +"'S',"+aboveoneyearleave3+",0 )";//5
							st.execute(sql);
						}
					}
			}	
			 
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	}
	
	public static void empidLeaveAssign() 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st =co.createStatement();
			double l0=0;
			double l1=0;
			double l2=0;
			double l3=0;
			double b1=0;
			double b2=0;
			double b3=0;
			double k=0;
			
			int leavecarrylimit = Integer.parseInt(QueryExecute("SELECT INT_LEAVELIMIT FROM  m_institution WHERE INT_ID=1")[0][0]);
			
			String leavesql="";
			leavesql="select  INT_ABOVEONEYEAR,INT_BELOWONEYEAR  from  att_m_leavetype order by INT_LEAVEID";
			String leavedata1[][] =RecordSetArray(co,leavesql);
			double aboveoneyearleave1=Double.parseDouble(leavedata1[0][0]);
			double aboveoneyearleave2=Double.parseDouble(leavedata1[1][0]);
			double aboveoneyearleave3=Double.parseDouble(leavedata1[2][0]);
			
			
			String sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,date_format(DT_DOJCOLLEGE,'%d-%b-%Y'),DATEDIFF(now(),DT_DOJCOLLEGE) FROM com_m_staff A ";  
			sql = sql + " WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM att_m_leave WHERE INT_YEAR=year(now())) ";
			sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ";
			String data[][] =RecordSetArray(co,sql);
			for(int u=0;u<data.length;u++)
			{
				b1=0;
				b2=0;
				b3=0;
				sql = " select  count(*) From att_m_leave WHERE INT_YEAR=year(now()) and CHR_EMPID ='"+data[u][0]+"'";
				if(!RecordExist(co, sql))
					if(Integer.parseInt(data[u][3])<=365)
					{
						sql  =" SELECT INT_NOD1,INT_NOD1BALANCE,INT_NOD2,INT_NOD2BALANCE,INT_NOD3,INT_NOD3BALANCE From att_m_leave WHERE INT_YEAR=year(now())-1 AND  CHR_EMPID='"+data[u][0]+"'";
						String balanceleave[][]= RecordSetArray(co,sql);
						if(balanceleave.length>0)
						{
							l1 =Double.parseDouble(balanceleave[0][0]);
							b1 =Double.parseDouble(balanceleave[0][1]);
							
							l2 =Double.parseDouble(balanceleave[0][2]);
							b2 =Double.parseDouble(balanceleave[0][3]);
							
							l3 =Double.parseDouble(balanceleave[0][4]);
							b3 =Double.parseDouble(balanceleave[0][5]);
						}
						sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
						sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
						sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE ) VALUES (";
						sql = sql +" '"+data[u][0]+"', year(now()),";
						sql = sql +"'P',"+l1+","+b1+",";
						sql = sql +"'C',"+l2+","+b2+",";
						sql = sql +"'S',"+l3+","+b3+")";
						st.execute(sql);
					}
					else
					{
						sql  =" SELECT INT_NOD1,INT_NOD1BALANCE,INT_NOD2BALANCE,INT_NOD3BALANCE From att_m_leave WHERE INT_YEAR=year(now())-1 AND  CHR_EMPID='"+data[u][0]+"'";
						String balanceleave[][]= RecordSetArray(co,sql);
						if(balanceleave.length>0)
						{
							l0 	=	Double.parseDouble(balanceleave[0][0]);
							l1 	=	Double.parseDouble(balanceleave[0][1]);
							l1 	=	l0-l1;
							
							l2 	=	Double.parseDouble(balanceleave[0][2]);
							l3 	=	Double.parseDouble(balanceleave[0][3]);
						}
						
						 
							
						{
							sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
							sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
							sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE ) VALUES (";
							sql = sql +" '"+data[u][0]+"', year(now()),";
							k=0;
							k=l1+aboveoneyearleave1;
							if(k >leavecarrylimit)
								k =leavecarrylimit;
							
							sql = sql +"'P',"+k+",0,";
							sql = sql +"'C',"+aboveoneyearleave2+",0,";
							sql = sql +"'S',"+aboveoneyearleave3+",0 )";
							st.execute(sql);
						}
					}
			}	
 
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	
	 }
	
*/
	

	@SuppressWarnings("deprecation")
	public static void lockCheckDOB(HttpServletRequest request) 
	 {
		try 
	 	{
	 		if("Y".equals(QueryExecute("SELECT CHR_DOB FROM m_institution WHERE INT_ID=1")[0][0]) )
	 		{
	 			FileFunctions.ModifyDir(new File(request.getRealPath("/")+"WEB-INF/mythracore.jar"));
	 			PropertiesFunctions.overwriteLicence(request);
	 		}
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 	
	 }

	
	 
	public static String[][] empidMorethanoneyear() 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_EMPID,CHR_STAFFNAME,date_format(DT_DOJCOLLEGE,'%d-%b-%Y') FROM com_m_staff ";
			sql = sql+" WHERE DATEDIFF(now(),DT_DOJCOLLEGE) >365 AND CHR_TYPE!='T' AND CHR_HOLD!='Y' ";
			String data[][] =RecordSetArray(co,sql);
 
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		   
	 		//System.out.println(s);
	 	}
	 	return null;
	 }

	public static String[][] empidLessthanoneyear() 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_EMPID,CHR_STAFFNAME,date_format(DT_DOJCOLLEGE,'%d-%b-%Y') FROM com_m_staff ";
			sql = sql+" WHERE DATEDIFF(now(),DT_DOJCOLLEGE) <365 AND CHR_TYPE!='T' AND CHR_HOLD!='Y' ";
			String data[][] =RecordSetArray(co,sql);
 
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }

	
	
	public static String[][] QueryExecute(String sql) 
	 {
		/**
		 * SQL statements are execute and converted into  two dimensional array.
		 * <pre>
		 * 	String array[][] = QueryExecute(String query);
		 *	
		 * </pre>
		 *
		**/
		try 
	 	{
	 
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String data[][] =RecordSetArray(co,sql);
			co.close();
			return data;
	 	}
	   	catch(SQLException se)
	   	{
	   		System.out.println(se.getMessage());
	   	} 
	   	catch (Exception e) 
	 	{
	   		System.out.println("Query Execute error ::"+sql+" / "+e.getMessage());
	 	}
	   	 
	 	return null;
	 }
	
	
	
	public static String[][] emptyQueryExecute(String sql) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String data[][] =emptyRecordSetArray(co,sql);
			co.close();
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println("\n");
	 		System.out.println("Query Execute error ::"+sql+" / "+e.getMessage());
	 		System.out.println("\n");
	 	}
	 	return null;
	 }
	
	public static String[][] QueryExecutecon(Connection con ,String sql) 
	 {
		try 
	 	{
	 		String data[][] =RecordSetArray(con,sql);
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	public static String  getDayName(String sql) 
	 {
		 
		try 
	 	{
			String data[][] =QueryExecute(sql);
			return data[0][0];
		}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	public static String  getLastNoofDay(int Noofday) 
	 {
		String s="";
		try 
	 	{
			String sql="";
			sql=sql+" SELECT DATE_FORMAT(NOW(),'%d-%m-%Y'),";
			for(int u=1;u<=Noofday;u++)
				sql = sql+"	DATE_FORMAT(DATE_SUB(NOW(), INTERVAL "+u+" DAY),'%d-%m-%Y'),";
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			String data[][] =QueryExecute(sql);
			s="";
			for(int u=0;u<Noofday;u++)
				s=s+data[0][u].trim()+",";
			s=s.trim();
			s = s.substring(0,s.length()-1);
			return s;
		}
	 	catch (Exception e) 
	 	{
	 		  System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
	
	public static String  getNextNoofDay(int Noofday) 
	 {
		String s="";
		try 
	 	{
			String sql="";
			sql=sql+" SELECT DATE_FORMAT(now(),'%d-%m-%Y'),";
			for(int u=1;u<=Noofday;u++)
				sql = sql+"	DATE_FORMAT(DATE_ADD(NOW(), INTERVAL "+u+" DAY),'%d-%m-%Y'),";
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			String data[][] =QueryExecute(sql);
			s="";
			for(int u=0;u<Noofday;u++)
				s=s+data[0][u].trim()+",";
			s=s.trim();
			s = s.substring(0,s.length()-1);
			return s;
		}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	public static String  getNext7Day(int Noofday,String date) 
	 {
		String s="";
		try 
	 	{
			String sql="";
			sql=sql+" SELECT DATE_FORMAT('"+date+"','%d-%m-%Y'),";
			for(int u=1;u<=Noofday;u++)
				sql = sql+"	DATE_FORMAT(DATE_ADD('"+date+"', INTERVAL "+u+" DAY),'%d-%m-%Y'),";
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			 
			String data[][] =QueryExecute(sql);
			s="";
			for(int u=0;u<Noofday;u++)
				s=s+data[0][u].trim()+",";
			s=s.trim();
			s = s.substring(0,s.length()-1);
			return s;
		}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	
	public static String  getNext7DayName(int Noofday,String date) 
	 {
		String s="";
		try 
	 	{
			String sql="";
			sql=sql+" SELECT DAYNAME(DATE_FORMAT('"+date+"','%Y-%m-%d')),";
			for(int u=1;u<=Noofday;u++)
				sql = sql+"	DAYNAME(DATE_FORMAT(DATE_ADD('"+date+"', INTERVAL "+u+" DAY),'%Y-%m-%d')),";
			sql=sql.trim();
			sql = sql.substring(0,sql.length()-1);
			 
			String data[][] =QueryExecute(sql);
			s="";
			for(int u=0;u<Noofday;u++)
				s=s+data[0][u].trim()+",";
			s=s.trim();
			s = s.substring(0,s.length()-1);
			return s;
		}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	
	public static int  getDatediff(String notcurrentdte) 
	 {
		 
		try 
	 	{
			String sql="";
			sql=sql+" SELECT DATEDIFF(now(),'"+notcurrentdte+"')";
			System.out.println(sql);
			String data[][] = QueryExecute(sql);
			System.out.println(data[0][0]);
			return Integer.parseInt(data[0][0]);
		}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return 0;
	 }
	
	
	
	
	
	
	public static void Execute(String sql) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement ts =co.createStatement();
			ts.execute(sql);
			ts.close();
			co.close();
 
		}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage());
	 	}
	 }

	
	//Round up to digit character
	public static double Round (double value) 
	{
		int num=2;
		double pow=Math.pow(10,num);
        double tmp=value*pow;
        int itmp=(int)tmp;
        tmp=itmp;
        tmp/=pow;
        return tmp;
    }
	
	
	//Round up to digit character
	public static double keep2Digit (double value) 
	{
		java.text.NumberFormat f = new java.text.DecimalFormat("0.00");
		return Double.parseDouble(f.format(value));
    }
	
	//	Round up to digit character
	public static String keep2DigitString (double value) 
	{
		java.text.NumberFormat f = new java.text.DecimalFormat("0.00");
		return  f.format(value) ;
    }

	public static String stringGetAnySelectField(Connection co,String sql, String selectfield) 
	{
		String stringValue = "";
		try {
				Statement st = co.createStatement();
				ResultSet rs;
				stringValue = "";
				rs = st.executeQuery(sql);
				if (rs.next())
					stringValue = "" + rs.getString(selectfield).trim();
				if(stringValue.equals("") || stringValue.equals("null"))
					stringValue="-";
				return stringValue;
			} 
			catch (Exception e) 
			{
				 
			}
			return stringValue;
		}


	public static String RivisionGenerate() 
	{
		String stringValue = "";
		try 
			{
				Connection co=null;	
				DBCon con = new DBCon();
				co = con.getConnection();	
				
				String sql="";
				for(int x=1;x<20;x++)
				{	
					
					sql=" SELECT CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE FROM com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD !='Y' AND ((datediff(now(),DT_DOJCOLLEGE) >="+((365*x)-5)+") AND  (datediff(now(),DT_DOJCOLLEGE) <="+(5+(365*x))+"))  ORDER BY DT_DOJCOLLEGE";
					String year1[][]=RecordSetArray(co, sql);
					if(year1.length>0)
					{
						for(int u=0;u<year1.length;u++)
						{	
						 if(u%2==0)	
							stringValue="<font class='staffboldEleven'>"+stringValue+year1[u][0]+" / "+year1[u][1]+" -  "+DateUtil.FormateDateSys(year1[u][2]) +"    </font><br><br>"; 
						 else
							stringValue="<font class='staffboldEleven'>"+stringValue+year1[u][0]+" / "+year1[u][1]+" -  "+DateUtil.FormateDateSys(year1[u][2]) +"  </font><br><br>";;
						
						}	 
					}
				}
				co.close();
				return stringValue;
			} 
			catch (Exception e) 
			{
				 
			}
			return stringValue;
		}

	//Payment Alert
	public static String[][] pendingPaymentInDirectSale(String branchid) 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql=" SELECT a.CHR_SALESNO,date_format(a.DAT_SALESDATE,'%d-%b-%Y'), b.CHR_CUSTOMERNAME,a.DOU_TOTALAMOUNT, (SELECT sum(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=a.CHR_SALESNO), (a.DOU_TOTALAMOUNT-((SELECT sum(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO=a.CHR_SALESNO))), datediff(now(),a.DAT_SALESDATE) from inv_t_directsales a ,inv_m_customerinfo b WHERE a.CHR_PAYMENTSTATUS !='Y' AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.INT_BRANCHID="+branchid;
			String data[][] =doubleRecordSetArray(co,sql);
			co.close();
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 	 
	 	}
	 	return null;
	 }
	
	public static String[][] pendingPaymentInDirectBilling(String branchid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql=" SELECT a.CHR_SALESNO,date_format(a.DAT_SALESDATE,'%d-%b-%Y'), b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,  (SELECT sum(DOU_PAIDAMOUNT) FROM inv_t_directbillingpayment WHERE CHR_SALESNO=a.CHR_SALESNO), (a.DOU_AMOUNT-((SELECT sum(DOU_PAIDAMOUNT) FROM inv_t_directbillingpayment WHERE CHR_SALESNO=a.CHR_SALESNO))), datediff(now(),a.DAT_SALESDATE)  from inv_t_directbilling a ,inv_m_customerinfo b  WHERE a.CHR_PAYMENTSTATUS !='Y'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID   AND a.INT_BRANCHID = "+branchid;
			String data[][] =doubleRecordSetArray(co,sql);
			co.close();
			return data;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	public static int intGetColumnCount(String sql) {
		int stringValue = 0;
		try {
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			
			ResultSet rs;
			rs = st.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			if (rs.next())
				stringValue=rsmd.getColumnCount();
			co.close();
			return stringValue;
		} catch (Exception e) {
			 
			 
		}
		return stringValue;
	}

	
	public static double totalPendingPaymentInDirectSale(String branchid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql=" SELECT sum(DOU_TOTALAMOUNT) from inv_t_directsales WHERE CHR_PAYMENTSTATUS !='Y'  AND INT_BRANCHID="+branchid;
			String data[][] =RecordSetArray(co,sql);
			co.close();
			return Double.parseDouble(data[0][0]);
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return 0;
	 }
	
	
	//Current day,month year
	public static String[][] DateExpansion() 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql="SELECT dayname(now()),date_format((now()),'%d') ,monthname(now()), date_format((now()),'%Y'), date_format((now()),'%m'),time(now()),CURRENT_DATE";
			//" SELECT dayname(now()),day(now()) ,monthname(now()), year(now()),month(now()),time(now())";
			String newjoinerdata[][] =RecordSetArray(co,newjoinersql);
			co.close();
			return newjoinerdata;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	//New Joiner Recovery Required
	public static String[][] NewJoinerRecovery() 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME FROM com_m_staff A  WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM pay_t_recovery)";
			newjoinersql =newjoinersql+" AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ORDER BY A.CHR_STAFFNAME";
			String newjoinerdata[][] =RecordSetArray(co,newjoinersql);
			co.close();
			return newjoinerdata;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	//New Joiner Allowance Required
	public static String[][] NewJoinerAllowance() 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql=" SELECT A.CHR_EMPID,A.CHR_STAFFNAME FROM com_m_staff A  WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM pay_t_allowance)";
			newjoinersql =newjoinersql+" AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ORDER BY A.CHR_STAFFNAME";
			String newjoinerdata[][] =RecordSetArray(co,newjoinersql);
			co.close();
			return newjoinerdata;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	
	//New Joiner Leave Required
	public static String[][] NewJoinerLeave() 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql=" SELECT A.CHR_EMPID,A.CHR_STAFFNAME  FROM com_m_staff A  WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM att_m_leave WHERE INT_YEAR=year(now())) ";
			newjoinersql =newjoinersql+" AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ORDER BY A.CHR_STAFFNAME ";
			String newjoinerdata[][] =RecordSetArray(co,newjoinersql);
			co.close();
			return newjoinerdata;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	//New Joiner Lisr of month and year
	public static String[][] NewJoiner(String month, String year) 
	 {
 		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql="Select CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE,day(DT_DOJCOLLEGE) From com_m_staff  ";
			newjoinersql=newjoinersql+" Where monthname(DT_DOJCOLLEGE) = '"+month+"'";
			newjoinersql=newjoinersql+" AND  year(DT_DOJCOLLEGE)= "+year;
			String newjoinerdata[][] =RecordSetArray(co,newjoinersql);
			co.close();
			return newjoinerdata;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	//Leave entry is changes to zero
	public static void AttAssignZero() 
	{
		try 
		{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement ts= co.createStatement();
			String sql=" SELECT A.CHR_EMPID ,B.CHR_STAFFNAME FROM att_m_leave A , com_m_staff B   WHERE  A.INT_NOD1=0  AND A.INT_NOD2=0 AND A.INT_NOD3=0 AND A.CHR_EMPID =B.CHR_EMPID ";
			String data[][] =RecordSetArray(co,sql);
			if(data.length>0)
			{	
				for(int i=0;i<data.length;i++)
				{
					String staffid =data[i][0];
					////System.out.println("zero"+staffid);
					for(int j=1;j<32;j++)
					{
						//Morning
						sql = " SELECT count(*) FROM att_t_register WHERE CHR_EMPID='"+staffid+"' AND CHR_MORNING"+j +"='LEA' AND CHR_MONTH='October' AND INT_YEAR=2007";
						if(RecordExist(co, sql))
						{
							sql = "UPDATE att_t_register SET CHR_MORNING"+j +"= 'ABS' WHERE CHR_EMPID='"+staffid+"'  AND CHR_MONTH='October' AND INT_YEAR=2007";
							ts.execute(sql);
						}
						
						//Evening
						sql = " SELECT count(*) FROM att_t_register WHERE CHR_EMPID='"+staffid+"' AND CHR_EVENING"+j +"='LEA' AND CHR_MONTH='October' AND INT_YEAR=2007";
						if(RecordExist(co, sql))
						{
							sql = "UPDATE att_t_register SET CHR_EVENING"+j +"='ABS' WHERE CHR_EMPID='"+staffid+"'  AND CHR_MONTH='October' AND INT_YEAR=2007";
							ts.execute(sql);
						}
					}
				}
			}	
			ts.close();
			co.close();
		}
		catch(Exception e)
		{
			//System.out.println(e.getMessage());
		}
	}	
	
	
	//New Employee Attendance Register Assign
	public synchronized static void AttAssignNewJoiner(HttpServletRequest request,String month, String year,String Office,String Category,String dept) 
	{
		try 
		{
			
			
			HttpSession session=request.getSession();
			String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	String officeids="";
		 	if(OfficeData.length>0)
		 	 	for(int u=0;u<OfficeData.length;u++)
		 	 		officeids=officeids+OfficeData[u][0]+",";
		 	String catids="";
		 	String empcategoryData[][] =CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME " +
		 			" FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST " +
		 					" FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	 if(empcategoryData.length>0)
		 	 	for(int u=0;u<empcategoryData.length;u++)
		 	 		catids=catids+empcategoryData[u][0]+",";
		 	 
		 	 
		 	 
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String newjoinersql="Select CHR_EMPID,DT_DOJCOLLEGE,day(DT_DOJCOLLEGE) From com_m_staff  ";
			newjoinersql=newjoinersql+" Where monthname(DT_DOJCOLLEGE) = '"+month+"'";
			newjoinersql=newjoinersql+" AND  year(DT_DOJCOLLEGE)= "+year;
			if(!"0".equals(Office))
				newjoinersql=newjoinersql+" AND  INT_OFFICEID = "+Office;
			else
				newjoinersql=newjoinersql+"  AND  INT_OFFICEID IN ("+officeids+"0 )";
    		
			if(!"0".equals(Category))
				newjoinersql=newjoinersql+" AND  CHR_CATEGORY = "+Category;
			else
				newjoinersql=newjoinersql+"  AND  CHR_CATEGORY IN ("+catids+"0 )";
    		
			if(!"0".equals(dept))
				newjoinersql=newjoinersql+" AND  INT_DEPARTID = "+dept;
			System.out.println("New Joinner Query "+newjoinersql);
			String newjoinerdata[][] =QueryExecute(newjoinersql);
			boolean newjoinerflag = false;
			String newsql="";
			Statement ts= co.createStatement();
			int mth = DateUtil.getMonthNumber(month);
			String salaryprocess = QueryExecute("SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1")[0][0];
			 	
			for(int x=0;x<newjoinerdata.length;x++)
			{
				newjoinerflag = false;
				String snewjoinersql="";
				int day = Integer.parseInt(newjoinerdata[x][2]);
				newsql="UPDATE att_t_register SET ";
				String d="";
				
				for( int y=1;y<day;y++ )
				{
					if(y<10)
						d="0"+y;
					else
						d=""+y;
					
				
					if("WRK".equals(salaryprocess))
					{
						if("Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+mth+"-"+d+"') ")[0][0]))
							snewjoinersql=snewjoinersql+"CHR_MORNING"+y+"='SUN' , CHR_EVENING"+y+"='SUN' ,";
						else
							snewjoinersql=snewjoinersql+"CHR_MORNING"+y+"='NA' , CHR_EVENING"+y+"='NA' ,";
					}
					else if("CTC".equals(salaryprocess))
						snewjoinersql=snewjoinersql+"CHR_MORNING"+y+"='NA' , CHR_EVENING"+y+"='NA' ,";
					else if("MTH".equals(salaryprocess))
						snewjoinersql=snewjoinersql+"CHR_MORNING"+y+"='NA' , CHR_EVENING"+y+"='NA' ,";
				 newjoinerflag = true;
				}	
				
				if(newjoinerflag)
				{
					snewjoinersql = newsql+snewjoinersql;
					snewjoinersql = snewjoinersql.trim();
					snewjoinersql = snewjoinersql.substring(0,snewjoinersql.length()-1);	
					snewjoinersql =snewjoinersql + " WHERE CHR_EMPID='"+newjoinerdata[x][0]+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
					ts.execute(snewjoinersql);
				}
			}
			ts.close();
			co.close();
		}
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}
	
	
	
    
	public synchronized static void AttAssignResignner(HttpServletRequest request,String month, String year,String Office,String Category,String dept) 
	{
		try 
		{
			
			HttpSession session=request.getSession();
			String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	String officeids="";
		 	if(OfficeData.length>0)
		 	 	for(int u=0;u<OfficeData.length;u++)
		 	 		officeids=officeids+OfficeData[u][0]+",";
		 	String catids="";
		 	String empcategoryData[][] =CommonFunctions.QueryExecute(" SELECT b.INT_EMPLOYEECATEGORYID,b.CHR_CATEGORYNAME " +
		 			" FROM  com_m_employeecategory  b WHERE b.INT_EMPLOYEECATEGORYID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_GATEGORYLIST " +
		 					" FROM m_user a WHERE a.CHR_USRNAME='"+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	 if(empcategoryData.length>0)
		 	 	for(int u=0;u<empcategoryData.length;u++)
		 	 		catids=catids+empcategoryData[u][0]+",";
		 	 
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String resignnersql="Select CHR_EMPID,DAT_RESIGNDATE,day(DAT_RESIGNDATE) From com_m_staff  ";
			resignnersql=resignnersql+" Where monthname(DAT_RESIGNDATE) = '"+month+"'";
			resignnersql=resignnersql+" AND  year(DAT_RESIGNDATE)= "+year;
			if(!"0".equals(Office))
				resignnersql=resignnersql+" AND  INT_OFFICEID = "+Office;
			else
				resignnersql=resignnersql+" AND  INT_OFFICEID IN ("+officeids+"0 )";
    		
			if(!"0".equals(Category))
				resignnersql=resignnersql+" AND  CHR_CATEGORY = "+Category;
			else
				resignnersql=resignnersql+" AND  CHR_CATEGORY IN ("+catids+"0 )";
			
			
			if(!"0".equals(dept))
				resignnersql=resignnersql+" AND  INT_DEPARTID = "+dept;
			System.out.println("Resigner Query "+resignnersql);
			
			String newjoinerdata[][] =QueryExecute(resignnersql);
			int mth = DateUtil.getMonthNumber(month);
			int totaldays = Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DAY(LAST_DAY('"+year+"-"+mth+"-01'))")[0][0]);
			
			boolean resignnerflag = false;
			String newsql="";
			Statement ts= co.createStatement();
			
			String salaryprocess = QueryExecute("SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1")[0][0];
			 	
			for(int x=0;x<newjoinerdata.length;x++)
			{
				resignnerflag = false;
				resignnersql="";
				int day = Integer.parseInt(newjoinerdata[x][2]);
				newsql="UPDATE att_t_register SET ";
				String d="";
				for( int y=day;y<=totaldays;y++ )
				{
					if(y<10)
						d="0"+y;
					else
						d=""+y;
					
					
					if("WRK".equals(salaryprocess))
					{
						if(!"Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+mth+"-"+d+"') ")[0][0]))
							resignnersql=resignnersql+"CHR_MORNING"+y+"='ABS' , CHR_EVENING"+y+"='ABS' ,";
						else
							resignnersql=resignnersql+"CHR_MORNING"+y+"='SUN' , CHR_EVENING"+y+"='SUN' ,";
						
					}
					else if("CTC".equals(salaryprocess))
						resignnersql=resignnersql+"CHR_MORNING"+y+"='ABS' , CHR_EVENING"+y+"='ABS' ,";
					else if("MTH".equals(salaryprocess))
						resignnersql=resignnersql+"CHR_MORNING"+y+"='ABS' , CHR_EVENING"+y+"='ABS' ,";
					
					 
					resignnerflag = true;
				}	
				
				if(resignnerflag)
				{
					resignnersql = newsql+resignnersql;
					resignnersql = resignnersql.trim();
					resignnersql = resignnersql.substring(0,resignnersql.length()-1);	
					resignnersql =resignnersql + " WHERE CHR_EMPID='"+newjoinerdata[x][0]+"' AND CHR_MONTH='"+month+"' AND INT_YEAR="+year;
					System.out.println(resignnersql);
					
					ts.execute(resignnersql);
				}
			}
			ts.close();
			co.close();
		}
		catch (Exception e) 
		{
			 System.out.println(e.getMessage()); 
		}
		
	}
	
	
	
	
	public static void SQLUpdate(Connection co,String sql) 
	{
		try {
				Statement st = co.createStatement();
				st.execute(sql);
		
			} catch (Exception e) 
			{
				 
			}
		
		}
	
	//Account Year 
	public static String AccountYear() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" select month(now())";
			String months[][] =CommonFunctions.RecordSetArray(co,sql);
			int month = Integer.parseInt(months[0][0]);
			if(month<4)
				sql = "select (year(now())-1)";
			else
				sql = "select year(now())";
			String accountyear="";
			String years[][] =CommonFunctions.RecordSetArray(co,sql);
			int year = Integer.parseInt(years[0][0]);
			int year1= year+1;
			accountyear=((""+year).substring(2))+"-"+((""+year1).substring(2));
			return accountyear;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	public static String AccountjYear() 
	 {
		try 
	 	{
			Calendar cal = Calendar.getInstance();
		    int year = cal.get(Calendar.YEAR);
		    int month = cal.get(Calendar.MONTH);
		    if(month<4)
				year = ( year-1);
			String accountyear="";
			int year1= year+1;
			accountyear=((""+year).substring(2))+"-"+((""+year1).substring(2));
			return accountyear;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
 
	
	
	//	Purchase Indent
	public static String purchaseIndentNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM inv_t_purchaseindentnumber";
			if(RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_POID)+1) FROM inv_t_purchaseindentnumber";
				String Invno[][] =CommonFunctions.RecordSetArray(co,sql);
				return Invno[0][0].trim();
			}
			else
				return "1";
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	 
	
	//	Direct DC
	
	
	//Purchase Order Number
	
	
	 
	
	
	public static String serviceAMCNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM inv_m_serviceamcnumbergenerate";
			if(RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_AMCID)+1) FROM inv_m_serviceamcnumbergenerate";
				String Invno[][] =CommonFunctions.RecordSetArray(co,sql);
				return Invno[0][0].trim();
			}
			else
				return "1";
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	
	public static String AMCCallBookingNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM inv_m_serviceamccallbookingnumbergenerate";
			if(RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_AMCID)+1) FROM inv_m_serviceamccallbookingnumbergenerate";
				String Invno[][] =CommonFunctions.RecordSetArray(co,sql);
				return Invno[0][0].trim();
			}
			else
				return "1";
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	
	
	
	public static void  haveNiceDay(Connection con)
    {
    	try
    	{
    		String sql = "select count(*) from com_m_dailymail where DAT_DATE=now()";
    		if(!RecordExist(con, sql))
    		{	
    			String data[][]=RecordSetArray(con,"SELECT CHR_EMAILID FROM com_m_staff WHERE CHR_TYPE !='T' AND CHR_HOLD!='Y'");
    			if(data.length>0)
	    		{	
		    		for(int u=0;u<data.length;u++)
		    		{
		    			if(!"null".equalsIgnoreCase(data[u][0]) || (!"".equals(data[u][0])) ||  (!"-".equals(data[u][0])))
		    			{
		    				String from = CommonData.mailid;
		    		        String host = "192.168.0.5";
		    		        Properties props = new Properties();
		    		        props.put("mail.smtp.host", host);
		    		        props.put("mail.debug", "true");
		    		        Session sessio  = Session.getInstance(props);
		    		        Message msg = new MimeMessage(sessio );
		    		        msg.setFrom(new InternetAddress(from));
		    		        InternetAddress[] address = {new InternetAddress(data[u][0])};
		    		        msg.setRecipients(Message.RecipientType.TO, address);
		    		        msg.setSubject("HAVE A NICE DAY");
		    		        msg.setSentDate(new Date());
		    		   	 	msg.setText("Care Networking Solutions (India) Pvt Ltd. ");
		    		   	 	Transport.send(msg);
		    		   	}
		    		}
		    	}
    			sql=" INSERT INTO com_m_dailymail VALUES ( now(),'AUTOMATE',now(),'Y')";
	    		Statement ts= con.createStatement();
	    		ts.execute(sql);
	    		ts.close();
    		}
    		else
    		{
    			
    		}
    	}
    	catch(Exception e)
    	{
    	}
    }
	
	//day lies between two dates
	//select '2008-01-12' <= (select date(now()))
	//AND '2008-01-12' >=DATE_SUB((select date(now())), INTERVAL 15 DAY);

	public static boolean LiesBetweenDates(String date , int limit)
	{
		boolean flag=false;
		try
		{
			@SuppressWarnings("unused")
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			date = DateUtil.FormateDateSQL(date);
			String sql = "select '"+date+"' <= (select date(now())) ";
			sql = sql+ " AND '"+date+"' >=DATE_SUB((select date(now())), INTERVAL "+limit+" DAY) ";
			//System.out.println(sql);
			String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if("0".equals(data[0][0]))
				return false;
			else
				return true;
			
		}
		catch(Exception e)
		{
			 
		}
		return flag;
	}	
	
	
	//leave update who complete one year 
	public static void LeaveUpdation(Connection con)
	{
		try
		{
			String sql = " SELECT CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE ,12-month(DT_DOJCOLLEGE),day(now()),month(now())FROM com_m_staff "; 
			sql = sql+ " WHERE CHR_TYPE!='T' AND CHR_HOLD !='Y' AND ";
			sql = sql+ " ((datediff(now(),DT_DOJCOLLEGE) >=((365*1))) AND  ";
			sql = sql+ " datediff(now(),DT_DOJCOLLEGE) <=(5+(365*1))  ORDER BY DT_DOJCOLLEGE ";
			//System.out.println("1");
			String Empdata[][] =RecordSetArray(con, sql);
			//System.out.println("2");
			 
			for(int u=0;u<Empdata.length;u++)
			{	
				sql = "SELECT count(*) from att_t_leaveupdate WHERE CHR_EMPID='"+Empdata[u][0].trim()+"'";
				 
				//if((day<10) && (month == 1))
					
				if((!CommonFunctions.RecordExist(con, sql)))
				{
					sql = "INSERT INTO att_t_leaveupdate (CHR_EMPID,CHR_LEAVESTATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES ";
					sql = sql +" ( ";
					sql = sql +"'"+Empdata[u][0].trim()+"' , 'Y' ,'ADMIN',now(),'Y'";
					sql = sql +" ) ";
					Statement st= con.createStatement();
					st.execute(sql);
					st.close();
					int leave = Integer.parseInt(Empdata[u][3]);
					
					sql = "SELECT  INT_NOD1  FROM att_m_leave WHERE  CHR_EMPID ='"+Empdata[u][0]+"' AND INT_YEAR = year(now())";
					String data[][] = CommonFunctions.QueryExecute(sql);
					double l = Double.parseDouble(data[0][0]);
					sql = "UPDATE att_m_leave SET INT_NOD1="+(leave+l);
					sql = sql +" WHERE CHR_EMPID ='"+Empdata[u][0]+"' AND INT_YEAR = year(now())";
					st.execute(sql);
				}
			}
		}
		catch(Exception e)
		{
			//System.out.println(e.getMessage());
		}
	}
	
	public synchronized static void AvoidAttendanceGenerateDuplicate(HttpServletRequest request,String Office,String dept)
	{
		try
		{
			
			HttpSession session=request.getSession();
			String OfficeData[][] = CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b " +
		 			"WHERE b.INT_OFFICEID IN("+CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a " +
		 					"WHERE a.CHR_USRNAME='"+""+session.getAttribute("USRID")+"' ")[0][0]+" )");
		 	String officeids="";
		 	if(OfficeData.length>0)
		 	 	for(int u=0;u<OfficeData.length;u++)
		 	 		officeids=officeids+OfficeData[u][0]+",";
		 	
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' ";
			if(!"0".equals(Office))
				sql=sql+" AND  INT_OFFICEID = "+Office;
			else
    			sql = sql + " AND INT_OFFICEID IN ("+officeids+"0 )";
    		

			
			
			if(!"0".equals(dept))
				sql=sql+" AND  INT_DEPARTID = "+dept;
			sql=sql+"  ORDER BY CHR_STAFFNAME ";
			System.out.println("Duplicate Query "+sql);
			String Empdata[][] =QueryExecute(sql);
			for(int u=0;u<Empdata.length;u++)
			{	
				sql = "SELECT count(*) from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
				String data1[][] = RecordSetArray(co, sql);
				int l = Integer.parseInt(data1[0][0]);
				sql = "SELECT INT_RNO,CHR_EMPID from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
				String data2[][] = RecordSetArray(co, sql);
				if(l>1)
				{
					String rollnumber = data2[0][0];
					sql ="DELETE FROM att_t_register WHERE  CHR_EMPID='"+data2[0][1]+"' AND INT_RNO!="+rollnumber+" AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
					Statement st = co.createStatement();
					st.execute(sql);
					st.close();
				}
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	 
	
	
	//Attendance Register monthly created for mainscreen
	@SuppressWarnings("deprecation")
	public static synchronized void AttendanceGenerate(Connection co ) 
	{
		try {
				
				Statement st = co.createStatement();
				String sql = "SELECT COUNT(*) from com_m_staff WHERE CHR_TYPE!='T' ";
				String data[][] =RecordSetArray(co, sql);
				sql = "SELECT COUNT(*) FROM att_t_register a , com_m_staff b WHERE a.CHR_MONTH =monthname(now()) AND a.INT_YEAR=year(now()) AND b.CHR_EMPID=a.CHR_EMPID AND b.CHR_TYPE!='T'";
				String data1[][] =RecordSetArray(co, sql);
				int d1 = Integer.parseInt(data[0][0]);
				int d2 = Integer.parseInt(data1[0][0]);
				java.util.Date d = new java.util.Date();
				int month=(d.getMonth()+1);
				int year=(d.getYear()+1900);
				if(d1 != d2)
				{
					String field ="";
					for(int u=1;u<32;u++)
					{
						sql = "SELECT DAYNAME('"+year+"-"+month+"-"+u+"'); ";
						String sunday[][] =RecordSetArray(co, sql);
						if("Sunday".equals(sunday[0][0]))
						{
							field = field+"CHR_MORNING"+u+", CHR_EVENING"+u+" , ";
						}
					}
					sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
					String Empdata[][] =RecordSetArray(co, sql);
					for(int u=0;u<Empdata.length;u++)
					{
						if(!RecordExist(co, "SELECT count(*) from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())"))
						{		
							sql = "INSERT INTO att_t_register(CHR_EMPID,CHR_MONTH,INT_YEAR) VALUES ('"+Empdata[u][0].trim()+"', monthname(now()),year(now()))";
							st.execute(sql);
							String sundata[] = field.split(",");
							sql = "UPDATE att_t_register SET ";
							for(int c=0;c<sundata.length-1;c++)
							   if((!"".equals(sundata[c]))||(!"null".equals(sundata[c])))	
								   sql = sql + " " +sundata[c]+" = 'SUN' , ";
							sql = sql.trim();
							sql = sql.substring(0,sql.length()-1);
							sql = sql +" WHERE CHR_EMPID='"+Empdata[u][0]+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
							st.execute(sql);
						}	
					}
				}
				
		
			} catch (Exception e) 
			{
			}
		
		}

	
	
	// attendance register created for cycle 21 to 20
	@SuppressWarnings("deprecation")
	public static void AttendanceGenerateCycle2() 
	{
		try 
		{
				Connection co=null;	
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
				String sql = "SELECT COUNT(*) from com_m_staff WHERE CHR_TYPE!='T' ";
				String data[][] =RecordSetArray(co, sql);
				sql = "SELECT COUNT(*) FROM att_t_register a , com_m_staff b WHERE a.CHR_MONTH =monthname(now()) AND a.INT_YEAR=year(now()) AND b.CHR_EMPID=a.CHR_EMPID AND b.CHR_TYPE!='T'";
				String data1[][] =RecordSetArray(co, sql);
				int d1 = Integer.parseInt(data[0][0]);
				int d2 = Integer.parseInt(data1[0][0]);
				java.util.Date d = new java.util.Date();
				int month=(d.getMonth()+1);
				int year=(d.getYear()+1900);
				if(d1 != d2)
				{
					String field ="";
					for(int u=1;u<32;u++)
					{
						sql = "SELECT DAYNAME('"+year+"-"+month+"-"+u+"'); ";
						String sunday[][] =RecordSetArray(co, sql);
						if("Sunday".equals(sunday[0][0]))
						{
							field = field+"CHR_MORNING"+u+", CHR_EVENING"+u+" , ";
						}
					}
					sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
					String Empdata[][] =RecordSetArray(co, sql);
					for(int u=0;u<Empdata.length;u++)
					{
						if(!RecordExist(co, "SELECT count(*) from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())"))
						{		
							sql = "INSERT INTO att_t_register(CHR_EMPID,CHR_MONTH,INT_YEAR) VALUES ('"+Empdata[u][0].trim()+"', monthname(now()),year(now()))";
							st.execute(sql);
							String sundata[] = field.split(",");
							sql = "UPDATE att_t_register SET ";
							for(int c=0;c<sundata.length-1;c++)
							   if((!"".equals(sundata[c]))||(!"null".equals(sundata[c])))	
								   sql = sql + " " +sundata[c]+" = 'SUN' , ";
							sql = sql.trim();
							sql = sql.substring(0,sql.length()-1);
							sql = sql +" WHERE CHR_EMPID='"+Empdata[u][0]+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
							st.execute(sql);
						}	
					}
				}
				st.close();
 
		
			} catch (Exception e) 
			{
				 
			}
		}

	
	public static void Attendance(String office , String dept,String month, String year ) 
	{
		try 
		{
				office = "4";
				dept = "4";
				month = "11";
				year="2007";
				
				
	/*			Statement st = co.createStatement();
				String sql = "SELECT COUNT(*) from com_m_staff WHERE CHR_TYPE!='T' ";
				String data[][] =RecordSetArray(co, sql);
				sql = "SELECT COUNT(*) FROM att_t_register a , com_m_staff b WHERE a.CHR_MONTH =monthname(now()) AND a.INT_YEAR=year(now()) AND b.CHR_EMPID=a.CHR_EMPID AND b.CHR_TYPE!='T'";
				String data1[][] =RecordSetArray(co, sql);
				int d1 = Integer.parseInt(data[0][0]);
				int d2 = Integer.parseInt(data1[0][0]);
				java.util.Date d = new java.util.Date();
				int month=(d.getMonth()+1);
				int year=(d.getYear()+1900);
				if(d1 != d2)
				{
					String field ="";
					for(int u=1;u<32;u++)
					{
						sql = "SELECT DAYNAME('"+year+"-"+month+"-"+u+"'); ";
						String sunday[][] =RecordSetArray(co, sql);
						if("Sunday".equals(sunday[0][0]))
						{
							field = field+"CHR_MORNING"+u+", CHR_EVENING"+u+" , ";
						}
					}
					 
					sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
					String Empdata[][] =RecordSetArray(co, sql);
					for(int u=0;u<Empdata.length;u++)
					{
						if(!RecordExist(co, "SELECT count(*) from att_t_register WHERE CHR_EMPID='"+Empdata[u][0]+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())"))
						{		
							sql = "INSERT INTO att_t_register(CHR_EMPID,CHR_MONTH,INT_YEAR) VALUES ('"+Empdata[u][0]+"', monthname(now()),year(now()))";
							st.execute(sql);
							String sundata[] = field.split(",");
							sql = "UPDATE att_t_register SET ";
							for(int c=0;c<sundata.length-1;c++)
							   if((!"".equals(sundata[c]))||(!"null".equals(sundata[c])))	
								   sql = sql + " " +sundata[c]+" = 'SUN' , ";
							sql = sql.trim();
							sql = sql.substring(0,sql.length()-1);
							sql = sql +" WHERE CHR_EMPID='"+Empdata[u][0]+"' AND CHR_MONTH =monthname(now()) AND INT_YEAR=year(now())";
							st.execute(sql);
						}	
					}
				}
*/				
		
			} catch (Exception e) 
			{
			}
		
		}

	
	public static boolean ArrayEquals(String a[] , String b[]) 
	{
		boolean flag = false;
		try 
		{
			String s="";
			if(a.length == b.length)
			{	
				for(int u=0;u<a.length;u++)
				{
					if(a[u].equals(b[u]))
						s = s+"true"+",";
					else
						s = s+"false"+",";
				}
				if(s.indexOf("false") <0)
					flag =true;
				else
					flag = false;
			}
			else
				//System.out.println("Invalid Array Size...");
			return flag;
		} 
		catch (Exception e)
		{
		}
		 
		return flag;
	}

	
	//Remove Array Duplicate values String arguments in format of string  asdd,asd,ads,asd,dasdasd 
	public static String  ArrayDuplicate(String string) 
	{
		@SuppressWarnings("unused")
		String  hs  = "";
		try 
		{
			String s = string;
			String array1[] = s.split(",");
			String array2[] = s.split(",");
			int arraylength = array1.length-1;
			int count=0;
			for(int u=0; u<arraylength; u++)
			{
				count=0;
				for(int v=0; v<arraylength; v++)
				{
					if(array2[u] == array1[v])
						count = count +1;
					if(count > 1)
						array1[v]="";
				}
			}
			String  hs2="";
			for(int v=0; v<arraylength; v++)
				if(array1[v]!="")
					hs2 = hs2 +	array1[v]+",";
			return hs2;
		 
				
		} 
		catch (Exception e)
		{
			 
		}
		 
		return "";
	}

	

	
	
	
	
	
	public static String displayWord(String number) 
	{
		String stringValue = "";
		try 
		{
			int num; 
		    int nextdigit; 
		    int numdigits; 
		    int[] n = new int[20]; 
		    String [] digits = { "zero", "one", "two","three", "four", "five", "six", "seven", "eight","nine" }; 
		    num = Integer.parseInt(number); 
		    nextdigit = 0; 
		    numdigits = 0; 
		    do 
		    { 
		      nextdigit = num % 10; 
		      n[numdigits] = nextdigit; 
		      numdigits++; 
		      num = num / 10; 
		    } while(num > 0); 
		    numdigits--; 
		    for( ; numdigits >= 0; numdigits--) 
		    	stringValue=stringValue+(digits[n[numdigits]] + "  ");
		    
		 return stringValue;
		}
		catch (Exception e) 
		{
			 
		}
		return stringValue;
	}
	
	
	
	
	
	public static int intGetAnySelectField(Connection co,String sql, String selectfield) {
			int stringValue = 0;
			try {

				
				Statement st = co.createStatement();
				ResultSet rs;
				rs = st.executeQuery(sql);
				if (rs.next())
					stringValue = Integer.parseInt(rs.getString(selectfield).trim());
				return stringValue;
			} catch (Exception e) {
				 
			}
			return stringValue;
		}

	
	public static int intGetColumnCount(Connection co,String sql) {
			int stringValue = 0;
			try {
				 
				Statement st = co.createStatement();
				
				ResultSet rs;
				rs = st.executeQuery(sql);
				ResultSetMetaData rsmd = rs.getMetaData();
				if (rs.next())
					stringValue=rsmd.getColumnCount();
				return stringValue;
			} catch (Exception e) {
				 
				 
			}
			return stringValue;
		}

	public static String[][] getTableAllValuesArray(Connection co,String sql) 
	{
	 		 
	 		try {

	 			Statement st = co.createStatement();
	 			ResultSet rs;
	 			rs = st.executeQuery(sql);
	 			ResultSetMetaData rsmd = rs.getMetaData();
	 			int colcount = rsmd.getColumnCount();
	 			int rowcount =0;
	 			while(rs.next())
	 				rowcount = rowcount +1;
	 			String svalue[][] = new String[rowcount][colcount];
	 			rs = st.executeQuery(sql);
	 			int i=0;
	 			while(rs.next())
	 			{	
	 				for(int u=0; u<rsmd.getColumnCount();u++)
	 				{
	 					svalue[i][u] = ""+rs.getString((u+1));
	 					if(svalue[i][u].equals("null")) svalue[i][u]="";
	 				}
	 				i= i+1;
	 				
	 			}		
	 			 
	 			return svalue;
	 		} catch (Exception e) {
	 			 
	 			 
	 		}
	 		return null;
	 	}

	
	
	
	public static double[][] DoubleRecordSetArray(String sql) 
	 {
	 		 
		 	try 
		 	{

		 		Connection co=null;	
				DBCon con = new DBCon();
				co = con.getConnection();
				Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		double svalue[][] = new double[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = rs.getInt((u+1));
		 					 
		 			}
		 			i=i+1;
		 				
		 		}		
		 		 
		 		return svalue;
		 		}
		 	catch (Exception e) 
		 	{
		 		String s=""+e.getMessage();
		 		 System.out.println(s);
		 			 
		 	}
		 	return null;
		 }
	 
	
	
	public static String[][] RecordSetArray(Connection co,String sql) 
	 {
	 		 
		 	try 
		 	{

		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="-";
		 			}
		 			i=i+1;
		 				
		 		}		
		 		rs.close();
		 		 
		 		return svalue;
		 		}
		 	catch (Exception e) 
		 	{
		 		String s=""+e.getMessage();
		 		 System.out.println(s);
		 			 
		 	}
		 	return null;
		 }
	 
	
	public static String[][] emptyRecordSetArray(Connection co,String sql) 
	 {
	 		 
		 	try 
		 	{

		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="";
		 			}
		 			i=i+1;
		 				
		 		}		
		 		 
		 		return svalue;
		 		}
		 	catch (Exception e) 
		 	{
		 		String s=""+e.getMessage();
		 		 System.out.println(s);
		 			 
		 	}
		 	return null;
		 }
	 
	
	public static String[][] KRecordSetArray(Connection co,String sql) 
	 {
	 		 
		 	try 
		 	{
		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="-";
		 			}
		 			
		 			i=i+1;
		 				
		 		}		
		 		 
		 		return svalue;
		 		}
		 	catch (Exception e) 
		 	{
		 		 
		 			 
		 	}
		 	return null;
		 }
	 
	public static String[][] doubleRecordSetArray(Connection co,String sql) 
	 {
	 		 
		 	try 
		 	{

		 		Statement st = co.createStatement();
		 		ResultSet rs;
		 		rs = st.executeQuery(sql);
		 		ResultSetMetaData rsmd = rs.getMetaData();
		 		int colcount = rsmd.getColumnCount();
		 		int rowcount =0;
		 		while(rs.next())
		 			rowcount = rowcount +1;
		 		String svalue[][] = new String[rowcount][colcount];
		 		rs = st.executeQuery(sql);
		 		int i=0;
		 		while(rs.next())
		 		{	
		 			for(int u=0; u<rsmd.getColumnCount();u++)
		 			{
		 					svalue[i][u] = ""+rs.getString((u+1));
		 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="0.0";
		 			}
		 			i= i+1;
		 				
		 		} 		 
		 		return svalue;
		 		}
		 	catch (SQLException e) 
		 	{
		 		 
		 			 
		 	}
		 	return null;
		 }

	public static String[][] intRecordSetArray(Connection co,String sql) 
	{
		 
	 	try 
	 	{

	 		Statement st = co.createStatement();
	 		ResultSet rs;
	 		rs = st.executeQuery(sql);
	 		ResultSetMetaData rsmd = rs.getMetaData();
	 		int colcount = rsmd.getColumnCount();
	 		int rowcount =0;
	 		while(rs.next())
	 			rowcount = rowcount +1;
	 		String svalue[][] = new String[rowcount][colcount];
	 		rs = st.executeQuery(sql);
	 		int i=0;
	 		while(rs.next())
	 		{	
	 			for(int u=0; u<rsmd.getColumnCount();u++)
	 			{
	 					svalue[i][u] = ""+rs.getString((u+1));
	 					if(svalue[i][u].equals("null") || svalue[i][u].equals(""))svalue[i][u]="0";
	 			}
	 			i= i+1;
	 				
	 		} 		
	 		
	 		 
	 		return svalue;
	 		}
	 	catch (Exception e) 
	 	{
	 		 
	 			 
	 	}
	 	return null;
	 }

	public static int intRecordCount(Connection con,String sql) 
	{
		int rcount = 0;
		try 
		{
				Statement st = con.createStatement();
				ResultSet rs;
				rs = st.executeQuery(sql);
				rcount =0;
				if(rs.next())
					rcount = rs.getInt(1);
				return rcount;
		} 
		catch (Exception e) {
			 
		}
			return rcount;
	}

 
	
	public static void ChangeRootPassword(Connection conn,String password) 
	{
		try 
		{
		     String sql = "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('"+password+"')";
             Statement stmt = conn.createStatement();
             stmt.executeQuery(sql);
             stmt.close();
             conn.close();
    	} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
		}
			 
	}
	
	public static String[] sortArray(String getArray[],int arraylength) 
	{
 		 
 		try 
 		{
 			String svalue[] = new String[arraylength];
 			int alength =svalue.length;
 			svalue = getArray;
 			String temp="";
			for(int i=0; i<alength-1;i++)
			{
				for(int j=i+1; j<alength; j++)
				{
					if(svalue[i].compareToIgnoreCase(svalue[j])>1)
					{	
					  temp = svalue[i];
					  svalue[i]=svalue[j];
					  svalue[j]=temp;
					} 
				}
			}
 			 
 			return svalue;
 			
 		} 
 		catch (Exception e) 
 		{
 			 
 		}
 		return null;
 	}

	public static String stringSortArray(String getArray[],int arraylength) 
	{
 		String stringValue ;
 		try 
 		{
 			String svalue[] = new String[arraylength];
 			int alength =svalue.length;
 			svalue = getArray;
 			String temp="";
			for(int i=0; i<alength-1;i++)
			{
				for(int j=i+1; j<alength; j++)
				{
					if(svalue[i].compareToIgnoreCase(svalue[j])>1)
					{	
					  temp = svalue[i];
					  svalue[i]=svalue[j];
					  svalue[j]=temp;
					} 
				}
			}
			temp="";
			for(int u=0; u<alength; u++)
				temp=temp+svalue[u]+","; 
 			
			stringValue = temp;
 			return stringValue;
 		} 
 		catch (Exception e) 
 		{
 			 
 		}
 		return null;
 	}

	 
	//return package name
	public static String getPackageName(String pack)
	{
 		 
 		try 
 		{
 			String str = pack.substring(0, 3);
 			String packName = null;
 			String sql="SELECT CHR_SHORTNAME,CHR_PACKAGE FROM  m_projectmodule";
			sql = sql+" WHERE CHR_SHORTNAME='"+str+"' ORDER BY CHR_MODULE";
			 
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			for(int u=0;u<data.length;u++)
				if(str.equalsIgnoreCase(data[u][0]))
					packName = data[u][1];

 		 
 			return packName;
 			
 		 
 		} 
 		catch (Exception e) 
 		{
 			 
 		}
 		return null;
 	}
	 
	
	
	
	
	public static StringBuffer ReportWrite(Connection co,String sql,int columncount)throws IOException 
	{
		 
		try 
		{
			String readData[][] = RecordSetArray(co,sql);
			StringBuffer sb = new StringBuffer();
			if (readData.length > 0)
	 		{	
				sb.append("<Fields>");
				for(int u=0; u<readData.length;u++)
	 			{
	 				sb.append("<Field>");
	 				for(int x=1; x<columncount; x++)
	 					sb.append("<Field"+x+">" +readData[u][x] +"</Field"+x+">");
	 				sb.append("</Field>");	
	 	 		}	
				sb.append("</Fields>");
				
	 		} 
			return sb;		
		}
		catch(Exception e)
		{
			 
		}
		return null;
	}
	
	public static  void fileCopy(File src, File dst) throws IOException 
	{
        InputStream in = new FileInputStream(src);
        OutputStream out = new FileOutputStream(dst);
        byte[] buf = new byte[1024];
        int len;
        while ((len = in.read(buf)) > 0) 
        {
            out.write(buf, 0, len);
        }
        in.close();
        out.close();
    }

	public static byte[] getBytesFromFile(File file) throws IOException 
	{
        InputStream is = new FileInputStream(file);
        long length = file.length();
        byte[] bytes = new byte[(int)length];
        int offset = 0;
        int numRead = 0;
        
        while (offset < bytes.length
               && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) {
            offset += numRead;
        }
        
        if (offset < bytes.length) 
        {
            throw new IOException("Could not completely read file "+file.getName());
        }
        is.close();
        return bytes;
    }

	public static void SQLOutFile(Connection con,String filename,String tablename) 
	{
		try 
		{
	        Statement stmt = con.createStatement();
	        stmt.executeUpdate("SELECT * INTO OUTFILE \"" + filename + "\" FROM " + tablename);
	    } 
		catch (Exception e) 
		{
			 
		}
	}

	public static void ReportWrite(String string, StringBuffer sb) 
	{
		try 
		{
			FileWriter fw = new FileWriter(string);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sb.toString());
			bw.close();
		} 
		catch (Exception e) 
		{
			//System.out.println(""+e.getMessage());
		}
		
	}

	public static void DirectWrite(String Path, String sql) 
	{
		try 
		{
			String string = sql;
			String fileName =Path+"dlog.txt";
			java.io.FileReader fr = new java.io.FileReader(fileName);
			@SuppressWarnings("unused")
			java.io.BufferedReader br = new java.io.BufferedReader(fr);
			@SuppressWarnings("unused")
			String strfline ="";
			String sline="";	
			sline = sline+string;
			FileWriter fw = new FileWriter(fileName);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sline);
			bw.close();
			fw.close();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		
	}

	public static boolean PackageExpired(String  validateDate,String path) 
	{
		boolean flag = false;
		try 
		{
			
		   
			String sql="select (now()<='"+validateDate+"')";
			String data[][] =  CommonFunctions.QueryExecute(sql);
			int i= Integer.parseInt(data[0][0]);
			if(i==1)
				return true;
			else
			{
				FileFunctions.deleteDir(new File(path+"Utility Software"));
				return false;
			}
				
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		return flag;
	} 
	
	public static boolean AttendanceProcess(String date) 
	{
		boolean flag = false;
		try 
		{
			String sql="SELECT (DATEDIFF(now(),'"+date+"')) ";
			String data[][] = CommonFunctions.QueryExecute(sql);
			int i= Integer.parseInt(data[0][0]);
			int daylimit = Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_ATTENDANCEPROCESS FROM att_m_basicsettings WHERE INT_ID=1")[0][0]);
			if((i<=daylimit )&& (i>=0))
				return true;
			else
				return false;
			
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		return flag;
	} 
	
	@SuppressWarnings("deprecation")
	public static void ErrorWrite( String sql) 
	{
		try 
		{
			String string = sql;
			String fileName ="../webapps/SmartCampus/log.txt";
			java.io.FileReader fr = new java.io.FileReader(fileName);
			java.io.BufferedReader br = new java.io.BufferedReader(fr);
			String strfline ="";
			String sline="";	
			 
			while((strfline=br.readLine())!= null )	
			{
				sline=sline +strfline+"\n";
			}
			 
			br.close();
			fr.close();
			
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			//java.net.InetAddress ip= new java.net.InetAddress();
			
			String time = date.getHours()+":"+date.getMinutes() +":" +date.getSeconds();
			sline = sline+"\nLogin :: DATE :: "+updatedate +"  TIME :: "+time+"    \n";
			//" -  Time :: "+time+"\n";
			sline = sline+string;
			sline = sline+"\nLogout :: \n----------------------------------------------------";
			FileWriter fw = new FileWriter(fileName);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sline);
			bw.close();
			fw.close();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}
	@SuppressWarnings("deprecation")
	public static void ControlWrite( String string) 
	{
		try 
		{
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("dd-MM-yyyy");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			String fileName ="../webapps/SmartCampus/logs/"+updatedate+".txt";
			java.io.FileReader fr = new java.io.FileReader(fileName);
			java.io.BufferedReader br = new java.io.BufferedReader(fr);
			String strfline ="";
			String sline="";	
			
			while((strfline=br.readLine())!= null )	
			{
				sline=sline +strfline+"\n";
			}
			
			br.close();
			fr.close();
			String time = date.getHours()+":"+date.getMinutes() +":" +date.getSeconds();
			sline = sline+"DATE :: "+updatedate +"  TIME :: "+time+"";
			sline = sline+string;
			sline = sline+"\n";
			FileWriter fw = new FileWriter(fileName);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(sline);
			bw.close();
			fw.close();
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
		
	}
	
	
	 
	 //send("hostname", 25, "joe@smith.com", "sue@smith.com","re: dinner", "How about at 7?");
    public static void send(String smtpHost, int smtpPort,
                                String from, String to,
                                String subject, String content)
                throws AddressException, MessagingException 
    {
        java.util.Properties props = new java.util.Properties();
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", ""+smtpPort);
        Session session = Session.getDefaultInstance(props, null);

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(from));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        msg.setSubject(subject);
        msg.setText(content);
        Transport.send(msg);
    } 
   
     

	public static String numberWord(String num) 
	{
 		String tmp = "";
		try 
		{
			String beforeadd="";
			for(int i=0;i<(10-num.length());i++)
				beforeadd=beforeadd+"0";
			num = beforeadd+num;
			int crore = Integer.parseInt(num.substring(0,3));
			int lakh = Integer.parseInt(num.substring(3,5));
			int thousand = Integer.parseInt(num.substring(5,7));
			int base = Integer.parseInt(num.substring(7,10));
			String s="Rupees. ";
			if(crore >=1)
			  s = s+numberWords(crore)+" Crore "; 
			if(lakh >=1)
			  s = s+numberWords(lakh)+" Lakhs "; 
			if(thousand >=1)
			  s = s+numberWords(thousand)+" Thousands "; 
			if(base >=1)
			  s = s+numberWords(base) ;
			s= s+" Only";  
			s = "( "+s+ ")";  
			tmp = s;
			return tmp;
 		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		return tmp;
	}
		
	 	
	public static String numberWords(int num) 
	{
 		String tmp = "";
		try 
		{
			String numArray[] =  {"","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"};
			String tensArray[] = {"","Ten","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"};
			String teensArray[] = {"Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen"};
			int hundreds = num/100;
			int tens = (num-(hundreds * 100))/10;
			int ones = num - ((hundreds*100) + (tens*10));
			if (num==0) return "zero";
			else if (hundreds >= 1)
			{
				if(tens == 1)
				{
					tmp = numArray[hundreds] + " Hundred " + teensArray[ones];
				}
		    	else tmp = numArray[hundreds] + " Hundred " + tensArray[tens] +' '+ numArray[ones];
			}
			else if (tens >= 1) 
			{
				if(tens == 1)
				{
					tmp = teensArray[ones];
				}
				else tmp = tensArray[tens] +' '+ numArray[ones];
			}
			else tmp = numArray[ones];
			return tmp;
 		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		return tmp;
	}

	
	
	public static String companyName(String Branchid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME FROM com_m_branch a,com_m_company b WHERE a.INT_BRANCHID="+Branchid+" AND b.INT_COMPANYID= a.INT_COMPANYID";
			String data[][] =RecordSetArray(co,sql);
			String s="";
			if(data.length>0)
				s = data[0][0]+" @ "+data[0][1];
 
			return s;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return null;
	 }
	
	
	
	public static String employeeName(String empid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql = "SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"'";
			String data[][] =RecordSetArray(co,sql);
			String s="";
			if(data.length>0)
				s = data[0][0];
 
			return s;
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	
	
	
	public static void FinancialYear()
	 {
		try 
	 	{
			String sql = " ";
			sql =" SELECT date(now()), month(now()),monthname(now()),year(now()) "; 
			String data[][] = QueryExecute(sql);
			int starting=0;
			int ending=0;
			String financialyear="";
			String startingdate="";
			String endingdate="";
			int dbmonth=Integer.parseInt(data[0][1]);
			int dbyear=Integer.parseInt(data[0][3]);
			if(dbmonth>=4)
			{
				starting = dbyear;
				ending=dbyear+1;
				startingdate= dbyear+"-04-01";
				endingdate= (dbyear+1)+"-03-31";
			}
			else
			{
				starting = dbyear-1;
				ending=dbyear;
				startingdate= (dbyear-1)+"-04-01";
				endingdate= dbyear+"-03-31";
			}	
			financialyear=starting+"-"+ending;
			sql ="SELECT COUNT(*)  FROM com_m_financialyear WHERE CHR_FINANCIALYEAR='"+financialyear+"'";
			if(! CommonFunction.RecordExist(sql))
			{
				sql ="INSERT INTO com_m_financialyear(CHR_FINANCIALYEAR,DAT_STARTINGDATE,DAT_ENDINGDATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)";
				
				sql = sql +" VALUES ('"+financialyear+"','"+startingdate+"','"+endingdate+"','ADMIN',now(),'Y')";
			 
				 Execute(sql);
			}
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	
	 }

	
	
	public static String  CurrentFinancialYear()
	 {
		String currentyear="";
		try 
	 	{
			String sql = "";
			sql =" SELECT date(now()), month(now()),monthname(now()),year(now())"; 
			String data[][] = QueryExecute(sql);
			int starting=0;
			int ending=0;
			int dbmonth=Integer.parseInt(data[0][1]);
			int dbyear=Integer.parseInt(data[0][3]);
			if(dbmonth>=4)
			{
				starting = dbyear;
				ending=dbyear+1;
			}
			else
			{
				starting = dbyear-1;
				ending=dbyear;
				
			}	
			currentyear=starting+"-"+ending;
			return currentyear;
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	return null;
	 }

	public static String  differenceBetweenTwoDateandTime (String dt1, String dt2)
	 {
		String difference="";
		try 
	 	{
			String sql = "";
			@SuppressWarnings("unused")
			String sdate[]= dt1.split(" ");
			String edate[]= dt2.split(" ");
			
			sql =" SELECT datediff('"+DateUtil.FormateDateSQL(edate[0])+"','"+DateUtil.FormateDateSQL(edate[0])+"')"; 
			@SuppressWarnings("unused")
			String data[][] = QueryExecute(sql);
			
			sql =" SELECT datediff('"+(edate[1])+"','"+(edate[2])+"')";
			return ""+difference;
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	return null;
	 }

	
	public static boolean FinancialyearCompletion(String fdate,String tdate)
	{
		boolean flag=false;
		try
		{
			boolean process=false;
			String sql = "select datediff('"+tdate+"','"+fdate+"')";
			int day = Integer.parseInt(QueryExecute(sql)[0][0]);
			if(day==365)
				process=true;
			
			if(process)
			{
				
			}
			return flag;
		}
		catch(Exception e)
		{
			e.getMessage();
	 		
		}
		return flag;
	}
	
	
	public static String dateandTimeDifference(String fromdate , String todate)
	{
		String value="";
		try
		{
			
			String sql="Select  ('"+todate+"' > '"+fromdate+"')";
			//ErrorWrite(sql);
			//ErrorWrite(""+Integer.parseInt(QueryExecute(sql)[0][0]));
			if(Integer.parseInt(QueryExecute(sql)[0][0])==1)
			{	
						
				String fdate[]=fromdate.split(" ")[0].split("-");
				String tdate[]=todate.split(" ")[0].split("-");
				String ftime[]=fromdate.split(" ")[1].split(":");
				String ttime[]=todate.split(" ")[1].split(":");
				int fyear=Integer.parseInt(fdate[0]);
				int fmonth=Integer.parseInt(fdate[1]);
				int fday=Integer.parseInt(fdate[2]);
				int fhour=Integer.parseInt(ftime[0]);
				int fminitue=Integer.parseInt(ftime[1]);
				int fsecond=Integer.parseInt(ftime[2]);
				
				int tyear=Integer.parseInt(fdate[0]);
				int tmonth=Integer.parseInt(tdate[1]);
				int tday=Integer.parseInt(tdate[2]);
				int thour=Integer.parseInt(ttime[0]);
				int tminitue=Integer.parseInt(ttime[1]);
				int tsecond=Integer.parseInt(ttime[2]);
				
				String ryear="";
				String rmonth="";
				String rday="";
				String rhour="";
				String rminute="";
				String rsecond="";
				
				//calculating Seconds
				if(fsecond>tsecond)
				{
					tminitue = tminitue-1;
					tsecond= tsecond+60;
					rsecond = ""+(tsecond-fsecond);
				}
				else
					rsecond = ""+(tsecond-fsecond);
				
				
				
				//Calculating minutes;
				if(fminitue>tminitue)
				{
					thour = thour-1;
					tminitue=tminitue+60;
					rminute=""+(tminitue-fminitue);
				}
				else
					rminute=""+(tminitue-fminitue);
				
				
				
				//calculating Hours
				if(fhour>thour)
				{
					String date= tyear+"-"+tmonth+"-"+tday;
					sql = "select DATE_SUB('"+date+"', INTERVAL 1 DAY)";
					String subdate[]= QueryExecute(sql)[0][0].split("-");
					tyear=Integer.parseInt(subdate[0]);
					tmonth=Integer.parseInt(subdate[1]);
					tday=Integer.parseInt(subdate[2]);
					thour= thour+24;
					rhour = ""+(thour-fhour);
					
				}
				else
					rhour =""+(thour-fhour);
				
				
				//day calculation
				if(fday>tday)
				{
					
					//pending here
					sql = "select day(LAST_DAY('"+tyear+"-"+(tmonth)+"-21'))";
					tday=tday+(Integer.parseInt(QueryExecute(sql)[0][0]));
					tmonth = tmonth-1;
					rday=""+(tday-fday);
				}
				else
					rday=""+(tday-fday);
				
				
				
				
				//calculating Month
				if(fmonth>tmonth)
				{
					tyear = tyear-1;
					tmonth = tmonth+12;
					rmonth=""+(tmonth-fmonth);
				}
				else
					rmonth=""+(tmonth-fmonth);
				
				
				
				//Calculating Year
				ryear = ""+(tyear-fyear);
				
				value = ryear+"-"+rmonth+"-"+rday+" "+rhour+":"+rminute+":"+rsecond;
				return value;
			}
			else
				return value;
			
			
		}
		catch(Exception e)
		{
			ErrorWrite(e.getMessage());
		}
		return null;
	}

	

	public static void LeaveCredit(String staffid,String doj) 
	 {
		try 
	 	{
			String leavesql="select  INT_ABOVEONEYEAR,INT_BELOWONEYEAR  from  att_m_leavetype order by INT_LEAVEID";
			String leavedata1[][] =QueryExecute(leavesql);
			double aboveoneyearleave1=Double.parseDouble(leavedata1[0][0]);
			double aboveoneyearleave2=Double.parseDouble(leavedata1[1][0]);
			double aboveoneyearleave3=Double.parseDouble(leavedata1[2][0]);
			double aboveoneyearleave4=Double.parseDouble(leavedata1[3][0]);
			double aboveoneyearleave5=Double.parseDouble(leavedata1[4][0]);
			double aboveoneyearleave6=Double.parseDouble(leavedata1[5][0]);
			double belowoneyearleave1=Double.parseDouble(leavedata1[0][1]);
			double belowoneyearleave2=Double.parseDouble(leavedata1[1][1]);
			double belowoneyearleave3=Double.parseDouble(leavedata1[2][1]);
			double belowoneyearleave4=Double.parseDouble(leavedata1[3][1]);
			double belowoneyearleave5=Double.parseDouble(leavedata1[4][1]);
			double belowoneyearleave6=Double.parseDouble(leavedata1[5][1]);
			String sql=" SELECT CHR_LEAVECREDIT  FROM m_institution WHERE INT_ID=1 ";
			String leavecredit[][] = QueryExecute(sql);
			if("Y".equals(leavecredit[0][0]))
			{	
				sql = "SELECT (datediff(now(),"+doj+")/365)>=1";
				String leavedata[][] = QueryExecute(sql);
				int above =Integer.parseInt(leavedata[0][0]);
				sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
				sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
				sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE";
				sql = sql +",CHR_LEAVE4,INT_NOD4,INT_NOD4BALANCE";
				sql = sql +",CHR_LEAVE5,INT_NOD5,INT_NOD5BALANCE";
				sql = sql +",CHR_LEAVE6,INT_NOD6,INT_NOD6BALANCE ) VALUES (";
				sql = sql +" '"+staffid+"', year(now()),";
				if(above>=1)
				{
					sql = sql +"'P',"+aboveoneyearleave1+",0,";
					sql = sql +"'C',"+aboveoneyearleave2+",0,";
					sql = sql +"'S',"+aboveoneyearleave3+",0,";
					sql = sql +"'M',"+aboveoneyearleave4+",0,";
					sql = sql +"'A',"+aboveoneyearleave5+",0,";
					sql = sql +"'O',"+aboveoneyearleave6+",0)";
				}
				else
				{
					sql = sql +"'P',"+belowoneyearleave1+",0,";
					sql = sql +"'C',"+belowoneyearleave2+",0,";
					sql = sql +"'S',"+belowoneyearleave3+",0,";
					sql = sql +"'M',"+belowoneyearleave4+",0,";
					sql = sql +"'A',"+belowoneyearleave5+",0,";
					sql = sql +"'O',"+belowoneyearleave6+",0)";
				}
				Execute(sql);
			}
		}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage()); 
	 	}
	 }
	
	

	public static String nameIntial(String Empid) 
	 {
		String initial="Mr.";
		try 
	 	{
			String data[][] =CommonFunctions.QueryExecute("SELECT CHR_GENDER, CHR_MARITALSTATUS FROM com_m_staff  WHERE CHR_EMPID='"+Empid+"'");
			if(data.length>0)
			{
				if(!"Male".equalsIgnoreCase(data[0][0].trim()))
					if("M".equalsIgnoreCase(data[0][1].trim()))
						initial ="Mrs.";
					else
						initial ="Miss.";
			}
			return initial;
	 	}
		catch(Exception e)
		{
		}
		return initial;
	 }
	
	
	
	public static String Appointmentyear(String joindate)
	{
		String id[]=joindate.split("-");
		int date=Integer.parseInt(id[0]);
		int month=Integer.parseInt(id[1]);
		int year=Integer.parseInt(id[2]);
		String jmonth=com.my.org.erp.ServiceLogin.DateUtil.getMonth(month);
		String fyear="";
		if(month==1||month==2||month==3)
			fyear=""+(year-1)+" - "+year;
		else 
			fyear=""+year+" - "+(year+1);
		
		String jdate=""+date+" "+jmonth+" "+year;
		String ret=fyear+"~"+jdate;
		return ret;
	}
	
	
	public static String ServerPath() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql="SELECT CHR_SERVERPATH  FROM m_institution WHERE INT_ID=1";
			String data[][] =RecordSetArray(co,sql);
 
			return data[0][0];
			  	
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }

	
	@SuppressWarnings("deprecation")
	public static String ServerPaths(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException
	{
	    String url = request.getRealPath("");
    	return url;
    }
	

	 
	
	public static String  TimeSlot(String stimein,String stimeout,String gracetimein,String gracetimeout,String ltimeout,String ltimein)
	{
		 
		try
		{
			String slot="0";
			String sql=" select (( select current_time() >='"+stimein+"' ) AND ( select current_time() <='"+gracetimein+"' )) ";
			String value = CommonFunctions.QueryExecute(sql)[0][0];
			if("1".equals(value))
				slot="1";
			sql=" select (( select current_time() >= '"+ltimein+"' ) AND ( select current_time() <= '"+ltimeout+"' )) ";
			value = CommonFunctions.QueryExecute(sql)[0][0];
			if("1".equals(value))
				slot="3";
			sql=" select (( select current_time() >= '"+gracetimeout+"' ) ) ";
			value = CommonFunctions.QueryExecute(sql)[0][0];
			if("1".equals(value))
				slot="5";
			return slot;
		}
		catch(Exception e)
		{
			 
		}
		return null;
	}
	
	
	public static void AttendanceMark(String empid, String MrnEve,String date, String month ,String year) 
	 {
		try 
	 	{
	 		String sql ="";
			if("M".equals(MrnEve))
				sql=	"  UPDATE att_t_register SET CHR_MORNING"+date+"='PRE' WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR= "+year;
			else
				sql=	"  UPDATE att_t_register SET CHR_EVENING"+date+"='PRE' WHERE CHR_EMPID='"+empid+"' AND CHR_MONTH='"+month+"' AND INT_YEAR= "+year;
			CommonFunctions.Execute(sql);
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	
	 }
	
	public static void CommonHolidayAttendanceMark() 
	 {
		try 
	 	{
	 		String sql ="";
	 		sql=" SELECT b.CHR_EMPID FROM att_t_register a , com_m_staff b WHERE a.CHR_MONTH =monthname(now()) AND b.CHR_TYPE!='T' AND a.INT_YEAR= year(now()) AND b.CHR_EMPID=a.CHR_EMPID ";
	 		String value[][] = CommonFunctions.QueryExecute(sql);
	 		sql ="SELECT day(DT_HOLIDATE) FROM att_t_commonholiday  WHERE month(DT_HOLIDATE)=month(now()) AND year(DT_HOLIDATE) = year(now())";
	 		String day[][] = CommonFunctions.QueryExecute(sql);
	 		for(int u=0;u<day.length;u++)
	 			for(int v=0;v<value.length;v++)
	 				CommonFunctions.Execute("  UPDATE att_t_register SET CHR_MORNING"+day[u]+"='PRE' , CHR_EVENING"+day[u]+"='PRE' WHERE CHR_EMPID='"+value[v][0]+"' AND CHR_MONTH=monthname(now()) AND INT_YEAR=year(now()) ");
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 }

	 
	public static String  returnRootMenuid(String sql)
	{
		String s="";
		try
		{
			s=""; 
			String data[][]  = CommonFunctions.QueryExecute(sql);
			if(data.length>0)
				for(int u=0;u<data.length;u++)
					s= s+data[u][0]+",";
			s = s.substring(0,s.length()-1);
			return s;
		}
		catch(Exception e)
		{
			 
		}
		return null;
	}

public static String  getDaysBetweenDateinSQLformat(String fromdate, String todate) 
{
	String s="";
	try 
	{
		 
		String sql="";
		int Noofday=0;
		sql = " SELECT DATEDIFF('"+todate+"','"+fromdate+"')";
		String datas[][] =QueryExecute(sql);
		Noofday = Integer.parseInt(datas[0][0]);
		sql=" SELECT DATE_FORMAT('"+fromdate+"','%Y-%m-%d'),";
		for(int u=1;u<=Noofday;u++)
			sql = sql+"	DATE_FORMAT(DATE_ADD('"+fromdate+"', INTERVAL "+u+" DAY),'%Y-%m-%d'),";
		sql=sql.trim();
		sql=sql+" DATE_FORMAT('"+todate+"','%Y-%m-%d'),";
		sql = sql.substring(0,sql.length()-1);
		String data[][] =QueryExecute(sql);
		s="";
		for(int u=0;u<=Noofday;u++)
			s=s+data[0][u].trim()+",";
		s=s.trim();
		s = s.substring(0,s.length()-1);
		return s;
	}
	catch (Exception e) 
	{
		  System.out.println(e.getMessage());
	}
	return null;
}



public static String getMonthShortName(int mon)
{
    String month = "";
    switch(mon)
    {
    case 1: // '\001'
        month = "JAN";
        break;
         
    case 2: // '\002'
        month = "FEB";
        break;

    case 3: // '\003'
        month = "MAR";
        break;

    case 4: // '\004'
        month = "APR";
        break;

    case 5: // '\005'
        month = "MAY";
        break;

    case 6: // '\006'
        month = "JUN";
        break;

    case 7: // '\007'
        month = "JUL";
        break;

    case 8: // '\b'
        month = "AUG";
        break;

    case 9: // '\t'
        month = "SEP";
        break;

    case 10: // '\n'
        month = "OCT";
        break;

    case 11: // '\013'
        month = "NOV";
        break;

    case 12: // '\f'
        month = "DEC";
        break;
    }
    return month;
}


public static void ErrorWrite(String Path, String sql) 
{
	try 
	{
		String fileName =Path+"log.txt";
		java.io.FileReader fr = new java.io.FileReader(fileName);
		java.io.BufferedReader br = new java.io.BufferedReader(fr);
		String strfline ="";
		String sline="";	
		
		while((strfline=br.readLine())!= null )	
		{
			sline=sline +strfline+"\n";
		}
		
		br.close();
		fr.close();
		
		 	
	 	sline = sline+sql;
		FileWriter fw = new FileWriter(fileName);
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(sline);
		bw.close();
		fw.close();
	} 
	catch (Exception e) 
	{
		 System.out.println(e.getMessage());
	}
}


public static String getMonthName(int mon)
{
    String month = "";
    switch(mon)
    {
    case 1: // '\001'
        month = "January";
        break;

    case 2: // '\002'
        month = "February";
        break;

    case 3: // '\003'
        month = "March";
        break;

    case 4: // '\004'
        month = "April";
        break;

    case 5: // '\005'
        month = "May";
        break;

    case 6: // '\006'
        month = "June";
        break;

    case 7: // '\007'
        month = "July";
        break;

    case 8: // '\b'
        month = "August";
        break;

    case 9: // '\t'
        month = "September";
        break;

    case 10: // '\n'
        month = "October";
        break;

    case 11: // '\013'
        month = "November";
        break;

    case 12: // '\f'
        month = "December";
        break;
    }
    return month;
}




public static void insertCareerProfile(String filename,String empid) 
{
		try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql="UPDATE com_m_careers SET IMG_PROFILE=? WHERE INT_CAREERID=?";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,empid);
		pstm.execute();
		pstm.close();
 	
		if(f.exists())
			f.deleteOnExit();
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}


public static String getUrl(HttpServletRequest req) 
{
    String scheme = req.getScheme();             // http
    String serverName = req.getServerName();     // hostname.com
    int serverPort = req.getServerPort();        // 80
    String contextPath = req.getContextPath();   // /mywebapp
    String servletPath = req.getServletPath();   // /servlet/MyServlet
    String pathInfo = req.getPathInfo();         // /a/b;c=123
    String queryString = req.getQueryString();          // d=789
    // Reconstruct original requesting URL
    String url = scheme+"://"+serverName+":"+serverPort+contextPath+servletPath;
    if (pathInfo != null) {
        url += pathInfo;
    }
    if (queryString != null) {
        url += "?"+queryString;
    }
    return url;
}


public static String getPath(HttpServletRequest req) 
{
    String scheme = req.getScheme();             // http
    String serverName = req.getServerName();     // hostname.com
    int serverPort = req.getServerPort();        // 80
    String contextPath = req.getContextPath();   // /mywebapp
    //String servletPath = req.getServletPath();   // /servlet/MyServlet
    //String pathInfo = req.getPathInfo();         // /a/b;c=123
    // queryString = req.getQueryString();          // d=789
    // Reconstruct original requesting URL
    String url = scheme+"://"+serverName+":"+serverPort+contextPath;
     
    return url;
}


public static void runDynamicJavaCode(String filename[], String content) 
{
	try
	{
		//String[] s = filename;
		//(new com.sun.tools.javac.Main()).compile(s);
		 
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
	}
}



public static void insertStaffImage(String filename,String empid) 
{
		try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql=" INSERT INTO com_m_staffaddressproof (IMG_IMAGE, CHR_EMPID ) VALUES(?,?)";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,empid);
		pstm.execute();
		//CommonFunctions.ErrorWrite(""+pstm);
 
		
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}




public static void updateStaffImage(String filename,String empid) 
{
	try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql=" UPDATE com_m_staffaddressproof  SET IMG_IMAGE=? WHERE CHR_EMPID=? ";	
		 
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,empid);
		pstm.execute();
 
		
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}


public static void insertStaffProfile(String filename,String empid) 
{
		try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql="UPDATE com_m_staffaddressproof SET IMG_PROFILE=? WHERE CHR_EMPID=?";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,empid);
		pstm.execute();
 	
		
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}


 

public static void insertAddressProof(String Path, String empid,String proofColumn ) 
{
	try 
	{
		String fs =Path+"Addressproof/"+empid+"_"+proofColumn+".jpg";
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
	    
	    String sql="UPDATE com_m_staffaddressproof SET "+proofColumn+"=? WHERE CHR_EMPID=?";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,empid);
		pstm.execute();
		 Execute("UPDATE com_m_staff SET CHR_ADDRESSPROOFSTATUS='Y'      WHERE CHR_EMPID='"+empid+"'");
    
		
	    /*if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staffaddressproof WHERE CHR_EMPID='"+empid+"'"))
	    {
	    	String sql="UPDATE com_m_staffaddressproof SET "+proofColumn+"=? WHERE CHR_EMPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
			com.my.org.erp.common.CommonFunctions.Execute("UPDATE com_m_staff SET CHR_ADDRESSPROOFSTATUS='Y'      WHERE CHR_EMPID='"+empid+"'");
	    }
	    else
	    {
	    	String sql="INSERT INTO com_m_staffaddressproof (CHR_EMPID,"+proofColumn+",CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (" +
	    			"?,?,?,DATE(NOW()),? )";	
			pstm = co.prepareStatement(sql);
			pstm.setString(1,empid);
			pstm.setObject(2,bytes);
			pstm.setString(3,"ADMIN");
			pstm.setString(4,"Y");
			pstm.execute();
			com.my.org.erp.common.CommonFunctions.Execute("UPDATE com_m_staff SET CHR_ADDRESSPROOFSTATUS='Y'      WHERE CHR_EMPID='"+empid+"'");
				
	    }*/
 
		
	} 
	catch (Exception e) 
	{
		System.out.println(""+e.getMessage());
	}
	
}





 
public static void autoUpdate(HttpServletRequest request,String date)throws IOException, ServletException
{
    try
    {
    	String sql ="SELECT if(datediff(now(),'"+date+"') <0 ,1,0)";
    	if(!"1".equals(QueryExecute(sql)[0][0]))
    		Execute("UPDATE m_institution SET CHR_DOB='Y'  WHERE INT_ID=1 ");
    		 
    }
    catch(Exception e)
    {
    	System.out.println(e.getMessage());
    }
}


 

public static void updateHRMApplicantImage(String filename,String applicantid) 
{
		try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql=" UPDATE hrm_m_application  SET IMG_IMAGE=? WHERE INT_APPID=? ";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,applicantid);
		pstm.execute();
 
		
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}



public static void updateHRMApplicantProfile(String filename,String applicantid) 
{
		try 
	{

		String fs =filename;
		File f = new File(fs);
		InputStream is = new FileInputStream(f);
	    long length = f.length();
	    byte[] bytes = new byte[(int)length];
	    int offset = 0;
	    int numRead = 0;
	    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
	    {
	        offset += numRead;
	    }
	    is.close();
	    Connection co = null;
		DBCon con = new DBCon();
		co = con.getConnection();
	    java.sql.PreparedStatement pstm ;
		String sql="UPDATE hrm_m_application SET IMG_PROFILE=? WHERE INT_APPID=?";	
		pstm = co.prepareStatement(sql);
		pstm.setObject(1,bytes);
		pstm.setString(2,applicantid);
		pstm.execute();
 
		
	} 
	catch (Exception e) 
	{
			 System.out.println(e.getMessage());
	}
	
}





public static   String getMonthNamebetweenTwoDates(String fdate , String tdate) 
{
	String month = "";
	try 
	{
		 
	   month = "'"+QueryExecute("SELECT MONTHNAME('"+fdate+"')")[0][0]+"',"; 
	   String tdatemonthandyear[][]= QueryExecute("SELECT MONTHNAME('"+tdate+"') , YEAR('"+tdate+"') "); 
	   String tdatemonth=tdatemonthandyear[0][0];
	   String tdateyear=tdatemonthandyear[0][1];
	   int count =1;
	   boolean flag= true;
	   while(flag)
	   {
		   String addmonthandyear[][]= QueryExecute("SELECT MONTHNAME(DATE_ADD('"+fdate+"', INTERVAL "+count+" MONTH)), YEAR(DATE_ADD('"+fdate+"', INTERVAL "+count+" MONTH))");
		   if(addmonthandyear[0][0].equals("January"))
			   month = month+	"~'"+addmonthandyear[0][0]+"',";
		   else
			   month = month+	 addmonthandyear[0][0]+"',";
		   count = count+1;
		   if( (tdatemonth.equals(addmonthandyear[0][0]) ) && (tdateyear.equals(addmonthandyear[0][1]))  )
		     
			   flag = false;
		   
		   
	   }
	   
	     
	    
	   return month;

	}
	catch (Exception e) 
	{
		 
	}
	return null;
}



public static   String getYearbetweenTwoDates(String fdate , String tdate) 
{
	String year = "";
	try 
	{
		 
		String fromyear = QueryExecute("SELECT YEAR('"+fdate+"')")[0][0];
		String toyear = QueryExecute("SELECT YEAR('"+tdate+"')")[0][0];
		int from = Integer.parseInt(fromyear);
		int to = Integer.parseInt(toyear);
		boolean flag= true;
		while(flag)
		{
			year = year+from+",";
			from  = from+1;
			if(from >= to)
				flag = false;
				
		}
	    return year;

	}
	catch (Exception e) 
	{
		 ErrorWrite(e.getMessage());
	}
	return null;
}


public static   void CloseServletResponse( HttpServletResponse response) 
{
	try
	{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("</head>");
		out.println("<script language=\"javascript\">");
		out.println("function post_value()");
		out.println("{");
		out.println("window.close();");
		out.println("}");
		out.println("</script>");
		out.println("<body  onpaste=\"return false;\" onLoad=\"post_value()\">");
		out.println("</body>");
		out.println("</html>");
		out.close();
	}
	catch (Exception e) 
	{
		 ErrorWrite(e.getMessage());
	}
}




/**
 * GarbageCollection.java
 * Copyright (c) 2012, HerongYang.com, All Rights Reserved.
 */
 
   public static void GarbageRemover()
   {
      int steps = 10000;
      int size = 32;
      Object[] queue = new Object[size];
      Runtime rt = Runtime.getRuntime();
      System.out.println("Memory: Maximum   Total   Free   Used");
      for (int m=0; m<steps; m++) 
      {
         for (int n=0; n<size-1; n++) 
            queue[size-n-1] = queue[size-n-2];
         queue[0] = getOneMega();
         System.out.println(m+"   "+rt.maxMemory()
            +"   "+rt.totalMemory()+"   "+rt.freeMemory()
            +"   "+(rt.totalMemory()-rt.freeMemory()));
         try 
         {
            Thread.sleep(1000/10);
         } 
         catch (InterruptedException e) {
            System.out.println("Interreupted...");
         }
      }
   }
   
   
   private static Object getOneMega() 
   {
      return new long[1024*128]; // 1MB
   }
 

   
   public static String numberWord1(String num) 
	{
		String tmp = "";
		try 
		{
			String beforeadd="";
			for(int i=0;i<(10-num.length());i++)
				beforeadd=beforeadd+"0";
			num = beforeadd+num;
			int crore = Integer.parseInt(num.substring(0,3));
			int lakh = Integer.parseInt(num.substring(3,5));
			int thousand = Integer.parseInt(num.substring(5,7));
			int base = Integer.parseInt(num.substring(7,10));
			String s="";
			if(crore >=1)
			  s = s+numberWords(crore)+" Crore "; 
			if(lakh >=1)
			  s = s+numberWords(lakh)+" Lakh "; 
			if(thousand >=1)
			  s = s+numberWords(thousand)+" Thousand "; 
			if(base >=1)
			{
				if(s.equals(""))
					s = s+numberWords(base) ;
				else
			  s = s+" and "+numberWords(base) ;
			}
			s= s+" Only";  
			//s = "( "+s+ ")";  
			tmp = s;
			return tmp;
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		return tmp;
	}

	
   public static String[]  getReportingEmployeeIds(String empid)
	{
		String getempids=""+empid+",";
		try
		{
			String data[][]  = CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_REP FROM com_m_staff WHERE CHR_TYPE !='T' AND CHR_REPTO='"+empid+"'");
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					getempids = getempids+data[u][0]+",";
					//if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_REP FROM com_m_staff WHERE CHR_EMPID='"+data[u][0]+"'")[0][0]))
					if("Y".equals(data[u][1]))	
						getempids = getempids+ getsubReportingEmployeeIds(data[u][0]);
				}
			}
			return getempids.split(",") ;
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
		return null;
	}

   
   
   
   public static String   getsubReportingEmployeeIds(String empid)
	{
		String getempids="";
		try
		{
			String data[][]  = CommonFunctions.QueryExecute("SELECT CHR_EMPID FROM com_m_staff WHERE CHR_TYPE !='T' AND CHR_REPTO='"+empid+"'");
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				 	getempids = getempids+data[u][0]+",";
				 
			}
			return getempids  ;
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
   
   
   
   //return ID/Name
   public static String[][]  getReportingEmployeeIdNames(String empid)
	{
		try
		{
			String datad[] = getReportingEmployeeIds(empid);
			String ids=" AND CHR_EMPID IN ( ";
			for(int u=0;u<datad.length;u++)
				ids = ids +"'"+datad[u]+"' , ";
			ids = ids +" '0'  )";
			ids = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE CHR_TYPE !='T' "+ids + " ORDER BY CHR_STAFFNAME ";
			return CommonFunctions.QueryExecute(ids);
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
  
  
   
   
   public static NumberFormat indianCurrencyFormat()  
   {
	   NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
	   DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
	   decimalFormatSymbols.setCurrencySymbol("");
	   ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
	   return formatter;
   }
   
   public static String capitalizeFirstLetter(String original)
   {
	    if(original.length() == 0)
	        return original;
	    return original.substring(0, 1).toUpperCase() + original.substring(1);
	}
   
}
	




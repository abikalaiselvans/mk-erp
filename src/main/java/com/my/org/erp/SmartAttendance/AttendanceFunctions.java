package com.my.org.erp.SmartAttendance;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import DBConnection.DBCon;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
public class AttendanceFunctions 
{
	
	
	//Monthly Attendance register created LoginActionHandler
	public static void AttendanceGenerate(String userid) 
	{
		try 
		{
			//If attendance register not available then automatically created 
			if(!CommonFunction.RecordExist("SELECT COUNT(*) FROM att_t_register WHERE CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR = YEAR(NOW())"))
			{	
			
				System.out.println("Attendance Register creation");
				Connection co=null;	
				DBCon con = new DBCon();
				co = con.getConnection();
				CallableStatement acs = co.prepareCall("{call  ATT_PRO_REGISTER_CREATION( ?)}");
				acs.setString(1, userid);
				acs.execute();
				acs.close();
					
				System.out.println("Sunday Marking");
				acs = co.prepareCall("{call  ATT_PRO_REGISTER_SUNDAY_MARKING( ?)}");
				acs.setString(1, userid);
				acs.execute();
				acs.close();
			}
 
			
		} 
			
		catch (Exception e) 
			
		{
				System.out.println(e.getMessage());
				System.out.println(""+e.getMessage());
			
		}
		
		}

	//New Employee Attendance Register Assign
	public synchronized static void AttAssignNewJoiner(CallableStatement acs,PreparedStatement apstm,Connection con, String month, String year) 
	{
		try 
		{
			String jsql="";
			jsql = " SELECT CHR_EMPID,DAY(DT_DOJCOLLEGE),(DAY(DT_DOJCOLLEGE)-1),DAY(last_day(DT_DOJCOLLEGE)),DT_DOJCOLLEGE FROM com_m_staff ";
			jsql = jsql +" WHERE  DAY(DT_DOJCOLLEGE) >1 AND MONTHNAME(DT_DOJCOLLEGE) = '"+month+"' AND YEAR(DT_DOJCOLLEGE) ="+year;
			System.out.println("Joinner Query :"+ jsql);
			String empids[][] =CommonFunctions.QueryExecute(jsql);
			if(empids.length>0)
			{
				acs = con.prepareCall("{call  ATT_PRO_REGISTER_EMPLOYEE_NOTAPPLICABLE_MARKING( ?,?,?)}");
				for (int i = 0; i < empids.length; i++) 
				{
					acs.setString(1, empids[i][0]);
					acs.setString(2, empids[i][4]);
					acs.setString(3, "ADMIN");
					System.out.println("NEW JOINNER :"+i + " / "+empids.length);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				
				
				 
			 
			}
		
		}
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}
	
	
	
	
	
	
	
	//Resignner Employee Attendance Register Assign
	public synchronized static void AttAssignResignner(PreparedStatement apstm,Connection con, String month, String year) 
	{
		try 
		{
			String jsql="";
			int starday=0;
			int endday=0;
			String salaryprocess = CommonFunctions.QueryExecutecon(con,"SELECT CHR_SALAYCALCULATION FROM  pay_m_basicsettings WHERE INT_ID=1")[0][0];
			int mth = DateUtil.getMonthNumber(month);
			String d="";
			jsql = " SELECT CHR_EMPID,DAY(DAT_RESIGNDATE),(DAY(DAT_RESIGNDATE)+1),DAY(last_day(DAT_RESIGNDATE)) FROM com_m_staff ";  
			jsql = jsql +" WHERE MONTHNAME(DAT_RESIGNDATE) = '"+month+"' AND  YEAR(DAT_RESIGNDATE)= "+year;
			jsql = jsql +" AND DAY(DAT_RESIGNDATE) <=31 ";
			System.out.println("Resignner Query : "+jsql);
			String empids[][] =CommonFunctions.QueryExecute(jsql);
			if(empids.length>0)
			{
				for(int u=0; u<empids.length;u++)
				{
					jsql="";
					jsql = " UPDATE att_t_register SET ";
					starday= Integer.parseInt(empids[u][2]);
					endday= Integer.parseInt(empids[u][3]);
					for(int x=starday;x<=endday;x++)
					{
						if("WRK".equals(salaryprocess))
						{
							if(x<10)
								d="0"+x;
							else
								d=""+x;
							if("Sunday".equals( CommonFunctions.QueryExecute(" SELECT DAYNAME('"+year+"-"+mth+"-"+d+"') ")[0][0]))
								jsql=jsql+"CHR_MORNING"+x+"='SUN' , CHR_EVENING"+x+"='SUN' ,";
							else
								jsql=jsql+"CHR_MORNING"+x+"='NA' , CHR_EVENING"+x+"='NA' ,";
						}
						else if("CTC".equals(salaryprocess))
							jsql=jsql+"CHR_MORNING"+x+"='NA' , CHR_EVENING"+x+"='NA' ,";
						else if("MTH".equals(salaryprocess))
							jsql=jsql+"CHR_MORNING"+x+"='NA' , CHR_EVENING"+x+"='NA' ,";
					
					}
					jsql = jsql.trim();
					jsql = jsql.substring(0,jsql.length()-1);
					jsql=jsql+" WHERE CHR_EMPID=? AND  CHR_MONTH=? AND INT_YEAR=?";
					apstm = con.prepareStatement(jsql);
					apstm.setString(1,empids[u][0]);
					apstm.setString(2,month);
					apstm.setString(3,year);
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					
				}
			}
		
		}
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}
	
	
	

	//Duplicate Employee Attendance Register Delete
	public synchronized static void AvoidAttendanceGenerateDuplicate(PreparedStatement apstm,Connection con, String month, String year) 
	{
		try 
		{ 
			String sql = "SELECT CHR_EMPID from com_m_staff WHERE CHR_TYPE!='T' ORDER BY CHR_STAFFNAME ";
			
			sql = "  SELECT a.CHR_EMPID, COUNT(*) from com_m_staff a, att_t_register b WHERE a.CHR_EMPID = b.CHR_EMPID "; 
			sql = sql+"  AND a.CHR_TYPE!='T'  AND CHR_MONTH = '"+month+"' AND INT_YEAR="+year;
			sql = sql+"  GROUP BY a.CHR_EMPID HAVING COUNT(*) >1 ";
			System.out.println("Duplicate Query "+sql);
			String Empdata[][] = CommonFunctions.QueryExecute(sql);
			if(Empdata.length>0)
			{	
				sql ="DELETE FROM att_t_register WHERE  CHR_EMPID=? AND INT_RNO!= ? AND CHR_MONTH =? AND INT_YEAR=? ";
				apstm = con.prepareStatement(sql);
				for(int u=0;u<Empdata.length;u++)
				{	
					sql = "SELECT count(*) from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH ='"+month+"' AND INT_YEAR="+year;
					String data1[][] = CommonFunctions.QueryExecutecon(con, sql);
					int l = Integer.parseInt(data1[0][0]);
					sql = "SELECT INT_RNO,CHR_EMPID from att_t_register WHERE CHR_EMPID='"+Empdata[u][0].trim()+"' AND CHR_MONTH ='"+month+"' AND INT_YEAR="+year;
					String data2[][] =CommonFunctions.QueryExecutecon(con, sql);
					if(l>1)
					{
						apstm.setString(1,data2[0][1]);
						apstm.setString(2,data2[0][0]);
						apstm.setString(3,month);
						apstm.setString(4,year);
						apstm.addBatch(); 
					}
				}
				apstm.executeBatch();
				apstm.close();
			}
		}
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
	}

	
	
	public synchronized static boolean attendanceRegisterCheck(Connection con, int month, String year,String data[][]) 
	{
		boolean flag = true;
		try 
		{
			String sql = "";
			int daysInMonth = CommonFunctions.daysInMonth(year+"-"+month+"-01");
			String monthname = DateUtil.getMonth(month);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
				
					sql=" SELECT ( ";
					for(int i=1;i<(daysInMonth+1);i++)
						sql = sql+" (CHR_MORNING"+i+"='0') OR (CHR_EVENING"+i+"='0') OR ";
					sql=sql.trim();
					sql = sql.substring(0,sql.length()-2);	
					sql=sql+" ) ";
					sql = sql+" FROM att_t_register WHERE CHR_EMPID='"+data[u][0]+"' AND CHR_MONTH='"+monthname+"' AND INT_YEAR="+year;
					if("1".equals(CommonFunctions.QueryExecutecon(con, sql)[0][0]))
					{
						flag = false;
						break;
					}
				}
			}
			
			
			return flag;

		}
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		return flag;
	}
	
	
	public static void attendanceAutoMarking(Connection con,PreparedStatement apstm)
	{
		try
		{
			 
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ATTENDANCEAUTOMARK FROM att_m_basicsettings WHERE INT_ID=1")[0][0]))
    	  	  	if("0".equals(CommonFunctions.QueryExecute("SELECT count(*)  FROM att_m_automark WHERE CHR_DATE=DATE(NOW())")[0][0]))
				{
    	  	  		System.out.println("Attendance auto marking");
    	  	  		attendanceAutoMarkingLogic(con,apstm);
    	  	  		CommonFunctions.Execute("DELETE FROM att_m_automark  WHERE  CHR_DATE < DATE_SUB((select date(now())), INTERVAL 15 DAY) "); // DATE_FORMAT(NOW(),'%Y-%m-%d') 
				}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
	}
	
	public static void attendanceAutoMarkingLogic(Connection con,PreparedStatement apstm)
	{
		try
		{
			String asql="";
			asql = " SELECT DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y'),datediff(now(),DT_HOLIDATE) FROM att_t_commonholiday  WHERE datediff(now(),DT_HOLIDATE) <= 30 AND datediff(now(),DT_HOLIDATE) >= -30 ORDER BY DT_HOLIDATE ";
			String commonData[][]= CommonFunctions.QueryExecute(asql);
			String commondate ="";
			if(commonData.length>0)
			{
					for(int u=0;u<commonData.length;u++)
						commondate = commondate +commonData[u][0]+",";
			}
			String holidayarray[]= commondate.split(",");
			
			asql = " SELECT DAY(NOW()) , UPPER(DAYNAME(NOW())) , DATE_FORMAT(NOW(),'%d-%m-%Y'),MONTHNAME(now()), YEAR(NOW()),TIME_FORMAT(NOW(),'%h')  ";
			String data[][] = CommonFunctions.QueryExecutecon(con, asql);
			int day = Integer.parseInt(data[0][0]);
			//int time = Integer.parseInt(data[0][5]);
			String dayname = data[0][1];
			String date  = data[0][2];
			
			boolean f1 = true;
			boolean f2 = true;
			
			if(holidayarray.length>0)
			{
				for(int i=0;i<holidayarray.length;i++)
					if(date.equals(holidayarray[i]))
							f1 = false;
			}
				
			if("Sunday".equalsIgnoreCase(dayname))
					f2 = false;
			if( f1 && f2 )
			{
				asql = "UPDATE com_m_staff a,att_t_register b    SET b.CHR_MORNING"+day+" = 'PRE'   ,  b.CHR_EVENING"+day+" = 'PRE' "; 
				asql = asql+ " WHERE a.CHR_EMPID = b.CHR_EMPID	";
				asql = asql+ " AND a.DAT_RESIGNDATE is null  AND b.CHR_MORNING"+day+" = '0'  AND  b.CHR_EVENING"+day+" = '0' ";//( a.DAT_RESIGNDATE is null OR a.DAT_RESIGNDATE <=NOW() )	
				asql = asql+ " AND DT_DOJCOLLEGE <= NOW() AND a.CHR_TYPE !='T' 	";
				asql = asql+ " AND b.CHR_MONTH=?  AND b.INT_YEAR=?	";		
				apstm = con.prepareStatement(asql);
				apstm.setString(1, data[0][3]);
				apstm.setString(2, data[0][4]);
				System.out.println(""+apstm);
				apstm.execute();
				 
				
				asql = "";
				asql = asql + " INSERT INTO att_m_automark (CHR_DATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
				asql = asql + " VALUES(date_format(now(),'%Y-%m-%d') ,'ADMIN' ,date_format(now(),'%Y-%m-%d') ,'Y') ";
				apstm = con.prepareStatement(asql);
				System.out.println(""+apstm);
				apstm.execute();
				 
			}
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
	}
	
	
	public static void commonholidayAutoMarking(Connection con,PreparedStatement apstm)
	{
		try
		{
			String asql = "";
			if(CommonFunction.RecordExist("SELECT COUNT(*) FROM att_t_commonholiday WHERE CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR = YEAR(NOW()) AND CHR_STATUS='N' "))
			{
				String data[][] = CommonFunctions.QueryExecute("SELECT DAY(DT_HOLIDATE) FROM att_t_commonholiday WHERE CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR = YEAR(NOW()) AND CHR_STATUS='N'");
				if(data.length>0)
				{
					 
					System.out.println("Commonholiday Marking");
					for(int u=0;u<data.length;u++)
					{
						asql = "UPDATE  att_t_register     SET  CHR_MORNING"+Integer.parseInt(data[u][0])+" = 'HOL'   ,   CHR_EVENING"+Integer.parseInt(data[u][0])+" = 'HOL' "; 
						asql = asql+ " WHERE   CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR = YEAR(NOW()) 	";		
						apstm = con.prepareStatement(asql);
						System.out.println(""+apstm);
						apstm.execute();
					}
					
					asql = "UPDATE att_t_commonholiday SET CHR_STATUS='Y' WHERE  CHR_MONTH = MONTHNAME(NOW()) AND INT_YEAR = YEAR(NOW())";
					apstm = con.prepareStatement(asql);
					System.out.println(""+apstm);
					apstm.execute();	
				}
				
				
			}
			
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
	}
	
	
	
	
	public static void registerCreation(Connection con,PreparedStatement apstm,String userid)
	{
		try
		{
			String sql = " SELECT DAY(NOW()) <= 4"; 
			if("1".equals(CommonFunctions.QueryExecute(sql)[0][0]))
			{
				sql = " SELECT count(*) FROM com_m_staff a, att_t_register b WHERE a.CHR_EMPID =b.CHR_EMPID  "; 
				sql = sql + " AND a.CHR_TYPE != 'T' AND b.CHR_MONTH = MONTHNAME(NOW()) AND b.INT_YEAR = YEAR(NOW()) ";
				if(!CommonFunction.RecordExist(sql))
				{
					AttendanceFunctions.AttendanceGenerate(userid);
					System.out.println("register creations...........");
				}
			}
			
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

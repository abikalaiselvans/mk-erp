<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="DBConnection.*"%>
<%
//CommonFunctions.empidLeaveAssign();
try 
{
 if("1".equals(CommonFunctions.QueryExecute("SELECT ( (MONTH(NOW()) = 1) AND (DAY(NOW()) <= 3) )")[0][0]))
	if("F".equals(""+session.getAttribute("USERTYPE")))
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
			
			int leavecarrylimit = Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_LEAVELIMIT FROM  m_institution WHERE INT_ID=1")[0][0]);
			
			String leavesql="";
			leavesql="select  INT_ABOVEONEYEAR,INT_BELOWONEYEAR  from  att_m_leavetype order by INT_LEAVEID";
			String leavedata1[][] =CommonFunctions.RecordSetArray(co,leavesql);
			double aboveoneyearleave1=Double.parseDouble(leavedata1[0][0]);
			double aboveoneyearleave2=Double.parseDouble(leavedata1[1][0]);
			double aboveoneyearleave3=Double.parseDouble(leavedata1[2][0]);
			
			
			String sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,date_format(DT_DOJCOLLEGE,'%d-%b-%Y'),DATEDIFF(now(),DT_DOJCOLLEGE) FROM com_m_staff A ";  
			sql = sql + " WHERE A.CHR_EMPID NOT IN(SELECT CHR_EMPID FROM att_m_leave WHERE INT_YEAR=year(now())) ";
			sql = sql + " AND A.CHR_TYPE!='T' AND A.CHR_HOLD!='Y' AND YEAR(DT_DOJCOLLEGE)<=year(now()) ";
			String data[][] =CommonFunctions.RecordSetArray(co,sql);
			for(int u=0;u<data.length;u++)
			{
				b1=0;
				b2=0;
				b3=0;
				sql = " select  count(*) From att_m_leave WHERE INT_YEAR=year(now()) and CHR_EMPID ='"+data[u][0]+"'";
				if(!CommonFunctions.RecordExist(co, sql))
					if(Integer.parseInt(data[u][3])<=365)
					{
						sql  =" SELECT INT_NOD1,INT_NOD1BALANCE,INT_NOD2,INT_NOD2BALANCE,INT_NOD3,INT_NOD3BALANCE From att_m_leave WHERE INT_YEAR=year(now())-1 AND  CHR_EMPID='"+data[u][0]+"'";
						String balanceleave[][]= CommonFunctions.RecordSetArray(co,sql);
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
						String balanceleave[][]= CommonFunctions.RecordSetArray(co,sql);
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
	 	
}
catch (Exception e) 
{
	 out.println(e.getMessage() );
	 System.out.println(e.getMessage() );
}

	 
	response.sendRedirect("AttendanceMain.jsp");
%>
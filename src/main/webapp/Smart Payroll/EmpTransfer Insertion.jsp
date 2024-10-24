<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;	
	String month,OptEmpName,TxtOrder,TxtDoj,TxtDor,OptFromDist,TxtReason,TxtName,TxtId;
	String Sql,Sql_District;
	String date1,date2;
	int TxtMonth,TxtYear,DistrictId,OptToDist;
	String sql_Insert_Query="INSERT INTO PAY_M_EMP_TRANSFER(INT_TRANS_ID,CHR_EMPID,DT_TRANSFERDATE,INT_FROMDISTRICTID,INT_TODISTRICTID,CHR_REASON,DT_OF_RELEAVE,INT_YEAR,CHR_MONTH,chr_USRNAME,dt_UPDATEDATE,chr_UPDATESTATUS)VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
	
	private String getMonth(int mon)
	{	String month="";
		switch(mon)
		{
			case 01:month="January";
					break;
			case 02:month="February";
					break;
			case 03:month="March";
					break;
			case 04:month="April";
					break;
			case 05:month="May";
					break;
			case 06:month="June";
					break;
			case 07:month="July";
					break;
			case 8:month="August";
					break;
			case 9:month="September";
					break;
			case 10:month="October";
					break;
			case 11:month="November";
					break;
			case 12:month="December";
					break;
		}
		return(month);
	}

	public void insertUserInformation() 
	{
		
		try
		{
		int Count;
		Sql="Select max(INT_TRANS_ID) as maxid from PAY_M_EMP_TRANSFER where chr_UPDATESTATUS='y'";
		pstm = con.prepareStatement(Sql);
		rst=pstm.executeQuery();

		if (rst.next())
		{
			Count=rst.getInt("maxid") +1 ; 

		}
		else
		{
			Count=1;
		}
		
		
		Sql_District="SELECT INT_DISTRICTID FROM  com_m_district  WHERE CHR_DISTRICT=? ";
		pstm=con.prepareStatement(Sql_District);
		pstm.setString(1,OptFromDist);
		rst=pstm.executeQuery();
	  
		while(rst.next())
		{
			DistrictId=rst.getInt("INT_DISTRICTID");
		
		}
    		 		
			pstm = con.prepareStatement(sql_Insert_Query);
			pstm.setInt(1,Count);
			pstm.setString(2,OptEmpName);
			pstm.setString(3,date1);
			pstm.setInt(4,DistrictId);
			pstm.setInt(5,OptToDist);
			pstm.setString(6,TxtReason);
			pstm.setString(7,date2);
			String data[]=date2.split("-");
			String month=getMonth(Integer.parseInt(data[1]));
			pstm.setInt(8,Integer.parseInt(data[0]));
			pstm.setString(9,month);
			pstm.setString(10,"ADMIN");
			pstm.setString(11,"2003-06-20 00:00:00");
			pstm.setString(12,"Y");
			pstm.execute();
		}catch(NullPointerException ex)
		{
		                     //System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
	
	public void updateUserInformation()
	{
		try{
			String sql_update="UPDATE  com_m_staff  SET INT_DISTRICTID =? WHERE CHR_EMPID=?";
			pstm=con.prepareStatement(sql_update);
			pstm.setInt(1,OptToDist);
			pstm.setString(2,OptEmpName);
			pstm.execute();
			}catch(NullPointerException ex)
				{
		                     //System.out.println(ex);
				}
			catch(SQLException ex)
				{
			//System.out.println(ex);
				}
		
	}
	
	public void releaseJDBCResource() 
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}
		
%>

<%
OptEmpName=request.getParameter("ename");
////System.out.println(OptEmpName);
TxtOrder=request.getParameter("TxtOrder");
date1=FormateDateSQL(TxtOrder);
////System.out.println(date1);
//TxtDoj=request.getParameter("TxtDateJoin");
TxtDor=request.getParameter("TxtDor");
date2=FormateDateSQL(TxtDor);
////System.out.println(date2);
OptFromDist=request.getParameter("OptFromDist");
////System.out.println(OptFromDist);
OptToDist=Integer.parseInt(request.getParameter("OptToDist"));
////System.out.println(OptToDist);
TxtReason=request.getParameter("TxtReason");
////System.out.println(TxtReason);
		
	//Loading JDBC Connection Information
	try
	{
	con = conbean.getConnection();
	insertUserInformation();
	updateUserInformation();
	releaseJDBCResource();
	response.sendRedirect("Employee Transfer.jsp?message=Employee Transfered Sucessfully");
	}catch(FileNotFoundException ex)
	{
		//System.out.println(ex);
	}
	
%>

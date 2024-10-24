<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!	Connection con;
	PreparedStatement pstm;
	ResultSet rst;
	String OptEmpName,TxtVisit,TxtPeriod,RadioTicket,TxtFromPlace,TxtToPlace,TxtTo,TxtPurpose,TxtReturn;
	String TxtTime,TxtRetFrom,TxtRetTo,TxtToDate,TxtRetDate,TxtRetTime,OptEmpCode,TicketType;
	String sql_Insert_Query="INSERT INTO PAY_M_EMP_TRAVEL(INT_TRAVELID,CHR_EMPID,CHR_VISITPLACE,CHR_PERIOD,CHR_PURPOSE,CHR_TICKETTYPE,CHR_FROMDEPTPLACE,CHR_TODEPTPLACE,CHR_DEPTDATE,CHR_DEPTTIME,CHR_FROMRETURNPLACE,CHR_TORETURNPLACE,CHR_RETURNDATE,CHR_RETURNTIME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
		
%>
<%
OptEmpName=request.getParameter("ename");
//System.out.println(OptEmpName);
TxtVisit=request.getParameter("TxtVisit");
//System.out.println(TxtVisit);
TxtPeriod=request.getParameter("TxtPeriod");
//System.out.println(TxtPeriod);
TxtPurpose=request.getParameter("TxtPurpose");
//System.out.println(TxtPurpose);
RadioTicket=request.getParameter("ticket");
//System.out.println(RadioTicket);
TxtFromPlace=request.getParameter("TxtFromPlace");
//System.out.println(TxtFromPlace);
TxtToPlace=request.getParameter("TxtToPlace");
//System.out.println(TxtToPlace);
TxtTo=request.getParameter("TxtDate");
//System.out.println(TxtFromPlace);
TxtToDate=FormateDateSQL(TxtTo);
//System.out.println(TxtToDate);
TxtTime=request.getParameter("TxtTime");
//System.out.println(TxtTime);
TxtRetFrom=request.getParameter("TxtRetFrom");
//System.out.println(TxtRetFrom);
TxtRetTo=request.getParameter("TxtRetTo");
//System.out.println(TxtRetTo);
TxtReturn=request.getParameter("TxtRetDate");
//System.out.println(TxtReturn);
TxtRetDate=FormateDateSQL(TxtReturn);
//System.out.println(TxtRetDate);
TxtRetTime=request.getParameter("TxtRetTime");
//System.out.println(TxtRetTime);

	try
		{
			int Count;
			con=conbean.getConnection();
			String Sql="Select MAX(INT_TRAVELID) as MAXID from PAY_M_EMP_TRAVEL where CHR_UPDATESTATUS='y'";
			pstm = con.prepareStatement(Sql);
			rst=pstm.executeQuery();
			if (rst.next())
					{
					Count=rst.getInt("MAXID") +1 ; 
					//System.out.println(Count);
					}
			else
					{
					Count=1;
					}

					pstm=con.prepareStatement(sql_Insert_Query);	
					
					pstm.setInt(1,Count);
					pstm.setString(2,OptEmpName);
					pstm.setString(3,TxtVisit);
					pstm.setString(4,TxtPeriod);
					pstm.setString(5,TxtPurpose);
					pstm.setString(6,RadioTicket);
					
					pstm.setString(7,TxtFromPlace);
					pstm.setString(8,TxtToPlace);
					pstm.setString(9,TxtToDate);
					pstm.setString(10,TxtTime);
					
					pstm.setString(11,TxtRetFrom);
					pstm.setString(12,TxtRetTo);
					pstm.setString(13,TxtRetDate);
					pstm.setString(14,TxtRetTime);
				
					pstm.setString(15,"ADMIN");
					pstm.setString(16,"2003-06-20 00:00:00");
					pstm.setString(17,"Y");
					pstm.execute();
					rst.close();
					pstm.close();
					 
					
			response.sendRedirect("Travel Program.jsp?message=Travel Added Sucessfully");
		}
	
	catch(FileNotFoundException ex)
		{
	        //System.out.println(ex);
		}
	
%>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%@ include file="index.jsp"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String month;
	int year;
	int i,sno;	
	
	String empid;
	String empname;
	
	Calendar calDate1 = Calendar.getInstance();
	Calendar calDate2 = Calendar.getInstance();
	
	private void setDate(String fDate,String tDate)
	{
   		int date= Integer.parseInt(fDate.substring(0,2));
		int month= Integer.parseInt(fDate.substring(3,5));
		int year= Integer.parseInt(fDate.substring(6));		
		calDate1.set(year,month,date);		
   		date= Integer.parseInt(tDate.substring(0,2));
		month= Integer.parseInt(tDate.substring(3,5));
		year= Integer.parseInt(tDate.substring(6));
		calDate2.set(year,month,date+1);
	}
	private String getDate()
	{
		String date=""+ calDate1.get(Calendar.DATE);
		String month=""+ calDate1.get(Calendar.MONTH);
		String year=""+calDate1.get(Calendar.YEAR);		
		if(date.length()==1) date="0"+date;
		if(month.length()==1) month="0"+month;
		return(""+year +"-"+month+"-"+date);
		//return(""+date +"/"+month+"/"+year);
	}
	private String getDateSQL()
	{
		String date=""+ calDate1.get(Calendar.DATE);
		String month=""+ calDate1.get(Calendar.MONTH);
		String year=""+calDate1.get(Calendar.YEAR);		
		if(date.length()==1) date="0"+date;
		if(month.length()==1) month="0"+month;
		return(""+year +"-"+month+"-"+date);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style78 {font-family: Verdana}
.style79 {font-size: 10px}
.style80 {font-family: Verdana; font-size: 10px; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
</head>

<body  onpaste='return false;'>
<table width="1000" height="400">
	<!--DWLayoutTable-->
	<tr>
		<td width="90" height="67">&nbsp;</td>
		<td width="804">&nbsp;</td>
		<td width="84">&nbsp;</td>
	</tr>
	<tr>
		<td height="54">&nbsp;</td>
		<td valign="top">
		<table width="800" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="24" colspan="7" valign="middle" 
					class="tablehead">Attendance - Month view</td>
			</tr>
			<tr>
				<td width="81" height="23" align="center" valign="middle"
					bgcolor="6E8FBC" class="tablehead">S.NO</td>
				<td width="81" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Emp ID</td>
				<td width="191" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Name</td>
				<td width="101" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Login Date</td>
				<td width="89" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Time in</td>
				<td width="102" valign="middle" align="center" bgcolor="6E8FBC"
					class="tablehead">Time Out</td>
				<td width="138" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Remarks</td>
			</tr>
			<%
	
try
{	
		month=request.getParameter("Month");
		year=Integer.parseInt(request.getParameter("Year"));
		
		String fdate="01-"+month+"-"+year;
		String tdate="30-"+month+"-"+year;

		sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
		sql=sql+"FROM  com_m_staff  ORDER BY CHR_EMPID";
		con=conbean.getConnection();
		st=con.createStatement();
		rs=st.executeQuery(sql);
		empid="";
		empname="";
		while(rs.next()){
			if(!empid.equalsIgnoreCase("")){
				empid=empid+",";
				empname=empname+",";
			}    				
			empid=empid+rs.getString(1);
			empname=empname+rs.getString(2);
		}
		rs.close();
	    String userid[]=empid.split(",");
	    String username[]=empname.split(",");           	       	   	
	    sno=0;
		for(int i=0;i<userid.length;i++)		
		{
			setDate(fdate,tdate);
			while(!calDate1.equals(calDate2))
		    {	
				sql="SELECT CHR_EMPID,DT_TIMEIN,DT_TIMEOUT,DT_LOGIN,DT_LOGOUT ";
				sql=sql+"FROM ATT_SMART_ATTENDANCE WHERE DT_LOGIN='"+getDate()+"' AND ";
				sql=sql+"DT_LOGOUT='"+getDate()+"' AND CHR_EMPID='"+userid[i]+"'";
				rs = st.executeQuery(sql);
				if(rs.next())
				{
					out.println("<tr>");
					out.println("<td>"+(++sno)+"</td>");
					out.println("<td>"+userid[i]+"</td>");	
					out.println("<td>"+username[i]+"</td>");
					out.println("<td>"+rs.getString(5)+"</td>");						
					out.println("<td>"+rs.getString(2)+"</td>");	
					String outtime=rs.getString(3);
					while(rs.next()){
						if(rs.getString(4)!=null) outtime=rs.getString(3);
					}
					out.println("<td>"+outtime+"</td>");
					out.println("<td>"+ "&nbsp; "+"</td>");
					out.println("</tr>");	
				}
				calDate1.add(Calendar.DATE,1);
			}
		}
		rs.close();
		st.close();
		 
}
catch(Exception npe)
{
	//System.out.println(npe);
}
%>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="269">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<center><br>
<br>


</center>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>

<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
//  	Variable Declaration
	Connection con ;
	Statement st ;
	ResultSet rs;
	ResultSet rsemp;
	String sql;
	
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
<%
//	Datas get from previous form
	

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
<br>
<br>
<br>
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="91" height="42">&nbsp;</td>
		<td width="801" valign="top">
		<table width="800" border="1" align="left" cellpadding="0"
			cellspacing="1"  >
			<tr>
				<td height="26" colspan="9" align="center" valign="middle"
					  class="tablehead">DateWise - View</td>
			</tr>
			<tr>
				<td width="10%" height="26" align="center" valign="middle"
					bgcolor="6E8FBC" class="tablehead">Emp Id</td>
				<td width="19%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Name</td>
				<td width="11%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Login Date</td>
				<td width="10%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Time In</td>
				<td width="11%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Time Out</td>
				<td width="8%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Remarks</td>
			</tr>
			<%
try
{

	String fdate=request.getParameter("fromdt");
	String tdate=request.getParameter("todt");	
	
	con=conbean.getConnection();
	st=con.createStatement();
	
	sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
	sql=sql+"FROM  com_m_staff  ORDER BY CHR_EMPID";
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
				out.println("<tr><td>"+userid[i]+"</td>");	
				out.println("<td>"+username[i]+"</td>");
				out.println("<td>"+rs.getString(5)+"</td>");						
				out.println("<td>"+rs.getString(2)+"</td>");	
				String outtime="";
				if(rs.getString(4)!=null) outtime=rs.getString(3);
				while(rs.next()){
					if(rs.getString(4)!=null) outtime=rs.getString(3);
				}
				out.println("<td>"+outtime+"</td>");
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
		<td width="86">&nbsp;</td>
	</tr>
</table>
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
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>

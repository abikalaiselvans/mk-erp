<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String depid;
	String month;
	String year;
	int i;		
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
.style78 {
	font-family: Verdana;
	font-size: 16px;
}
a:visited {
	
}
a:hover {

}

-->
</style>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="86" height="176">
		<td colspan="2" valign="top">
		<table width="800" border="1" cellpadding="0" cellspacing="1"
			 >
			<tr align="center" valign="middle">
				<td height="25" colspan="8"  class="tablehead">
				Attendance Department View</td>
			</tr>
			<tr>
				<td width="15%" height="20" align="center" valign="middle"
					bgcolor="6E8FBC" class="tablehead">Emp Id</td>
				<td width="17%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Name</td>
				<td width="16%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Login Date</td>
				<td width="13%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Time in</td>
				<td width="11%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Time Out</td>
				<td width="13%" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Remarks</td>
			</tr>
			<%
        
        depid=request.getParameter("Department");
    	month=request.getParameter("Month");
    	year=request.getParameter("Year");
    	String fdate="01-"+month+"-"+year;
    	String tdate="30-"+month+"-"+year;
    try
    {
    	con=conbean.getConnection();
       	st=con.createStatement();
       	sql="SELECT CHR_EMPID,CHR_STAFFNAME ";
    	sql=sql+"FROM  com_m_staff  WHERE INT_DEPARTID="+depid+" ORDER BY CHR_EMPID";
    	rs=st.executeQuery(sql);
    	empid="";
    	empname="";
    	//System.out.println(sql);
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
catch(Exception e)
{
    //System.out.println(e);
}
%>
		</table>
		<br>
		<br>
		<br>
		<br>
		<table border=0>
			<!--DWLayoutTable-->
			<tr>
				<td width="167" height="72">&nbsp;</td>
				<td width="94" valign="top" background="../if">
				<div align="left"></div>
				</td>
				<td width="222">&nbsp;</td>
				<td width="93" valign="top" background="../if">
				<div align="right"></div>
				</td>
				<td width="202">&nbsp;</td>
			</tr>
		</table>
		<td width="88">
	</tr>
	<tr>
		<td height="2" colspan="2"></td>
		<td width="86"></td>
		<td></td>
	<tr>
		<td height="5"></td>
		<td width="714"></td>
		<td></td>
		<td></td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>

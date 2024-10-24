<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<html>
<head>
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
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<title> :: ATTENDANCE ::</title>


  


  
</head>
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

  
<script language="javascript" src="../JavaScript/comfunction.js"></script> 

 

<%
try
{
	String empid = request.getParameter("empid");
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	String staffname=CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"'")[0][0];
	String sql="";
	int tot =  DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
	String mon =  DateUtil.getMonth(Integer.parseInt(month));
	sql =" SELECT * FROM att_t_register WHERE CHR_EMPID='"+empid+"'  AND INT_YEAR="+year+" AND  CHR_MONTH ='"+mon+"' ";
	 
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql = " SELECT MONTHNAME(now()) , YEAR(NOW()), DAY(now()) ";
	String mdata[][] = CommonFunctions.QueryExecute(sql); 
	if(mon.equals( mdata[0][0]) && year.equals( mdata[0][1]) )
		tot = Integer.parseInt(mdata[0][2])	;
			 
		 Vector mn = new Vector();
		 Vector child= null;
		 int r = 4;
		 int x=0;
		 for(int u=1; u<=tot;u++)
		{
				child = new Vector();
				child.addElement(u);
				child.addElement(empid);
				child.addElement(staffname);
				child.addElement( ((u<=9)?("0"+u):(""+u))+"-"+month+"-"+year);
				if("SUN".equals(data[0][r].trim()))
					child.addElement("<font class='bolddeepred'>Sunday</font>");
				else if("PRE".equals(data[0][r].trim()))
					child.addElement("Present");
				else if("ABS".equals(data[0][r].trim()))
					child.addElement("<font class='bolddeepred'>Absent</font>");	
				else if("PER".equals(data[0][r].trim()))
					child.addElement("Permission");	
				else if("LEA".equals(data[0][r].trim()))
					child.addElement("<font class='bolddeepred'>Leave</font>");	
				else if("OND".equals(data[0][r].trim()))
					child.addElement("Onduty");	
				else if("LAT".equals(data[0][r].trim()))
					child.addElement("<font class='bolddeepred'>Late</font>");	
				else if("HOL".equals(data[0][r].trim()))
					child.addElement("Holiday");	
				else	
					child.addElement("-");	
					
				
				
				
				//evening
				if("SUN".equals(data[0][r+1].trim()))
					child.addElement("<font class='bolddeepred'>Sunday</font>");
				else if("PRE".equals(data[0][r+1].trim()))
					child.addElement("Present");
				else if("PER".equals(data[0][r+1].trim()))
					child.addElement("<font class='bolddeepred'>Permission</font>");	
				else if("ABS".equals(data[0][r+1].trim()))
					child.addElement("<font class='bolddeepred'>Absent</font> ");	
				else if("LEA".equals(data[0][r+1].trim()))
					child.addElement("<font class='bolddeepred'>Leave</font>");	
				else if("OND".equals(data[0][r+1].trim()))
					child.addElement("Onduty");	
				else if("LAT".equals(data[0][r+1].trim()))
					child.addElement("<font class='bolddeepred'>Late</font>");	
				else if("HOL".equals(data[0][r+1].trim()))
					child.addElement("Holiday");	
				else	
					child.addElement("-");	
			
			r = r+2;
			
			mn.add(child);
		
		}
		 
		 
		 
		request.setAttribute("table",mn);
		out.println("<br><center><h1>Attendance Report for the month - "+mon+" "+year+"  Employee Id :: "+empid+"  </h1></center><br>");
		
	
	
	%>
	
	
	
	
<display:table   id="_table" name="table"    export="true">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMPID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="STAFF NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Date" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="MORNING" sortable="true"><%=temp.elementAt(4)%></display:column>
		 			<display:column title="EVENING" sortable="true"><%=temp.elementAt(5)%></display:column>
					 
					 
					<display:setProperty name="export.csv.filename" value="Attendance.csv"/>
					<display:setProperty name="export.excel.filename" value="Attendance.xls"/>
					<display:setProperty name="export.xml.filename" value="Attendance.xml"/>
					<display:setProperty name="export.pdf.filename" value="Attendance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table> 
	
 
	<%
	
	
	
	
	
	
	/*
	
	out.println("<center><table width='80%'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	if(data.length>0)
	{
		out.println("<tr bgcolor='#ffffff'><td colspan=5 class='boldEleven' align=center><b>Attendance Report for the month - "+mon+" "+year+"  Employee Id :: "+empid+" </b>");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven' ><b>S.No");
		out.println("<td class='boldEleven' ><b>Date");
		out.println("<td class='boldEleven' ><b>Morning");
		out.println("<td class='boldEleven' ><b>Evening");
		int r = 4;
		int x=0;
		for(int u=1; u<=tot;u++)
		{
			if(u%2 == 0)
				out.println("<tr class='MRow1'><td class='boldEleven' >"+u);
			else
				out.println("<tr class='MRow2'><td class='boldEleven' >"+u);	
			
			out.println("<td class='boldEleven' >"+u+"-"+month+"-"+year);
			//morning
			
			if("SUN".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><b>Sunday");
			else if("PRE".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' > Present");
			else if("ABS".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font>");	
			else if("PER".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' > Permission");	
			else if("LEA".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' > Leave");	
			else if("OND".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' > Onduty");	
			else if("LAT".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' > Late");	
			else if("HOL".equals(data[0][r].trim()))
				out.println("<td class='boldEleven' ><b> Holiday");	
			else	
				out.println("<td class='boldEleven' > -");	
				
			
			
			
			//evening
			if("SUN".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><b>Sunday");
			else if("PRE".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Present");
			else if("PER".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Permission");	
			else if("ABS".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><font class='boldred'> Absent</font>");	
			else if("LEA".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Leave");	
			else if("OND".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Onduty");	
			else if("LAT".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' > Late");	
			else if("HOL".equals(data[0][r+1].trim()))
				out.println("<td class='boldEleven' ><b> Holiday");	
			else	
				out.println("<td class='boldEleven' > -");	
			
			r = r+2;
		
			
		}
	}
	else
	{
		out.println("<tr><td colspan=3> <br><br><center><font class='boldred'>Data not found...</font></center>");
	}
	out.println("</table></center>");
	out.println("<br><br>");
	//out.println("<a href='javascript:window.print()'><font class=boldEleven>Print</font></a>");*/
	
	
	
}
catch(Exception e)
{
}
%>

 		 
     
<br />
 
									<center>	<a href='AttenMonth.jsp'> CLOSE</a></center>



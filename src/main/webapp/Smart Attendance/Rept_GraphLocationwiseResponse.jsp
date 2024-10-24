 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>

 <%
try
{
%>
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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/CommonHolidayAjax.js"></script>

 <body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
 
  
		<%
		String reportingto= " OFFICE WISE ";
		
		String office = request.getParameter("office"); 
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String monthname = "";
		if(!"0".equals(month))
			monthname = com.my.org.erp.Date.Day.getMonth(Integer.parseInt( month));
		int fyear = Integer.parseInt( year); 
	 	String sql ="  ";
		sql = sql + "  SELECT b.CHR_OFFICENAME,";
		sql = sql + "  SUM(c.DOU_PRESENT),SUM(c.DOU_ONDUTY),SUM(c.DOU_SUNDAY),SUM(c.DOU_HOLIDAY),SUM(c.DOU_LEAVE),SUM(c.DOU_ABSENT), ";
		sql = sql + "  SUM(INT_LATE),SUM(INT_PERMISSION),SUM(DOU_EXTRADAYS),SUM(DOU_EXTRAHOURS) ";
		sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
		sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
		sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
		if(!"0".equals(month))
			sql = sql + "  AND a.INT_OFFICEID = "+office;
		sql = sql + "  AND c.INT_YEAR = "+year;
		if(!"0".equals(month))
			sql = sql + "  AND c.CHR_MONTH = '"+monthname+"'";
		sql = sql + "  GROUP BY b.CHR_OFFICENAME ";
		sql = sql + "  ORDER BY  b.CHR_OFFICENAME ";
		//out.println(sql);
		String data[][]= CommonFunctions.QueryExecute(sql);
		
			 
		 Vector mn = new Vector();
		 Vector child= null;
		 for(int u=0; u<data.length;u++)
		 {
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]); 
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]); 
				mn.add(child);
		 } 
	   
		 
		request.setAttribute("table",mn);
		String reportheader =  " OFFICE WISE CONSOLIDATE ATTENDANCE " ;
 	%>
	
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 			<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PRESENT" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="ON DUTY" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="SUNDAY " sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="HOLIDAY " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="LEAVE" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="ABSENT" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="LATE" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PERMISSION" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="EXTRA DAYS" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="EXTRA HOURS" sortable="true"><%=temp.elementAt(11)%></display:column>
					 
		 
				 <display:setProperty name="export.excel.filename" value="Rept_GraphLocationwise.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_GraphLocationwise.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_GraphLocationwise.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
                     
					 
</display:table> 
	
 
		 
     
<br />
 
									<center>	<a href='Rept_GraphLocationwise.jsp'> CLOSE</a></center>


 
</body>
<%
}
catch(Exception e)
{
}
%>

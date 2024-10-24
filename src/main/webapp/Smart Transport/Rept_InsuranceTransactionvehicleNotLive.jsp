 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
<title> :: TRANSPORT ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>

  
<script language="javascript" src="../JavaScript/comfunction.js"> </script><body  onpaste='return false;'><br><br><br><br>

	<%
	try
	{
		String sql=" SELECT  e.CHR_OFFICENAME,a.CHR_EMPID,b.CHR_STAFFNAME, c.CHR_REMINDERNAME,a.CHR_POLICYNO, a.CHT_PERIOD , a.DOU_PREMIUM,DATE_FORMAT(a.DT_DATE,'%d-%m-%Y'),   DATE_FORMAT(a.DT_DUEDATE,'%d-%m-%Y'), DATE_FORMAT(a.DT_MATURITY,'%d-%m-%Y'),  a.DOU_SUMASSURED,a.CHR_REGNUMBER, a.CHR_MAKE,a.CHR_MODEL,d.CHR_ISSUERNAME,   DATE_FORMAT(a.DT_VALIDUPTO,'%d-%m-%Y'),	a.CHR_STATUS,a.CHR_VECHICLESTATUS   FROM veh_t_insurancereminder a  ,com_m_staff b,vehicle_m_insurancereminder c,vehicle_m_insuranceissuer d,   	com_m_office e   WHERE a.CHR_EMPID=b.CHR_EMPID  AND a.INT_REMINDERID = c.INT_REMINDERID AND a.INT_ISSUERID=d.INT_ISSUERID AND a.INT_BRANCHID=e.INT_OFFICEID  AND a.CHR_VECHICLESTATUS='N' ORDER BY e.CHR_OFFICENAME ";
		
	 	
	 	 
 String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		 
	 	 
		 String reportheader="Insurance  Information";
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
				if("A".equals(data[u][5]))
				 	child.addElement("Annually");
				else if("H".equals(data[u][5]))
				 	child.addElement("Half Yearly");	
				else	
					child.addElement("Quartely");	
				
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				if("Y".equals(data[u][16]))
				 	child.addElement("Live");	
				else	
					child.addElement("Not Live");	

				 
				if("Y".equals(data[u][17]))
				 	child.addElement("Live");	
				else	
					child.addElement("Not Live");
				
				mn.add(child);
		 } 
			   
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
		
		
		 
		
	%>
	 
 	
	
 		
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee id" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Reminder Name" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Policy Number" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Period" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Premium Amount" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Entry Date " sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Due Date " sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Matured Date " sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Sum Assured" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Registration Number" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Make Info" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Model Info" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Issuer Name" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Valid Upto" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Policy Status" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Vehicle Status" sortable="true"><%=temp.elementAt(18)%></display:column>
					
		  		 
					<display:setProperty name="export.csv.filename" value="Rept_InsuranceTransaction.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_InsuranceTransaction.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_InsuranceTransaction.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_InsuranceTransaction.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					
					
					 
</display:table>     
<br />	<center>	<a href='Insurance Report.jsp'> CLOSE</a></center>
 
	 		
			
			
 
 
<%
}
catch(Exception e)
{
}
%>









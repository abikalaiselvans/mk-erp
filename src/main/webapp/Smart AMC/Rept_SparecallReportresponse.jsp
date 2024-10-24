  <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
 <%@ page import="java.util.*"%>
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
 
<title> :: AMC ::</title>



<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<%
try
{
%>
 
<body  onpaste='return false;'><br> 
<%
 
String reportheader = "REPORT";
String fromdate=request.getParameter("fromdate");
String todate=request.getParameter("todate");
String servicecenter=request.getParameter("servicecenter");
String customerid=request.getParameter("customerid");
String Customergroup=request.getParameter("Customergroup");
String sparecall=request.getParameter("sparecall");
String callstatus=request.getParameter("callstatus");


String sql =   " SELECT  ";
sql = sql + " g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME,d.CHR_CENTERNAME,f.CHR_SERVICEITEMNAME,  ";
sql = sql + " a.CHR_SERVICECALLNO, a.CHR_EMPID,a.CHR_SERIALNO,DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ATTENDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_CLOSEDATE,'%d-%b-%Y'),  ";
sql = sql + " a.CHR_CALLSTATUS,if(a.CHR_SPARE='Y','Yes','No'),a.CHR_SPAREDESC,a.CHR_CONTACTPERSON,a.CHR_CONTACTMOBILE,a.CHR_CONTACTADDRESS,a.CHR_CONTACTEMAIL,h.CHR_STAFFNAME  ";
sql = sql + " FROM inv_t_servicecallbookingtrack a,inv_t_servicecallbooking b,inv_m_servicecustomerinfo c,inv_m_servicecenter d,  ";
sql = sql + " inv_m_serviceamc e,inv_m_serviceitems f,inv_m_servicecustomergroup g ,com_m_staff h ";
sql = sql + " WHERE a.CHR_SERVICECALLNO = b.CHR_SERVICECALLNO  ";
sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID  ";
sql = sql + " AND c.INT_SERVICECENTERID = d.INT_SERVICECENTERID   ";
sql = sql + " AND a.CHR_SERIALNO=e.CHR_SERIALNO  ";
sql = sql + " AND c.INT_CUSTOMERID = e.INT_CUSTOMERID  ";
sql = sql + " AND e.INT_SERVICEITEMID = f.INT_SERVICEITEMID  ";
sql = sql + " AND c.INT_GROUPID = g.INT_GROUPID  AND a.CHR_EMPID =h.CHR_EMPID";
if(!"0".equals(servicecenter))
sql = sql + " AND d.INT_SERVICECENTERID="+servicecenter;
if(!"0".equals(Customergroup))
sql = sql + " AND g.INT_GROUPID="+Customergroup;
if(!"0".equals(customerid))
sql = sql + " AND c.INT_CUSTOMERID="+customerid;
if(!"0".equals(callstatus))
sql = sql + " AND a.CHR_CALLSTATUS="+callstatus;	
if(!"0".equals(sparecall))
sql = sql + " AND a.CHR_SPARE='"+sparecall+"' ";	
sql = sql + " AND date(a.DT_ASSIGNDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
sql = sql + " AND date(a.DT_ASSIGNDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
sql = sql + " ORDER BY g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME";
//out.println(sql);




String data[][] = CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;
for(int u=0; u<data.length;u++)
{
	child = new Vector();
	child.addElement((u+1)+".");
	child.addElement(data[u][0]);
	child.addElement(data[u][1]);
	child.addElement(data[u][2]);
	child.addElement(data[u][3]);
	child.addElement(data[u][4]);
	child.addElement(data[u][5]+ "/"+data[u][17]);
	child.addElement(data[u][6]);
	child.addElement(data[u][7]);
	child.addElement(data[u][8]);
	child.addElement(data[u][9]);
	if("1".equals(data[u][10]))
		child.addElement("Pending for Spare");
	else if("2".equals(data[u][10]))	 
		child.addElement("Pending for Response");
	else if("3".equals(data[u][10]))	 
		child.addElement("Pending for Customer");
	else if("4".equals(data[u][10]))	 
		child.addElement("Under Observation");
	 else if("5".equals(data[u][10]))	 
		child.addElement("Closed");
	child.addElement(data[u][11]);
	child.addElement(data[u][12]);
	child.addElement(data[u][13]);
	child.addElement(data[u][14]);
	child.addElement(data[u][15]);
	child.addElement(data[u][16]);	   
				   
	mn.add(child);
} 


request.setAttribute("table",mn);



  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Group Name" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Customer Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Service Center" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Service Item" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Service Call Number" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Empid / Staff Name" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Assign Date" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Atten Date" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Close Date" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Call Status" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Spare" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Spare Description" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Contact Person" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Contact Address" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Contact Mobile" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Contact Email" sortable="true"><%=temp.elementAt(17)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_serial.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_serial.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_serial.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='Rept_Servicereport.jsp'> CLOSE</a></center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

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
String reportheader="REPORT"; 

String fromdate=request.getParameter("fromdate");
String todate=request.getParameter("todate");
String servicecenter=request.getParameter("servicecenter");
String customerid=request.getParameter("customerid");
String Customergroup=request.getParameter("Customergroup");
String sparecall=request.getParameter("sparecall");

String sql=" SELECT c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME,b.CHR_STREET,a.CHR_SERIALNO,d.CHR_SERVICEITEMNAME, ";
sql = sql + " DATE_FORMAT(a.DT_STARTDATE,'%d-%m-%Y %H:%m:%s'),DATE_FORMAT(a.DT_ENDDATE,'%d-%m-%Y %H:%m:%s'),a.INT_NOOFYEAR " ;
sql = sql + " FROM inv_m_serviceamc a ,inv_m_servicecustomerinfo b,inv_m_servicecustomergroup c,inv_m_serviceitems d";
sql = sql + "  WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.INT_SERVICEITEMID=d.INT_SERVICEITEMID  ";
sql = sql + " AND b.INT_GROUPID= c.INT_GROUPID ";

if(!"0".equals(servicecenter))
sql = sql + " AND b.INT_SERVICECENTERID="+servicecenter;

if(!"0".equals(Customergroup))
sql = sql + " AND b.INT_GROUPID="+Customergroup;

if(!"0".equals(customerid))
sql = sql + " AND a.INT_CUSTOMERID="+customerid;

sql = sql + " AND date(a.DT_STARTDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
sql = sql + " AND date(a.DT_STARTDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
sql = sql + " ORDER BY c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME";


 //out.print(sql);

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
	child.addElement(data[u][5]);
	child.addElement(data[u][6]);
	child.addElement(data[u][7]);
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
					<display:column title="Address" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Item name" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Starting Date" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Ending Date" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Warranty" sortable="true"><%=temp.elementAt(8)%></display:column>
					 
		 
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

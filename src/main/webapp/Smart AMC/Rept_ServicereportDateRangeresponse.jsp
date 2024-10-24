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
String callstatus=request.getParameter("callstatus");

String sql=" SELECT a.INT_SERVICEID,a.CHR_SERVICECALLNO, c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME,d.CHR_CENTERNAME, ";
sql = sql + " a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%M-%Y %H:%i:%s'), " ;
sql = sql + " DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%M-%Y %H:%i:%s'), ";
sql = sql + " DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%M-%Y %H:%i:%s'), ";
sql = sql + " a.CHR_SERVICEDESC,";
sql = sql + " if(a.CHR_BOOKINGTYPE ='P','Phone',if(a.CHR_BOOKINGTYPE ='D','Direct','Others')) ,";
sql = sql + " if(a.CHR_BOOKINGUNDER ='W','Warranty',if(a.CHR_BOOKINGUNDER ='A','AMC','On Call')) ,";

sql = sql + " if(a.CHR_STATUS ='C','Completed',if(a.CHR_STATUS ='N','New Call',if(a.CHR_STATUS ='P','Pending','Cancelled / Rejected'))) ,";
sql = sql + " if(a.CHR_ENGGSTATUS ='N','Not Assign',if(a.CHR_ENGGSTATUS ='Y','Assigned','Re-Assign')) ,";
sql = sql + " a.CHR_BOOKINGEMPID,e.CHR_STAFFNAME,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE, ";
sql = sql + " a.CHR_CONTACTEMAIL ";
sql = sql + " FROM inv_t_servicecallbooking a ,inv_m_servicecustomerinfo b,inv_m_servicecustomergroup c, ";
sql = sql + " inv_m_servicecenter d,com_m_staff e ";
sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID ";
sql = sql + " AND b.INT_GROUPID=c.INT_GROUPID ";
sql = sql + " AND b.INT_SERVICECENTERID=d.INT_SERVICECENTERID ";
sql = sql + " AND a.CHR_BOOKINGEMPID=e.CHR_EMPID ";
if(!"0".equals(servicecenter))
sql = sql + " AND b.INT_SERVICECENTERID= "+servicecenter;

if(!"0".equals(customerid))
sql = sql + " AND a.INT_CUSTOMERID= "+customerid;
if(!"0".equals(callstatus))	
sql = sql + " AND a.CHR_STATUS= '"+callstatus+"' ";

sql = sql + " AND date(a.DT_BOOKINGDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
sql = sql + " AND date(a.DT_BOOKINGDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
//out.print(sql);

String data[][] = CommonFunctions.QueryExecute(sql);
Vector mn = new Vector();
Vector child= null;
for(int u=0; u<data.length;u++)
{
	child = new Vector();
	child.addElement((u+1)+".");
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
	child.addElement(data[u][11]);
	child.addElement(data[u][12]);
	child.addElement(data[u][13]);
	child.addElement(data[u][14]);
	child.addElement(data[u][15]);
	child.addElement(data[u][16]);
	child.addElement(data[u][17]);
	child.addElement(data[u][18]);
	child.addElement(data[u][19]);	   
	mn.add(child);
} 


request.setAttribute("table",mn);



  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Service CallNo" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Group Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Customer Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Service Center" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Booking Date" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Assign Date" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Close Date" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Service Description" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Booking Type" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Booking Under" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Status" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Engg Status" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Booking EmpId " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Emp Name" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Contact Persion" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Contact MobileContact Address" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Contact Mobile " sortable="true"><%=temp.elementAt(18)%></display:column>
					 <display:column title="Contact Email " sortable="true"><%=temp.elementAt(19)%></display:column>
					      
		 
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

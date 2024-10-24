<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<title>-</title>



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
 

String reportheader="DAILY CALLS REPORT"; 
String  calltype= request.getParameter("calltype");
String  customer= request.getParameter("customer");
String  close= request.getParameter("close");
String  fromdate= request.getParameter("fromdate");
fromdate = DateUtil.FormateDateSys(fromdate);
String  todate= request.getParameter("todate");
todate = DateUtil.FormateDateSys(todate);
String sql="";
sql = " SELECT  FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID), c.CHR_CALLTYPE,a.CHR_NAME,  ";
sql = sql+ " FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID),a.CHR_DESC, ";
sql = sql+ " DATE_FORMAT(a.DAT_START,'%W %d-%b-%Y %H:%i:%s  %p'),  "; 
sql = sql+ " DATE_FORMAT(a.DAT_END,'%W %d-%b-%Y %H:%i:%s  %p'), ";
sql = sql+ " if(a.CHR_STATUS='Y','Closed','Pending'), ";
sql = sql+ " if(a.CHR_NEXT='Y','Yes',''),DAT_FOLLOWON , FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID)  ";
sql = sql+ " FROM mkt_t_daillycalls a, mkt_k_calltype c ";
sql = sql+ " WHERE a.CHR_CALLTYPE=c.INT_CALLTYPEID  ";
sql = sql + " AND a.CHR_EMPID ='"+session.getAttribute("EMPID")+"'";

if(!"0".equals(calltype))
	sql = sql+ " AND a.CHR_CALLTYPE ="+calltype;
if(!"0".equals(customer))
	sql = sql+ " AND a.INT_CUSTOMERID ="+customer;
if(!"0".equals(close))
	sql = sql+ " AND a.CHR_STATUS = '"+close+ "'";
	
sql = sql+ " AND a.DAT_START  >='"+fromdate+"'";
sql = sql+ " AND a.DAT_END  <='"+todate+"'";
sql = sql+ " ORDER BY  a.DAT_START ";
//out.println(sql);
String data[][] = CommonFunctions.QueryExecute(sql);
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


  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CALL TYPE"   sortable="true"><%=temp.elementAt(2)%></display:column>
                    <display:column title="AJANDA"   sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="ENTRY"   sortable="true"><%=temp.elementAt(4)%></display:column>
                    <display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(5)%></display:column>
                    <display:column title="FROM "   sortable="true"><%=temp.elementAt(6)%></display:column>
                    <display:column title="TO"   sortable="true"><%=temp.elementAt(7)%></display:column>
                    <display:column title="STATUS"   sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="FOLLOWS"   sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title="FOLLOWS ON"   sortable="true"><%=temp.elementAt(10)%></display:column>
                    
                      
					<display:setProperty name="export.excel.filename" value="Rept_DailyCalls.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DailyCalls.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DailyCalls.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='Rept_DailyCalls.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

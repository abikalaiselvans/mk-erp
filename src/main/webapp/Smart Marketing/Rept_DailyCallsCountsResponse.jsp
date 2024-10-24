<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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
 
<title> :: MARKETING ::</title>



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
 
<body onselectstart="return false" onpaste="return false;" onCopy="return false"   onpaste='return false;'>
 <br> 
<%
 

String reportheader="DAILY CALLS COUNT REPORT"; 
String  calltype= request.getParameter("calltype");
String  customer= request.getParameter("customer");
String  close= request.getParameter("close");
String  me= request.getParameter("me");

String  fromdate= request.getParameter("fromdate");
fromdate = DateUtil.FormateDateSys(fromdate);
String  todate= request.getParameter("todate");
todate = DateUtil.FormateDateSys(todate);
String sql="";
String datad[] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
String ids=" AND a.CHR_EMPID IN ( '"+session.getAttribute("EMPID")+"',";
for(int u=0;u<datad.length;u++)
	ids = ids +"'"+datad[u]+"' , ";
ids = ids +" '0'  )";
String usertype=""+session.getAttribute("USRTYPE");

  
sql =  " SELECT a.CHR_EMPID, COUNT(*) FROM mkt_t_daillycalls  a ";
sql = sql+ " WHERE a.CHR_STATUS ='Y'  AND a.CHR_RESCHEDULE ='N' ";
/*if(!"0".equals(calltype))
	sql = sql+ " AND a.CHR_CALLTYPE ="+calltype;
if(!"0".equals(customer))
	sql = sql+ " AND a.INT_CUSTOMERID ="+customer;
*/ 
sql = sql+ " AND DATE(a.DAT_START)  >='"+fromdate+"'";
sql = sql+ " AND DATE(a.DAT_START)  <='"+todate+"'";

if(!"0".equals(me))
	sql = sql+ " AND a.CHR_EMPID ='"+me+"'";
else
{	
	if(!"F".equals(usertype))
		sql = sql + ids;
}

 
sql = sql+ " GROUP BY a.CHR_EMPID ";
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
	mn.add(child);
} 
request.setAttribute("table",mn);


  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="M.E"   sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="COUNT"   sortable="true"><%=temp.elementAt(2)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_DailyCallsCounts.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DailyCallsCounts.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DailyCallsCounts.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='Rept_DailyCallsCounts.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

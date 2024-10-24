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
 
<body onpaste="return false;" >
 <br> 
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
 
sql =   " SELECT FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME,  FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID), c.CHR_CALLTYPE,   ";
sql = sql+ " DATE_FORMAT(a.DAT_START,'%d-%b-%Y'),  ";
sql = sql+ " DATE_FORMAT(a.DAT_START,'%H:%i:%s  %p'), DATE_FORMAT(a.DAT_END,'%H:%i:%s  %p'),  ";
sql = sql+ " TIME_FORMAT(TIMEDIFF(a.DAT_END,a.DAT_START),'%H:%i:%s')  age,  a.CHR_DEPARTMENT,a.CHR_DESIGINATION,a.CHR_CONTACTPERSON, ";
sql = sql+ " a.CHR_DESC, ";
sql = sql+ " if(a.CHR_NEXT='Y','Yes',''), DATE_FORMAT(a.DAT_FOLLOWON,'%d-%b-%Y %H:%i:%s  %p') , ";
sql = sql+ " IF(a.CHR_RESCHEDULE ='Y','Reschedule','')  ,  ";
sql = sql+ " IF(a.CHR_STATUS ='Y','Closed','Follows Up') , FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID) ";
sql = sql+ " FROM mkt_t_daillycalls a, mkt_k_calltype c   ";
sql = sql+ " WHERE a.CHR_CALLTYPE=c.INT_CALLTYPEID   ";

if(!"0".equals(calltype))
	sql = sql+ " AND a.CHR_CALLTYPE ="+calltype;
if(!"0".equals(customer))
	sql = sql+ " AND a.INT_CUSTOMERID ="+customer;
if(!"0".equals(close))
	sql = sql+ " AND a.CHR_STATUS = '"+close+ "'";
	
sql = sql+ " AND DATE(a.DAT_START)  >='"+fromdate+"'";
sql = sql+ " AND DATE(a.DAT_START)  <='"+todate+"'";
sql = sql + "   AND a.CHR_EMPID = '"+session.getAttribute("EMPID")+"' ";
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
	child.addElement(data[u][11]);
	child.addElement(data[u][12]);
	child.addElement(data[u][13]);
	child.addElement(data[u][14]);
	child.addElement(data[u][15]);
	mn.add(child);
} 
request.setAttribute("table",mn);


  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
                    <display:column title="M.E"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="CALL TYPE"   sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="CALL DATE"   sortable="true"><%=temp.elementAt(4)%></display:column>
                    <display:column title="START TIME"   sortable="true"><%=temp.elementAt(5)%></display:column>
                    <display:column title="END TIME"   sortable="true"><%=temp.elementAt(6)%></display:column>
                    <display:column title="TOTAL TIME "   sortable="true"><%=temp.elementAt(7)%></display:column>
                     <display:column title="DEPARTMENT"   sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="DESIGINATION"   sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title="CONTACT PERSON"   sortable="true"><%=temp.elementAt(10)%></display:column>
                    <display:column title="CALL DESC "   sortable="true"><%=temp.elementAt(11)%></display:column>
                    <display:column title="FOLLOWS ON"   sortable="true"><%=temp.elementAt(13)%></display:column>
                    <display:column title="RECHEDULE"   sortable="true"><%=temp.elementAt(14)%></display:column>
                    <display:column title="Status"   sortable="true"><%=temp.elementAt(15)%></display:column>
                    
					<display:setProperty name="export.excel.filename" value="MyRept_DailyCallsResponse.xls"/>
					<display:setProperty name="export.pdf.filename" value="MyRept_DailyCallsResponse.pdf"/>
					<display:setProperty name="export.csv.filename" value="MyRept_DailyCallsResponse.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='MarketingMain.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

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
 
<body onselectstart="return false" onpaste="return false;" onCopy="return false"   onpaste='return false;'><br> 
<%
 

String reportheader="WIN CALLS REPORT"; 
 String  fromdate= request.getParameter("fromdate");
fromdate = DateUtil.FormateDateSys(fromdate);
String  todate= request.getParameter("todate");
todate = DateUtil.FormateDateSys(todate);
String sql="";
 
sql =  "    SELECT  FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME,   FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID) Clientname, b.CHR_DESC,  ";
sql=sql+"CONCAT(MKT_FUN_GET_STAGENAME(a.INT_PERCENTAGE),a.INT_PERCENTAGE,'( % )') stage,DATE_FORMAT(c.DAT_QUOTATIONDATE,'%d-%b-%Y') funneldate, ";
sql = sql + " b.INT_QUANTITY,b.DOU_UNITPRICE,b.DOU_TOTAL,FIND_A_EMPLOYEE_REPORTING_TO(a.CHR_EMPID) Owner,MKT_FUN_GET_COLORCODE(a.INT_PERCENTAGE) ";
sql = sql + " FROM mkt_t_daillycalls a ,mkt_t_quotationitem b, mkt_t_quotation c ";
sql = sql + " WHERE  a.INT_CALLID >0  AND a.CHR_QUOTATION = b.CHR_QUOTATIONNO  AND b.CHR_QUOTATIONNO = c.CHR_QUOTATIONNO ";
sql = sql + " AND  a.CHR_ADDEDTO_FUNNEL ='Y'  AND a.CHR_STATUS ='Y'   AND a.CHR_WINLOST ='W' ";
sql = sql+ "  AND  c.DAT_QUOTATIONDATE   >='"+fromdate+"'";
sql = sql+ "  AND  c.DAT_QUOTATIONDATE   <='"+todate+"'";
sql = sql + "   AND a.CHR_EMPID = '"+session.getAttribute("EMPID")+"' ";
sql = sql + "     ORDER BY c.DAT_QUOTATIONDATE  ";
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
	mn.add(child);
} 
request.setAttribute("table",mn);


  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
                    <display:column title="M.E"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CLIENT"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DESC"   sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="STAGE (%) "   sortable="true"><%=temp.elementAt(4)%></display:column>
                    <display:column title="FUNNEL DATE"   sortable="true"><%=temp.elementAt(5)%></display:column>
                    <display:column title="QUANTITY"   sortable="true"><%=temp.elementAt(6)%></display:column>
                    <display:column title="UNIT PRICE "   sortable="true"><%=temp.elementAt(7)%></display:column>
                     <display:column title="TOTAL"   sortable="true"><%=temp.elementAt(8)%></display:column>
                    <display:column title="OWNER"   sortable="true"><%=temp.elementAt(9)%></display:column>
                      
					<display:setProperty name="export.excel.filename" value="MyRept_Wincalls.xls"/>
					<display:setProperty name="export.pdf.filename" value="MyRept_Wincalls.pdf"/>
					<display:setProperty name="export.csv.filename" value="MyRept_Wincalls.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table>     
<br />	<center>	<a href='MyRept_Wincalls.jsp'> CLOSE</a>
</center>
 
	 		
			
			

 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

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

<script language="javascript">
	function  Print(salno)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="DirectSalesPrint.jsp?salno="+salno +"&serialyes=false" ;
			
			 
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
	</script>
 <title>:: INVENTORY ::</title>

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
 
<body ><br> 
<%
 

String reportheader="NO OF INVOICE CUSTOMER WISE ";
String branch = request.getParameter("Branch");
String customer = request.getParameter("customer");
String month = request.getParameter("month");
String year = request.getParameter("year");
//month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month));



String sql="";
	 
sql = " SELECT  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),b.CHR_SALESNO,DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y'),b.DOU_TOTALAMOUNT,b.CHR_CONTACTDETAILS,b.CHR_CONTACTNO ";
sql = sql +" FROM inv_m_customerinfo a ,inv_t_directsales b ";
sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID ";
 if(!"0".equals(branch))
  sql = sql +" AND   (b.INT_BRANCHID)  = "+branch+"  ";

if(!"0".equals(customer))
  sql = sql +" AND   (b.INT_CUSTOMERID)  = "+customer+"  ";
  
if(!"0".equals(month))
  sql = sql +" AND  MONTH(b.DAT_SALESDATE)  = "+month+"  ";
  
if(!"0".equals(year))
  sql = sql +" AND  YEAR(b.DAT_SALESDATE)  = "+year+"  ";
 sql = sql +"   ORDER BY b.DAT_SALESDATE ";
 	 
 	 
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
			child.addElement("<a href=\"javascript:Print('"+data[u][1]+"')\">Print</a>");
			 
			mn.add(child);
     } 
  
	 
	request.setAttribute("table",mn); 
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");

  
  
 
%>
<center>
 	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="CUSTOMER " sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="SALE NUMBER " sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="SALE DATE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="AMOUNT"   style="text-align:right" sortable="true"  ><%=temp.elementAt(4)%></display:column>
					<display:column title="CONTACT " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="CONTACT NUMBER"   style="text-align:right" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Print" media ="html" sortable="true"><%=temp.elementAt(7)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_Customer_NoofSales.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Customer_NoofSales.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Customer_NoofSales.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table> 
			
<br />	<center>	<a href='Rept_Customer_NoofSaleswithRef.jsp'> CLOSE</a></center><br />
</center>			
	 



 
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

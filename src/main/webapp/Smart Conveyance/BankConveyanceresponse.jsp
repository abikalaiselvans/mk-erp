<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
   

<%
try
{
%>
<html>
<head>

<title> :: CONVEYANCE ::</title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>


<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<% 		 

	String companyid=request.getParameter("company");
	String branch=request.getParameter("branch");
	String officeid=request.getParameter("Office");
	String paiddate=request.getParameter("paiddate");
	String dept=request.getParameter("dept");
	String Category=request.getParameter("Category");
	String sql="";
	String off="";
	String cpy="";
	String bid ="";
	sql = " SELECT  ";
	sql = sql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','BT','ACH'  ),DATE_FORMAT(NOW(),'%d/%m/%Y'),  ";
	sql = sql +"  FLOOR(ROUND(sum(a.DOU_TOTAL),2)),b.CHR_STAFFNAME, CONCAT('',b.CHR_ACCNO),   "; 
	sql = sql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','SCBLINBBXXX','IFC-CODE'  ),   ";
	sql = sql +"  b.CHR_EMAILID,b.CHR_STAFFNAME,  ";
	sql = sql +"  concat('Conveyance for the month of ',UPPER(MONTHNAME('"+paiddate+"')) ,' ',YEAR('"+paiddate+"'))   ";
	sql = sql +"  FROM conveyance_t_conveyance a, com_m_staff b , com_m_office d ,com_m_depart e, com_m_employeecategory f , com_m_deposit_to g  ";
	sql = sql +"  WHERE a.CHR_EMPID=b.CHR_EMPID    ";
	sql = sql +"  AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y' AND b.INT_OFFICEID =d.INT_OFFICEID   ";
	sql = sql +"  AND b.INT_DEPARTID= e.INT_DEPARTID AND b.CHR_CATEGORY = f.INT_EMPLOYEECATEGORYID   ";
	sql = sql +"  AND  a.INT_BANKID = g.INT_DEPOSITID "; //  CHR_DEPOSITNAME
	sql = sql + "  AND a.DAT_ACCDATE='"+paiddate+"' ";
	sql = sql + "  AND b.INT_COMPANYID= "+companyid;		
	if(!"0".equals(officeid))
		sql = sql + " AND b.INT_OFFICEID = " +officeid;
	if(!"0".equals(branch))
		sql = sql + "  AND b.INT_BRANCHID = " +branch;Rept_Tally_conveyance.jsp
	if(!"0".equals(dept))
		sql = sql + "  AND b.INT_DEPARTID = " +dept;
	if(!"0".equals(Category))
		sql = sql + "  AND b.CHR_CATEGORY = " +Category;
	sql = sql + "  GROUP BY a.CHR_EMPID	 ORDER BY FIND_A_BANKGROUP_NAME(b.CHR_BANK),b.CHR_STAFFNAME";
	out.println(sql); 
		
		
 
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
			 
			
			mn.add(child);
     } 
   
	String reportheader="CONVEYANCE REPORT ";  
	request.setAttribute("table",mn);
	 
 
  

%>
 <center> 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="PAYMENT TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PAYMENT DATE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PAYMENT AMOUNT" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="PAYEE NAME" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PAYEE ACCOUNT NO" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="PAYEE BANK IFSC" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="EMAIID" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CUSTOMER REFERENCE" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PAYMENT DETAILS" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_Conveyance.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Conveyance.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Conveyance.csv"/>
					
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>    

<br />	 	<a href='BankConveyance.jsp'> CLOSE</a>
<br>
</center>


 
<%	 
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</form>
 </body>
</html>

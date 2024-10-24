 
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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='GEN' ")[0][0]%></title>


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
 

 	
 	
	String month= ""+request.getParameter("month");
	String year= ""+request.getParameter("year");
	String repmon = DateUtil.getMonth(Integer.parseInt( month));
	String company= ""+request.getParameter("company");
	String branch= ""+request.getParameter("branch");
	String Category= ""+request.getParameter("Category");
	String Office= ""+request.getParameter("Office");
	String dept= ""+request.getParameter("dept");
	
	
	
	
	String reportheader="SALARY BANK LIST REPORT FOR THE MONTH  "+repmon.toUpperCase() +"   YEAR  "+year; 
	String sql =  " ";
	
	 sql = "  SELECT "; 
	 sql = sql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','BT','ACH'  ),DATE_FORMAT(NOW(),'%d/%m/%Y'), ";
	 sql = sql +"  FLOOR(ROUND(a.DOU_MONTHSAL,2)), ";
	 sql = sql +"  a.CHR_EMPNAME,CONCAT('A/c-',a.CHR_ACCNO), ";
	 sql = sql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','SCBLINBBXXX', b.CHR_IFSC  ) ";
	 sql = sql +"  ,b.CHR_EMAILID,a.CHR_EMPNAME, ";
	 sql = sql +"  CONCAT('Salary for the month of "+repmon.toUpperCase()+"','"+year+"') ,d.CHR_OFFICENAME,f.CHR_CATEGORYNAME ";
	 sql = sql +"  FROM  pay_t_salary a , com_m_staff b,  com_m_office d, com_m_depart e, com_m_employeecategory f  ";
	 sql = sql +"   WHERE  a.CHR_EMPID =b.CHR_EMPID  ";
 
	 sql = sql +"  AND a.INT_OFFICEID = d.INT_OFFICEID  ";
	 sql = sql +"  AND a.INT_DEPARTID = e.INT_DEPARTID  "; 
	 sql = sql +"  AND  b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID  ";
	 
	 if(!"0".equals(company))
		sql = sql +"  AND b.INT_COMPANYID="+company;
	 if(!"0".equals(branch))
		sql = sql +"  AND b.INT_BRANCHID="+branch;
	 if(!"0".equals(Office))
		sql = sql +"  AND b.INT_OFFICEID="+Office;
	
	 if(!"0".equals(dept))
		sql = sql +"  AND b.INT_DEPARTID="+dept;
	
	if(!"0".equals(Category))
 		sql = sql +"   AND b.CHR_CATEGORY='"+Category +"' ";	
	
	sql = sql +"   AND a.CHR_MONTH='"+repmon+"' AND a.INT_YEAR="+year;
 
	sql = sql+ " GROUP BY a.CHR_EMPID ORDER BY FIND_A_BANKGROUP_NAME(b.CHR_BANK),a.CHR_EMPNAME   "; 
 	//out.println(sql);
	 
  /* SELECT 
 if(FIND_A_BANKNAME_NAME(c.INT_BANKID) ='STANDARD CHARTERED BANK','BT','ACH'  ),DATE_FORMAT(NOW(),'%d/%m/%Y'),
 FLOOR(ROUND(a.DOU_MONTHSAL,2)),
 a.CHR_EMPNAME,a.CHR_ACCNO,'IFC-CODE',b.CHR_EMAILID,a.CHR_EMPNAME,
 CONCAT('Salary for the month of  ','2012') 
 FROM  pay_t_salary a , com_m_staff b, com_m_bank c, com_m_office d, com_m_depart e, com_m_employeecategory f 
 WHERE  a.CHR_EMPID =b.CHR_EMPID 
 AND a.CHR_BANK=c.INT_BANKID  
 AND a.INT_OFFICEID = d.INT_OFFICEID 
 AND a.INT_DEPARTID = e.INT_DEPARTID  
 AND  b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID  
 GROUP BY a.CHR_EMPID
ORDER BY a.CHR_EMPNAME*/
 
  	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
	

%>
 
  
 
<center>
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="PAYMENT TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PAYMENT DATE" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PAYMENT AMOUNT" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="PAYEE NAME"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PAYEE ACCOUNT NO" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="PAYEE BANK IFSC" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="EMAILID" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CUSTOMER REFERENCE" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="PAYMENT DETAILS" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="OFFICE" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="CATEGORY" sortable="true"><%=temp.elementAt(11)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="SalaryBankReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="SalaryBankReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="SalaryBankReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table> 
</center>			
<br />	<center>	<a href='SalaryBankReport.jsp'> CLOSE</a></center>
			

 
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 

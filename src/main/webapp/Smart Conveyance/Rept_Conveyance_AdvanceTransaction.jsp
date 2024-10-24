<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
  
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
<title> :: CONVEYANCE ::</title>

 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<body  onpaste='return false;'>
 
	<%
try
{
		String empid = request.getParameter("empid");
		String sql="";
		 
		sql = sql + " SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID), ";
		sql = sql + " DOU_AMOUNT,DATE_FORMAT(DAT_ENTRYDATE,'%d-%b-%Y'),CHR_DESC,FIND_A_EMPLOYEE_ID_NAME(CHR_ENTRYBY), ";
		sql = sql + " DOU_CAMOUNT,DATE_FORMAT(DAT_CDATE,'%d-%b-%Y'), FIND_A_EMPLOYEE_ID_NAME(CHR_CENTRY)  ";
		sql = sql + " FROM conveyance_m_advance WHERE  CHR_EMPID = '"+empid+"' ";
		sql = sql + " ORDER BY INT_ADVANCEID ";

		String cdata[][]= CommonFunctions.QueryExecute(sql);
		Vector mn = new Vector();
		Vector child= null;
		for(int u=0;u<cdata.length;u++)
		{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(cdata[u][0]);
				child.addElement(cdata[u][1]);
				child.addElement(cdata[u][2]);
				child.addElement(cdata[u][3]);
				child.addElement(cdata[u][4]);
				child.addElement(cdata[u][5]);
				child.addElement(cdata[u][6]);
				mn.add(child);  

		} 
		request.setAttribute("table",mn);
		out.println("<br><center><h3> <b>  CONVEYANCE  ADVANCE TRANSACTIONS</h3></center><br>");
	 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" EMPLOYEE ID/NAME" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title=" ADVANCE "  style="text-align:right" sortable="true"  ><%=temp.elementAt(2)%></display:column>
					<display:column title=" ADVANCE DATE"  sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title=" DESCRIPTION"  sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" ENTRY BY"  sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title=" CONVEYANCE AMOUNT" style="text-align:right" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" CONVEYANCE DATE"  sortable="true"><%=temp.elementAt(7)%></display:column>
  <display:column title=" ENTRY BY"   style="text-align:right" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:setProperty name="export.csv.filename" value="Rept_Conveyance_advance.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_Conveyance_advance.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_Conveyance_advance.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Conveyance_advance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='Conveyancemain.jsp' style="text-align:right"> CLOSE</a></center>


<%

}
catch(Exception e)
{
	
}
%>
 
</body>
</html>

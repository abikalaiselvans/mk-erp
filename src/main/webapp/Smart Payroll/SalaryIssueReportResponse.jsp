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
 <title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>


<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>
<body >

<%
try
{
 		
		String sql ="SELECT UPPER(CHR_COLORCODE) FROM inv_m_color ORDER BY CHR_COLORCODE";
		String  Office= request.getParameter("Office");
		String  dept= request.getParameter("dept");
		String  Category= request.getParameter("Category");
		String  Month= request.getParameter("Month");
		String  Year= request.getParameter("Year");
		String monthname= DateUtil.getMonth(Integer.parseInt(Month));
		String reportheader="SALARY ISSUE REPORT "+monthname.toUpperCase() +" - " +Year; 
		sql = " SELECT b.CHR_EMPID,b.CHR_EMPNAME,c.CHR_OFFICENAME, ";
		sql = sql + " d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,b.CHR_MONTH,b.INT_YEAR,b.DOU_MONTHSAL,";
		sql = sql + " if(b.CHR_ISSUEMODE ='0','Not issue',if(b.CHR_ISSUEMODE ='D','DD',if(b.CHR_ISSUEMODE ='C','CHEQUE',if(b.CHR_ISSUEMODE ='H','CASH',if(b.CHR_ISSUEMODE ='R','RTGS','NEFT'))))), ";
		sql = sql + " DATE_FORMAT(b.CHR_ISSUEDATE,'%d-%b-%Y'),f.CHR_BANKGROUPNAME,b.CHR_ISSUE_DESC,FIND_A_EMPLOYEE_ID_NAME(b.CHR_ISSUEDBY) ";
		sql = sql + " FROM com_m_staff a,pay_t_salary b,com_m_office c, com_m_depart d, com_m_employeecategory e ,com_m_bankgroup f ";
		sql = sql + " WHERE a.CHR_EMPID =b.CHR_EMPID  ";
		sql = sql + " AND b.INT_OFFICEID =c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID =d.INT_DEPARTID ";
		sql = sql + " AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND b.CHR_ISSUEBANK = f.INT_BANKGROUPID ";
		sql = sql + " AND b.CHR_MONTH ='"+monthname+"' ";
		sql = sql + " AND b.INT_YEAR = "+Year;
		if(!"0".equals(dept))
			sql = sql+" AND b.INT_DEPARTID="+dept +" ";
		if(!"0".equals(Office))
			sql = sql+" AND b.INT_OFFICEID="+Office +" ";  
		if(!"0".equals(Category))
			sql = sql+" AND a.CHR_CATEGORY='"+Category +"' ";
		
		sql = sql + " ORDER BY b.CHR_EMPNAME ";
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] =  CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
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
				 
				 mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Emp Id"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Emp Name"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Office"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Department"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Category"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Month"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Year"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Month Salary"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Issue Mode"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Issue Date"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Bank "   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Description"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Issued By"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_SalaryIssueReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_SalaryIssueReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_SalaryIssueReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='SalaryIssueReport.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


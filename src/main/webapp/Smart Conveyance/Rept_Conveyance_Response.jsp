<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
	
 	 
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String fromdatesql = DateUtil.FormateDateSQL(fromdate);
		String todatesql = DateUtil.FormateDateSQL(todate);
		 
		String sql="";
		 
		 
	 	sql = " SELECT a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME, ";
		sql = sql + " MONTHNAME(a.DAT_CONDATE),YEAR(a.DAT_CONDATE), ";
		sql = sql + " SUM(a.DOU_TRAVEL),SUM(a.DOU_TRAIN),SUM(a.DOU_AUTO),SUM(a.DOU_LUNCH),SUM(a.DOU_TELEPHONE),SUM(a.DOU_OTHERAMT),SUM(a.DOU_TOTAL) ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b,com_m_office c, com_m_depart d, com_m_employeecategory e ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID= d.INT_DEPARTID ";
		sql = sql + " AND b.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.CHR_STATUS='Y' ";
		sql = sql + " AND a.CHR_ACCEPT ='Y' ";
		sql = sql + " AND a.CHR_ACCSTATUS='Y' ";
		sql = sql + " AND a.DAT_CONDATE >='"+fromdatesql+"' ";
		sql = sql + " AND a.DAT_CONDATE <='"+todatesql+"' ";
		if(!"0".equals(company))
			sql = sql + " AND   b.INT_COMPANYID ="+company;
		if(!"0".equals(branch))
			sql = sql + " AND   b.INT_BRANCHID ="+branch;
		if(!"0".equals(office))
			sql = sql + " AND   b.INT_OFFICEID ="+office;
			
		sql = sql + " GROUP BY a.CHR_EMPID ,MONTH(a.DAT_CONDATE),YEAR(a.DAT_CONDATE) ";
		sql = sql + " ORDER BY b.CHR_STAFFNAME,a.DAT_CONDATE ";
		 
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
				child.addElement(cdata[u][2]);
				child.addElement(cdata[u][4]);
				child.addElement(cdata[u][5]);
				child.addElement(cdata[u][6]);
				child.addElement(cdata[u][7]);
				child.addElement(cdata[u][8]);
				child.addElement(cdata[u][9]);
				child.addElement(cdata[u][10]);
				child.addElement(cdata[u][11]);
				child.addElement(cdata[u][12]);
				child.addElement(cdata[u][13]);
				mn.add(child);  

		} 
		
		sql = " SELECT  SUM(a.DOU_TRAVEL),SUM(a.DOU_TRAIN),SUM(a.DOU_AUTO),SUM(a.DOU_LUNCH),SUM(a.DOU_TELEPHONE),SUM(a.DOU_OTHERAMT),SUM(a.DOU_TOTAL) ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b,com_m_office c, com_m_depart d, com_m_employeecategory e ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID= d.INT_DEPARTID ";
		sql = sql + " AND b.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.CHR_STATUS='Y' ";
		sql = sql + " AND a.CHR_ACCEPT ='Y' ";
		sql = sql + " AND a.CHR_ACCSTATUS='Y' ";
		if(!"0".equals(company))
			sql = sql + " AND  b.INT_COMPANYID ="+company;
		if(!"-1".equals(branch))
			sql = sql + " AND   b.INT_BRANCHID ="+branch;
		if(!"0".equals(office))
			sql = sql + " AND   b.INT_OFFICEID ="+office;
		
		sql = sql + " AND a.DAT_CONDATE >='"+fromdatesql+"' ";
		sql = sql + " AND a.DAT_CONDATE <='"+todatesql+"' ";
		String cdata1[][]= CommonFunctions.QueryExecute(sql);
		for(int u=0;u<cdata1.length;u++)
		{
				child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement(cdata1[u][0]);
				child.addElement(cdata1[u][1]);
				child.addElement(cdata1[u][2]);
				child.addElement(cdata1[u][3]);
				child.addElement(cdata1[u][4]);
				child.addElement(cdata1[u][5]);
				child.addElement(cdata1[u][6]);
				mn.add(child);  
		}
				
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b>  CONVEYANCE REPORT   FROM : ( "+fromdate+")  TO :  "+todate+"</h3></center><br>");
 
  

 
	 
		
	 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" EMPLOYEE ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title=" NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title=" OFFICE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title=" DEPARTMENT" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" CATEGORY" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title=" MONTH" sortable="true" style="text-align:right"><%=temp.elementAt(6)%></display:column>
					<display:column title=" YEAR" sortable="true" style="text-align:right"><%=temp.elementAt(7)%></display:column>
					<display:column title=" TRAVEL" sortable="true" style="text-align:right"><%=temp.elementAt(8)%></display:column>
					<display:column title=" TRAIN" sortable="true" style="text-align:right"><%=temp.elementAt(9)%></display:column>
					<display:column title=" AUTO" sortable="true" style="text-align:right"><%=temp.elementAt(10)%></display:column>
					<display:column title=" LUNCH" sortable="true" style="text-align:right"><%=temp.elementAt(11)%></display:column>
					<display:column title=" TELEPHONE" sortable="true" style="text-align:right"><%=temp.elementAt(12)%></display:column>
					<display:column title=" OTHERS" sortable="true" style="text-align:right"><%=temp.elementAt(13)%></display:column>
					<display:column title=" TOTAL " sortable="true" style="text-align:right"><%=temp.elementAt(14)%></display:column>
					 
					
					<display:setProperty name="export.csv.filename" value="Rept_Conveyance.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_Conveyance.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_Conveyance.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Conveyance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='Rept_Conveyance.jsp' style="text-align:right"> CLOSE</a></center>


<%

}
catch(Exception e)
{
	
}
%>
 
</body>
</html>

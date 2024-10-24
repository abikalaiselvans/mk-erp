<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
   
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
<title> :: PAYROLL ::</title>


 
  


  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<br>
<br>


<%
try
{
 	String  company  = request.getParameter("company");
	String  branch  = request.getParameter("branch");
	String  Office  = request.getParameter("Office");
	String  Month  = request.getParameter("Month");
	String  Year  = request.getParameter("Year");
	String repmon = DateUtil.getMonth(Integer.parseInt( Month));
	String off="";
	if(!"0".equals(Office))
		off=" AND e.INT_OFFICEID="+Office;
	
	String cpy="";
	if(!"0".equals(company))
		cpy=" AND e.INT_COMPANYID="+company;
		
	String bch="";
	if(!"0".equals(branch))
		bch=" AND e.INT_BRANCHID="+branch;

		
	String sql="";
	sql=" SELECT a.CHR_EMPID, a.CHR_EMPNAME,  a.DOU_ORIGINALCTC, a.DOU_CTC, a.DOU_LOPDAY,a.DOU_LOP,b.CHR_COMPANYNAME, ";
	sql = sql +" d.CHR_OFFICENAME,c.CHR_DEPARTNAME,f.DOU_ABSENT,f.INT_LATE,f.INT_PERMISSION FROM pay_t_salary a, com_m_staff e ,";
	sql = sql + " com_m_company b ,com_m_depart c , com_m_office  d ,att_t_register f";
	sql = sql+ " WHERE a.CHR_EMPID= f.CHR_EMPID AND a.INT_YEAR="+Year+" AND a.CHR_MONTH='"+repmon+"'  AND a.DOU_LOPDAY>0 AND a.DOU_LOP>0 AND f.INT_YEAR="+Year+" AND f.CHR_MONTH='"+repmon+"' AND ";
	sql = sql+"	e.CHR_EMPID = a.CHR_EMPID AND e.INT_COMPANYID=b.INT_COMPANYID AND e.INT_OFFICEID = d.INT_OFFICEID ";
	sql = sql+ " ANd e.INT_DEPARTID = c.INT_DEPARTID "+off+	 cpy + bch+" ORDER BY a.CHR_EMPNAME";
	 
	

String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	int absent=0;
	int late=0;
	int permission=0;
	sql="SELECT INT_PERLIMIT,INT_LATELIMIT,DOU_LOSSOFDAY1,DOU_LOSSOFDAY2  FROM att_m_basicsettings WHERE INT_ID=1";
	String basedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	int perlimit=Integer.parseInt(basedata[0][0]);
	int latelimit=Integer.parseInt(basedata[0][1]);
	double lossofday1=Double.parseDouble(basedata[0][2]);
	double lossofday2=Double.parseDouble(basedata[0][3]);
	

	Vector mn = new Vector();
	Vector child= null;
	double sum=0;
	for(int x=0;x<reportdata.length;x++)
	{
		 child = new Vector();
		 child.addElement((x+1));
		 absent=0;
		 late=0;
		 permission=0;
		 child.addElement(reportdata[x][0]);
		 child.addElement(reportdata[x][1]);
		 child.addElement(reportdata[x][6]);
		 child.addElement(reportdata[x][7]);
		 child.addElement(reportdata[x][8]);
		 child.addElement(repmon+"-"+Year);
		 child.addElement(reportdata[x][2]);
		 child.addElement(reportdata[x][3]);
		 
		 absent=Integer.parseInt(reportdata[x][10]);
		 late=Integer.parseInt(reportdata[x][10]);
		 permission=Integer.parseInt(reportdata[x][11]);
		 child.addElement(absent);
		 child.addElement(late);
		 child.addElement(permission);
		
		 child.addElement(reportdata[x][4]);
		 child.addElement(reportdata[x][5]);
	  
		 sum=sum+Double.parseDouble(reportdata[x][5]);/**/
		 mn.add(child);  
		 
	}  


child = new Vector();
child.addElement("");
child.addElement("TOTAL");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement("");
child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(sum));
mn.add(child);  



request.setAttribute("table",mn);
out.println("<br><center><h3> Loss of Pay ("+repmon+"-"+Year+" )  </h3></center><br>");






 
	
	%>
	
		
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Department"sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Period" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Original CTC" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Month CTC" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Absent" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Late" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Permission" sortable="true"><%=temp.elementAt(11)%></display:column>
					
					<display:column title="Loss of day" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Loss Amount" sortable="true"><%=temp.elementAt(13)%></display:column>
					 
					
				 
					
					  
					
					<display:setProperty name="export.csv.filename" value="Lossofpay.csv"/>
					<display:setProperty name="export.excel.filename" value="Lossofpay.xls"/>
					<display:setProperty name="export.xml.filename" value="Lossofpay.xml"/>
					<display:setProperty name="export.pdf.filename" value="Lossofpay.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>
	
     
<br />	<center>	<a href='Lossofpay.jsp'> CLOSE</a></center>
 
	 		
	<%
	
}
catch(Exception e)
{
}
 %>
 
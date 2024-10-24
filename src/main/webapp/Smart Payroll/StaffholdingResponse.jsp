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
 
<br>
<br>

<%
	String addsql="";
	String repName="";
	String repHeader="";
	String bankcondition="";
	String Office= request.getParameter("Office");
	String Dept= request.getParameter("dept");
	
	String fmdate= request.getParameter("frmdate");
	fmdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fmdate);
	String todate= request.getParameter("todate");
	todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
	String orderby= request.getParameter("orderby");
	
	String off="";
	String dep="";
	if(!"0".equals(Office))
		off=" AND a.INT_OFFICEID="+Office;
	if(!"0".equals(Dept))
		dep=" AND a.INT_DEPARTID= "+Dept;
		
 		
	 String sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
	 sql = sql +" DATE_FORMAT(b.DAT_HOLD,'%d-%b-%Y') FROM   com_m_staff a, att_t_hold b ";
	 sql = sql +" WHERE  a.CHR_EMPID = b.CHR_EMPID ";
	 sql = sql+" AND b.DAT_HOLD >= '"+fmdate+"' ";
	 sql = sql+" AND b.DAT_HOLD <= '"+todate+"' ";
	 sql = sql+off;
	 sql = sql+dep;
	 sql = sql + " ORDER BY "+orderby;
	 System.out.println(sql);
	repName =" STAFF HOLDING LIST FROM  "+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(fmdate)  + " TO "+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(todate);
	 
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
			mn.add(child);
     } 
   request.setAttribute("table",mn);
	out.println("<br><center><h3> "+repName+" </h3></center><br>");
 
   
	 
	 
	 
	 
	 
	 
	  
	   
			 
%>
  <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Date of Joinning" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Resigned Date" sortable="true"><%=temp.elementAt(4)%></display:column>
					 
				 
					
				
					<display:setProperty name="export.csv.filename" value="StallHolding.csv"/>
					<display:setProperty name="export.excel.filename" value="StallHolding.xls"/>
					<display:setProperty name="export.xml.filename" value="StallHolding.xml"/>
					<display:setProperty name="export.pdf.filename" value="StallHolding.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='StallHolding.jsp'> CLOSE</a></center>
 
	 		
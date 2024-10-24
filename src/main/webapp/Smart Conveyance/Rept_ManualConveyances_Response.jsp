<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%
try
{
%>

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
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<body  onpaste='return false;'>
 
	<%
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		String office=request.getParameter("office");
		String monthname = DateUtil.getMonth(Integer.parseInt(month)); 
		String sql="";
		
	   
		sql = sql +" SELECT   a.CHR_EMPID,b.CHR_STAFFNAME,   ";
		sql = sql +" d.CHR_OFFICENAME,e.CHR_DEPARTNAME, f.CHR_CATEGORYNAME,  ";
		sql = sql +" FIND_A_BANKGROUP_NAME(b.CHR_BANK) ,b.CHR_ACCNO, b.CHR_IFSC,  ";
		sql = sql +" a.CHR_MONTH,a.INT_YEAR ,  ";
		sql = sql +" SUM(a.DOU_AMOUNT)    "; 
		sql = sql +" FROM conveyance_m_manual a ,com_m_staff b ,com_m_office d,  com_m_depart e ,  ";
		sql = sql +" com_m_employeecategory f  ";
		sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID   ";
		sql = sql +" AND b.INT_OFFICEID =d.INT_OFFICEID   ";
		sql = sql +" AND b.INT_DEPARTID= e.INT_DEPARTID  "; 
		sql = sql +" AND b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID   ";
		 
		if(!"0".equals(office))
			sql=sql+" AND  b.INT_OFFICEID=  "+office+"  ";
		if(!"0".equals(month))
			sql=sql+" AND  a.CHR_MONTH= '"+monthname+"' ";
		if(!"0".equals(year))
			sql=sql+" AND  a.INT_YEAR=  "+year+"  ";
		
		 
		sql = sql +" GROUP BY a.CHR_EMPID ,a.CHR_MONTH,a.INT_YEAR  ";
		sql = sql +" ORDER BY b.CHR_STAFFNAME  ";
		//out.println(sql);
		 
		String cdata[][]=CommonFunctions.QueryExecute(sql);
	 	
		Vector mn = new Vector();
		Vector child= null;
		if(cdata.length>0)
		{
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
					child.addElement(cdata[u][7]); 
					child.addElement(cdata[u][8]); 
					child.addElement(cdata[u][9]); 
					child.addElement(cdata[u][10]);  
					mn.add(child);  
	
			}
		}
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b>  MANUAL CONVEYANCE  REPORT </h3></center><br>");
 
  

 
	 
		 
		 
		
	 
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title=" Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title=" Office" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title=" Department" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" Category" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title=" Bank" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" A/C No" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title=" IFSC" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title=" Month" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title=" Year" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" Amount" sortable="true"><%=temp.elementAt(11)%></display:column>
 
					<display:setProperty name="export.csv.filename" value="Rept_ManualConveyances.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_ManualConveyances.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_ManualConveyances.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_ManualConveyances.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='Rept_ManualConveyances.jsp'> CLOSE</a></center>


</body>
</html>

<%

}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
 
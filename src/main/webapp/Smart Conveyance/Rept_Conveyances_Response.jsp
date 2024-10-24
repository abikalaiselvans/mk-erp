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
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String type=request.getParameter("type");
		fromdate = DateUtil.FormateDateSQL(fromdate);
		todate = DateUtil.FormateDateSQL(todate);
		
		String sql="";
		sql="SELECT b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DAT_CONDATE,'%d-%b-%Y'),a.CHR_FROM,a.CHR_TO,a.CHR_CALLID,a.DOU_KM, ";
		sql = sql +" a.DOU_TRAVEL, a.DOU_TRAIN,a.DOU_AUTO,a.DOU_LUNCH,  "; 
		sql = sql +" a.DOU_TELEPHONE,a.CHR_OTHERDESC, a.DOU_OTHERAMT,a.DOU_TOTAL, ";
		sql = sql +"  if(a.CHR_STATUS ='Y','Accept',if(a.CHR_STATUS='N','Pending','Reject')) ";
		sql = sql +" FROM conveyance_t_conveyance  a , com_m_staff b  ";
		sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
		if(!"0".equals(company))
			sql=sql+" AND  b.INT_COMPANYID=  "+company+"  ";
		if(!"0".equals(branch))
			sql=sql+" AND  b.INT_BRANCHID=  "+branch+"  ";
		if(!"0".equals(office))
			sql=sql+" AND  b.INT_OFFICEID=  "+office+"  ";
		if(!"0".equals(type))
			sql=sql+" AND  a.CHR_STATUS= '"+type+"' ";
		
		sql=sql+" AND  a.DAT_CONDATE >='"+fromdate+"'";
		sql=sql+" AND  a.DAT_CONDATE <='"+todate+"'";
		
		sql=sql+" ORDER BY  b.CHR_STAFFNAME";
		 
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
					child.addElement(cdata[u][11]);
					child.addElement(cdata[u][12]);
					child.addElement(cdata[u][13]);
					child.addElement(cdata[u][14]);
					child.addElement(cdata[u][15]);
					mn.add(child);  
	
			}
		 	
			sql = " SELECT SUM(a.DOU_TRAVEL), SUM(a.DOU_TRAIN),SUM(a.DOU_AUTO),SUM(a.DOU_LUNCH), ";
 			sql = sql +" SUM(a.DOU_TELEPHONE),SUM(a.DOU_OTHERAMT),SUM(a.DOU_TOTAL) ";
			sql = sql +" FROM conveyance_t_conveyance  a , com_m_staff b  ";
			sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
			if(!"0".equals(company))
				sql=sql+" AND  b.INT_COMPANYID=  "+company+"  ";
			if(!"0".equals(branch))
				sql=sql+" AND  b.INT_BRANCHID=  "+branch+"  ";
			if(!"0".equals(office))
				sql=sql+" AND  b.INT_OFFICEID=  "+office+"  ";
			if(!"0".equals(type))
				sql=sql+" AND  a.CHR_STATUS= '"+type+"' ";
			
			sql=sql+" AND  a.DAT_CONDATE >='"+fromdate+"'";
			sql=sql+" AND  a.DAT_CONDATE <='"+todate+"'";
			 
			String cdata1[][]=CommonFunctions.QueryExecute(sql);
			
			
			
			if(cdata1.length>0)
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
					child.addElement(cdata1[0][0]);
					child.addElement(cdata1[0][1]);
					child.addElement(cdata1[0][2]);
					child.addElement(cdata1[0][3]);
					child.addElement(cdata1[0][4]);
					child.addElement(cdata1[0][5]);
					child.addElement(""); 
					child.addElement(cdata1[0][6]);
					child.addElement(""); 
					
					mn.add(child);  
				
			} 
			 
		}		
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> <b>   CONVEYANCE  REPORT </h3></center><br>");
 
  

 
	 
		 
		 
		
	 
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">

	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title=" Sl.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title=" Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title=" Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title=" Date" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title=" From" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title=" To" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title=" Call Number" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title=" Kilometer" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title=" Vehicle Amount" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title=" Train/Bus are" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title=" Auto Fare" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title=" Lunch / Dinner" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title=" Telephone Charges" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title=" Others Desc" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title=" other Amount " sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title=" Totals " sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title=" Status " sortable="true"><%=temp.elementAt(16)%></display:column>

 
					<display:setProperty name="export.csv.filename" value="PaidConveyance.csv"/>
					<display:setProperty name="export.excel.filename" value="PaidConveyance.xls"/>
					<display:setProperty name="export.xml.filename" value="PaidConveyance.xml"/>
					<display:setProperty name="export.pdf.filename" value="PaidConveyance.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   

<br />	<center>	<a href='PaidConveyance.jsp'> CLOSE</a></center>


</body>
</html>

<%

}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
 
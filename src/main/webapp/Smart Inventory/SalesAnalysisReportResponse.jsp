<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body >
 <%
try
{
 
		 
		String reportheader="SALES ANALYSIS "; 
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("divis");
		String payType=request.getParameter("payType");
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		
		String sql = "";
		String dd="";
		 
		 
		if(!"0".equals(division))
			dd="  AND a.INT_DIVIID="+division;
		
	 
			
		 
		Vector mn = new Vector();
		Vector child= null;
		 
		if("Direct".equals(payType) || "ALL".equals(payType))
		{
			sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_TOTALAMOUNT), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)   ";
			sql = sql +" FROM inv_t_directsales a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			sql = sql +" where a.INT_DIVIID=b.INT_DIVIID   ";
			sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
			sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID  ";
			if(!"0".equals(Branch))
				sql = sql +" AND a.INT_BRANCHID ="+Branch;
			
			sql = sql +" AND YEAR(a.DAT_SALESDATE) ="+year;	
			sql = sql +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
			sql = sql +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
			 
			String data[][] = CommonFunctions.QueryExecute(sql);	
			if(data.length>0)
			{
				 
				for(int y=0;y<data.length;y++)
				{
					child = new Vector();
					child.addElement((y+1));
					child.addElement("CUSTOMER SALES");
					child.addElement(data[y][0]);
					child.addElement(data[y][1]);
					child.addElement(data[y][2]);
					child.addElement(data[y][3]);
					child.addElement(data[y][4]);
					child.addElement(data[y][5]);
					child.addElement(data[y][6]);
					mn.add(child);
				 
					 
				}
			}
			 
	
	}	
	
	 
	//Service Billing
	if("ServiceBilling".equals(payType) || "ALL".equals(payType))
		{
			sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_NETAMOUNT), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)   ";
			sql = sql +" FROM inv_t_servicebilling a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			sql = sql +" where a.INT_DIVIID=b.INT_DIVIID   ";
			sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
			sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID  ";
			if(!"0".equals(Branch))
				sql = sql +" AND a.INT_BRANCHID ="+Branch;
			
			sql = sql +" AND YEAR(a.DAT_SALESDATE) ="+year;	
			sql = sql +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
			sql = sql +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
			 
			String sdata[][] = CommonFunctions.QueryExecute(sql);	
			if(sdata.length>0)
			{
				 
				for(int y=0;y<sdata.length;y++)
				{
					
					child = new Vector();
					child.addElement((y+1));
					child.addElement("SERVICE BILLING");
					child.addElement(sdata[y][0]);
					child.addElement(sdata[y][1]);
					child.addElement(sdata[y][2]);
					child.addElement(sdata[y][3]);
					child.addElement(sdata[y][4]);
					child.addElement(sdata[y][5]);
					child.addElement(sdata[y][6]);
					mn.add(child);
			 		 
				}
			}
			 
	}	
	  
	 
	
	  
	 //DIRECT BILLIN
	 
	if("DirectBilling".equals(payType) || "ALL".equals(payType))
		{
			sql = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_NETAMOUNT), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)   ";
			sql = sql +" FROM inv_t_directbilling a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
			sql = sql +" where a.INT_DIVIID=b.INT_DIVIID   ";
			sql = sql +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
			sql = sql +" AND c.INT_COMPANYID=d.INT_COMPANYID  ";
			if(!"0".equals(Branch))
				sql = sql +" AND a.INT_BRANCHID ="+Branch;
			
			sql = sql +" AND YEAR(a.DAT_SALESDATE) ="+year;	
			sql = sql +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
			sql = sql +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
			sql = sql +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
			 
			String data[][] = CommonFunctions.QueryExecute(sql);	
			if(data.length>0)
			{
				 
				for(int y=0;y<data.length;y++)
				{
					
					
					child = new Vector();
					child.addElement((y+1));
					child.addElement("DIRECT BILLING");
					child.addElement(data[y][0]);
					child.addElement(data[y][1]);
					child.addElement(data[y][2]);
					child.addElement(data[y][3]);
					child.addElement(data[y][4]);
					child.addElement(data[y][5]);
					child.addElement(data[y][6]);
					mn.add(child);
					
					 
					 
				}
			}
			 
	
	}	
 
 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>
  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					 
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="TOTAL INVOICE " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="TOTAL AMOUNT" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="MONTH" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="YEAR" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_SalesAnalysis.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_SalesAnalysis.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_SalesAnalysis.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='SalesAnalysisReport.jsp'> CLOSE</a>
</center><br /><br />


 
<%		 		 
}
catch(Exception e)
{
 out.println(e.getMessage());
}
%>
<%@ include file="../footer.jsp"%>

</body>
</html>

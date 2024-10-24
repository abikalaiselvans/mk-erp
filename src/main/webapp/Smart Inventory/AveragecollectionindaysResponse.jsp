  <%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*,java.util.*"%>

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
	  String link="";
	  	try
			{
	  			
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String Branch = request.getParameter("Branch");
				String division=request.getParameter("division");
				String fdt = DateUtil.FormateDateSQL(fromdate);
				String tdt = DateUtil.FormateDateSQL(todate);
				String sql="";
						
sql = " SELECT  g.CHR_DIVICODE Division, ";
sql = sql +" CONCAT(DATE_FORMAT('"+fdt+"','%d-%b-%Y'),' to ',DATE_FORMAT('"+tdt+"','%d-%b-%Y')) Period, ";
sql = sql +" SUM(a.DOU_PAIDAMOUNT) Paidamount, ";
sql = sql +" SUM( if(datediff(a.CHR_CHKDATE,d.DAT_SALESDATE)<0,a.DOU_PAIDAMOUNT, 0)) advanceamount, ";
sql = sql +" ROUND(SUM( if(datediff(a.CHR_CHKDATE,d.DAT_SALESDATE)<0,0,datediff(a.CHR_CHKDATE,d.DAT_SALESDATE))) / COUNT(*) ,2) avgcollectiondays ";
sql = sql +" FROM inv_t_customersalespayment a, inv_m_customerinfo b ,inv_t_directsales d , ";
sql = sql +" com_m_company e, com_m_branch f,inv_m_division g  ";
sql = sql +" WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID "; 
sql = sql +" AND a.CHR_SALESORDERNO =d.CHR_SALESNO  ";
sql = sql +" AND d.INT_BRANCHID = f.INT_BRANCHID  ";
sql = sql +" AND f.INT_COMPANYID =e.INT_COMPANYID  ";
sql = sql +" AND d.INT_DIVIID = g.INT_DIVIID  ";
sql = sql +" AND a.DAT_PAYMENTDATE<='"+tdt+"' ";
sql = sql +" AND a.DAT_PAYMENTDATE>='"+fdt+"'  ";
if(!"0".equals(Branch))
	sql = sql+" AND a.INT_BRANCHID ="+Branch;
if(!"0".equals(division))
	sql = sql +" AND d.INT_DIVIID="+division+" ";
sql = sql +" GROUP BY g.CHR_DIVICODE ";
sql = sql +" ORDER BY g.CHR_DIVICODE ";
 						 		
				 
				String reportheader="AVERAGE COLLECTION       [ FROM -"+fromdate +"  TO-  "+ todate +" ] "; 
				Vector mn = new Vector();
				Vector child= null; 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
				
					double sum=0.0;
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][0]);
						child.addElement(data[u][1]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						mn.add(child);
					}
				}
				 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="PERIOD" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PAID AMOUNT" sortable="true"  style="text-align:right"><%=temp.elementAt(3)%></display:column>
					<display:column title="ADVANCE" sortable="true"  style="text-align:right"><%=temp.elementAt(4)%></display:column>
					<display:column title="AVERAGE IN DAYS" sortable="true"  style="text-align:right"><%=temp.elementAt(5)%></display:column>
					<display:setProperty name="export.excel.filename" value="Averagecollectionindays.xls"/>
					<display:setProperty name="export.pdf.filename" value="Averagecollectionindays.pdf"/>
					<display:setProperty name="export.csv.filename" value="Averagecollectionindays.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					
					
					 
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br />


 
<%		 		 
			}
			catch(Exception e)
			{
			}	
	  %>
	  
 </body>
</html>

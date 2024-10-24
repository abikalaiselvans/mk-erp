<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
	String Direct=request.getParameter("payType");
	String sql="";
	String fdt=DateUtil.FormateDateSQL(fromdate);
	String tdt=DateUtil.FormateDateSQL(todate);
	String mode="";
	
	
	if("Direct".equals(Direct))
	{
		mode = "DIRECT SALES";
		
		sql ="SELECT a.CHR_SALESNO, date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),c.CHR_DIVICODE, ";
		sql = sql+" d.CHR_BRANCHNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF), ";
		sql = sql+" a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_NOOFPAYMENTCOMMITMENT, ";
		sql = sql+"(SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment e WHERE e.CHR_SALESORDERNO = a.CHR_SALESNO ), ";
		sql = sql+" date_format(f.DT_COMMITMENTDATE,'%d-%b-%Y'),f.DOU_COMMITMENTAMOUNT, ";
		sql = sql+" f.DOU_ACTUALAMOUNT, date_format(f.DT_RECIEVEDDATE,'%d-%b-%Y'),f.DOU_RECEIVEDAMOUNT , ";
		sql = sql+" if(f.DT_RECIEVEDDATE <= f.DT_COMMITMENTDATE ,'Honoured', 'Not Honoured') ";
		sql = sql+" FROM inv_t_directsales a, inv_m_customerinfo b, inv_m_division c, ";
		sql = sql+" com_m_branch d  , inv_t_paymentcommitment f ";
		sql = sql+" WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
		sql = sql+" AND a.INT_DIVIID = c.INT_DIVIID ";
		sql = sql+" AND a.INT_BRANCHID = d.INT_BRANCHID ";
		sql = sql+" AND a.CHR_SALESNO = f.CHR_SALESNO ";
		sql = sql+" AND a.DAT_SALESDATE >= '"+fdt+"'";
		sql = sql+" AND a.DAT_SALESDATE <= '"+tdt+"'";
		 if(!"0".equals(Branch))
			sql = sql+" AND a.INT_BRANCHID ="+Branch;
		if(!"0".equals(division))
			sql = sql+"  AND a.INT_DIVIID="+division+" ";
		sql = sql+" ORDER BY a.DAT_SALESDATE ";

		
		 
		 
	}
	else if("DirectBilling".equals(Direct))
	{
		mode = "DIRECT BILLING ";
		 
	}
	else if("ServiceBilling".equals(Direct))
	{
	
		mode = "SERVICE BILLING";
		sql ="SELECT a.CHR_SALESNO, date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),c.CHR_DIVICODE, ";
		sql = sql+" d.CHR_BRANCHNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF), ";
		sql = sql+" a.DOU_AMOUNT,a.DOU_SERVICE_AMOUNT,a.DOU_NETAMOUNT,a.CHR_NOOFPAYMENTCOMMITMENT, ";
		sql = sql+"(SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment e WHERE e.CHR_SALESORDERNO = a.CHR_SALESNO ), ";
		sql = sql+" date_format(f.DT_COMMITMENTDATE,'%d-%b-%Y'),f.DOU_COMMITMENTAMOUNT, ";
		sql = sql+" f.DOU_ACTUALAMOUNT, date_format(f.DT_RECIEVEDDATE,'%d-%b-%Y'),f.DOU_RECEIVEDAMOUNT , ";
		sql = sql+" if(f.DT_RECIEVEDDATE <= f.DT_COMMITMENTDATE ,'Honoured', 'Not Honoured') ";
		sql = sql+" FROM inv_t_servicebilling a, inv_m_customerinfo b, inv_m_division c, ";
		sql = sql+" com_m_branch d  , inv_t_paymentcommitment f ";
		sql = sql+" WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
		sql = sql+" AND a.INT_DIVIID = c.INT_DIVIID ";
		sql = sql+" AND a.INT_BRANCHID = d.INT_BRANCHID ";
		sql = sql+" AND a.CHR_SALESNO = f.CHR_SALESNO ";
		sql = sql+" AND a.DAT_SALESDATE >= '"+fdt+"'";
		sql = sql+" AND a.DAT_SALESDATE <= '"+tdt+"'";
		 if(!"0".equals(Branch))
			sql = sql+" AND a.INT_BRANCHID ="+Branch;
		if(!"0".equals(division))
			sql = sql+"  AND a.INT_DIVIID="+division+" ";
		sql = sql+" ORDER BY a.DAT_SALESDATE ";

		
		 
	}
	
	String reportheader="PAYMENY HONOURED COLLECTION FOR  "+mode+"   [ FROM -"+fromdate +"  TO-  "+ todate +" ] "; 
	Vector mn = new Vector();
	Vector child= null; 
	 
	String data[][] = CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
		for(int u=0;u<data.length;u++)
		{
			
			child = new Vector();
			child.addElement((u+1));
			child.addElement(mode);
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
			child.addElement(data[u][13]);
			child.addElement(data[u][14]);
			child.addElement(data[u][15]);
			child.addElement(data[u][16]);
			mn.add(child);
		}
	}
		 
request.setAttribute("table",mn);
out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVOICE Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="INVOICE NUMBER" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="INVOICE DATE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="CUSTOMER" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="BILLED BY" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="AMOUNT" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="TAX AMOUNT" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="NET AMOUNT" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="NO OF COMMITMENT" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="PAID AMOUNT" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="COMMITMENT DATE" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="COMMITMENT AMOUNT" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="INVOICE AMOUNT" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="RECEIVED AMOUNT" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="RECEIVED DATE" sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="STATUS" sortable="true"><%=temp.elementAt(18)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_PaymentHonouredCollection.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_PaymentHonouredCollection.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_PaymentHonouredCollection.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					
					
					 
					 
</display:table>     
<br />	<center>	<a href='Rept_PaymentHonouredCollection.jsp'> CLOSE</a>
</center><br /><br />


 
<%		 		 
			}
			catch(Exception e)
			{
			}	
	  %>
	  
 </body>
</html>

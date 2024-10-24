<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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
<title>:: INVENTORY ::</title>

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
  
   
</head>

<%
try
{
 		String sql ="";
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String Branch = request.getParameter("Branch");
		String title="";
		 
		sql = "SELECT a.CHR_POREQUESTNO,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),e.CHR_VENDORNAME,b.CHR_BRANCHNAME,c.CHR_DIVICODE, ";
		sql = sql +" DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
		sql = sql +" DATE_FORMAT(a.DAT_PURCHASEDATE,'%d-%b-%Y'), ";
		sql = sql +" DATE_FORMAT(a.DAT_COMMITMENTDATE,'%d-%b-%Y'), ";
		sql = sql +" datediff(a.DAT_COMMITMENTDATE,a.DAT_PURCHASEDATE), ";
		sql = sql +" ( SELECT SUM(f.DOU_PURCHASEPRICE) FROM inv_t_purchaserequestitem f,inv_t_purchaserequestitem g WHERE f.CHR_POREQUESTNO =a.CHR_POREQUESTNO AND f.CHR_ACCEPT='Y' GROUP BY f.CHR_POREQUESTNO) ";
		
		sql = sql +" FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d, inv_m_vendorsinformation  e,inv_t_purchaserequestitem g  ";
		sql = sql +" WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
		sql = sql +" AND a.INT_DIVIID = c.INT_DIVIID ";
		sql = sql +" AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
		sql = sql +" AND e.INT_VENDORID = g.INT_VENDORID ";
		sql = sql +" AND a.CHR_CLOSEDSTATUS='Y'  ";
		sql = sql +" AND a.DAT_COMMITMENTDATE >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"'";	
		sql = sql +" AND a.DAT_COMMITMENTDATE <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"'";	
		 
		String reportheader=" PAYMENT COMMITMENT "+title+" ( FROM "+fromdate+" ) - (  TO "+todate+" ) REPORT "; 
		String data[][] =  CommonFunctions.QueryExecute(sql);
  		Vector mn = new Vector();
	 	Vector child= null;
		
		
  		if(data.length>0)
		{
			
			double sum1 = 0.0;
			 
			
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
				 
				mn.add(child);	
					
				
				sum1 = sum1+Double.parseDouble(data[u][9]);
			 
					
			}
			
				child = new Vector(); 
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("TOTAL : ");
				child.addElement(sum1);
				mn.add(child);	
				 
     			
				 
			
		}
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
 %>
 
 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Invoice No" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Customer" sortable="true" ><%=temp.elementAt(2)%></display:column>
					<display:column title="Vendor" sortable="true" ><%=temp.elementAt(3)%></display:column>
					<display:column title="Branch" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="Division" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Request Date" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Proposed Purchase Date" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="Commitment Date" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="Day Difference" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title="Amount" sortable="true" style="text-align:right"><%=temp.elementAt(10)%></display:column>
					<display:setProperty name="export.excel.filename" value="Rept_PaymentCommitmentDatewise.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_PaymentCommitmentDatewise.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_PaymentCommitmentDatewise.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

<br />	<center>	<a href= 'InventoryMains.jsp'> CLOSE</a></center>

<br /><br />
 
	 		
 <%
		 
		 
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 
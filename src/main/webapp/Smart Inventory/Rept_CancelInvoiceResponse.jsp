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
 <title>:: INVENTORY ::</title>

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
 		String reportheader="CANCELLED INVOICE"; 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String customer = request.getParameter("customer");
		String ref = request.getParameter("ref");
		String delivery = request.getParameter("delivery");
		String saleDate = request.getParameter("saleDate");
		String saleDate2  = request.getParameter("saleDate2");
		saleDate = DateUtil.FormateDateSQL(saleDate);
		saleDate2 = DateUtil.FormateDateSQL(saleDate2);
		String invoice  = request.getParameter("invoice");	
		String sql ="";
		Vector mn = new Vector();
		Vector child= null;
		
		//CUSTOMER SALES
		if("0".equals(invoice) || "C".equals(invoice))
		{
			sql = " SELECT d.CHR_BRANCHNAME,c.CHR_PROJECTNAME,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ,  ";
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  ";
			sql = sql + " a.DOU_CANCELAMOUNT,if(a.CHR_CANCEL='Y','CANCELLED',''),a.CHR_CANCELDESC  ";
			sql = sql + " FROM  inv_t_directsales a , inv_t_paymentcommitment b, inv_m_project c , com_m_branch d ";
			sql = sql + " WHERE   a.CHR_SALESNO = b.CHR_SALESNO AND a.INT_PROJECTID= c.INT_PROJECTID  AND a.CHR_CANCEL ='Y'  ";
			sql = sql + " AND a.INT_BRANCHID =d.INT_BRANCHID  ";
			sql = sql + " AND a.DAT_SALESDATE >='"+saleDate+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+saleDate2+"' ";
			if(!"0".equals(Branch)) 
				sql = sql + " AND a.INT_BRANCHID="+Branch;
			if(!"0".equals(division)) 
				sql = sql + " AND  a.INT_DIVIID="+division;
			if(!"0".equals(customer)) 
				sql = sql + " AND  a.INT_CUSTOMERID="+customer;
			if(!"0".equals(ref)) 
				sql = sql + " AND  a.CHR_REF='"+ref+"' ";
			
			sql = sql + " ORDER BY a.DAT_SALESDATE  ";
			
			
			String data[][] =  CommonFunctions.QueryExecute(sql);
					
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					child = new Vector();
					child.addElement((u+1));
					child.addElement(data[u][0]);
					child.addElement("CUSTOMER SALES");
					child.addElement(data[u][1]);
					child.addElement(data[u][2]);
					child.addElement(data[u][3]);
					child.addElement(data[u][4]);
					child.addElement(data[u][5]);
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					mn.add(child); 
				}
			} 
		}
		
		//SERVICE BILLING
		if("0".equals(invoice) || "C".equals(invoice))
		{
			sql = " SELECT d.CHR_BRANCHNAME,c.CHR_PROJECTNAME,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ,  ";
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  ";
			sql = sql + " a.DOU_CANCELAMOUNT,if(a.CHR_CANCEL='Y','CANCELLED',''),a.CHR_CANCELDESC  ";
			sql = sql + " FROM  inv_t_servicebilling a , inv_t_paymentcommitment b, inv_m_project c , com_m_branch d ";
			sql = sql + " WHERE   a.CHR_SALESNO = b.CHR_SALESNO AND a.INT_PROJECTID= c.INT_PROJECTID  AND a.CHR_CANCEL ='Y'  ";
			sql = sql + " AND a.INT_BRANCHID =d.INT_BRANCHID  ";
			sql = sql + " AND a.DAT_SALESDATE >='"+saleDate+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+saleDate2+"' ";
			if(!"0".equals(Branch)) 
				sql = sql + " AND a.INT_BRANCHID="+Branch;
			if(!"0".equals(division)) 
				sql = sql + " AND  a.INT_DIVIID="+division;
			if(!"0".equals(customer)) 
				sql = sql + " AND  a.INT_CUSTOMERID="+customer;
			if(!"0".equals(ref)) 
				sql = sql + " AND  a.CHR_REF='"+ref+"' ";
			sql = sql + " ORDER BY a.DAT_SALESDATE  ";
			String data[][] =  CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					child = new Vector();
					child.addElement((u+1));
					child.addElement(data[u][0]);
					child.addElement("SERVICE BILLING");
					child.addElement(data[u][1]);
					child.addElement(data[u][2]);
					child.addElement(data[u][3]);
					child.addElement(data[u][4]);
					child.addElement(data[u][5]);
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					mn.add(child); 
				}
			} 
		}
		
		
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
                    <display:column title="BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
                    <display:column title="INVOICE TYPE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="PROJECT"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="INVOICE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="M.E."   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="AMOUNT"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="CANCEL"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(10)%></display:column>
                    <display:setProperty name="export.excel.filename" value="Rept_cancelinvoice.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_cancelinvoice.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_cancelinvoice.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


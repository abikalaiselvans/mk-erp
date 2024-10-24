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
 		String reportheader="EMD TYPE "; 
		String sql ="";
		String Branch=request.getParameter("Branch");
		String division = ""+request.getParameter("division");
		String customer=request.getParameter("customer");
		String ref = ""+request.getParameter("ref");
		String type=request.getParameter("EmdType");
		String fromdate = ""+request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		sql = " SELECT   if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',  ";
		sql = sql+ " if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),  ";
		sql = sql+ " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,  ";
		sql = sql+ " DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),  ";
		sql = sql+ " d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  ";
		sql = sql+ " if(a.CHR_APPROVAL='Y','Approved',if(a.CHR_APPROVAL='R','Reject','Pending')) ,  ";
		sql = sql+ " if(a.CHR_STATUS='Y','Returned','Not Returned')  ";
		sql = sql+ " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d   ";
		sql = sql+ " WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
		sql = sql+ " AND  a.CHR_REF =c.CHR_EMPID  ";
		 
		if(!"0".equals(Branch))
			sql = sql + " AND a.INV_BRANCHID = "+Branch;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID = "+division;
		if(!"0".equals(customer))
			sql = sql + " AND a.INT_CUSTOMERID = "+customer;
		if(!"0".equals(type))
			sql = sql + " AND a.INT_EMD_TYPE = '"+type+"' ";
		if(!"0".equals(ref))
			sql = sql + " AND a.CHR_REF = '"+ref+"' ";	
		sql = sql + " AND a.DAT_TENDER_LASTDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
		sql = sql + " AND a.DAT_TENDER_LASTDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
		sql = sql + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID )   ";
		 
		String data[][] = CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1)+".");
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				 
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMD TYPE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="CUSTOME"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="AMOUNT"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="TENDER LAST DATE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="REFERENCE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="APPROVAL"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="STATUS"   sortable="true"><%=temp.elementAt(8)%></display:column>
					    
					<display:setProperty name="export.excel.filename" value="Rept_Tallyexport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tallyexport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tallyexport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_EMD.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


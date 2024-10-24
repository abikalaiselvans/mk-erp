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
 		String reportheader="DEPOSIT TYPE "; 
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
		
		sql =  " SELECT   a.CHR_EMD_REFNUMBER,IF(a.INT_EMD_TYPE='E' ,'Earnest money deposit',if(a.INT_EMD_TYPE='B','Bank guarantee','Security deposit')),  ";
		sql = sql+ " b.CHR_DIVICODE,a.CHR_TENDERNO,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),  ";
		sql = sql+ " DATE_FORMAT(a.DAT_TENDER_TIMELINE,'%d-%b-%Y'),FIND_A_CUSTOMER_ADDRESS(a.INT_CUSTOMERID),  ";
		sql = sql+ " a.DOU_EMD_AMOUNT,a.CHR_EMD_INFAVOUROF,a.CHR_PAYABLE_AT,a.DOU_ORDERVALUE,  ";
		sql = sql+ " FIND_A_EMPLOYEE_ID_NAME(CHR_REF),c.CHR_BANKGROUPNAME,a.CHR_DD_NUMBER,  ";
		sql = sql+ " a.CHR_TENDER_DESC,a.DAT_DATEOFDD,a.CHR_OTHERDEC,  ";
		sql = sql+ " if(a.CHR_APPROVAL='Y','Approved','Pending'),  ";
		sql = sql+ " if(a.CHR_STATUS='Y','Returned','Not Return')  ";
		sql = sql+ " FROM inv_t_emd_informations a, inv_m_division b,com_m_bankgroup c  ";
		sql = sql+ " WHERE a.INT_DIVIID =b.INT_DIVIID  ";
		sql = sql+ " AND a.INT_BANKGROUPID = c.INT_BANKGROUPID  ";
		 
		if(!"0".equals(Branch))
			sql = sql + " AND a.INV_BRANCHID = "+Branch;
		if(!"0".equals(division))
			sql = sql + " AND a.INT_DIVIID = "+division;
		if(!"0".equals(customer))
			sql = sql + " AND a.INT_CUSTOMERID = "+customer;
		if(!"0".equals(type))
			sql = sql + " AND a.INT_EMD_TYPE = '"+type+"' ";
		sql = sql + " AND a.CHR_REF = '"+session.getAttribute("EMPID")+"' ";	
		sql = sql + " AND a.DAT_TENDER_LASTDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
		sql = sql + " AND a.DAT_TENDER_LASTDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
		sql = sql + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID )   ";
		//out.println(sql);
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
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				child.addElement(data[u][16]);
				child.addElement(data[u][17]);
				child.addElement(data[u][18]);
				 
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="EMD NUMBER"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="EMD TYPE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="TENDER NUMBER"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="TENDER LAST DATE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="TENDER TIME LINE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="CUSTOMER"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="EMD AMOUNT"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="EMD FAVOUR OF"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="PAYABLE AT"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="ORDER VALUE"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="ENTRY BY"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="BANK"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="CHEQUE /DD NUMBER"   sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="DESCRIPTION"   sortable="true"><%=temp.elementAt(15)%></display:column>
					
					<display:column title="APPROVAL"   sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="STATUS"   sortable="true"><%=temp.elementAt(19)%></display:column>
					    
					<display:setProperty name="export.excel.filename" value="Myemd_reports.xls"/>
					<display:setProperty name="export.pdf.filename" value="Myemd_reports.pdf"/>
					<display:setProperty name="export.csv.filename" value="Myemd_reports.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Myemd_reports.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


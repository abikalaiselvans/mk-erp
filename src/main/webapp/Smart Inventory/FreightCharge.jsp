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
 		String reportheader="Freight Charge"; 
		String frmdate = request.getParameter("frmdate");
		String todate = request.getParameter("todate");
		String Branch = request.getParameter("branch");
		String division = request.getParameter("division");
		String vendor = request.getParameter("vendor");
		
		String sql ="";
		sql = sql + " SELECT FUN_GET_BRANCH_NAME(INT_BRANCHID), FUN_INV_DIVISION(INT_DIVIID), CHR_PURCHASEORDERNO,  ";
		sql = sql + " FIND_A_VENDOR_NAME(INT_VENDORID),DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(CHR_REF), ";
		sql = sql + " DOU_AMOUNT,DOU_TAXAMOUNT,DOU_FRIEGHT_CHARGE,DOU_TOTALAMOUNT, DOU_FRIEGHT_CHARGE_BASE_AMOUNT,DOU_FRIEGHT_CHARGE_PERCENT, DOU_FRIEGHT_CHARGE  ";
		sql = sql + " FROM inv_t_directpurchase ";
		sql = sql + " WHERE CHR_PURCHASEORDERNO IS NOT NULL ";
		if(!"0".equals(Branch))
			sql = sql + " AND INT_BRANCHID = "+Branch;
		if(!"0".equals(division))
			sql = sql + " AND INT_DIVIID = "+division;
		if(!"0".equals(vendor))
			sql = sql + " AND INT_VENDORID = "+vendor;
		
		sql =sql + " AND DAT_ORDERDATE >= '"+DateUtil.FormateDateSQL(frmdate)+"'";
		sql =sql + " AND DAT_ORDERDATE <= '"+DateUtil.FormateDateSQL(todate)+"'";
		
			
			
		
		sql = sql + " ORDER BY DAT_ORDERDATE ";
		System.out.println(sql);
		Vector mn = new Vector();
	 	Vector child= null;
		String data[][] = CommonFunctions.QueryExecute(sql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));//s.no
				child.addElement(data[u][0]);//branch
				child.addElement(data[u][1]);//division
				child.addElement(data[u][2]);//ref number
				child.addElement("<a target='_blank' href='DirectGoodsReceiveViewList.jsp?gdreceiveno="+data[u][2]+"'>Details</a>");//details
				child.addElement(data[u][3]);//vendor
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="INWARD REF NUMBER"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Details" media='html' sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="VENDOR"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="M.E"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="AMOUNT" style="text-align:right" sortable="true"><%=temp.elementAt(8)%></display:column>
					<%-- <display:column title="TAX AMOUNT" style="text-align:right" sortable="true"><%=temp.elementAt(9)%></display:column>
					 --%><display:column title="FRIEGHT BASE" style="text-align:right" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="FRIEGHT TAX" style="text-align:right" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="FRIEGHT AMOUNT" style="text-align:right" sortable="true"><%=temp.elementAt(12)%></display:column>
					 <display:column title="NET AMOUNT" style="text-align:right" sortable="true"><%=temp.elementAt(13)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="FreightCharge.xls"/>
					<display:setProperty name="export.pdf.filename" value="FreightCharge.pdf"/>
					<display:setProperty name="export.csv.filename" value="FreightCharge.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a  href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


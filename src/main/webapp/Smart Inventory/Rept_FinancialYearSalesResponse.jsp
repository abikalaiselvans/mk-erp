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
 		String reportheader=" CUMULATIVE SALES "; 
		String Branch = request.getParameter("Branch");
		String  division= request.getParameter("division");
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String link = "Branch="+Branch+"&division="+division+"&type="+type+"&year="+year;
		String sql ="SELECT '-','0','0','0'  ";
		
		Vector mn = new Vector();
	 	Vector child= null;
		 
		
		if("1".equals(type))
		{
			sql = "   SELECT CONCAT('DIRECT SALES'),  CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ";
			sql = sql + " SUM(DOU_AMOUNT),SUM(DOU_TAXAMOUNT), SUM( a.DOU_TOTALAMOUNT ) amount  ";
			sql = sql + " FROM inv_t_directsales a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE  ";
	 	}
		else if("2".equals(type) )
		{
		 	sql = "  SELECT  CONCAT('SERVICE'), CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ";
			sql = sql + " SUM(DOU_AMOUNT) ,SUM(DOU_SERVICE_AMOUNT+CHR_TAXAMOUNT), SUM( a.DOU_NETAMOUNT ) amount  ";
			sql = sql + " FROM inv_t_servicebilling a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE   ";
			
		}
		else if ("0".equals(type))
		{
			
			sql = " (  SELECT CONCAT('DIRECT SALES'),  CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ";
			sql = sql + " SUM(DOU_AMOUNT),SUM(DOU_TAXAMOUNT), SUM( a.DOU_TOTALAMOUNT ) amount  ";
			sql = sql + " FROM inv_t_directsales a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ) ";
			
			sql = sql + " UNION ";
			sql = sql + "( SELECT  CONCAT('SERVICE'), CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ";
			sql = sql + " SUM(DOU_AMOUNT) ,SUM(DOU_SERVICE_AMOUNT+CHR_TAXAMOUNT), SUM( a.DOU_NETAMOUNT ) amount  ";
			sql = sql + " FROM inv_t_servicebilling a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE  )";
			
		}
		
		//out.println(sql);
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			double sum=0.0;	
			double sum1=0.0;	
			double sum2=0.0;
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]); 
				sum = sum+Double.parseDouble(data[u][2]);
				sum1 = sum1+Double.parseDouble(data[u][3]);
				sum2 = sum2+Double.parseDouble(data[u][4]);
				mn.add(child); 
			}
				child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("Total : ");
				child.addElement(sum);
				child.addElement(sum1);
				child.addElement(sum2);
				mn.add(child); 
		} 
			
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="MONTH "   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Tax AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="NET AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(5)%></display:column>
					
					<display:setProperty name="export.excel.filename" value="Rept_FinancialYearSales.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_FinancialYearSales.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_FinancialYearSales.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_DailySales.jsp'> CLOSE</a></center>
<br />	<center>	<a style="text-align:right" target="_blank" href='../SmartLoginAuth?filename=PDFFinancialPie&actionS=INVFinancialYearPieChart&<%=link%>'> 3D - Bar Chart</a></center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>


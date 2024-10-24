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
		String fate = request.getParameter("saleDate");
		String tdate = request.getParameter("saleDate2");
		String split = request.getParameter("split");
		
		String sql ="SELECT 'BRANCH','DIVISION','0','0','0','0','0','0 '  ";
		if("1".equals(type) )
		{
			sql = " SELECT FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,FUN_INV_DIVISION(a.INT_DIVIID) division, ";
			sql = sql + " COUNT(*) noofinvoice,  ";
			sql = sql + "  SUM(DOU_AMOUNT),SUM(DOU_TAXAMOUNT),  SUM(  a.DOU_TOTALAMOUNT  ) amount, ";
			if("Y".equals(split))
				sql = sql + "MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			else	
				sql = sql + "CONCAT('-') ,CONCAT('-')  ";
				
			sql = sql + "  FROM   inv_t_directsales a  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(tdate)+"'  ";
			
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
				
			sql = sql + " 	GROUP BY a.INT_BRANCHID ,a.INT_DIVIID   ";	
			if("Y".equals(split))
				sql = sql + "  ,MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql + "  order by a.INT_BRANCHID ,a.INT_DIVIID  ";
			
			
		}
		else if("2".equals(type))
		{
		
			sql =  "  SELECT  FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,FUN_INV_DIVISION(a.INT_DIVIID) division,   ";
			sql = sql + " COUNT(*) noofinvoice,  ";
			sql = sql + "  SUM(DOU_AMOUNT),SUM(DOU_SERVICE_AMOUNT ), ";
			sql = sql + "  SUM(  a.DOU_NETAMOUNT  ) amount ,";
			if("Y".equals(split))
				sql = sql + "MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			else	
				sql = sql + "CONCAT('-') ,CONCAT('-')  ";
			sql = sql + "  FROM   inv_t_servicebilling a  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1";
			sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(tdate)+"'  ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " 	GROUP BY a.INT_BRANCHID ,a.INT_DIVIID   ";	
			if("Y".equals(split))
				sql = sql + "  ,MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql + "  order by a.INT_BRANCHID ,a.INT_DIVIID  ";

		}
		else if("0".equals(type))
		{
		
		
			sql = "( SELECT FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,FUN_INV_DIVISION(a.INT_DIVIID) division, ";
			sql = sql + " COUNT(*) noofinvoice,  ";
			sql = sql + "  SUM(DOU_AMOUNT),SUM(DOU_TAXAMOUNT),  SUM(  a.DOU_TOTALAMOUNT  ) amount, ";
			if("Y".equals(split))
				sql = sql + "MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			else	
				sql = sql + "CONCAT('-') ,CONCAT('-')  ";
				
			sql = sql + "  FROM   inv_t_directsales a  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(tdate)+"'  ";
			
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
				
			sql = sql + " 	GROUP BY a.INT_BRANCHID ,a.INT_DIVIID   ";	
			if("Y".equals(split))
				sql = sql + "  ,MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql + "  order by a.INT_BRANCHID ,a.INT_DIVIID  )";
			
			sql = sql + " UNION ";
			sql = sql + " ( SELECT  FUN_GET_BRANCH_NAME(a.INT_BRANCHID) branch,FUN_INV_DIVISION(a.INT_DIVIID) division,   ";
			sql = sql + " COUNT(*) noofinvoice,  ";
			sql = sql + "  SUM(DOU_AMOUNT),SUM(DOU_SERVICE_AMOUNT ), ";
			sql = sql + "  SUM(  a.DOU_NETAMOUNT  ) amount ,";
			if("Y".equals(split))
				sql = sql + "MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			else	
				sql = sql + "CONCAT('-') ,CONCAT('-')  ";
			sql = sql + "  FROM   inv_t_servicebilling a  WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1";
			sql = sql + " AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(tdate)+"'  ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " 	GROUP BY a.INT_BRANCHID ,a.INT_DIVIID   ";	
			if("Y".equals(split))
				sql = sql + "  ,MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)  ";
			sql = sql + "  order by a.INT_BRANCHID ,a.INT_DIVIID  ) ";

		}
		
		//out.println(sql);
 		String data[][] =  CommonFunctions.QueryExecute(sql);
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		
			
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
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				sum = sum+Double.parseDouble(data[u][3]);
				sum1 = sum1+Double.parseDouble(data[u][4]);
				sum2 = sum2+Double.parseDouble(data[u][5]);
				mn.add(child); 
			}
				child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("Total : ");
				child.addElement("");
				child.addElement(sum);
				child.addElement(sum1);
				child.addElement(sum2);
				child.addElement("");
				child.addElement("");
				mn.add(child); 
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DIVISION"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="NOS"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="MONTH "   sortable="true"><%=temp.elementAt(7)%></display:column> 
					<display:column title="YEAR "   sortable="true"><%=temp.elementAt(8)%></display:column> 
					<display:column title="NET AMOUNT"   sortable="true"><%=temp.elementAt(6)%></display:column>
					
					
					<display:setProperty name="export.excel.filename" value="Rept_CumulativeSales.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_CumulativeSales.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_CumulativeSales.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>


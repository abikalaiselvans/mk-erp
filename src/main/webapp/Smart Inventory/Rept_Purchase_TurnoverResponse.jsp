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
 		
		//String Branch = request.getParameter("Branch");
		//String  division= request.getParameter("division");
		String quarter = request.getParameter("quarter");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String reportheader="PURCHASE TURN OVER FOR "+fyear+" - "+(fyear+1) ; 
		String sql ="";
		
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		
		
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='April'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			String adata[][] =  CommonFunctions.QueryExecute(sql);
			 
			child = new Vector();
			child.addElement("APRIL");
			if(adata.length>0)
				child.addElement(adata[0][0]);
			else
				child.addElement("0");
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
			
		
		
		 
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='May'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String mdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 child = new Vector();
			
			child.addElement("MAY");
			if(mdata.length>0)
				child.addElement(mdata[0][0]);
			else
				child.addElement("0");
			child.addElement("Details"); 
			child.addElement("");
			mn.add(child);
		}
			 
					
		if("1".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='June'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String junedata[][] =  CommonFunctions.QueryExecute(sql);
			
			child = new Vector();
			
			child.addElement("JUNE");
			if(junedata.length>0)
				child.addElement(junedata[0][0]);
			else
				child.addElement("0");
			 child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		
		
		if("2".equals(quarter) || "0".equals(quarter))
		{
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='July'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Julydata[][] =  CommonFunctions.QueryExecute(sql);
			
			 child = new Vector();
			
			child.addElement("JULY");
			if(Julydata.length>0)
				child.addElement(Julydata[0][0]);
			else
				child.addElement("0");
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		if("2".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='August'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Augustdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 child = new Vector();
			
			child.addElement("AUGUST");
			if(Augustdata.length>0)
				child.addElement(Augustdata[0][0]);
			else
				child.addElement("0");
			child.addElement("Details"); 
			child.addElement("");
			mn.add(child);
		}				
		
		if("2".equals(quarter) || "0".equals(quarter))
		{
			
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='September'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Septemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("September");
			if(Septemberdata.length>0)
				child.addElement(Septemberdata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		
					
		if("3".equals(quarter) || "0".equals(quarter))
		{	
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='October'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Octoberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("October");
			if(Octoberdata.length>0)
				child.addElement(Octoberdata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		if("3".equals(quarter) || "0".equals(quarter))
		{			 
			
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='November'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Novemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("November");
			if(Novemberdata.length>0)
				child.addElement(Novemberdata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		if("3".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='December'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+fyear;
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Decemberdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("December");
			if(Decemberdata.length>0)
				child.addElement(Decemberdata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		if("4".equals(quarter) || "0".equals(quarter))
		{			
			 
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='January'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Januarydata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("January");
			if(Januarydata.length>0)
				child.addElement(Januarydata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
			
		}
					
		if("4".equals(quarter) || "0".equals(quarter))
		{			
		
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='February'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
		 
			String Februarydata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("February");
			if(Februarydata.length>0)
				child.addElement(Februarydata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child);
		}
		
		if("4".equals(quarter) || "0".equals(quarter))
		{			
			sql ="";
			sql = sql +" SELECT 	SUM(b.DOU_TOTAL)/100000   "; 
			sql = sql +" FROM inv_t_directpurchase a , inv_t_directpurchaseitem b  ";
			sql = sql +" WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO AND a.CHR_CANCEL='N' AND a.CHR_FLAG='Y'    "; 
			sql = sql +" AND  MONTHNAME(a.DAT_ORDERDATE) ='March'   ";
			sql = sql +" AND  YEAR(a.DAT_ORDERDATE) = "+(fyear+1);
			sql = sql +" GROUP BY MONTH(a.DAT_ORDERDATE),YEAR(a.DAT_ORDERDATE)  ";  
			sql = sql +" order by a.INT_BRANCHID , a.DAT_ORDERDATE    ";
			 
			String Marchdata[][] =  CommonFunctions.QueryExecute(sql);
			
			 
			child = new Vector();
			
			child.addElement("March");
			if(Marchdata.length>0)
				child.addElement(Marchdata[0][0]);
			else
				child.addElement("0");
			 
			child.addElement("Details");
			child.addElement("");
			mn.add(child); 
		}
			 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25"  style="text-align:center" >
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="MONTH" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="DIRECT PURCHASE (Rs. In Lacs)"  style="text-align:right"    sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DETAILS"  media='html' sortable="true"><%=temp.elementAt(2)%></display:column>
					  
					<display:setProperty name="export.excel.filename" value="Rept_Purchase_Turnover.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Purchase_Turnover.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Purchase_Turnover.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a style="text-align:right" href='Rept_Purchase_Turnover.jsp'> CLOSE</a></center>
  <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>


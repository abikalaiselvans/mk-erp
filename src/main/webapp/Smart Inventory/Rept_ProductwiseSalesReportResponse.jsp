 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>


<meta http-equiv="refresh" content="300"/>
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
		 
		String branchid = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String pgroup = request.getParameter("pgroup");
		String item = request.getParameter("item");
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		fromdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
		todate= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
		String sql ="";
		String reportheader="";
		
		if(!"0".equals(branchid))
		{
			String cpydata[][]= CommonFunctions.QueryExecute("SELECT b.CHR_COMPANYNAME ,a.CHR_BRANCHNAME FROM com_m_branch a,com_m_company b WHERE a.INT_COMPANYID=b.INT_COMPANYID AND a.INT_BRANCHID="+branchid);
		 	reportheader="CUSTOMER WISE PRODUCT SALE REPORT  FOR "+cpydata[0][0].toUpperCase()+" @ "+cpydata[0][1].toUpperCase()+" FROM  "+fromdate+"- TO "+todate ; 
		}
		else
			reportheader="CUSTOMER WISE PRODUCT SALE REPORT  FROM  "+fromdate+"- TO "+todate ; 
		Vector mn = new Vector();
	    Vector child= null;
		
		if("1".equals(itype))
		{
			 
			
			 
			int row=0;
			sql = "";
			sql = " SELECT  f.CHR_GROUPNAME,c.CHR_ITEMNAME,c.CHR_DES,d.CHR_DIVICODE,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_GET_CUSTOMER_ADDRESS(a.INT_CUSTOMERID,'\n'), b.INT_QUANTITY, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql +" b.DOU_UNITPRICE,b.DOU_TOTAL,a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT ";
			sql = sql +" from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_item c,inv_m_division d,inv_m_customerinfo e,inv_m_itemgroup f ";
			sql = sql +" WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='I'  AND a.INT_SALESSTATUS=1 ";
			sql = sql +" AND b.CHR_ITEMID =c.CHR_ITEMID   "; 
			sql = sql +" AND a.INT_DIVIID= d.INT_DIVIID  ";
			sql = sql +" AND a.INT_CUSTOMERID = e.INT_CUSTOMERID ";
			sql = sql +" AND c.INT_ITEMGROUPID = f.INT_ITEMGROUPID ";
			if(!"0".equals(item))
				sql = sql +" AND b.CHR_ITEMID=   '"+item+"' ";
			if(!"0".equals(pgroup))
				sql = sql +" AND c.INT_ITEMGROUPID =  "+pgroup ;
			
			if(!"0".equals(division))
				sql = sql +" AND a.INT_DIVIID= "+division ;	
			if(!"0".equals(branchid))
				sql = sql +" AND a.INT_BRANCHID=   "+branchid;
			
			sql = sql +" AND a.DAT_SALESDATE >='"+fromdate+"' AND a.DAT_SALESDATE <='"+todate+"'  ";
			sql = sql +" ORDER BY b.CHR_ITEMID  ";
			 
			String data[][] =  CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					 
					row=row+1;
					child = new Vector();
					child.addElement(row);
					child.addElement("ITEM");
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
					mn.add(child);
					 
					}
	
				 
			}
			 
		}
			
		
		if("2".equals(itype))
		{ 
		    int row=0;
			sql = "";
			sql = " SELECT  f.CHR_NAME,c.CHR_PRODUCTCODE,c.CHR_PRODUCTDESC,d.CHR_DIVICODE,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_GET_CUSTOMER_ADDRESS(a.INT_CUSTOMERID,'\n'), b.INT_QUANTITY, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			sql = sql +" b.DOU_UNITPRICE,b.DOU_TOTAL,a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT ";
			sql = sql +" from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_produtlist c,inv_m_division d,inv_m_customerinfo e,inv_m_productgroup f";
			sql = sql +" WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='P' AND a.INT_SALESSTATUS=1  ";
			sql = sql +" AND b.CHR_ITEMID =c.CHR_PRODUCTID  ";
			sql = sql +" AND a.INT_DIVIID= d.INT_DIVIID  ";
			sql = sql +" AND a.INT_CUSTOMERID = e.INT_CUSTOMERID ";
			sql = sql +" AND c.INT_PRODUCTGROUPID = f.INT_PRODUCTGROUPID ";
			if(!"0".equals(item))
				sql = sql +" AND b.CHR_ITEMID=   '"+item+"' ";
			if(!"0".equals(pgroup))
				sql = sql +" AND c.INT_PRODUCTGROUPID =  "+pgroup ;
			
			if(!"0".equals(branchid))
				sql = sql +" AND a.INT_BRANCHID=   "+branchid;
			if(!"0".equals(division))
				sql = sql +" AND a.INT_DIVIID= "+division ;	
			sql = sql +" AND a.DAT_SALESDATE >='"+fromdate+"' AND a.DAT_SALESDATE <='"+todate+"'  ";
			sql = sql +" ORDER BY b.CHR_ITEMID  ";
			//out.println(sql);
			String data[][] =  CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				for(int u=0;u<data.length;u++)
				{
					 
					row=row+1;
					 
					child = new Vector();
					child.addElement(row);
					child.addElement("PRODUCT");
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
					mn.add(child);
					
					 
					}
	
				 
			}
			 
		}
		
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 
  

%>


<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="TYPE" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="ITEM GROUP" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="ITEM NAME" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="DESCRIPTION" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="DIVISION" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="SALES NUMBER" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="CUSTOMER NAME" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="CUSTOMER ADDRESS" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="QUANTITY" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="SALE DATE" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="UNIT PRICE" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="AMOUNT" sortable="true"><%=temp.elementAt(12)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_ProductwiseSalesReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_ProductwiseSalesReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_ProductwiseSalesReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a></center><br /><br />


 
<%	 		
					
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
	  	
  %>
 </body>
</html>

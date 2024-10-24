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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return,purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
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
 		String reportheader="SALES REPORT "; 
		String sql ="";
		String Branch=request.getParameter("Branch");
		String division = ""+request.getParameter("division");
		String type=request.getParameter("type");
		String fromdate = ""+request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		String invoicetype = request.getParameter("invoicetype");
		String serial = request.getParameter("serial");
		Vector mn = new Vector();
	 	Vector child= null;
		String empid [] = CommonFunctions.getReportingEmployeeIds(""+session.getAttribute("EMPID"));
		String empids ="'"+session.getAttribute("EMPID")+"', ";
		if(empid.length>0)
			for(int i=0;i<empid.length;i++)
				empids = empids +" '"+empid[i]+"' , ";
				
		if(("1".equals(type)) || ("0".equals(type) ))
		{
			
			
			sql = sql + "(SELECT  a.CHR_SALESNO InvNumber, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') InvDate, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) NameoftheCustomer,  e.CHR_GSTNO  CustomerGSTNo,  ";
			sql = sql + " j.CHR_MODELCODE Brand ,  b1.CHR_GROUPNAME ProductGroup, c.CHR_DES PCODEDESCRIPTION ,   ";
			sql = sql + " FUN_INV_GET_WARRANTY_IN_YEAR(b.INT_WARRANTY) Warranty, c.CHR_HSNCODE HSNorSAC,   FUN_INV_GET_SALES_SERIALNUMBER_CONCATS( b.CHR_TYPE,b.CHR_ITEMID,a.CHR_SALESNO) SlNos, ";
			sql = sql + "B.INT_QUANTITY Qty,  b.DOU_UNITPRICE UnitCost, ROUND((b.INT_QUANTITY  * b.DOU_UNITPRICE),2) BeforeTax,   b.DOU_TAX_AMOUNT TaxAmt, b.DOU_TOTAL Total, a.DOU_AMOUNT NetValue, a.DOU_TCS_AMOUNT TCS,   ";
			sql = sql + " ROUND(a.DOU_TOTALAMOUNT,2)  FinalValue , k.CHR_TAXNAME GST, g.CHR_STAFFNAME AccountManager  , FUN_GET_BRANCH_NAME(a.INT_BRANCHID)  branchname, FUN_INV_DIVISION(a.INT_DIVIID) division  ";
			sql = sql + "from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_item c, inv_m_itemgroup b1, inv_m_division d,inv_m_customerinfo e,inv_m_itemgroup f, com_m_staff g ,  ";
			sql = sql + "inv_m_customertype i, inv_m_model j, inv_m_tax k  ";
			sql = sql + "WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='I'    ";
			sql = sql + "AND b.CHR_ITEMID =c.CHR_ITEMID   ";
			sql = sql + "AND a.INT_DIVIID= d.INT_DIVIID   ";
			sql = sql + "AND a.INT_CUSTOMERID = e.INT_CUSTOMERID   ";
			sql = sql + "AND c.INT_ITEMGROUPID = f.INT_ITEMGROUPID   ";
			sql = sql + "AND a.CHR_REF=g.CHR_EMPID   ";
			sql = sql + "AND c.INT_ITEMGROUPID = b1.INT_ITEMGROUPID   ";
			sql = sql + "AND e.INT_CUSTOMERTYPEID = i.INT_CUSTOMERTYPEID  ";
			sql = sql + "AND j.INT_MODELID = c.INT_MODELCODE  ";
			sql = sql + "AND b.INT_TAXID = k.INT_TAXID  ";
			if(!"F".equals(""+session.getAttribute("USRTYPE")) )
				sql = sql + "  AND a.CHR_REF IN("+empids+"'0') ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			if(!"0".equals(invoicetype))
				sql = sql + " AND a.CHR_CANCEL = '"+invoicetype+"' ";
			
			sql = sql + " AND a.DAT_SALESDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";  
			sql = sql + "ORDER BY a.CHR_SALESNO )     ";
			
			sql = sql + "UNION  ALL ";
			
			sql = sql + "(SELECT  a.CHR_SALESNO InvNumber, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') InvDate, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) NameoftheCustomer,   e.CHR_GSTNO  CustomerGSTNo,  ";
			sql = sql + "j.CHR_MODELCODE Brand ,  b1.CHR_NAME ProductGroup, c.CHR_PRODUCTDESC PCODEDESCRIPTION ,    ";
			sql = sql + "FUN_INV_GET_WARRANTY_IN_YEAR(b.INT_WARRANTY) Warranty,  c.CHR_HSNCODE HSNorSAC ,   FUN_INV_GET_SALES_SERIALNUMBER_CONCATS(b.CHR_TYPE,b.CHR_ITEMID, a.CHR_SALESNO) SlNos,";
			sql = sql + "b.INT_QUANTITY Qty, b.DOU_UNITPRICE UnitCost, ROUND((b.INT_QUANTITY  * b.DOU_UNITPRICE),2) BeforeTax,b.DOU_TAX_AMOUNT TaxAmt, b.DOU_TOTAL Total, a.DOU_AMOUNT NetValue, a.DOU_TCS_AMOUNT TCS,   ";
			sql = sql + " ROUND(a.DOU_TOTALAMOUNT,2)  FinalValue ,  k.CHR_TAXNAME GST, g.CHR_STAFFNAME AccountManager  , FUN_GET_BRANCH_NAME(a.INT_BRANCHID)  branchname , FUN_INV_DIVISION(a.INT_DIVIID) division ";
			sql = sql + "from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_produtlist c,  inv_m_productgroup b1, inv_m_division d,inv_m_customerinfo e,inv_m_productgroup f, com_m_staff g ,  ";
			sql = sql + "inv_m_customertype i, inv_m_model j, inv_m_tax k  ";
			sql = sql + "WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='P'    ";
			sql = sql + "AND b.CHR_ITEMID =c.CHR_PRODUCTID   ";
			sql = sql + "AND a.INT_DIVIID= d.INT_DIVIID   ";
			sql = sql + "AND a.INT_CUSTOMERID = e.INT_CUSTOMERID   ";
			sql = sql + "AND c.INT_PRODUCTGROUPID = f.INT_PRODUCTGROUPID   ";
			sql = sql + "AND c.INT_PRODUCTGROUPID = b1.INT_PRODUCTGROUPID   ";
			sql = sql + "AND a.CHR_REF=g.CHR_EMPID   ";
			sql = sql + "AND e.INT_CUSTOMERTYPEID = i.INT_CUSTOMERTYPEID  ";
			sql = sql + "AND j.INT_MODELID = c.CHR_MODEL  ";
			sql = sql + "AND b.INT_TAXID = k.INT_TAXID  ";
			if(!"F".equals(""+session.getAttribute("USRTYPE")) )
				sql = sql + "  AND a.CHR_REF IN("+empids+"'0') ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			if(!"0".equals(invoicetype))
				sql = sql + " AND a.CHR_CANCEL = '"+invoicetype+"' ";
			
			sql = sql + " AND a.DAT_SALESDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
			sql = sql + " AND a.DAT_SALESDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";  
			
			sql = sql + "ORDER BY a.CHR_SALESNO  ";
			sql = sql + ")  ";
			
 			//out.println(sql);
 
			//System.out.println(sql);
			
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					 
					for(int u=0;u<data.length;u++)
					{
						 
						child = new Vector();
						child.addElement(data[u][0]);
						child.addElement(data[u][1]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						child.addElement(data[u][6]);
						child.addElement(data[u][7]);
						child.addElement(data[u][8]);
						if(serial.equals("Y"))
							child.addElement(data[u][9]);
						else
							child.addElement("");	
						child.addElement(data[u][10]);
						child.addElement(data[u][11]);
						child.addElement(data[u][12]);
						child.addElement(data[u][13]);
						child.addElement(data[u][14]);
						child.addElement(data[u][15]);
						child.addElement(data[u][16]); 
						child.addElement(data[u][17]); 
						child.addElement(data[u][18]);
						child.addElement(data[u][19]);
						child.addElement(data[u][20]);
						child.addElement(data[u][21]);
						
						child.addElement((u+1));
						mn.add(child); 
					}
				}
				 
		}
		 
		request.setAttribute("table",mn);
		//System.out.println(mn);
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO"   sortable="true"><%=temp.elementAt(22)%></display:column>    
					
					<display:column title="INVNUMBER"   sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="INVDATE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					
					<display:column title="BRANCH"   sortable="true"><%=temp.elementAt(20)%></display:column>  
					 <display:column title="DIVISION"   sortable="true"><%=temp.elementAt(21)%></display:column>           
	
					<display:column title="NAMEOFTHECUSTOMER" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="CUSTOMERGSTNO"   sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="BRAND"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="PRODUCTGROUP"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="PCODEDESCRIPTION"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="WARRANTY"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="HSNORSAC"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="SLNOS"  sortable="true"><%=temp.elementAt(9)%></display:column>
					
					<display:column title="QTY"   style="text-align:right" ><%=temp.elementAt(10)%></display:column>
					<display:column title="UNITCOST" style="text-align:right"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="BEFORETAX"   style="text-align:right" ><%=temp.elementAt(12)%></display:column>
					<display:column title="TAXAMT"   style="text-align:right" ><%=temp.elementAt(13)%></display:column>
					<display:column title="TOTAL"   style="text-align:right" ><%=temp.elementAt(14)%></display:column>
					 
					<display:column title="TCS"  style="text-align:right" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="FINALVALUE"   style="text-align:right" ><%=temp.elementAt(17)%></display:column>  
					<display:column title="GST"   sortable="true"><%=temp.elementAt(18)%></display:column>  
					<display:column title="ACCOUNTMANAGER"   sortable="true"><%=temp.elementAt(19)%></display:column>  	
					
	
	
		 	
					<display:setProperty name="export.excel.filename" value="Rept_Salessetails_Template.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Salessetails_Template.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Salessetails_Template.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_MySalessetails.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>		 
</body>
</html>


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
 		String reportheader="EXPORT TO TALLY "; 
		String sql ="";
		String Branch=request.getParameter("Branch");
		String division = ""+request.getParameter("division");
		String vendor=request.getParameter("vendor");
		String ref = ""+request.getParameter("ref");
		String type=request.getParameter("type");
		String fromdate = ""+request.getParameter("fromdate");
		String todate = request.getParameter("todate");
		Vector mn = new Vector();
	 	Vector child= null;
		if(("1".equals(type)) || ("0".equals(type) ))
		{
				
				sql = sql + " SELECT a.CHR_PURCHASEORDERNO  FROM inv_t_directpurchase a  "; 
				sql = sql + " WHERE  a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y' ";
				if(!"0".equals(Branch))
					sql = sql + " AND a.INT_BRANCHID = "+Branch;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(vendor))
					sql = sql + " AND a.INT_VENDORID = "+vendor;
				if(!"0".equals(ref))
					sql = sql + " AND a.CHR_REF = '"+ref+"' ";
				sql = sql + " AND a.DAT_ORDERDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
				sql = sql + " AND a.DAT_ORDERDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
				sql = sql + " ORDER BY a.INT_PURCHASEORDERID   ";
				String mdata[][] = CommonFunctions.QueryExecute(sql);
				if(mdata.length>0)
				{
					int row =0;
					for(int j=0;j<mdata.length;j++)
					{
						sql = "";
						//ITEM VALUE
						sql = sql + " (  "; 
						sql = sql + "  SELECT ";    
						sql = sql + "  a.CHR_PURCHASEORDERNO po, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') dt,   ";
						sql = sql + "  CONCAT('CR-',a.INT_VENDORID) CR, CONCAT(b.CHR_VENDORNAME,'-','CR-',a.INT_VENDORID) vendor,  "; 
						sql = sql + "  a.CHR_VENDORPO,CONCAT(LEFT(a.CHR_PURCHASEORDERNO,2),' Purchase @ ',d.CHR_TAXNAME ) base,  "; 						
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') costcenter, ";
						sql = sql + "   SUM((INT_QUANTITY*DOU_UNITPRICE)) basevalue, ";
						sql = sql + "  CONCAT('DR'),  ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')    ";
						sql = sql + "   FROM inv_t_directpurchase a, inv_m_vendorsinformation b, inv_t_directpurchaseitem c ,inv_m_tax d  "; 
						sql = sql + "  WHERE a.INT_VENDORID = b.INT_VENDORID   ";
						sql = sql + "  AND c.INT_TAXID = d.INT_TAXID AND c.DOU_TAX_PERCENTAGE >0  "; 
						sql = sql + "  AND a.CHR_PURCHASEORDERNO =c.CHR_PURCHASEORDERNO   ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y'   ";
						sql = sql + "  AND a.CHR_PURCHASEORDERNO = '"+mdata[j][0] +"' ";
  						sql = sql + "  GROUP BY c.INT_TAXID  ";
 						sql = sql + "  ORDER BY a.CHR_PURCHASEORDERNO ";
						sql = sql + " )  "; 
						 
						 
						sql = sql + "  UNION  "; 
						
						//ITEM TAX
						sql = sql + " (  "; 
						sql = sql + " SELECT   ";    
						sql = sql + "  a.CHR_PURCHASEORDERNO po, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') dt,   ";  
						sql = sql + "  CONCAT('CR-',a.INT_VENDORID) CR, CONCAT(b.CHR_VENDORNAME,'-','CR-',a.INT_VENDORID) vendor,    "; 
						sql = sql + "  a.CHR_VENDORPO,CONCAT(LEFT(a.CHR_PURCHASEORDERNO,2),' Purchase Input  @ ',d.CHR_TAXNAME) tax,   ";  
						sql = sql + "  CONCAT('CORPORATE'),    "; 
						sql = sql + "  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') costcenter, "; 
						sql = sql + "  SUM(c.DOU_TAX_AMOUNT) taxamount, CONCAT('DR'),   "; 
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')    ";  
						sql = sql + "   FROM inv_t_directpurchase a, inv_m_vendorsinformation b, inv_t_directpurchaseitem c ,inv_m_tax d   ";  
						sql = sql + "  WHERE a.INT_VENDORID = b.INT_VENDORID   ";  
						sql = sql + "  AND c.INT_TAXID = d.INT_TAXID AND c.DOU_TAX_PERCENTAGE >0   ";  
						sql = sql + "  AND a.CHR_PURCHASEORDERNO =c.CHR_PURCHASEORDERNO    "; 
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y'    "; 
						sql = sql + "  AND a.CHR_PURCHASEORDERNO = '"+mdata[j][0] +"' ";
						sql = sql + "   GROUP BY c.INT_TAXID  "; 
						sql = sql + "  ORDER BY d.CHR_TAXNAME   "; 
						sql = sql + " )  "; 
						
						 sql = sql + "  UNION  "; 
						
						//TOTAL VALUE
						sql = sql + " (  "; 
						sql = sql + "  SELECT   ";  
						sql = sql + "   a.CHR_PURCHASEORDERNO po, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') dt,  ";  
						sql = sql + "  CONCAT('CR-',a.INT_VENDORID) CR, CONCAT(b.CHR_VENDORNAME,'-','CR-',a.INT_VENDORID) vendor,  ";  
						sql = sql + "  a.CHR_VENDORPO,CONCAT(LEFT(a.CHR_PURCHASEORDERNO,2),' Purchase @ ',d.CHR_TAXNAME) tax,  ";  
						sql = sql + "  CONCAT('CORPORATE'),  ";  
						sql = sql + "  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') costcenter,  ";  
						sql = sql + "  SUM(c.DOU_TOTAL) amount, CONCAT('DR'),  ";  
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')  ";   
						sql = sql + "  FROM inv_t_directpurchase a, inv_m_vendorsinformation b,  inv_t_directpurchaseitem c ,inv_m_tax d   "; 
						sql = sql + "  WHERE a.INT_VENDORID = b.INT_VENDORID  ";  
						sql = sql + "  AND a.INT_TAXID = d.INT_TAXID  "; 
						sql = sql + "   AND a.CHR_PURCHASEORDERNO =c.CHR_PURCHASEORDERNO  ";    
						sql = sql + "   AND a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y'  ";  
						sql = sql + "  AND a.CHR_PURCHASEORDERNO =  '"+mdata[j][0] +"' ";
						sql = sql + "  GROUP BY a.CHR_PURCHASEORDERNO  ";  
						sql = sql + "  ORDER BY a.CHR_PURCHASEORDERNO   "; 
					 	sql = sql + " )  ";  
						
						sql = sql + "  UNION  "; 
						//TOTAL TAX
						sql = sql + " (  "; 
						sql = sql + " SELECT    ";
						sql = sql + "  a.CHR_PURCHASEORDERNO po, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') dt,  ";
						sql = sql + "  CONCAT('CR-',a.INT_VENDORID) CR, CONCAT(b.CHR_VENDORNAME,'-','CR-',a.INT_VENDORID) vendor, ";
						sql = sql + "  a.CHR_VENDORPO,CONCAT(LEFT(a.CHR_PURCHASEORDERNO,2),' Purchase Input @ ',d.CHR_TAXNAME) tax, ";
						sql = sql + "  CONCAT('CORPORATE'), ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') costcenter, ";
						sql = sql + "  a.DOU_TAXAMOUNT amount, CONCAT('DR'), ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')   ";
						sql = sql + "  FROM inv_t_directpurchase a, inv_m_vendorsinformation b, inv_m_tax d ";
						sql = sql + "  WHERE a.INT_VENDORID = b.INT_VENDORID  "; 
						sql = sql + "  AND a.INT_TAXID = d.INT_TAXID AND a.DOU_TAXAMOUNT >0  ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y' ";
						sql = sql + "  AND a.CHR_PURCHASEORDERNO =  '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.CHR_PURCHASEORDERNO ";
						sql = sql + " )  "; 
						
						sql = sql + "  UNION  "; 
						
						sql = sql + " (  "; 
						
						//FRIEGHT
						sql = sql + " SELECT   ";
						sql = sql + "  a.CHR_PURCHASEORDERNO po, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') dt,   "; 
						sql = sql + "  CONCAT('CR-',a.INT_VENDORID) CR, CONCAT(b.CHR_VENDORNAME,'-','CR-',a.INT_VENDORID) vendor,   ";
						sql = sql + "  a.CHR_VENDORPO,CONCAT(LEFT(a.CHR_PURCHASEORDERNO,2),' Purchase Input @  Frieght' ) freight,  ";
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') costcenter,  "; 
						sql = sql + "  a.DOU_FRIEGHT_CHARGE amount, CONCAT('DR'),   ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')    ";
						sql = sql + "  FROM inv_t_directpurchase a, inv_m_vendorsinformation b  ";
						sql = sql + "  WHERE a.INT_VENDORID = b.INT_VENDORID   ";
						sql = sql + "  AND a.DOU_FRIEGHT_CHARGE >0    ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y'   ";
						sql = sql + "  AND a.CHR_PURCHASEORDERNO =  '"+mdata[j][0] +"' ";
						sql = sql + "  ORDER BY a.CHR_PURCHASEORDERNO   ";
						sql = sql + " )  "; 
						//out.println(sql);
						String data[][] = CommonFunctions.QueryExecute(sql);
						if(data.length>0)
						{
							
							for(int u=0;u<data.length;u++)
							{
								row = row+1;
								child = new Vector();
								child.addElement(row);
								child.addElement(data[u][0]);
								child.addElement(data[u][1]);
								child.addElement("PURCHASE-"+data[u][0].split("/")[2]);
								child.addElement(data[u][2]);
								child.addElement(data[u][3]);
								child.addElement(data[u][4]);
								child.addElement(data[u][5]);
								child.addElement(data[u][6]);
								child.addElement(data[u][7]);
								child.addElement(data[u][8]);
								child.addElement(data[u][9]);
								child.addElement(data[u][10]);
								mn.add(child); 
							}
						}
						
					}
				}	
				
		}
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="INVOICE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="VRTYPE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="SUPPCODE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="SUPPNAME"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="BILLREF"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="LEDGER"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="COSTCAT"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="COSTCENTRE"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="AMOUNT"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="CR/CR"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(12)%></display:column>
					   
					<display:setProperty name="export.excel.filename" value="Rept_Tallypurchaseexport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tallypurchaseexport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tallypurchaseexport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_Purchase_ExportTally.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


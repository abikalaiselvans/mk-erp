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
 		String reportheader="EXPORT WITH STOCK TO TALLY "; 
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
			sql = sql + " SELECT      a.CHR_PURCHASEORDERNO DOCNO, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') DOCDT, a.CHR_VENDORPO INVNO, DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') INVDT,   ";
			sql = sql + " CONCAT('GST Purchase') VOCUHERTYPE,  CONCAT('CR-',b.INT_VENDORID) LEDGERCODE, b.CHR_VENDORNAME PARTYLEDGER,   b.CHR_GSTNO GSTINNO  ,  ";
			sql = sql + " b.CHR_ADDRESS1 ADDRESS1, b.CHR_ADDRESS2 ADDRESS2,  CONCAT('') ADDRESS3,  g. CHR_CITYNAME CITY , f.CHR_DISTRICT DISTRICT,  e.CHR_STATENAME STATENAME,   ";
			sql = sql + " e.CHR_TINCODE STATECODE, b.INT_PINCODE PINCODE,  a.DOU_TOTALAMOUNT INVOICEVALUE,  ";
			sql = sql + " FUN_INV_PRODUCTCODE(c.CHR_TYPE,c.CHR_ITEMID) ITEMNAME, FUN_INV_HSNCODE(c.CHR_TYPE,c.CHR_ITEMID) HSNCODE,  ";
			sql = sql + " ROUND(c.DOU_TAX_PERCENTAGE,0) GSTRATE, 	c.INT_QUANTITY QTY, 	FUN_INV_UNITS(c.CHR_TYPE,c.CHR_ITEMID) UOM,  	DOU_UNITPRICE RATE,  ";
			sql = sql + " c.DOU_UNITDISCOUNT DISCOUNT, 	((c.INT_QUANTITY*c.DOU_UNITPRICE) - c.DOU_UNITDISCOUNT) AMOUNT,  ";
			sql = sql + " CONCAT('GST Purchase A/c')	SALESLEDGERNAME,  ";
			sql = sql + " IF(a.CHR_GST_TYPE !='S', ROUND(d.CHR_PERCENTAGE,2) , '') IGST, IF(a.CHR_GST_TYPE !='S', FUN_INV_DIRECT_PURCHASE_TAX_AMOUNT(a.CHR_PURCHASEORDERNO , 'igst'),'') IGSTAMOUNT,  ";
			sql = sql + " IF(a.CHR_GST_TYPE ='S', ROUND((d.CHR_PERCENTAGE * DOU_CGST/100)  , ''),2) CGST,  ";
			sql = sql + " IF(a.CHR_GST_TYPE ='S',  FUN_INV_DIRECT_PURCHASE_TAX_AMOUNT(a.CHR_PURCHASEORDERNO , 'cgst'),'') CGSTAMOUNT, ";
			sql = sql + " IF(a.CHR_GST_TYPE ='S', ROUND((d.CHR_PERCENTAGE * DOU_SGST/100)  , '') ,2) SGST,  ";
			sql = sql + " IF(a.CHR_GST_TYPE ='S', FUN_INV_DIRECT_PURCHASE_TAX_AMOUNT(a.CHR_PURCHASEORDERNO , 'sgst'), '' ) SGSTAMOUNT, ";
			sql = sql + " CONCAT('') TCS, CONCAT('') TCSAMOUNT, ";
			sql = sql + " IF(a.DOU_TAXAMOUNT >0 , a.INT_TAXID , '') TDS, a.DOU_TAXAMOUNT TDSAMOUNT,  ";
			sql = sql + " a.DOU_FRIEGHT_CHARGE  FREIGHTCHARGE, ";
			sql = sql + " CONCAT('') ADD_OR_LESS1, CONCAT('') ADD_OR_LESS, CONCAT('') ADD_OR_LESS,   ";
			sql = sql + " a.DOU_ROUNDED ROUNDOFF, a.DOU_TOTALAMOUNT INVOICEVALUE_2, ";
			sql = sql + " CONCAT('CORPORATE') COSTCAT,  REPLACE(RIGHT(a.CHR_PURCHASEORDERNO,7),'/','-') COSTCENTER, REPLACE(LEFT(a.CHR_DES,200),'\n','') NARRATION, ";
			sql = sql + " SUBSTRING(c.CHR_DESC, 1, 50) PROD_DEC1 , SUBSTRING(c.CHR_DESC, 51, 50) PROD_DEC2 , SUBSTRING(c.CHR_DESC, 101, 50) PROD_DEC3 , SUBSTRING(c.CHR_DESC, 151, 50) PROD_DEC4 ,  ";
			sql = sql + " SUBSTRING(c.CHR_DESC, 200, 50) PROD_DEC5 , SUBSTRING(c.CHR_DESC, 201, 50) PROD_DEC6 , SUBSTRING(c.CHR_DESC, 251, 50) PROD_DEC7 ,  ";
			sql = sql + " CONCAT('') SRNO_DETAILS,  ";
			sql = sql + " FUN_INV_GET_WARRANTY_IN_YEAR(c.INT_WARRANTY) WARRANTY_DETAILS, ";
			sql = sql + " CONCAT('') PO_REFERENCE, FIND_A_PAYMENT_TERM(a.INT_PAYMENTTERMID) PAYMENT_TERMS, CONCAT('') DESPATCHED_THRU, CONCAT('') DESTINATION, ";
			sql = sql + " CONCAT('') CONTACT_PERSON, CONCAT('') CONTACT_NO, ";
			sql = sql + " b.CHR_VENDORNAME CONSIGNEE_NAME, b.CHR_ADDRESS1 CONSIGNEE_ADDRESS1, b.CHR_ADDRESS2 CONSIGNEE_ADDRESS2,   ";
			sql = sql + " CONCAT('') CONSIGNEE_ADDRESS3,  g. CHR_CITYNAME CONSIGNEE_CITY , f.CHR_DISTRICT CONSIGNEE_DISTRICT,  e.CHR_STATENAME CONSIGNEE_STATENAME,  ";
			sql = sql + " b.INT_PINCODE CONSIGNEE_PINCODE ,IF(a.CHR_GST_TYPE='S','STATE','CENTRAL') GSTTYPE,   ";
			sql = sql + " CONCAT('') CONSIGNEEADD ";
			
			sql = sql + " FROM  inv_t_directpurchase a, inv_m_vendorsinformation b, inv_t_directpurchaseitem c  ,inv_m_tax d , com_m_state  e , com_m_district f, com_m_city g  "; 
			sql = sql + " WHERE   a.CHR_CANCEL = 'N' AND a.CHR_FLAG='Y' AND a.INT_VENDORID = b.INT_VENDORID   ";
			sql = sql + " AND  a.INT_VENDORID = b.INT_VENDORID    ";    
			sql = sql + " AND a.CHR_PURCHASEORDERNO =c.CHR_PURCHASEORDERNO  ";     
			sql = sql + " AND c.INT_TAXID = d.INT_TAXID   ";
			sql = sql + " AND b.INT_STATEID = e.INT_STATEID ";
			sql = sql + " AND b.INT_DISTRICTID = f.INT_DISTRICTID ";
			sql = sql + " AND b.INT_CITYID = g.INT_CITYID ";
			 
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
			System.out.println(sql);
			
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					 
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
						child.addElement(data[u][19]);
						child.addElement(data[u][20]);
						child.addElement(data[u][21]);
						child.addElement(data[u][22]);
						child.addElement(data[u][23]);
						child.addElement(data[u][24]);
						child.addElement(data[u][25]);
						child.addElement(data[u][26]);
						child.addElement(data[u][27]);
						child.addElement(data[u][28]);
						child.addElement(data[u][29]);
						child.addElement(data[u][30]);
						child.addElement(data[u][31]);
						child.addElement(data[u][32]);
						child.addElement(data[u][33]);
						child.addElement(data[u][34]); 
						child.addElement(data[u][35]);
						child.addElement(data[u][36]);
						child.addElement(data[u][37]);
						child.addElement(data[u][38]);
						child.addElement(data[u][39]);
						child.addElement(data[u][40]);
						child.addElement(data[u][41]);
						child.addElement(data[u][42]);
						child.addElement(data[u][43]);
						child.addElement(data[u][44]);
						child.addElement(data[u][45]);
						child.addElement(data[u][46]);
						child.addElement(data[u][47]);
						child.addElement(data[u][48]);
						child.addElement(data[u][49]);
						child.addElement(data[u][50]);
						child.addElement(data[u][51]);
						child.addElement(data[u][52]);
						child.addElement(data[u][53]);
						child.addElement(data[u][54]);
						child.addElement(data[u][55]);
						child.addElement(data[u][56]);
						child.addElement(data[u][57]);
						child.addElement(data[u][58]);
						child.addElement(data[u][59]);
						child.addElement(data[u][60]);
						child.addElement(data[u][61]);
						child.addElement(data[u][62]);
						child.addElement(data[u][63]);
						child.addElement(data[u][64]);
						child.addElement(data[u][65]);
						child.addElement(data[u][66]);
						child.addElement(data[u][67]);
						child.addElement(data[u][68]);
						child.addElement(data[u][69]);
						mn.add(child); 
					}
				}
				 
		}
		 
		request.setAttribute("table",mn);
		System.out.println(mn);
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="DOCNO"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DOCDT"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="INVNO" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="INVDT"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="VOCUHERTYPE"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="LEDGERCODE"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="PARTYLEDGER"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="GSTINNO"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="ADDRESS1"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="ADDRESS2"  sortable="true"><%=temp.elementAt(10)%></display:column>
					
					<display:column title="ADDRESS3"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="CITY"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="DISTRICT"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="STATENAME"   sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="STATECODE"   sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="PINCODE"  style="text-align:right" sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="INVOICEVALUE"   sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="ITEMNAME"   sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="HSNCODE"    style="text-align:right" sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="GSTRATE"    style="text-align:right" sortable="true"><%=temp.elementAt(20)%></display:column>
																		
					<display:column title="QTY"   sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="UOM"   sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="RATE"    style="text-align:right" sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="DISCOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="AMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="SALESLEDGERNAME"   sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="IGST"    style="text-align:right" sortable="true"><%=temp.elementAt(27)%></display:column>
					<display:column title="IGSTAMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(28)%></display:column>
					<display:column title="CGST"    style="text-align:right" sortable="true"><%=temp.elementAt(29)%></display:column>
					<display:column title="CGSTAMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(30)%></display:column>
																			
					<display:column title="SGST"    style="text-align:right" sortable="true"><%=temp.elementAt(31)%></display:column>
					<display:column title="SGSTAMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(32)%></display:column>
					<display:column title="TCS"  style="text-align:right" sortable="true"><%=temp.elementAt(33)%></display:column>
					<display:column title="TCSAMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(34)%></display:column>
					<display:column title="TDS"    style="text-align:right" sortable="true"><%=temp.elementAt(35)%></display:column>
					<display:column title="TDSAMOUNT"    style="text-align:right" sortable="true"><%=temp.elementAt(36)%></display:column>
					<display:column title="FREIGHTCHARGE"   style="text-align:right"  sortable="true"><%=temp.elementAt(37)%></display:column>
					<display:column title="ADD_OR_LESS1"     sortable="true"><%=temp.elementAt(38)%></display:column>
					<display:column title="ADD_OR_LESS"    sortable="true"><%=temp.elementAt(39)%></display:column>
					<display:column title="ADD_OR_LESS_2"      sortable="true"><%=temp.elementAt(40)%></display:column>
					
					<display:column title="ROUNDOFF"   sortable="true"><%=temp.elementAt(41)%></display:column>
					<display:column title="INVOICEVALUE_2"   style="text-align:right" sortable="true"><%=temp.elementAt(42)%></display:column>
					<display:column title="COSTCAT" sortable="true"><%=temp.elementAt(43)%></display:column>
					<display:column title="COSTCENTER"   sortable="true"><%=temp.elementAt(44)%></display:column>
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(45)%></display:column>
					<display:column title="PROD_DEC1"   sortable="true"><%=temp.elementAt(46)%></display:column>
					<display:column title="PROD_DEC2"   sortable="true"><%=temp.elementAt(47)%></display:column>
					<display:column title="PROD_DEC3"   sortable="true"><%=temp.elementAt(48)%></display:column>
					<display:column title="PROD_DEC4"   sortable="true"><%=temp.elementAt(49)%></display:column>
					<display:column title="PROD_DEC5"  sortable="true"><%=temp.elementAt(50)%></display:column>
																		
					<display:column title="PROD_DEC6"   sortable="true"><%=temp.elementAt(51)%></display:column>
					<display:column title="PROD_DEC7"   sortable="true"><%=temp.elementAt(52)%></display:column>
					<display:column title="SRNO_DETAILS" sortable="true"><%=temp.elementAt(53)%></display:column>
					<display:column title="WARRANTY_DETAILS"   sortable="true"><%=temp.elementAt(54)%></display:column>
					<display:column title="PO_REFERENCE"   sortable="true"><%=temp.elementAt(55)%></display:column>
					<display:column title="PAYMENT_TERMS"   sortable="true"><%=temp.elementAt(56)%></display:column>
					<display:column title="DESPATCHED_THRU"   sortable="true"><%=temp.elementAt(57)%></display:column>
					<display:column title="DESTINATION"   sortable="true"><%=temp.elementAt(58)%></display:column>
					<display:column title="CONTACT_PERSON"   sortable="true"><%=temp.elementAt(59)%></display:column>
					
					<display:column title="CONTACT_NO"  sortable="true"><%=temp.elementAt(60)%></display:column>
					<display:column title="CONSIGNEE_NAME"   sortable="true"><%=temp.elementAt(61)%></display:column>
					<display:column title="CONSIGNEE_ADDRESS1" sortable="true"><%=temp.elementAt(62)%></display:column>
					<display:column title="CONSIGNEE_ADDRESS2"   sortable="true"><%=temp.elementAt(63)%></display:column>
					<display:column title="CONSIGNEE_ADDRESS3"   sortable="true"><%=temp.elementAt(64)%></display:column>
					<display:column title="CONSIGNEE_CITY"   sortable="true"><%=temp.elementAt(65)%></display:column>
					<display:column title="CONSIGNEE_DISTRICT"   sortable="true"><%=temp.elementAt(66)%></display:column>
					<display:column title="CONSIGNEE_STATENAME"   sortable="true"><%=temp.elementAt(67)%></display:column>
					<display:column title="CONSIGNEE_PINCODE"   sortable="true"><%=temp.elementAt(68)%></display:column>
					<display:column title="GSTTYPE"   sortable="true"><%=temp.elementAt(69)%></display:column>	
					 <display:column title="CONSIGNEE_TYPE"   sortable="true"><%=temp.elementAt(70)%></display:column>							
									
										
					<display:setProperty name="export.excel.filename" value="Purchase_ExportWithStock_Template.xls"/>
					<display:setProperty name="export.pdf.filename" value="Purchase_ExportWithStock_Template.pdf"/>
					<display:setProperty name="export.csv.filename" value="Purchase_ExportWithStock_Template.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_Purchase_ExportWithStockTally.jsp'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>


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
 		String reportheader="EXPORT TO TALLY "; 
		String sql ="";
		String Branch=request.getParameter("Branch");
		String division = ""+request.getParameter("division");
		String custid=request.getParameter("customer");
		String ref = ""+request.getParameter("ref");
		String type=request.getParameter("type");
		String fromdate = ""+request.getParameter("saleDate");
		String todate = request.getParameter("saleDate2");
		
		
		Vector mn = new Vector();
	 	Vector child= null;
		
		
		//Direct Sales
		if(("1".equals(type)) )
		{
				sql =  "  SELECT a.CHR_SALESNO  FROM inv_t_directsales a   WHERE  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
				if(!"0".equals(Branch))
					sql = sql + " AND a.INT_BRANCHID = "+Branch;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(custid))
					sql = sql + " AND a.INT_CUSTOMERID = "+custid;
				if(!"0".equals(ref))
					sql = sql + " AND a.CHR_REF = '"+ref+"' ";
				sql = sql + " AND a.DAT_SALESDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
				sql = sql + " AND a.DAT_SALESDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
				sql = sql + " ORDER BY a.INT_SALESID   "; 
				System.out.println(sql);
				String mdata[][] = CommonFunctions.QueryExecute(sql);
				if(mdata.length>0)
				{
					int row =0;
					for(int j=0;j<mdata.length;j++)
					{
						sql = "";
						//ITEM LEDGER
						sql = sql + " (  ";
						sql = sql + " SELECT    ";
						sql = sql + "  a.CHR_SALESNO sale, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,    ";
						sql = sql + "  CONCAT('DR-',b.INT_CUSTOMERGROUPID) DR,    ";
						sql = sql + "  CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,    ";
						sql = sql + "  a.CHR_OTHERREF,    ";
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter,  ";
						sql = sql + "  CONCAT(LEFT(a.CHR_SALESNO,2),' Sales @ ',d.CHR_TAXNAME ) ledger, ";
						sql = sql + "  SUM(c.INT_QUANTITY*c.DOU_UNITPRICE) ledgeramount, CONCAT('CR'),   ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')   , CONCAT(a.CHR_BYBACK)  ";
						sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b, inv_t_swapsalesitem c  ,inv_m_tax d   ";
						sql = sql + "  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID     ";
						sql = sql + "  AND a.CHR_SALESNO =c.CHR_SALESNO    ";
						sql = sql + "  AND c.INT_TAXID = d.INT_TAXID  AND c.DOU_TAX_PERCENTAGE >0  ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1    ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + "  GROUP BY d.INT_TAXID  ";
						sql = sql + "   ORDER BY a.CHR_SALESNO    ";
						sql = sql + "  ) ";
						
						sql = sql + "  UNION ";
						//ITEM TAX LEDGER
						sql = sql + " (  ";
						sql = sql + " SELECT    ";
						sql = sql + "  a.CHR_SALESNO sale, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,    ";
						sql = sql + "  CONCAT('DR-',b.INT_CUSTOMERGROUPID) DR,    ";
						sql = sql + "  CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,    ";
						sql = sql + "  a.CHR_OTHERREF,    ";
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter,  ";
						sql = sql + "  CONCAT(LEFT(a.CHR_SALESNO,2),' Sales Output Tax @ ',d.CHR_TAXNAME ) ledger, ";
						sql = sql + "  SUM(c.DOU_TAX_AMOUNT) ledgeramount, CONCAT('CR'),   ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')   , CONCAT(a.CHR_BYBACK)  ";
						sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b, inv_t_swapsalesitem c  ,inv_m_tax d   ";
						sql = sql + "  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID     ";
						sql = sql + "  AND a.CHR_SALESNO =c.CHR_SALESNO    ";
						sql = sql + "  AND c.INT_TAXID = d.INT_TAXID  AND c.DOU_TAX_PERCENTAGE >0  ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1    ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + "  GROUP BY d.INT_TAXID  ";
						sql = sql + "   ORDER BY a.CHR_SALESNO    ";
						sql = sql + "  ) ";
						
						sql = sql + "  UNION ";
						 
						 //ITEM NO TAX LEDGER
						sql = sql + "  ( ";
						sql = sql + " SELECT    ";
						sql = sql + "  a.CHR_SALESNO sale, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,    ";
						sql = sql + "  CONCAT('DR-',b.INT_CUSTOMERGROUPID) DR,    ";
						sql = sql + "  CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,    ";//,'-','DR-',b.INT_CUSTOMERGROUPID
						sql = sql + "  a.CHR_OTHERREF,    ";
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter,  ";
						sql = sql + "  CONCAT(LEFT(a.CHR_SALESNO,2),' Sales @ ',d.CHR_TAXNAME ) ledger, ";
						sql = sql + " SUM(c.INT_QUANTITY*c.DOU_UNITPRICE) ledgeramount, CONCAT('CR'),   ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')   , CONCAT(a.CHR_BYBACK)  ";
						sql = sql + " FROM inv_t_directsales a, inv_m_customerinfo b, inv_t_swapsalesitem c  ,inv_m_tax d   ";
						sql = sql + "  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID     ";
						sql = sql + "  AND a.CHR_SALESNO =c.CHR_SALESNO    ";
						sql = sql + "  AND a.INT_TAXID = d.INT_TAXID  AND c.DOU_TAX_PERCENTAGE =0  ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1    ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + "  GROUP BY a.CHR_SALESNO  ";
						sql = sql + "   ORDER BY a.CHR_SALESNO   ";
						sql = sql + "   ) ";
						
						sql = sql + "   UNION ";
						//INVOICE TAX
						sql = sql + "   ( ";
						sql = sql + "  SELECT    ";
						sql = sql + "  a.CHR_SALESNO sale, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,    ";
						sql = sql + "  CONCAT('DR-',b.INT_CUSTOMERGROUPID) DR,    ";
						sql = sql + "  CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,    "; //,'-','DR-',b.INT_CUSTOMERGROUPID
						sql = sql + "  a.CHR_OTHERREF,    ";
						sql = sql + "  CONCAT('CORPORATE'),   ";
						sql = sql + "  REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter,  ";
						sql = sql + "  CONCAT(LEFT(a.CHR_SALESNO,2),' Sales Output@ ',d.CHR_TAXNAME ) ledger, ";
						sql = sql + "  a.DOU_TAXAMOUNT ledgeramount, CONCAT('CR'),   ";
						sql = sql + "  REPLACE(LEFT(a.CHR_DES,200),'\n','')   , CONCAT(a.CHR_BYBACK)  ";
						sql = sql + "  FROM inv_t_directsales a, inv_m_customerinfo b, inv_m_tax d   ";
						sql = sql + "  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID     ";
						sql = sql + "  AND a.INT_TAXID = d.INT_TAXID   AND a.DOU_TAXAMOUNT >0   ";
						sql = sql + "  AND a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1    ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + "    ORDER BY a.CHR_SALESNO    ";
						sql = sql + "   ) ";
						System.out.println(sql);
						String data[][] = CommonFunctions.QueryExecute(sql);
						if(data.length>0)
						{
							System.out.println(data.length);
							for(int u=0;u<data.length;u++)
							{
								row = row+1;
								child = new Vector();
								child.addElement(row);
								child.addElement(data[u][0]);
								child.addElement(data[u][1]);
								
								//child.addElement("SALES-"+data[u][0].split("/")[2]); MSL0297/22-23
								child.addElement("SALES-"+data[u][0]);
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
								mn.add(child); 
							}
						}
						
					}
				}	
				
		}
		System.out.println(mn);

		
		//Service Billing
		if(("3".equals(type)) )
		{
				sql =  "  SELECT a.CHR_SALESNO  FROM inv_t_servicebilling a   WHERE  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
				if(!"0".equals(Branch))
					sql = sql + " AND a.INT_BRANCHID = "+Branch;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(custid))
					sql = sql + " AND a.INT_CUSTOMERID = "+custid;
				if(!"0".equals(ref))
					sql = sql + " AND a.CHR_REF = '"+ref+"' ";
				sql = sql + " AND a.DAT_SALESDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
				sql = sql + " AND a.DAT_SALESDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
				sql = sql + " ORDER BY a.INT_ID   "; 
			
				String mdata[][] = CommonFunctions.QueryExecute(sql);
				if(mdata.length>0)
				{
					int row =0;
					for(int j=0;j<mdata.length;j++)
					{
						sql = "";
						sql = sql + "  ( ";
						sql = sql + " SELECT a.CHR_SALESNO invoice, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt, ";   
						sql = sql + " CONCAT('DR-',b.INT_CUSTOMERGROUPID) CR, "; 
						sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)) customer,  ";//,'-','CR-',b.INT_CUSTOMERGROUPID
						sql = sql + " a.CHR_OTHERREF, ";
						sql = sql + " CONCAT('CORPORATE'),REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter  , ";   
						sql = sql + " CONCAT(LEFT(a.CHR_SALESNO,2),' Sales @ SERVICE') ledger,  "; 
						sql = sql + " a.DOU_AMOUNT ledgervalue, ";
						sql = sql + " CONCAT('CR'),  ";
						sql = sql + " REPLACE(LEFT(a.CHR_DES,200),'\n',''),a.CHR_TAXID dualtax   "; 
						sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b ";
						sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
						sql = sql + " AND  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.DAT_SALESDATE ";
						sql = sql + " ) ";
						
						sql = sql + " UNION ";
						
						sql = sql + " ( ";
						sql = sql + " SELECT a.CHR_SALESNO invoice, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,  ";  
						sql = sql + " CONCAT('DR-',b.INT_CUSTOMERGROUPID) CR,  ";
						sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,  ";
						sql = sql + " a.CHR_OTHERREF, ";
						sql = sql + " CONCAT('CORPORATE'),REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter  ,  ";  
						sql = sql + " CONCAT(LEFT(a.CHR_SALESNO,2),' Service @ SERVICE TAX ',a.DOU_SERVICETAX12) ledger,  "; 
						sql = sql + " a.DOU_SERVICE_AMOUNT12 ledgervalue, ";
						sql = sql + " CONCAT('CR'),  ";
						sql = sql + " REPLACE(LEFT(a.CHR_DES,200),'\n','') ,a.CHR_TAXID dualtax  "; 
						sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b ";
						sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_SERVICETAX_FLAG ='Y' ";
						sql = sql + " AND  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.DAT_SALESDATE ";
						sql = sql + " ) ";
						
						sql = sql + " UNION ";
						
						sql = sql + " ( ";
						sql = sql + " SELECT a.CHR_SALESNO invoice, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt, ";   
						sql = sql + " CONCAT('DR-',b.INT_CUSTOMERGROUPID) CR,  ";
						sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,  ";
						sql = sql + " a.CHR_OTHERREF, ";
						sql = sql + " CONCAT('CORPORATE'),REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter  ,   "; 
						sql = sql + " CONCAT(LEFT(a.CHR_SALESNO,2),' Service @ SERVICE TAX ',a.DOU_SERVICETAX2) ledger, ";  
						sql = sql + " a.DOU_SERVICE_AMOUNT2 ledgervalue, ";
						sql = sql + " CONCAT('CR'),  ";
						sql = sql + " REPLACE(LEFT(a.CHR_DES,200),'\n','') ,a.CHR_TAXID dualtax  ";  
						sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b ";
						sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_SERVICETAX_FLAG ='Y' ";
						sql = sql + " AND  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.DAT_SALESDATE ";
						sql = sql + " ) ";
						
						sql = sql + " UNION ";
						
						sql = sql + " ( ";
						sql = sql + " SELECT a.CHR_SALESNO invoice, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,  ";  
						sql = sql + " CONCAT('DR-',b.INT_CUSTOMERGROUPID) CR,  ";
						sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,  ";
						sql = sql + " a.CHR_OTHERREF, ";
						sql = sql + " CONCAT('CORPORATE'),REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter  ,  ";  
						sql = sql + " CONCAT(LEFT(a.CHR_SALESNO,2),' Service @  SERVICE TAX ',a.DOU_SERVICETAX1) ledger,  "; 
						sql = sql + " a.DOU_SERVICE_AMOUNT1 ledgervalue, ";
						sql = sql + " CONCAT('CR'),  ";
						sql = sql + " REPLACE(LEFT(a.CHR_DES,200),'\n',''),a.CHR_TAXID dualtax  "; 
						sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b ";
						sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_SERVICETAX_FLAG ='Y' ";
						sql = sql + " AND  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1 ";
						sql = sql + "  AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.DAT_SALESDATE ";
						sql = sql + " ) ";
						
						
						sql = sql + " UNION ";
						
						sql = sql + " ( ";
						sql = sql + " SELECT a.CHR_SALESNO invoice, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') dt,    ";
						sql = sql + " CONCAT('DR-',b.INT_CUSTOMERGROUPID) CR,  "; 
						sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ) customer,  ";
						sql = sql + " a.CHR_OTHERREF,  ";
						sql = sql + " CONCAT('CORPORATE'),REPLACE(RIGHT(a.CHR_SALESNO,7),'/','-') costcenter  ,  ";
						sql = sql + " CONCAT(LEFT(a.CHR_SALESNO,2),' Service @ ',FUN_GET_TAX_NAME(SUBSTRING_INDEX(CHR_TAXID,',',1))) ledger, ";//
						sql = sql + " SUBSTRING_INDEX(CHR_TAXAMOUNT,',',1) ledgervalue, ";
						sql = sql + " CONCAT('CR'),  "; 
						sql = sql + " REPLACE(LEFT(a.CHR_DES,200),'\n',''),a.CHR_TAXID dualtax   ";
						sql = sql + " FROM inv_t_servicebilling a , inv_m_customerinfo b  ";
						sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
						sql = sql + " AND  a.CHR_CANCEL = 'N' AND a.INT_SALESSTATUS=1  ";
						sql = sql + " AND a.CHR_SALESNO = '"+mdata[j][0] +"' ";
						sql = sql + " ORDER BY a.DAT_SALESDATE  ";
						sql = sql + " ) ";


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
								//child.addElement("SERVICE-"+data[u][0].split("/")[2]);
								child.addElement("SERVICE-"+data[u][0]);
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
								mn.add(child); 
							}
						}
						
					}
				}	
				
		}
		
		request.setAttribute("table",mn);
		System.out.println(mn);
%>

<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="INVOICE"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DATE"   sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="VRTYPE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="SUPPCODE"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="SUPPNAME"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="BILLREF"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="LEDGER"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="COSTCAT"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="COSTCENTRE"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="AMOUNT" style="text-align:right"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="CR/DR"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="NARRATION"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="BUY BACK / DUAL TAX"   sortable="true"><%=temp.elementAt(13)%></display:column>
					   
					<display:setProperty name="export.excel.filename" value="Rept_Tallyexport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_Tallyexport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_Tallyexport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_ExportTally.jsp'> CLOSE</a></center>
 <%
}
catch(Exception e)
{
	out.println("Error :"+e.getMessage());
	System.out.println("Error :"+e.getMessage());
}
%>		 
</body>
</html>


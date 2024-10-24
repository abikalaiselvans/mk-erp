<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%> 
 
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


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
				String Branch = request.getParameter("Branch");
				String AllBranch = request.getParameter("AllBranch");
				String itype = request.getParameter("itype");
				String Salesflag = request.getParameter("Salesflag");
				String pgroup = request.getParameter("pgroup");
				String item = request.getParameter("item");
				String sql="";
				sql=" SELECT CHR_PURCHASEORDERNO, CHR_ITEMID,CHR_TYPE, CHR_SERIALNO, ";
				sql = sql + " date_format(DAT_RECIVEDDATE,'%d-%m-%Y'),CHR_PURCHASE_WARRANTY, ";
				sql = sql + " CHR_WARRANTY,CHR_FLAG,CHR_QUALITY  , ";
				
				sql=sql+" (Select c.CHR_BRANCHNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND  ";
				sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID) ,";
				
				sql=sql+" (Select d.CHR_SHORTNAME from  com_m_branch  c  ,com_m_company d where  c.INT_COMPANYID = d.INT_COMPANYID AND ";
				sql=sql+" c.INT_BRANCHID = a.INT_BRANCHID)   ";
			
				sql = sql + " FROM inv_t_vendorgoodsreceived a ";
				sql = sql + " WHERE a.CHR_WARRANTY <> a.CHR_PURCHASE_WARRANTY  AND ( ( CHR_SERIALNO IS NOT NULL) OR ( CHR_SERIALNO != '') ) ";
				
				if(!"Y".equals(Salesflag))
					sql = sql + " AND a.CHR_FLAG <> 'N' ";
					
				if("1".equals(itype))	
					sql = sql + " AND a.CHR_TYPE ='I' ";
				
				if("2".equals(itype))	
					sql = sql + " AND a.CHR_TYPE ='P' ";	
					
				//if(!"0".equals(pgroup))	
				//	sql = sql + " AND a.CHR_ITEMID ='"+pgroup+"' ";	
					
				if(!"0".equals(item))	
					sql = sql + " AND a.CHR_ITEMID ='"+item+"' ";		
				
				if(!"Y".equals(AllBranch))
					sql = sql+ " AND a.INT_BRANCHID ="+Branch;
				
				
				  
String reportheader="CHANGE WARRANTY"  ; 
Vector mn = new Vector();
Vector child= null;

String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(data.length>0)
{
	String productname="";
	for(int u=0;u<data.length;u++)
	{
		productname="";
		child = new Vector();
		child.addElement((u+1));
		child.addElement(data[u][0].trim());
		if("I".equals(data[u][2].trim()))
			child.addElement("ITEM"); 
		else
			child.addElement("PRODUCT"); 
		
		
		if("I".equals(data[u][2].trim()))
		{
			if(!"-".equals(data[u][1].trim()))
				productname=CommonFunctions.QueryExecute(" SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+data[u][1].trim()+"'")[0][0];
		}
		else
		{
			if(!"-".equals(data[u][1].trim()))
				productname=CommonFunctions.QueryExecute("SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+data[u][1].trim()+"'")[0][0];
		}	 	
		  
		child.addElement( productname);
		child.addElement(data[u][10].trim()+" @ "+data[u][9].trim());
		child.addElement(data[u][3]);
		child.addElement(data[u][4]);
		child.addElement(data[u][5]+" Yrs");
		child.addElement(data[u][6]+" Yrs");
		if("Y".equals(data[u][7].trim()))
			child.addElement("STOCK");	
		else
			child.addElement("SALE");	
		
		
		if("H".equals(data[u][8].trim()))
			child.addElement("DC Mode");	
		else if("N".equals(data[u][8].trim()))
			child.addElement("FAULT");		
		else
			child.addElement("GOOD");	
		mn.add(child);
	}
	 
}
 
	
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center> ");
	 
 %>
			

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Invoice No" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Item/Product" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Serial No " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Received Date" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Purchase Warranty" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Sales Warranty" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Sales" sortable="true"><%=temp.elementAt(9)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_WarrantyChange.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_WarrantyChange.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_WarrantyChange.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a></center><br /><br />


 
<%	 		


			}
			catch(Exception e)
			{
			}	
	  %>
	 
</body>
</html>

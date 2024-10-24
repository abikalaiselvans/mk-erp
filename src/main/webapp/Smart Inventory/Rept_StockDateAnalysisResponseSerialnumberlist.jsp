<%@ page import="java.io.*,java.util.*,java.text.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
		String division = request.getParameter("division");
		String Item = request.getParameter("Item");
		String ptype = request.getParameter("ptype");
		String Agetype = request.getParameter("Agetype");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		

		String sql ="";
		String itemname=""; 
		  
		 {
		 	sql ="";
			if("I".equals(ptype))
			{
				sql =" SELECT a.CHR_TYPE,a.CHR_ITEMID,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,b.CHR_GROUPNAME,c.CHR_ITEMNAME,c.CHR_DES,";
				sql = sql+ " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y'),  ";
				sql = sql+ " DATE_FORMAT(now(),'%d-%b-%Y'),  ";
				sql = sql+ " DATEDIFF(now(),a.DAT_RECIVEDDATE),a.DOU_UNITPRICE,  ";
				sql = sql+ " a.CHR_QUALITY,a.CHR_SERIALNO,a.CHR_PURCHASE_WARRANTY,a.CHR_WARRANTY,a.CHR_PURCHASEORDERNO    ";
				sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_itemgroup b ,inv_m_item c,com_m_company d , com_m_branch e  ";
				sql = sql+ " WHERE b.INT_ITEMGROUPID= c.INT_ITEMGROUPID   ";
				sql = sql+ " AND a.CHR_ITEMID = c.CHR_ITEMID  ";
				sql = sql+ " AND d.INT_COMPANYID = e.INT_COMPANYID  ";
				sql = sql+ " AND a.INT_BRANCHID= e.INT_BRANCHID  ";
				sql = sql+ " AND a.CHR_ITEMID = '"+Item+"'";
				sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)>="+ from;
				sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)<="+ to;
				if(!"0".equals(Branch))
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
				if(!"0".equals(division))
					sql = sql + "  AND a.INT_DIVIID = "+division;
			
				sql = sql+ " AND  a.CHR_TYPE='I'  AND a.CHR_FLAG <> 'Y'  AND a.CHR_SERIALNO is not null   ";
				sql = sql+ " ORDER BY  a.DAT_RECIVEDDATE  DESC ";
				itemname="Item";

			}
			else
			{
			
				sql =" SELECT a.CHR_TYPE,a.CHR_ITEMID,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,b.CHR_NAME,c.CHR_PRODUCTCODE,c.CHR_PRODUCTDESC,  ";
				sql = sql+ " DATE_FORMAT(a.DAT_RECIVEDDATE,'%d-%b-%Y'),  ";
				sql = sql+ " DATE_FORMAT(now(),'%d-%b-%Y'),  ";
				sql = sql+ " DATEDIFF(now(),a.DAT_RECIVEDDATE),a.DOU_UNITPRICE,  ";
				sql = sql+ " a.CHR_QUALITY,a.CHR_SERIALNO,a.CHR_PURCHASE_WARRANTY,a.CHR_WARRANTY ,a.CHR_PURCHASEORDERNO   ";
				sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_productgroup b ,inv_m_produtlist c,com_m_company d , com_m_branch e  ";
				sql = sql+ " WHERE b.INT_PRODUCTGROUPID= c.INT_PRODUCTGROUPID   ";
				sql = sql+ " AND a.CHR_ITEMID = c.CHR_PRODUCTID  ";
				sql = sql+ " AND d.INT_COMPANYID = e.INT_COMPANYID  ";
				sql = sql+ " AND a.INT_BRANCHID= e.INT_BRANCHID  ";
				sql = sql+ " AND a.CHR_ITEMID = '"+Item+"'";
				sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)>="+ from;
				sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)<="+ to;
				if(!"0".equals(Branch))
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
				if(!"0".equals(division))
					sql = sql + "  AND a.INT_DIVIID = "+division;
		
				sql = sql+ " AND  a.CHR_TYPE='P'  AND a.CHR_FLAG <> 'Y'  AND a.CHR_SERIALNO is not null  ";
				sql = sql+ " ORDER BY  a.DAT_RECIVEDDATE  DESC ";
				itemname="Product";

			}
		 }
		
		 
		String data[][]=CommonFunctions.QueryExecute(sql);
		String reportheader="STOCK AGE "; 
		Vector mn = new Vector();
		Vector child= null;
		
		
		if(data.length>0 )
		{
			double sum=0;
			for(int u=0;u<data.length;u++)
			{
				
				child = new Vector();
				child.addElement((u+1));
				child.addElement(itemname);
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
				child.addElement("<a href='Rept_SerialTrackReportPrint.jsp?serial="+data[u][12]+"'>Track</a>");
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				mn.add(child);
				sum = sum+Double.parseDouble(data[u][10].trim());
				 
				
			}
				child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("TOTAL :");
				child.addElement(Math.round(sum));
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				mn.add(child);
			 
		}
		
			request.setAttribute("table",mn);
			out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>
  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Item/Product Group" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Item/Product Name" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Received Date" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Current Date" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Stock (In Days )" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Unit Price" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Quality" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Track" sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Purchase Warranty(Yrs)" sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Change Warranty(Yrs)" sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Purchase Number" sortable="true"><%=temp.elementAt(16)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_StockAge.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_StockAge.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_StockAge.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br />


 
<%		 

		  
	}
	catch(Exception e)
	{
		
	}	
	%>
		
	 
</body>
</html>

 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
  
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
 <script language="javascript" src="../JavaScript/comfunction.js"></script><title>:: INVENTORY ::</title> 


 
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>


<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<body >
 		<%
	try
	{
		String sql = " ";
		String Branch = request.getParameter("Branch");
		String from = request.getParameter("from");
		String to = request.getParameter("to");
		String Producttype = request.getParameter("Producttype");
		
		
		sql = sql+"  SELECT d.CHR_BRANCHNAME ,a.CHR_TYPE,c.CHR_GROUPNAME,b.CHR_ITEMNAME,b.CHR_PURCHASEDES,  ";
		sql = sql+"  a.DAT_RECIVEDDATE,COUNT(*),SUM(a.DOU_UNITPRICE) ";
		sql = sql+"  FROM inv_t_vendorgoodsreceived  a,inv_m_item b,inv_m_itemgroup c,com_m_branch d   ";
		sql = sql+"  WHERE a.CHR_FLAG <> 'Y' AND a.CHR_TYPE ='I' AND a.CHR_ITEMID = b.CHR_ITEMID   ";
		sql = sql+"  AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID  AND a.INT_BRANCHID=d.INT_BRANCHID  ";
		if("".equals(Branch))
			sql = sql+"  AND a.INT_BRANCHID ="+Branch;
		sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)>="+ from;
		sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)<="+ to;
		
		sql = sql+"  AND a.CHR_SERIALNO is not null   ";
		sql = sql+"  GROUP BY a.CHR_ITEMID,a.DAT_RECIVEDDATE ";
		sql = sql+"  ORDER BY  b.CHR_ITEMNAME,d.CHR_BRANCHNAME  DESC   ";
		  
		String data[][] =  CommonFunctions.QueryExecute(sql);
		double sum=0.0;
		
		String reportheader="Stock Age"  ;
		Vector mn = new Vector();
		Vector child= null;
		if("0".equals(Producttype)  || "I".equals(Producttype)  )
		if(data.length>0 )
		{
			for(int u=0;u<data.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement("Item");
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				sum = sum+Double.parseDouble(data[u][7]);
				mn.add(child); 
						
			}
					child = new Vector();
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("Item Total");
					child.addElement(Math.round(sum));
					mn.add(child); 
		}	 
			
		   
		
		sql = "  SELECT   d.CHR_BRANCHNAME,a.CHR_TYPE,c.CHR_NAME,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC, ";
		sql = sql+"  a.DAT_RECIVEDDATE ,COUNT(*),SUM(a.DOU_UNITPRICE) ";
		sql = sql+"  FROM inv_t_vendorgoodsreceived  a,inv_m_produtlist b,inv_m_productgroup c ,com_m_branch d  ";
		sql = sql+"  WHERE a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_FLAG <> 'Y' AND a.CHR_TYPE ='P'    ";
		sql = sql+"  AND b.INT_PRODUCTGROUPID=c.INT_PRODUCTGROUPID AND a.INT_BRANCHID=d.INT_BRANCHID   ";
		sql = sql+"  AND a.CHR_SERIALNO is not null  ";
		sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)>="+ from;
		sql = sql+ " AND DATEDIFF(now(),a.DAT_RECIVEDDATE)<="+ to;
		
		if("".equals(Branch))
			sql = sql+"  AND a.INT_BRANCHID ="+Branch;
		
	
		sql = sql+"  GROUP BY a.CHR_ITEMID,a.DAT_RECIVEDDATE ";
		sql = sql+"  ORDER BY  b.CHR_PRODUCTCODE,d.CHR_BRANCHNAME  DESC   ";
		  
		String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		double sum1=0.0;
		
		if("0".equals(Producttype)  || "P".equals(Producttype)  ) 
		if(data1.length>0 )
		{
			for(int u=0;u<data1.length;u++)
			{
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data1[u][0]);
				child.addElement("Product");
				child.addElement(data1[u][2]);
				child.addElement(data1[u][3]);
				child.addElement(data1[u][4]);
				child.addElement(data1[u][5]);
				child.addElement(data1[u][6]);
				child.addElement(data1[u][7]);
				sum1 = sum1+Double.parseDouble(data1[u][7]);
				mn.add(child); 
				
						
			}
					 child = new Vector();
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("");
					child.addElement("Product Total");
					child.addElement(Math.round(sum1));
					mn.add(child);  
		}	 
		 	
 		
		 child = new Vector();
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("Item Total");
		child.addElement(Math.round(sum));
		mn.add(child); 
					
		 child = new Vector();
			
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("Product Total");
			child.addElement(Math.round(sum1));
			mn.add(child); 	
			
			
		child = new Vector();
		
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("");
		child.addElement("Net Total");
		child.addElement(Math.round(sum+sum1));
		mn.add(child); 
			 
		 
	 
	
	
	
	
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
		 
 %>
    <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S. No " sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Item/Product Group" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Item/Product Name" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Received Date" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Quantity" sortable="true"  style="text-align:right"><%=temp.elementAt(7)%></display:column>
					<display:column title="Value" sortable="true" style="text-align:right"><%=temp.elementAt(8)%></display:column>

					<display:setProperty name="export.csv.filename" value="StockAge.csv"/>
					<display:setProperty name="export.excel.filename" value="StockAge.xls"/>
					<display:setProperty name="export.xml.filename" value="StockAge.xml"/>
					<display:setProperty name="export.pdf.filename" value="StockAge.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>   
<br />	<br /><br /><center>	<a href='javascript:window.close()'> CLOSE</a>
</center><br /><br /><br />

 <%		 		 
		
		 
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}	
	%>
		
	 
</body>
</html>

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
  
<body >
  <%
	try
	{
		 
		out.print("<br>");
		String sql="";
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("division");
		String Producttype=request.getParameter("Producttype");
		
		String reportheader="STOCK"  ;
		double s=0.0;
		double s1=0.0;
		Vector mn = new Vector();
		Vector child= null;
		
			
		if ("P".equals(Producttype) ||  "0".equals(Producttype))
		{
			 
			sql = " SELECT  d.CHR_COMPANYNAME,c.CHR_BRANCHNAME,b.CHR_PRODUCTCODE ,b.CHR_PRODUCTDESC,e.CHR_DIVICODE, ";
			sql = sql+ " a.CHR_SERIALNO ,a.CHR_WARRANTY,a.DOU_UNITPRICE ,f.CHR_NAME ";
			sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_produtlist b,com_m_branch c,com_m_company d,inv_m_division e, inv_m_productgroup f  ";
			sql = sql+ " WHERE a.CHR_ITEMID=b.CHR_PRODUCTID  AND b.CHR_PTYPE !='S'   AND b.INT_PRODUCTGROUPID = f.INT_PRODUCTGROUPID   ";
			sql = sql+ " AND a.INT_BRANCHID=c.INT_BRANCHID ";
			sql = sql+ " AND c.INT_COMPANYID=d.INT_COMPANYID ";
			sql = sql+ " AND a.INT_DIVIID=e.INT_DIVIID ";
			sql = sql+ " AND a.CHR_FLAG='N' AND a.CHR_TYPE='P' ";
			if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID="+Branch;
			if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID="+division;		
				
			sql = sql+ "  AND a.CHR_SERIALNO is not null ORDER BY d.CHR_COMPANYNAME,c.CHR_BRANCHNAME";
			//out.println(sql);
			String data[][] = CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				
				for(int u=0;u<data.length;u++) 
				{
					child = new Vector();
					child.addElement((u+1));	 
					child.addElement(data[u][0]);
					child.addElement(data[u][1]); 
					child.addElement("Product" );
					child.addElement(data[u][2].toUpperCase() );
					child.addElement(data[u][3]);
					child.addElement(data[u][4]);
					child.addElement(data[u][5]);
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					s = s+Double.parseDouble(data[u][7]);
					mn.add(child); 
				}
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
			child.addElement("Product Total");
			child.addElement(Math.round(s));
			mn.add(child); 
			
		}			
		
		if ("I".equals(Producttype) ||  "0".equals(Producttype))
		{
			Producttype ="I";
			sql = " SELECT  d.CHR_COMPANYNAME,c.CHR_BRANCHNAME,b.CHR_ITEMNAME ,b.CHR_DES,e.CHR_DIVICODE,";
			sql = sql+ " a.CHR_SERIALNO ,a.CHR_WARRANTY,a.DOU_UNITPRICE , f.CHR_GROUPNAME ";
			sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_item b,com_m_branch c,com_m_company d,inv_m_division e ,inv_m_itemgroup f ";
			sql = sql+ " WHERE a.CHR_ITEMID=b.CHR_ITEMID  AND b.INT_ITEMGROUPID =f.INT_ITEMGROUPID  ";
			sql = sql+ " AND a.INT_BRANCHID=c.INT_BRANCHID ";
			sql = sql+ " AND c.INT_COMPANYID=d.INT_COMPANYID ";
			sql = sql+ " AND a.INT_DIVIID=e.INT_DIVIID ";
			sql = sql+ " AND a.CHR_FLAG='N' AND a.CHR_TYPE='I' ";
			if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID="+Branch;
			if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID="+division;		
			sql = sql+ "   AND a.CHR_SERIALNO is not null  ORDER BY d.CHR_COMPANYNAME,c.CHR_BRANCHNAME";
		 	//out.println(sql); 
			String data[][] = CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				
				for(int u=0;u<data.length;u++) 
				{
					child = new Vector();
					child.addElement((u+1));	 
					child.addElement(data[u][0]);
					child.addElement(data[u][1]); 
					child.addElement("Item" );
					child.addElement(data[u][2].toUpperCase() );
					child.addElement(data[u][3]);
					child.addElement(data[u][4]);
					child.addElement(data[u][5]);
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					s1 = s1+Double.parseDouble(data[u][7]);
					mn.add(child); 
				}
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
			child.addElement("Item Total");
			child.addElement(Math.round(s1));
			mn.add(child); 
  
		 
		}
		 
		if(s>0 || s1>0)
		{
			child = new Vector();
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("Net Total");
			child.addElement(Math.round(s1+s));
			mn.add(child); 
		}
		 	 
			
 
	
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
		 
 %>
    <display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No " sortable="true"><%=temp.elementAt(0)%></display:column>
					 
					<display:column title="Branch Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Item / Product Type" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Group"  sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Item / Product Code" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Division" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Warranty (yrs) " style="text-align:right" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Unit Price" style="text-align:right" sortable="true"><%=temp.elementAt(9)%></display:column>
					 <display:setProperty name="export.excel.filename" value="Rept_SerialStocks.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_SerialStocks.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_SerialStocks.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					
					 
</display:table>   
<br />	<br /><br /><center>	<a href='javascript:window.close()' > CLOSE</a>
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

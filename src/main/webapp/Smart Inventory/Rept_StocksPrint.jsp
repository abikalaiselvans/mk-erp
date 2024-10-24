<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%><head>
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


 <div>
<%
	try
	{
		 
		 
		String sql="";
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("division");
		String Producttype=request.getParameter("Producttype");
		String pname="";
		if("I".equals(Producttype))
			pname="Item";
		else
			pname="Product";
			
		if("P".equals(Producttype))
		{
			sql = " SELECT  d.CHR_COMPANYNAME,c.CHR_BRANCHNAME,e.CHR_DIVICODE,b.CHR_PRODUCTCODE ,b.CHR_PRODUCTDESC, ";
			sql = sql+ " COUNT(*) ,sum(a.DOU_UNITPRICE) ";
			sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_produtlist b,com_m_branch c,com_m_company d,inv_m_division e ";
			sql = sql+ " WHERE a.CHR_ITEMID=b.CHR_PRODUCTID  ";
			sql = sql+ " AND a.INT_BRANCHID=c.INT_BRANCHID  AND b.CHR_PTYPE !='S' ";
			sql = sql+ " AND c.INT_COMPANYID=d.INT_COMPANYID ";
			sql = sql+ " AND a.INT_DIVIID=e.INT_DIVIID ";
			sql = sql+ " AND a.CHR_FLAG='N' AND a.CHR_TYPE='"+Producttype+"' ";
			if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID="+Branch;
			if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID="+division;	
			sql = sql+ "  AND a.CHR_SERIALNO is not null GROUP BY a.INT_BRANCHID,a.CHR_ITEMID ORDER BY d.CHR_COMPANYNAME,c.CHR_BRANCHNAME";
		}			
		else
		{
		
			sql = " SELECT  d.CHR_COMPANYNAME,c.CHR_BRANCHNAME,e.CHR_DIVICODE,b.CHR_ITEMNAME ,b.CHR_DES,";
			sql = sql+ " COUNT(*) ,sum(a.DOU_UNITPRICE) ";
			sql = sql+ " FROM inv_t_vendorgoodsreceived a ,inv_m_item b,com_m_branch c,com_m_company d,inv_m_division e ";
			sql = sql+ " WHERE a.CHR_ITEMID=b.CHR_ITEMID  ";
			sql = sql+ " AND a.INT_BRANCHID=c.INT_BRANCHID ";
			sql = sql+ " AND c.INT_COMPANYID=d.INT_COMPANYID ";
			sql = sql+ " AND a.INT_DIVIID=e.INT_DIVIID ";
			sql = sql+ " AND a.CHR_FLAG='N' AND a.CHR_TYPE='"+Producttype+"' ";
			if(!"0".equals(Branch))
				sql = sql+ " AND a.INT_BRANCHID="+Branch;
				if(!"0".equals(division))
				sql = sql+ " AND a.INT_DIVIID="+division;	
			sql = sql+ "  AND a.CHR_SERIALNO is not null GROUP BY a.INT_BRANCHID,a.CHR_ITEMID ORDER BY d.CHR_COMPANYNAME,c.CHR_BRANCHNAME";
		 	
		 
		 
		}

		String reportheader="STOCK INFORMATION ";   
		String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		Vector mn = new Vector();
	 	Vector child= null;
	 
	 
		
		int rcount=0;
		double s=0.0;
		if(data.length>0)
		{
			
			for(int u=0;u<data.length;u++) 
			{
				
				child = new Vector();
				child.addElement((u+1));
				child.addElement(data[u][0]);
				child.addElement(data[u][1]);
				child.addElement(pname);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][2]);
				child.addElement(data[u][5]);
				child.addElement(data[u][6]);
				mn.add(child);	
				s = s+Double.parseDouble(data[u][6]);
			}
		}
	 
				 child = new Vector();
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("");
				child.addElement("TOTAL : ");
				child.addElement("");
				child.addElement(com.my.org.erp.common.CommonFunctions.Round(s));
				mn.add(child);
				
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
 	
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					
					<display:column title="Branch Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Item / Product Type" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Item / Product Code" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Division" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="No of Stock" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Average Price"  sortable="true"><%=temp.elementAt(8)%></display:column>
					
					 <display:setProperty name="export.excel.filename" value="Rept_StocksPrint.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_StocksPrint.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_StocksPrint.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 
<br />	<br />		 		
			
			

 
 
<%
 }
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
 %>
 </body>
</html>

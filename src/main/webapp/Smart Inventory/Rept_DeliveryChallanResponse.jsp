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
<body >
<%
	
	try
	{
		
	
		String sql ="";
		String sql1 ="";
		String Branch=request.getParameter("Branch");
		String division=request.getParameter("division");
		String itype=request.getParameter("itype");
		String item=request.getParameter("item");
		
		if("1".equals(itype))
		{
			 sql =  " SELECT a.CHR_ITEMID,a.CHR_TYPE,b.CHR_ITEMNAME,b.CHR_DES,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_QUALITY , DATE_FORMAT(d.DAT_DCDATE,'%d-%b-%Y'),c.CHR_DCNO ,FIND_A_CUSTOMER_NAME(e.INT_CUSTOMERID ), ";
			 sql = sql + "   d.INT_DCSTATUS,a.DOU_UNITPRICE ";
			 sql = sql + " FROM inv_t_vendorgoodsreceived  a  ,inv_m_item b , inv_t_directdcitem c,inv_t_directdc d,inv_m_customerinfo e ";
			 sql = sql + " WHERE a.CHR_QUALITY='H' AND a.CHR_ITEMID = b.CHR_ITEMID AND a.CHR_TYPE='I' AND a.CHR_SERIALNO !='' ";
			 sql = sql + " AND a.CHR_ITEMID = c.CHR_ITEMID ";
			 sql = sql + " AND  a.CHR_TYPE = c.CHR_TYPE  ";
			 sql = sql + " AND a.CHR_SERIALNO = c.CHR_SERIALNO   AND   d.INT_DCSTATUS=0 ";
			 sql = sql + " AND c.CHR_DCNO = d.CHR_DCNO  ";
			 sql = sql + " AND d.INT_CUSTOMERID = e.INT_CUSTOMERID ";
			 if(!"0".equals(Branch))
			 	sql = sql + " AND d.INT_BRANCHID =  "+Branch ;	
			 if(!"0".equals(division))
			 	sql = sql + " AND d.INT_DIVIID = '"+division+"'";
			 if(!"0".equals(item))
			 	sql = sql + " AND a.CHR_ITEMID = '"+item+"'";
			  sql = sql + " ORDER BY c.CHR_DCNO ";
			  
			  
		}
		
		if("2".equals(itype))
		{
			sql =  " SELECT a.CHR_ITEMID,a.CHR_TYPE,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_QUALITY ,DATE_FORMAT(d.DAT_DCDATE,'%d-%b-%Y'),c.CHR_DCNO ,FIND_A_CUSTOMER_NAME(e.INT_CUSTOMERID ),";
			sql = sql + "  d.INT_DCSTATUS,a.DOU_UNITPRICE  ";
			sql = sql + " FROM inv_t_vendorgoodsreceived  a  ,inv_m_produtlist b , inv_t_directdcitem c,inv_t_directdc d,inv_m_customerinfo e ";
			sql = sql + " WHERE a.CHR_QUALITY='H' AND a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_TYPE='P' AND a.CHR_SERIALNO !=''  AND b.CHR_PTYPE !='S'  ";
			sql = sql + " AND a.CHR_ITEMID = c.CHR_ITEMID ";
			sql = sql + " AND  a.CHR_TYPE = c.CHR_TYPE  ";
			sql = sql + " AND a.CHR_SERIALNO = c.CHR_SERIALNO   AND   d.INT_DCSTATUS=0 ";
			sql = sql + " AND c.CHR_DCNO = d.CHR_DCNO  ";
			sql = sql + " AND d.INT_CUSTOMERID = e.INT_CUSTOMERID ";
			 if(!"0".equals(Branch))
			 	sql = sql + " AND d.INT_BRANCHID =  "+Branch ;	
			 if(!"0".equals(division))
			 	sql = sql + " AND d.INT_DIVIID = '"+division+"'";
			 if(!"0".equals(item))
			 	sql = sql + " AND a.CHR_ITEMID = '"+item+"'";
				
			
			sql = sql + " ORDER BY c.CHR_DCNO ";
		}
		 
		//out.println(sql);
		String reportheader="DELIVERY CHALLAN  REPORT";   
		String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql); 
		Vector mn = new Vector();
	 	Vector child= null;
	  
        if(data.length>0)
		{
		
			double sum=0.0;
			for(int u=0;u<data.length;u++)
			{
				
				child = new Vector();
				child.addElement((u+1));
				if("I".equals(data[u][1]))
					child.addElement("ITEM");
				else
					child.addElement("PRODUCT");
				child.addElement(data[u][2]);
				child.addElement(data[u][3]);
				child.addElement(data[u][4]);
				child.addElement(data[u][5]);
				child.addElement("DC MODE");
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				if("0".equals(data[u][10]))
					child.addElement("DC - OPENED");
				else
					child.addElement("DC - CLOSED");
				child.addElement(data[u][11]);
				
				if(!"-".equals(data[u][11]))
					sum = sum  + Double.parseDouble(data[u][11]);
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
			child.addElement("");
			child.addElement("");
			child.addElement("");
			child.addElement("TOTAL :: ");
			child.addElement(com.my.org.erp.Math.MathFunction.keep2Digit(sum));
			mn.add(child);	
				
			
			 
		}
		 
		 
request.setAttribute("table",mn);
 %>

<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Type" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Item / Product" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Serial Number" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Warranty (Yrs)" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Mode" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="DC Date" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="DC No"  sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Customer Name"  sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Status"  sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="DC Value"  style="text-align:right" sortable="true"><%=temp.elementAt(11)%></display:column>
					
					
					 <display:setProperty name="export.excel.filename" value="Rept_DeliveryChallan.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DeliveryChallan.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DeliveryChallan.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='Rept_DeliveryChallan.jsp'> CLOSE</a></center>
 
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

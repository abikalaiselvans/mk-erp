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

<script language="javascript">
	function  Print(salno)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="DirectSalesPrint.jsp?salno="+salno +"&serialyes=false" ;
			
			 
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
	</script>
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
 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String itype = request.getParameter("itype");
		String item = request.getParameter("item");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String sql=""; 
		 String reportheader=CommonFunctions.QueryExecute("Select CONCAT(b.CHR_COMPANYNAME,'  @  ',a.CHR_BRANCHNAME   ) from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+Branch)[0][0]; 
		Vector mn = new Vector();
	 	Vector child= null;
		 
		 
		
		
		 if("1".equals(itype))
		{
				
				
				
 
				sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),a.CHR_TYPE,c.CHR_GROUPNAME,b.CHR_ITEMNAME,a.CHR_DESC,a.CHR_TYPE, ";
				sql = sql +" DATE_FORMAT(d.DAT_SALESDATE,'%d-%b-%Y'), ";
				sql = sql +" a.INT_QUANTITY,a.DOU_UNITPRICE, ";
				sql = sql +" a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,a.DOU_TOTAL,a.CHR_SWAP ";
				sql = sql +" FROM  ";
				sql = sql +" inv_t_swapsalesitem a,inv_m_item b , inv_m_itemgroup c, inv_t_directsales d,inv_m_customerinfo e ";
				sql = sql +" WHERE a.CHR_ITEMID = b.CHR_ITEMID AND a.CHR_TYPE='I' AND d.INT_SALESSTATUS =1 ";
				sql = sql +" AND b.INT_ITEMGROUPID = c.INT_ITEMGROUPID ";
				sql = sql +" AND a.CHR_SALESNO = d.CHR_SALESNO ";
				sql = sql +" AND d.INT_CUSTOMERID = e.INT_CUSTOMERID ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND d.INT_DIVIID="+division;	
				if(!"0".equals(division))
					sql = sql+ "  AND  d.INT_BRANCHID = "+Branch;	
				if(!"0".equals(month))
					sql = sql+ "  AND  MONTH(d.DAT_SALESDATE) = "+month;	
				if(!"0".equals(year))
					sql = sql+ "  AND  YEAR(d.DAT_SALESDATE) = "+year;		
				sql = sql+ "  ORDER BY b.CHR_ITEMID    ";
				//out.println(sql);
			 	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
				if(data.length>0)
				{
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1)+".");
						child.addElement(data[u][0]);
						child.addElement(data[u][1]);
						child.addElement("Item");
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						child.addElement("");
						child.addElement(data[u][7]);
						child.addElement(data[u][8]);
						child.addElement(data[u][9]);
						child.addElement(data[u][10]);
						child.addElement(data[u][11]);
						child.addElement(data[u][12]);
						child.addElement(data[u][13]);
						child.addElement(data[u][14]);
						child.addElement("");
						child.addElement("<a href=\"javascript:Print('"+data[u][0]+"')\">Print</a>");
						mn.add(child); 
						 
					}
					
				} 
				   
		}
			
			
			
		 
		
		
		
		//PRODUCT
		
		if("2".equals(itype))
		{
				
				
				sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),a.CHR_TYPE,c.CHR_NAME,b.CHR_PRODUCTCODE,a.CHR_DESC,b.CHR_PTYPE,    ";
				sql = sql+ "  DATE_FORMAT(d.DAT_SALESDATE,'%d-%b-%Y'),    ";
				sql = sql+ "  a.INT_QUANTITY,a.DOU_UNITPRICE,    ";
				sql = sql+ "  a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,a.DOU_TOTAL,a.CHR_SWAP    ";
				sql = sql+ "  FROM     ";
				sql = sql+ "  inv_t_swapsalesitem a,inv_m_produtlist b , inv_m_productgroup c, inv_t_directsales d,inv_m_customerinfo e    ";
				sql = sql+ "  WHERE a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_TYPE='P' AND d.INT_SALESSTATUS =1    ";
				sql = sql+ "  AND b.INT_PRODUCTGROUPID = c.INT_PRODUCTGROUPID    ";
				sql = sql+ "  AND a.CHR_SALESNO = d.CHR_SALESNO    ";
				sql = sql+ "  AND d.INT_CUSTOMERID = e.INT_CUSTOMERID    ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND d.INT_DIVIID="+division;	
				if(!"0".equals(division))
					sql = sql+ "  AND  d.INT_BRANCHID = "+Branch;	
				if(!"0".equals(month))
					sql = sql+ "  AND  MONTH(d.DAT_SALESDATE) = "+month;	
				if(!"0".equals(year))
					sql = sql+ "  AND  YEAR(d.DAT_SALESDATE) = "+year;		
				sql = sql+ "  ORDER BY b.CHR_PRODUCTID    ";
				 
				//out.println(sql); 
			 	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
				if(data.length>0)
				{
					for(int u=0;u<data.length;u++)
					{
						
						child = new Vector();
						child.addElement((u+1)+".");
						child.addElement(data[u][0]);
						child.addElement(data[u][1]);
						child.addElement("Product");
						child.addElement(data[u][3]);
						child.addElement(data[u][4]);
						child.addElement(data[u][5]);
						if("S".equals(data[u][6]))
							child.addElement("Consumables");
						else if("F".equals(data[u][6]))
							child.addElement("Full Product");
						else
							child.addElement("Combination");
						
						child.addElement(data[u][7]);
						child.addElement(data[u][8]);
						child.addElement(data[u][9]);
						child.addElement(data[u][10]);
						child.addElement(data[u][11]);
						child.addElement(data[u][12]);
						child.addElement(data[u][13]);
						child.addElement(data[u][14]);
						
						if("Y".equals(data[u][15]))
							child.addElement("Swap");
						else
							child.addElement("");
							
						child.addElement("<a href=\"javascript:Print('"+data[u][0]+"')\">Print</a>");
						mn.add(child); 
						 
					}
					
				} 
		}
		
	request.setAttribute("table",mn);
%>


<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Sales No"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Customer" sortable="true" ><%=temp.elementAt(2)%></display:column>
 					<display:column title="Type" sortable="true" ><%=temp.elementAt(3)%></display:column>
 					<display:column title="Group" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="P Code" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="Desc"  sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Category"  sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="Sale Date"  sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="Qty" style="text-align:right" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title="Unit Price" style="text-align:right" sortable="true" ><%=temp.elementAt(10)%></display:column>
					<display:column title="Discount" style="text-align:right" sortable="true" ><%=temp.elementAt(11)%></display:column>
					<display:column title="Unit Discount" style="text-align:right" sortable="true" ><%=temp.elementAt(12)%></display:column>
					<display:column title="Tax %"  style="text-align:right" sortable="true" ><%=temp.elementAt(13)%></display:column>
					<display:column title="Tax Amount" style="text-align:right" sortable="true" ><%=temp.elementAt(14)%></display:column>
					<display:column title="Total" style="text-align:right" sortable="true" ><%=temp.elementAt(15)%></display:column>
					<display:column title="Swap"  sortable="true" ><%=temp.elementAt(16)%></display:column>
					<display:column title="Print"  sortable="true" ><%=temp.elementAt(17)%></display:column>
					
 					
 					
 					
					<display:setProperty name="export.excel.filename" value="Rept_DetailedSales.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_DetailedSales.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_DetailedSales.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='Rept_DetailedSales.jsp'> CLOSE</a></center>
 

 
 <%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>		 
</body>
</html>

 
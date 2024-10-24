<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%
try
{
%> 	  
	  


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
<script language="JavaScript" src="../JavaScript/calendar1.js"
	type="text/javascript"></script>
<body >
 <%
	    String  Branch = request.getParameter("Branch");
	 	String  fromdate = request.getParameter("fromdate");
	 	String  todate = request.getParameter("todate");
	  	String itype = request.getParameter("itype");
	  	String item = request.getParameter("item");
		String filter = request.getParameter("filter");
		String cdata[][] = CommonFunctions.QueryExecute(" SELECT  a.CHR_COMPANYNAME ,b.CHR_BRANCHNAME  FROM com_m_company a ,com_m_branch b WHERE a.INT_COMPANYID = b.INT_COMPANYID AND b.INT_BRANCHID="+Branch );
 		String sql=""; 
		
		 
		 String reportheader="";
		  
		 Vector mn = new Vector();
		 Vector child= null;
		 
		 if("1".equals(itype)) 
		 {
			 	fromdate =   DateUtil.FormateDateSQL(fromdate) ;
				todate =  DateUtil.FormateDateSQL(todate) ;
				int qty1=0;
				int qty2=0;
				int qty3=0;
				int qty4=0;
				int qty5=0;
				double value1=0;
				double value2=0;
				double value3=0;
				double value4=0;
				double value5=0;
				double unitprice=0;
				
				sql = " SELECT a.CHR_GROUPNAME,b.CHR_ITEMID,b.CHR_ITEMNAME,b.CHR_DES ,DATE(NOW()),  ";
				sql = sql + " INV_FIND_A_ITEM_BEFORE_INWARD('"+Branch+"','"+fromdate+"',b.CHR_ITEMID), ";
				sql = sql + " INV_FIND_A_ITEM_BEFORE_OUTWARD('"+Branch+"','"+fromdate+"',b.CHR_ITEMID), ";
				sql = sql + " INV_FIND_A_ITEM_INWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_ITEMID), ";
				sql = sql + " INV_FIND_A_ITEM_OUTWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_ITEMID), ";
				sql = sql + " FUN_GET_BRANCH_NAME('"+Branch+"') ";
				sql = sql + " FROM inv_m_itemgroup a,  inv_m_item b";
				sql = sql + "  WHERE a.INT_ITEMGROUPID= b.INT_ITEMGROUPID  AND b.INT_ACTIVE !=0  ";
				
				if(!"0".equals(item))
						sql = sql + " AND b.CHR_ITEMID ='"+item+"'";
				//out.println(sql);
				String data[][] =  CommonInfo.doubleRecordSetArray(sql);
				if(data.length>0)
				{
				   	
				    for(int u=0;u<data.length;u++)
					{
						qty1=0;
						qty2=0;
						qty3=0;
						qty4=0;
						qty5=0;
						value1=0;
						value2=0;
						value3=0;
						value4=0;
						value5=0;
						 
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][9]);
						child.addElement("Item");
						child.addElement(data[u][0]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						child.addElement("Full Product");
						data[u][5] = data[u][5]+"0,0,0,0";
						qty1 = Integer.parseInt(  data[u][5].split(",") [0] );
						child.addElement(qty1);
						unitprice=Double.parseDouble( data[u][5].split(",")[1] );
						value1 = Double.parseDouble( data[u][5].split(",")[2] );
						child.addElement(value1);
						 
						qty2 = Integer.parseInt(data[u][6]);
						child.addElement(qty2);
						value2 =  (qty2*unitprice) ;
						child.addElement(Math.round(value2));
						child.addElement((qty1-qty2));
						child.addElement(Math.round(value1-value2));
						
						data[u][7] = data[u][7]+"0,0,0,0";
						qty3 = Integer.parseInt(  data[u][7].split(",")[0] );
						child.addElement(qty3);
						unitprice=Double.parseDouble( data[u][7].split(",")[1] );
						value3 = Double.parseDouble( data[u][7].split(",")[2] );
						child.addElement(Math.round(value3));
						
						
						
						
						qty4 = Integer.parseInt( data[u][8] );
						child.addElement(qty4);
						value4 =  (qty4 *unitprice);
						child.addElement(Math.round(value4));
						 
						child.addElement(Math.round(qty1-qty2+qty3-qty4 ) );
						child.addElement( Math.round(value1-value2 +value3-value4) );
					  
						if (  (qty1 >0) || (qty2 >0) || (qty3 >0)  || (qty3 >0)  || (qty4 >0) )
							mn.add(child);
				 
			      	}
					
					 
				}
				 
				 
				 
		 } 
		 
		 
		 if("2".equals(itype)) 
		 {
				 
				fromdate =  DateUtil.FormateDateSQL(fromdate) ;
				todate =  DateUtil.FormateDateSQL(todate) ;
				int qty1=0;
				int qty2=0;
				int qty3=0;
				int qty4=0;
				int qty5=0;
				double value1=0;
				double value2=0;
				double value3=0;
				double value4=0;
				double value5=0;
				double unitprice=0;
				
				sql = " SELECT a.CHR_NAME,b.CHR_PRODUCTID,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,b.CHR_PTYPE,  ";
				sql = sql + " INV_FIND_A_PRODUCT_BEFORE_INWARD('"+Branch+"','"+fromdate+"',b.CHR_PRODUCTID), ";
				sql = sql + " INV_FIND_A_PRODUCT_BEFORE_OUTWARD('"+Branch+"','"+fromdate+"',b.CHR_PRODUCTID), ";
				sql = sql + " INV_FIND_A_PRODUCT_INWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_PRODUCTID), ";
				sql = sql + " INV_FIND_A_PRODUCT_OUTWARD('"+Branch+"','"+fromdate+"','"+todate+"',b.CHR_PRODUCTID), ";
				sql = sql + " FUN_GET_BRANCH_NAME('"+Branch+"') ";
				sql = sql + " FROM inv_m_productgroup a, inv_m_produtlist b ";
				sql = sql + "  WHERE a.INT_PRODUCTGROUPID= b.INT_PRODUCTGROUPID  AND b.INT_ACTIVE !=0  ";
				sql = sql + "  AND b.CHR_PTYPE ='"+filter+"'";
				
				if(!"0".equals(item))
						sql = sql + " AND b.CHR_PRODUCTID ='"+item+"'";
				 
				 
				String data[][] =  CommonInfo.doubleRecordSetArray(sql);
				if(data.length>0)
				{
				   	
				    for(int u=0;u<data.length;u++)
					{
						qty1=0;
						qty2=0;
						qty3=0;
						qty4=0;
						qty5=0;
						value1=0;
						value2=0;
						value3=0;
						value4=0;
						value5=0;
						 
						child = new Vector();
						child.addElement((u+1));
						child.addElement(data[u][9]);
						child.addElement("Product");
						child.addElement(data[u][0]);
						child.addElement(data[u][2]);
						child.addElement(data[u][3]);
						if("F".equals(data[u][4]))
							child.addElement("Full Product");
						else if("C".equals(data[u][4]))
							child.addElement("Combination Product");
						else 
							child.addElement("Consumable Product");
						
						data[u][5] = data[u][5]+"0,0,0,0"; 
						qty1 = Integer.parseInt(  data[u][5].split(",") [0] );
						child.addElement(qty1);
						unitprice=Double.parseDouble( data[u][5].split(",")[1] );
						value1 = Double.parseDouble( data[u][5].split(",")[2] );
						child.addElement(value1);
						 
						qty2 = Integer.parseInt(data[u][6]);
						child.addElement(qty2);
						value2 =  (qty2*unitprice) ;
						child.addElement(Math.round(value2));
						child.addElement((qty1-qty2));
						child.addElement(Math.round(value1-value2));
						
						data[u][7] = data[u][7]+"0,0,0,0";
						qty3 = Integer.parseInt(  data[u][7].split(",")[0] );
						child.addElement(qty3);
						unitprice=Double.parseDouble( data[u][7].split(",")[1] );
						value3 = Double.parseDouble( data[u][7].split(",")[2] );
						child.addElement(Math.round(value3));
						
						
						
						
						qty4 = Integer.parseInt( data[u][8] );
						child.addElement(qty4);
						value4 =  (qty4 *unitprice);
						child.addElement(Math.round(value4));
						 
						child.addElement(Math.round(qty1-qty2+qty3-qty4 ) );
						child.addElement( Math.round(value1-value2 +value3-value4) );
					    
						if (  (qty1 >0) || (qty2 >0) || (qty3 >0)  || (qty3 >0)  || (qty4 >0) )
							mn.add(child);
				 
			      	}
					
					 
				}
				 
				 
		 } 
		 
	 
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center><br>"); 
		 
		 
		 
		
 %>
<display:table   id="_table" name="table"   export="true" pagesize="25">
        <display:caption><%=" STOCK BOOK IN AND OUT "%></display:caption>
        <display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
        <display:column title="S. No " sortable="true"><%=temp.elementAt(0)%></display:column>
        <display:column title="Branch" sortable="true"><%=temp.elementAt(1)%></display:column>
        <display:column title="Type" sortable="true"><%=temp.elementAt(2)%></display:column>
        <display:column title="Group" sortable="true"><%=temp.elementAt(3)%></display:column>
        <display:column title="Code" sortable="true"><%=temp.elementAt(4)%></display:column>
        <display:column title="Description" sortable="true"><%=temp.elementAt(5)%></display:column>
        <display:column title="" sortable="true"><%=temp.elementAt(6)%></display:column>
       <display:column title="Opening In  Qty" style="text-align:right" sortable="true"><%=temp.elementAt(11)%></display:column>
        <display:column title="Opening Value" style="text-align:right" sortable="true"><%=temp.elementAt(12)%></display:column>
        <display:column title="In Qty " style="text-align:right" sortable="true"><%=temp.elementAt(13)%></display:column>
        <display:column title="In Value" style="text-align:right" sortable="true"><%=temp.elementAt(14)%></display:column>
        <display:column title="Out Qty" style="text-align:right" sortable="true"><%=temp.elementAt(15)%></display:column>
        <display:column title="Out Value" sortable="true"><%=temp.elementAt(16)%></display:column>
        <display:column title="Close  Qty" sortable="true"><%=temp.elementAt(17)%></display:column>
        <display:column title="Close Value" sortable="true"><%=temp.elementAt(18)%></display:column>
        <display:setProperty name="export.csv.filename" value="Rept_StockBookDateView.csv"/>
        <display:setProperty name="export.excel.filename" value="Rept_StockBookDateView.xls"/>
        <display:setProperty name="export.xml.filename" value="Rept_StockBookDateView.xml"/>
        <display:setProperty name="export.pdf.filename" value="Rept_StockBookDateView.pdf"/>
        <display:setProperty name="export.pdf" value="true" />
</display:table> 
      
<br />	<br /><br />
<center>	<a href='javascript:window.close()' style="text-align:right"> CLOSE</a></center>
<br /><br /><br />

</body>
</html>

<%		
/*


 Before In Qty 
   Before In Value 
 After Out  Qty 
 After Out value 
 

*/   


}
catch(Exception e)
{
	out.println(e.getMessage());
	
}
%>
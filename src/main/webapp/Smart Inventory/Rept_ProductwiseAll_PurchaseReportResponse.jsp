<%@ page import="java.io.*,java.util.*"%>
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
  
   
</head><div>
<%
	try
	{
		 
			String branchid = request.getParameter("Branch");
			String division = request.getParameter("division");
			String vendor = request.getParameter("vendor");
			String payment = request.getParameter("payment");
			String account = request.getParameter("account");
			String fromdate = request.getParameter("fromdate");
			String todate = request.getParameter("todate");
			fromdate = DateUtil.FormateDateSQL(fromdate);
			todate =  DateUtil.FormateDateSQL(todate);
			String sql ="";
			String cpydata[][]=  CommonFunctions.QueryExecute("SELECT b.CHR_COMPANYNAME ,a.CHR_BRANCHNAME FROM com_m_branch a,com_m_company b WHERE a.INT_COMPANYID=b.INT_COMPANYID AND a.INT_BRANCHID="+branchid);
			String reportheader=" PURCHASE REPORT  FOR "+cpydata[0][0].toUpperCase()+" @ "+cpydata[0][1].toUpperCase()+" FROM  "+fromdate+"- TO "+todate+""; 
			
 
			Vector mn = new Vector();
	 		Vector child= null;
			
			
			sql = sql +" SELECT  FUN_GET_BRANCH_NAME(a.INT_BRANCHID),d.CHR_DIVICODE,   "; 
			sql = sql +" if( f.CHR_TYPE ='I' ,'ITEM','PRODUCT' ), "; 
			sql = sql +" if( f.CHR_TYPE ='I' , "; 
			sql = sql +" (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =f.CHR_ITEMID), "; 
			sql = sql +" (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =f.CHR_ITEMID)  "; 
			sql = sql +" ) productcode, "; 
			
			sql = sql +" if( f.CHR_TYPE ='I' , "; 
			sql = sql +" (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =f.CHR_ITEMID), "; 
			sql = sql +" (SELECT aa2.CHR_PRODUCTDESC FROM inv_m_produtlist aa2  WHERE  aa2.CHR_PRODUCTID =f.CHR_ITEMID)  "; 
			sql = sql +" ) productdescription, "; 
			
			sql = sql +" a.CHR_PURCHASEORDERNO, "; 
			sql = sql +" DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), e.CHR_VENDORNAME, "; 
			
			sql = sql +" f.INT_QUANTITY,f.DOU_UNITPRICE,  a.DOU_AMOUNT, "; 
			sql = sql +" a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS,a.CHR_ACCOUNTFLAG    ";  
			sql = sql +" FROM  inv_t_directpurchase a, "; 
			sql = sql +" inv_m_division d, inv_m_vendorsinformation  e,inv_t_directpurchaseitem f  "; 
			sql = sql +" WHERE   a.INT_DIVIID = d.INT_DIVIID   ";  
			sql = sql +" AND a.INT_VENDORID = e.INT_VENDORID    "; 
			sql = sql +" AND a.CHR_PURCHASEORDERNO =f.CHR_PURCHASEORDERNO   ";  
			 
			if(!"0".equals(division))
					sql = sql +" AND a.INT_DIVIID= "+division ;	
					
			if(!"0".equals(vendor))
				sql = sql +" AND a.INT_VENDORID= "+vendor ;		
				
			if(!"0".equals(branchid))
				sql = sql + " AND a.INT_BRANCHID = "+branchid ;
			if(!"0".equals(account))
				sql = sql + " AND a.CHR_ACCOUNTFLAG = '"+account+"' " ;
			
			if(!"0".equals(payment))
				sql = sql + " AND a.CHR_PAYMENTSTATUS = '"+payment+"' " ;
				
			sql = sql +" AND a.DAT_ORDERDATE >='"+fromdate+"' AND a.DAT_ORDERDATE <='"+todate+"'  ";
			sql = sql +" ORDER BY a.DAT_ORDERDATE  ";
			 
			String data[][] =  CommonFunctions.QueryExecute(sql);
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
					child.addElement("<a  target='_blank' href='ViewDirectPurchase.jsp?gdreceiveno="+data[u][5]+"'  target='_blank'>"+data[u][5]+"</a>");
					child.addElement(data[u][6]);
					child.addElement(data[u][7]);
					child.addElement(data[u][8]);
					child.addElement(data[u][9]);
					child.addElement(data[u][10]);
					child.addElement(data[u][11]);
					child.addElement(data[u][12]);
					
					if("Y".equals(data[u][13]))
						child.addElement("Completed");
					else if("P".equals(data[u][14]))
						child.addElement("Partially Completed");
					else 
						child.addElement("Pending");
						
					if("Y".equals(data[u][14]))
						child.addElement("Received");
					else
						child.addElement("Not Received");
				
					mn.add(child);	
						
					}
			} 
	
		
		
		 
		
		
		 
		request.setAttribute("table",mn);
		out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
%>		 
		 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="BRANCH" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="DIVISION" sortable="true" ><%=temp.elementAt(2)%></display:column>
					<display:column title="TYPE" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="ITEM / PRODUCT NAME" sortable="true" ><%=temp.elementAt(4)%></display:column>
					<display:column title="DESCRIPTION" sortable="true" ><%=temp.elementAt(5)%></display:column>
					<display:column title="PURCHASE NUMBER" sortable="true" ><%=temp.elementAt(6)%></display:column>
					<display:column title="Details" media="html" sortable="true" ><%=temp.elementAt(7)%></display:column>
					<display:column title="PURCHASE DATE" sortable="true" ><%=temp.elementAt(8)%></display:column>
					<display:column title="VENDOR NAME" sortable="true" ><%=temp.elementAt(9)%></display:column>
					<display:column title="QUANTITY" sortable="true" ><%=temp.elementAt(10)%></display:column>
					<display:column title=" UNIT PRICE" sortable="true" style="text-align:right"><%=temp.elementAt(11)%></display:column>
					<display:column title="AMOUNT" sortable="true" style="text-align:right"><%=temp.elementAt(12)%></display:column>
					<display:column title="TAX" sortable="true" style="text-align:right"><%=temp.elementAt(13)%></display:column>
					<display:column title="NET TOTAL" sortable="true" style="text-align:right"><%=temp.elementAt(14)%></display:column>
					<display:column title="PAYMENT STATUS" sortable="true" style="text-align:right"><%=temp.elementAt(15)%></display:column>
					<display:column title="ACCOUNT DEPT" sortable="true" style="text-align:right"><%=temp.elementAt(16)%></display:column>
					
					
					<display:setProperty name="export.excel.filename" value="Rept_ProductwisePurchaseReport.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_ProductwisePurchaseReport.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_ProductwisePurchaseReport.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     

<br />	<center>	<a href='Rept_ProductwiseAll_PurchaseReport.jsp'> CLOSE</a></center>

<br /><br />
 
	 		 
<%		  }
 catch(Exception e)
 {
 	e.printStackTrace();
	out.println(e.getMessage());
 }
	  	
  %>
 </body>
</html>

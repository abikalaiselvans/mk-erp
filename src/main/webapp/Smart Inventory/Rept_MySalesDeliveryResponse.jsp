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
 		String reportheader="DELIVERY INFORMATIONS"; 
		String Branch = request.getParameter("Branch");
		String division = request.getParameter("division");
		String customer = request.getParameter("customer");
		String ref = request.getParameter("ref");
		String delivery = request.getParameter("delivery");
		String saleDate = request.getParameter("saleDate");
		String saleDate2  = request.getParameter("saleDate2");
		saleDate = DateUtil.FormateDateSQL(saleDate);
		saleDate2 = DateUtil.FormateDateSQL(saleDate2);
		
		
			
			
			
		String sql ="";
		sql = " SELECT a.CHR_SALESNO,c.CHR_BRANCHNAME,d.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), ";
		sql = sql + " DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF), ";
		sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1),FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2), ";
		sql = sql + " a.DOU_TOTALAMOUNT,if(a.CHR_PAYMENTSTATUS='N','Pending',if(a.CHR_PAYMENTSTATUS='Y','Completed','Partial')), ";
		sql = sql + " if(a.CHR_DELIVERY='N','Pending',if(a.CHR_DELIVERY='P','Progress',if(a.CHR_DELIVERY='Y','Delivered','Rejected'))),  ";
		sql = sql + " if(a.CHR_DELIVERYTHROUGH ='C','Courier',if(a.CHR_DELIVERYTHROUGH='P','Person',if(a.CHR_DELIVERYTHROUGH='O','Own','Vehicle'))),  ";
		sql = sql + " a.CHR_COURIER_EMPID,a.CHR_COURIER_EMPID_MOBILE,  ";
		sql = sql + " if(a.INT_COURIERID =0 ,'',(SELECT e.CHR_COURIERNAME FROM inv_m_courier e WHERE e.INT_COURIERID =a.INT_COURIERID)), ";
		sql = sql + " a.DOU_COURIERAMOUNT,  ";
		sql = sql + " DATE_FORMAT(a.DAT_COURIERDATE,'%d-%b-%Y %h:%m:%s'),  ";
		sql = sql + " a.CHR_STARTING_PLACE,a.CHR_ENDING_PLACE,a.INT_COURIER_KILOMETER,  ";
		sql = sql + " a.CHR_COURIER_DESC,a.CHR_RECEIVERNAME,a.CHR_RECEIVER_MOBILE,  ";
		sql = sql + " DATE_FORMAT(a.DAT_DISPATCHEDDATE,'%d-%b-%Y %h:%m:%s'),  ";
		sql = sql + " a.CHR_CLOSEDBY,a.CHR_RECEIVER_DESC,datediff(a.DAT_COURIERDATE,a.DAT_DISPATCHEDDATE) , ";
		sql = sql + " e.DOU_SUPPORT,e.DOU_INSTALLATION,e.DOU_TRANSPORT ";
		sql = sql + " FROM inv_t_directsales a , inv_m_customerinfo b, com_m_branch c, inv_m_division d,  inv_t_contribution e ";
		sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
		sql = sql + " AND a.INT_BRANCHID  = c.INT_BRANCHID  ";
		sql = sql + " AND a.INT_DIVIID =d.INT_DIVIID AND a.CHR_SALESNO =e.CHR_SALESNO ";
		sql = sql +" AND a.CHR_REF='"+session.getAttribute("EMPID")+"'";
		sql = sql + " AND a.DAT_SALESDATE >='"+saleDate+"' ";
		sql = sql + " AND a.DAT_SALESDATE <='"+saleDate2+"' ";
		if(!"0".equals(Branch)) 
			sql = sql + " AND a.INT_BRANCHID="+Branch;
  
  		if(!"0".equals(division)) 
			sql = sql + " AND  a.INT_DIVIID="+division;
			
		if(!"0".equals(customer)) 
			sql = sql + " AND  a.INT_CUSTOMERID="+customer;
  	
		if(!"0".equals(ref)) 
			sql = sql + " AND  a.CHR_REF='"+ref+"' ";
		if(!"0".equals(delivery)) 
			sql = sql + " AND  a.CHR_DELIVERY='"+delivery+"' ";
  		//out.println(sql);
		
		Vector mn = new Vector();
	 	Vector child= null;
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
				child.addElement(data[u][6]);
				child.addElement(data[u][7]);
				child.addElement(data[u][8]);
				child.addElement(data[u][9]);
				child.addElement(data[u][10]);
				child.addElement(data[u][11]);
				child.addElement(data[u][12]);
				child.addElement(data[u][13]);
				child.addElement(data[u][14]);
				child.addElement(data[u][15]);
				child.addElement(data[u][16]);
				child.addElement(data[u][17]);
				child.addElement(data[u][18]);
				child.addElement(data[u][19]);
				child.addElement(data[u][20]);
				child.addElement(data[u][21]);
				child.addElement(data[u][22]);
				child.addElement(data[u][23]);
				child.addElement(data[u][24]);
				child.addElement(data[u][25]);
				child.addElement(data[u][26]);
				child.addElement(data[u][27]);
				child.addElement(data[u][28]);
				child.addElement(data[u][29]);
				mn.add(child); 
			}
		} 
		
		request.setAttribute("table",mn);
%>
<display:table   id="_table" name="table"   export="true" pagesize="25">
 
	 				<display:caption><%=reportheader.toUpperCase()%></display:caption>
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Branch"   sortable="true"><%=temp.elementAt(2)%></display:column>
                    <display:column title="Division"   sortable="true"><%=temp.elementAt(3)%></display:column>
                    <display:column title="Sales No"   sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Sale Date"   sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Customer"   sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Sale Amount"   sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="Payment Status"   sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="M.E - 1"   sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="M.E - 2"   sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="M.E - 3"   sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Delivery Status"   sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="Despatch Through"   sortable="true"><%=temp.elementAt(12)%></display:column>
					<display:column title="Person Name"   sortable="true"><%=temp.elementAt(13)%></display:column>
					<display:column title="Person Contact"   sortable="true"><%=temp.elementAt(14)%></display:column>
					<display:column title="Courier  "   sortable="true"><%=temp.elementAt(15)%></display:column>
					<display:column title="Courier   Anount"   sortable="true"><%=temp.elementAt(16)%></display:column>
					<display:column title="Starting Date"   sortable="true"><%=temp.elementAt(17)%></display:column>
					<display:column title="Starting Place "   sortable="true"><%=temp.elementAt(18)%></display:column>
					<display:column title="Ending Place"   sortable="true"><%=temp.elementAt(19)%></display:column>
					<display:column title="Kilometer"   sortable="true"><%=temp.elementAt(20)%></display:column>
					<display:column title="Description"   sortable="true"><%=temp.elementAt(21)%></display:column>
					<display:column title="Receiver Name"   sortable="true"><%=temp.elementAt(22)%></display:column>
					<display:column title="Receiver Contact"   sortable="true"><%=temp.elementAt(23)%></display:column>
					<display:column title="Received Date"   sortable="true"><%=temp.elementAt(24)%></display:column>
					<display:column title="Closed BY"   sortable="true"><%=temp.elementAt(25)%></display:column>
					<display:column title="Reeceived Description"   sortable="true"><%=temp.elementAt(26)%></display:column>
					<display:column title="Day difference"   sortable="true"><%=temp.elementAt(27)%></display:column>
					<display:column title="Support Charge"   sortable="true"><%=temp.elementAt(28)%></display:column>
					<display:column title="Installation Charge"   sortable="true"><%=temp.elementAt(29)%></display:column>
					<display:column title="Transport difference"   sortable="true"><%=temp.elementAt(30)%></display:column>
					 
					<display:setProperty name="export.excel.filename" value="Rept_MyDelivery.xls"/>
					<display:setProperty name="export.pdf.filename" value="Rept_MyDelivery.pdf"/>
					<display:setProperty name="export.csv.filename" value="Rept_MyDelivery.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
					 
</display:table> 
    
<br />	<center>	<a href='javascript:window.close()'> CLOSE</a>
</center>
 <%
}
catch(Exception e)
{
}
%>		 
</body>
</html>


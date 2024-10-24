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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body >
 <%
try
{
 			String reportheader="PAYMENT COLLECTION  "; 
			String fromdate = request.getParameter("fromdate");
			String todate = request.getParameter("todate");
			
			String sql = "";
			sql = sql +" ( ";
			sql = sql +" SELECT CHR_SALESORDERNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment,  ";
			sql = sql +" IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(CHR_BANKNAME)) bank,  ";
			sql = sql +" CHR_PAYNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT,  ";
			sql = sql +" CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY), ";
			sql = sql +" FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)  FROM    inv_t_customersalespayment   "; 
			sql = sql +"  WHERE DAT_PAYMENTDATE >= '"+DateUtil.FormateDateSQL(fromdate)+"' ";
			sql = sql +"   AND  DAT_PAYMENTDATE <= '"+DateUtil.FormateDateSQL(todate)+"' ";
			sql = sql +"  )  ";
			sql = sql +" UNION  ";
			sql = sql +"  ( ";
			sql = sql +" SELECT CHR_SALESNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment,  ";
			sql = sql +" IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(INT_BANKID)) bank,  ";
			sql = sql +" CHR_REFNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT,   ";
			sql = sql +" CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)  ";
			sql = sql +" FROM    inv_t_servicebillingpayment   ";
			sql = sql +"  WHERE DAT_PAYMENTDATE >= '"+DateUtil.FormateDateSQL(fromdate)+"' ";
			sql = sql +"   AND  DAT_PAYMENTDATE <= '"+DateUtil.FormateDateSQL(todate)+"' ";	
			sql = sql +" ) ";
			
			
			Vector mn = new Vector();
			Vector child= null;
			
			
			String data[][] = CommonFunctions.QueryExecute(sql);	
			if(data.length>0)
			{
				for(int y=0;y<data.length;y++)
				{
					child = new Vector();
					child.addElement(y+1);
					child.addElement(data[y][0]);
					child.addElement(data[y][1]);
					child.addElement(data[y][2]);
					child.addElement(data[y][3]);
					child.addElement(data[y][4]);
					child.addElement(data[y][5]);
					child.addElement(data[y][6]);
					child.addElement(data[y][7]);
					child.addElement(data[y][8]);
					child.addElement(data[y][9]);
					mn.add(child);
				}
			}
			 
	 
	
 
	 
 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center> ");
  
		 
%>
  
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Invoice" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Customer" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Payment" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Bank" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Ref number " sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Payment Date" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Paid Amount" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Description" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Collected By" sortable="true"><%=temp.elementAt(9)%></display:column>
                    <display:column title="Credited to " sortable="true"><%=temp.elementAt(10)%></display:column>
                    
					<display:setProperty name="export.excel.filename" value="todayCollectionPayment.xls"/>
					<display:setProperty name="export.pdf.filename" value="todayCollectionPayment.pdf"/>
					<display:setProperty name="export.csv.filename" value="todayCollectionPayment.csv"/>
					<display:setProperty name="export.pdf"  value="true" />
					 
</display:table>     
<br />	<center>	<a href='todayCollectionPayment.jsp'> CLOSE</a></center><br /><br />


 
<%		 		 
}
catch(Exception e)
{
 	System.out.println(e.getMessage());
}
%>
<%@ include file="../footer.jsp"%>

</body>
</html>

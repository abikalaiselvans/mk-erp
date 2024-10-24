<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<html>
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

<title>:: INVENTORY ::</title></head>

<body >
<%
	
	//Connection con ;
	//PreparedStatement pstm;
	//con = conbean.getConnection();
	try
	{
		String length = request.getParameter("length");
		String bid = request.getParameter("bid");
		int l = Integer.parseInt(length);
		String pid="";
		String pstock="";
		String pprice="";
		String sql="";
		for(int u=0; u<l;u++)
		{
			pid = request.getParameter("pid"+(u+1));
			pstock = request.getParameter("stockinhand"+(u+1));
			pprice = request.getParameter("price"+(u+1));
			sql = " UPDATE inv_t_stock SET  INT_STOCKINHAND=" + pstock+" WHERE CHR_TYPE='P' AND CHR_ITEMID='"+pid+"' AND  INT_BRANCHID="+bid;
			com.my.org.erp.common.CommonFunctions.Execute(sql);
			 
			sql = " UPDATE inv_t_averageprice SET  DOU_AVGPRICE=" + pprice+" WHERE CHR_TYPE='P' AND CHR_ITEMID='"+pid+"' AND  INT_BRANCHID="+bid;
			//out.println(sql);
			com.my.org.erp.common.CommonFunctions.Execute(sql); 
		}
	}
	catch(Exception e)
	{
	}	
	response.sendRedirect("InventoryMain.jsp");
%>

</body>
</html>

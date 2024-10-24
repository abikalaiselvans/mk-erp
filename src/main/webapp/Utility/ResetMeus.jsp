<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%@ page  import="com.my.org.erp.common.CommonFunctions" %>
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


<title> :: UTILITY :: </title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<%
try
{
	
		
		String staffid = request.getParameter("ename");
		String module = request.getParameter("module");
		
		
		if("0".equals(module))
		{
			String sql = " UPDATE m_user SET ";
			sql = sql + "  CHR_MENUHRM='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_hrm WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUATTENDANCE='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    	m_menu_attendance	WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUPAYROL='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    		m_menu_payroll		WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUMANAGEMENT='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    	m_menu_management	WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUMARKETING='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    	m_menu_marketing	WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUINVENTORY='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM   		m_menu_inventory	WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUSTOCK='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    		m_menu_stock		WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUACCOUNT='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    		m_menu_accounts		WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUUTILITY='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    		m_menu_utility		WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  CHR_MENUSTAFF='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM    		m_menu_staff		WHERE  INT_MENUID >0 AND CHR_MENUDES ='Root'")+"' ,";	
			sql = sql + "  DT_UPDATEDATE=now() , CHR_UPDATESTATUS='Y' WHERE CHR_USRNAME !='ADMIN'";
			com.my.org.erp.common.CommonFunctions.Execute(sql);
		}
		else
		{
			String pdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ID,CHR_FIELD,CHT_TABLE FROM  m_projectmodule  WHERE INT_ID="+module);
			String sql = " UPDATE m_user SET ";
			sql = sql + "  "+pdata[0][1]+"='"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  "+pdata[0][2]+" WHERE CHR_MENUDES ='Root'")+"'  DT_UPDATEDATE=now() , CHR_UPDATESTATUS='Y' WHERE CHR_USRNAME !='ADMIN' ";	
			com.my.org.erp.common.CommonFunctions.Execute(sql);
		}	
		
		response.sendRedirect("Userframe.jsp");	 
		


}
catch(Exception e)
{
}
%>
</body>
</html>

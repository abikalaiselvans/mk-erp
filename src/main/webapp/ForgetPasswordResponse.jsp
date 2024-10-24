<%@ page  language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.setting.*"%>
<html>
<head>
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 
</head>
<style type="text/css">
 
.titles {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: .7pc; font-weight: bold; color: #000066}
.bord1 {  border: #000066; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px}
.button1{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif}
.button2{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;    BACKGROUND-COLOR: #cc0033}
.button3{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;    BACKGROUND-COLOR: #5f9ea0}
 
.style2 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: .7pc; font-weight: bold; color: #FF0000; }
</style>
<body  onpaste='return false;'>
<%
String email = request.getParameter("email");
String dob = request.getParameter("dob");
String status = request.getParameter("status");
String sql ="";
String passdecision[][]=CommonFunctions.QueryExecute("SELECT CHR_FORGETPASSWORD FROM  m_institution WHERE INT_ID=1");



if(passdecision[0][0].equals("Y"))
{
	if(status.equals("O"))
	{
		sql="SELECT count(*) FROM com_m_staff WHERE CHR_EMAILID='"+email+"' AND DT_DOB='"+dob+"'";
		 
		if(CommonFunction.RecordExist(sql))
		{
			String pdata[][]=CommonFunctions.QueryExecute("SELECT CHR_FORGETPASSWORD FROM  m_institution WHERE INT_ID=1");
			sql=" SELECT FUN_GET_FORGETPASSWORD('"+email+"','"+dob+"') ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			sql="";
			sql = " Your Pass word :: "+data[0][0];
			if("Y".equals(pdata[0][0]))
			{
					//com.my.org.erp.General.General.SimpleMail(""+CommonData.mailid, email, "Login Password for Smart Campus", sql);
					String recipients[] = new String[1];
					recipients[0] = CommonData.mailid;
					com.my.org.erp.mail.Mail.SimpleHTMLMail(recipients, "Login Password for Smart Campus" ,sql);
					System.out.println("====");
					%>
					<SCRIPT language="javascript">
						window.close()
					</SCRIPT>
			<%
			}
			else
			{	
				out.println("<br><br><br><div align='center'><h3 color='red'>"+sql+"</h3></div>");
			}
		}
		else
		{
			out.println("<br><br><br><div align='center'><h3 color='red'>"+email +" and " +dob+"</h3></div>");
			out.println("<br><br><br><div align='center'><h3 color='red'>Sorry you are not a Registered User</h3></div>");
		}
	}
	else//personal mail
	{
		sql="SELECT count(*) FROM com_m_staff WHERE CHR_PERMAILID='"+email+"' AND DT_DOB='"+dob+"'";
		if(CommonFunction.RecordExist(sql))
		{
			String pdata[][]=CommonFunctions.QueryExecute("SELECT CHR_FORGETPASSWORD FROM  m_institution WHERE INT_ID=1");
			sql=" SELECT FUN_GET_FORGETPASSWORD('"+email+"','"+dob+"') ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			sql="";
			sql = " Your Pass word :: "+data[0][0];
			if("Y".equals(pdata[0][0]))
			{
					com.my.org.erp.General.General.SimpleMail(""+CommonData.mailid, email, "Login Password for Smart Campus", sql);
					%>
					<SCRIPT language="javascript">
						window.close()
					</SCRIPT>
			<%
			}
			else
			{	
				out.println("<br><br><br><div align='center'><h3 color='red'>"+sql+"</h3></div>");
			}
		}
		else
		{
			out.println("<br><br><br><div align='center'><h3 color='red'>"+email +" and " +dob+"</h3></div>");
			out.println("<br><br><br><div align='center'><h3 color='red'>Sorry you are not a Registered User</h3></div>");
		}
	}

}
else {
	
	sql=" SELECT FUN_GET_FORGETPASSWORD('"+email+"','"+dob+"') ";
	String data[][]=CommonFunctions.QueryExecute(sql);
	sql = " Your Password :: "+data[0][0];
	out.println("<br><br><br><div align='center'><h3 color='red'>"+sql+"</h3></div>");
}

 %>
 
</body>
</html>

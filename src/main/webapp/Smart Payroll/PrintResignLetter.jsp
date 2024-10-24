<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: PAYROLL ::</title>


 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<body>

<p>
  <%
	String empid =request.getParameter("empid");
	String sql ="";
	sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(c.DT_TERM_DATE,'%d-%b-%Y'),b.CHR_DESIGNAME, ";
	sql = sql + " if(a.CHR_GENDER= 'Male' ,'Mr.' , (if(a.CHR_MARITALSTATUS ='M', 'Mrs. ' ,'Miss. ' )) ), ";
	sql = sql + " if(a.CHR_GENDER= 'Male' ,'his' ,'her') , if(a.CHR_GENDER= 'Male' ,'he' ,'she') ";
	sql = sql + " FROM com_m_staff a, com_m_desig b, pay_m_emp_termination c ";
	sql = sql + " WHERE a.CHR_EMPID =c.CHR_EMPID AND a.INT_DESIGID = b.INT_DESIGID AND a.CHR_EMPID = '"+empid+"'";
	//out.println(sql);
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
%>
 
<table width="600" border="0" align="center" cellpadding="2" cellspacing="2" class="boldEleven">
  <tr>
    <td width="611">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center" class="boldgre">
      <div align="center">Sub: Relieving Order cum Experience Certificate </div>
    </div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="49"><div align="justify">Further to your resignation letter, we are placed to inform you that you are relieved from your service effective<span class="boldThirteen"> <%=data[0][3]%> </span>.</div></td>
  </tr>
  <tr>
    <td><div align="justify"></div></td>
  </tr>
  <tr>
    <td height="92"><div align="justify">We also certify <span class="boldThirteen"><%=data[0][5] +" " +data[0][1]%> </span>was employed in our organization as <span class="boldThirteen"> <%=data[0][4]%> </span> from <span class="boldThirteen"> <%=data[0][2]%> &nbsp;&nbsp;to&nbsp;&nbsp;<%=data[0][3]%>.</span>&nbsp;&nbsp; During <%=data[0][6]%> tenure in our organization <%=data[0][7]%> was found to be efficient, hardworking and sincere in delivering <%=data[0][6]%> duties to the organization and <%=data[0][6]%> conduct was very good. </div></td>
  </tr>
  <tr>
    <td><div align="justify"></div></td>
  </tr>
  <tr>
    <td><div align="justify">we wish you best of luck in the new assignment that you are taking up </div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Wishing you all the very best </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Your's faithfully </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="boldThirteen">For IT Solutions Pvt Ltd, </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="boldThirteen">Authorized Signatory </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
 
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="boldred">Note * </td>
  </tr>
  <tr>
    <td class="boldgreen" align="center">[&nbsp;Employee background verifications using the following link : <font style="text-decoration:underline"><%=CommonFunctions.getPath(request)+"/Employee Verififcation.jsp"%>&nbsp;]</font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<%

}
else
	out.println("<br><br><br><br><br><center><font class='bolddeepred'>Data not found....</font></center>");

%>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

<%@ page import="java.io.*,java.util.*"%>
<%@ page errorPage="../errorpge.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<html>
<head>

<title> :: UTILITY :: </title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
<form name="frm" method="get" action="UserList.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td height="100">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" width="60%" border="0"  
			cellpadding="1" cellspacing="1">
			<tr>
				<td align="center">
				<div id="divscroll" style="OVERFLOW: auto;width:780px;height:120px">
				<% 			    
			  	try
			  		{
			  		 String userName=request.getParameter("userName");
			  		 String type = request.getParameter("grade");
					 String live = request.getParameter("Live");
					 String add = request.getParameter("add");
					 String edit = request.getParameter("edit");
					 String delete = request.getParameter("delete");
					 String changepassword = request.getParameter("changepassword");
					 String sessiontime = request.getParameter("sessiontime");
					  
			  		 String sql="Update m_user set CHR_LIVE='"+live+"' , CHR_TYPE='"+type+"' ,";
					 sql = sql +" CHR_ADD ='"+add+"' ,";
					 sql = sql +" CHR_EDIT ='"+edit+"' ,";
					 sql = sql +" CHR_DELETE ='"+delete+"' ,  ";
					 sql = sql +" CHR_USRPWD =(ENCODE('"+changepassword+"','9865043008')) ,";
					 sql = sql +" INT_SESSIONTIME = ("+sessiontime+" * 60 )  ";
					 sql = sql +" where CHR_USRNAME='"+userName+"'";
					 //out.println(sql);
					 Connection con=conbean.getConnection();
					 Statement st=con.createStatement();
					 st.execute(sql);
					 session.setMaxInactiveInterval(Integer.parseInt(sessiontime)*60); 
					 session.setAttribute("USERTYPE", type);
					 session.setAttribute("USRTYPE", (""+type).toUpperCase());
			  		}
			  		catch(Exception e)
			  		{
					  	
						out.println("<br> "+e.getMessage());
			  			//response.sendRedirect("../errorpg.jsp?error="+e.getMessage().toString());
			  		}					 
		   %> <span class="boldEleven"> Edit Sucessfully </span></div>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table>
			<tr>
				<td width="54"><input type="submit"  value="Close"   accesskey="c" 
					class="buttonbold"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="100"></td>
	</tr>
</table>
 </form>
</body>
</html>

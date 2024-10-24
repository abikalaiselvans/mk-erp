<%@ page import="java.sql.*" isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%!
	String sql;
%>
<html>
<head>
<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
 	 
function  Validate()
{
	try
	{
		if(
		  	checkNullSelect('Month','Select Month','0')
			&& checkNullSelect('Year','Select Year','0')
			
		  )
		  {
 					return true;
 			} 
		  else
		  	return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
	
	 
	 
	
	 
</script>
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

<style type="text/css">
@import url("../bootstrap/css/bootstrap.min.css");
@import url("../JavaScript/SmartStyles.css");
</style>
<script src="../bootstrap/js/jquery.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script> 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form action="../SmartLoginAuth" method="post"   name="salfrm" onSubmit=" return Validate()"  AUTOCOMPLETE = "off">
<p>&nbsp;</p>
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
        <%
		String sql ="";
		String monthname= request.getParameter("monthname");
		String year= request.getParameter("year");
		 
		sql = " SELECT b.INT_VERIFICATIONID,a.CHR_EMPID ID, a.CHR_STAFFNAME NAME, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y') DOJ,a.CHR_TYPE Types, ";
		sql = sql + " DATE_FORMAT(a.DAT_RESIGNDATE,'%d-%b-%Y') DOR ,b.INT_ATTENDANCECYCLE ";
		sql = sql + " FROM  com_m_staff a,pay_t_salaryverification b ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.CHR_MONTH = '"+monthname+"' AND  b.INT_YEAR= "+year;
		sql = sql + "   GROUP BY a.CHR_EMPID ORDER BY a.CHR_STAFFNAME";
		String data[][] = CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			out.println("<center>");
			out.println("<div class='container'><div class='col-md-6'>");
			out.println("<table  width='100%'class='table table-bordered' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'>");
			out.println("<td class='boldEleven' colspan='10' align='center'><div class='page-header'><h3>SALARY NOT PROCESSED FOR THE MONTH - "+monthname+" - "+year+" </h3></div></td>");
			out.println("</tr>");
			
			out.println("<tr class='MRow1'>");
			out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
			out.println("<td class='boldEleven' align='center'><b>ID</b></td>");
			out.println("<td class='boldEleven' align='center'><b>Name</b></td>");
			out.println("<td class='boldEleven' align='center'><b>DOJ</b></td>");
			out.println("<td class='boldEleven' align='center'><b>Type</b></td>");
			out.println("<td class='boldEleven' align='center'><b>DOR</b></td>");
			out.println("<td class='boldEleven' align='center'><b>Cycle</b></td>");
			out.println("<td class='boldEleven' align='center'><b>Reason</b></td>");
			//out.println("<td class='boldEleven' align='center'><b>&nbsp;</b></td>");
			out.println("</tr>");
			for(int x=0;x<data.length;x++)
			{
				if(x%2==0)
					out.println("<tr class='success'>");
				else	
					out.println("<tr class='info'>");
				out.println("<td class='boldEleven'>"+(x+1)+".</td>");
				out.println("<td class='boldEleven'>"+data[x][1]+"</td>");
				out.println("<td class='boldEleven'>"+data[x][2]+"</td>");
				out.println("<td class='boldEleven'>"+data[x][3]+"</td>");
				out.println("<td class='boldEleven'>"+data[x][4]+"</td>");
				out.println("<td class='boldEleven'>"+data[x][5]+"</td>");
				out.println("<td class='boldEleven'>"+data[x][6]+"</td>");
				out.println("<td class='boldEleven'><b><input type='text' name='reason"+x+"' id='reason"+x+"' value='' size='30'/></b></td>");
				//out.println("<td class='boldEleven'><b>&nbsp;</b></td>");
				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div></div>");
			out.println("</center>");
		}
		%>
        </td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<p>&nbsp;</p>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

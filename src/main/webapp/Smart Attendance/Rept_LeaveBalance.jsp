<%@ page import="java.io.*,java.util.*"%><html>
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


<title> :: ATTENDANCE ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br><br><br><br><br> 
<%
	try
	{
	
	String empid= session.getAttribute("EMPID").toString();
	String sql = "SELECT INT_LEAVEID,CHR_LEAVENAME FROM att_m_leavetype ORDER BY INT_LEAVEID";
	String Leaves[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql = "SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+empid+"'";
	 
	
	//out.println("<center>");
	//out.println("<table width='50%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1   >");
	//out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>Employee Id</b>");
	//out.println("<td class='boldEleven'  ><b>"+empid+"</b>");
	//out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>Employee Name</b>");
	//out.println("<td class='boldEleven' >"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]+"<b></b>");
	if(Leaves.length>0)
	{
		//out.println("<tr bgcolor='#ffffff'><td class='boldEleven' colspan=2  >");
		out.println("<center>");
		out.println("<table  width='80%'  class='boldEleven' cellpadding=5 cellspacing=3 bgcolor='#9900CC' >");
		out.println("<tr bgcolor='#ffffff'><td class='boldEleven'  ><b>Leave name</b>");
		out.println("<td class='boldEleven'  ><b>No of Leave</b>");
		out.println("<td class='boldEleven'  ><b>Leave Taken</b>");
		out.println("<td class='boldEleven'  ><b>Balance Leave</b>");
		
		for(int u=0; u<Leaves.length; u++)
		{
			if(u%2==0)
				out.println("<tr  class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
			
			out.println("<td class='boldEleven' >"+Leaves[u][1]+"");
			sql="SELECT INT_NOD"+Leaves[u][0]+",INT_NOD"+Leaves[u][0]+"BALANCE ,(INT_NOD"+Leaves[u][0]+" -INT_NOD"+Leaves[u][0]+"BALANCE) FROM att_m_leave  WHERE CHR_EMPID='"+empid+"' AND INT_YEAR =year(now())";
			out.println("<td class='boldEleven' >"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
			out.println("<td class='boldEleven' >"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][1]);
			out.println("<td class='boldEleven' >"+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][2]);
		
		}
		out.println("</table>");
		out.println("</center>");
	}	
	//out.println("</table>");
	//out.println("</center>");
	}
	catch(Exception e)
	{
	}
			%>
<br>
<br>
<table width="56" align="center">
<tr><td>
<input name="Button" type="Button" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')">
</td></tr></table>
</body>
</html>
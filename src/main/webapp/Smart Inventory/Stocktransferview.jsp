<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
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

<title>:: INVENTORY ::</title> <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body >
<p align="right"><br>

<br>
<a href="javascript:window.close()"> <span class="boldEleven">close</span></a></p>
<br>
<p>
<%
try
{
	String serialno = request.getParameter("serialno");
	String  sql ="SELECT CHR_SERIALNO,CHR_STOCKTRANSFERID,CHR_WARRANTY,CHR_RECEIVEDBY FROM  inv_t_stocktransferitemserial ";
	sql = sql + " where CHR_SERIALNO like'%"+serialno+"%'";
	/*String sql=" SELECT a.CHR_STOCKTRANSFERID,a.CHR_SERIALNO,a.CHR_WARRANTY,b.CHR_STAFFNAME ";
	sql = sql+" FROM  inv_t_stocktransferitemserial a , com_m_staff b ";
 	sql = sql+" WHERE a.CHR_SERIALNO ='"+serialno+"' ";
 	sql = sql+" AND a.CHR_RECEIVEDBY = b.CHR_EMPID  ORDER BY a.INT_ID";
	*/
	 String data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
	out.println("<center><table cellspacing=0 cellpadding=3 border=1>");
	if(data.length>0)
	{
		out.println("<td class='boldEleven'><b>S.No");
		out.println("<td class='boldEleven'><b>Transfer Id");
		out.println("<td class='boldEleven'><b>Serial");
		out.println("<td class='boldEleven'><b>Warranty (yrs)");
		out.println("<td class='boldEleven'><b>Received By");

		for(int i=0; i<data.length; i++)
		{
			if(i%2 == 0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
					
			out.println("<td class='boldEleven'>"+(i+1));
			out.println("<td class='boldEleven'>"+data[i][0]);
			out.println("<td class='boldEleven'>"+data[i][1]);
			out.println("<td class='boldEleven'>"+data[i][2]);
			if("-".equals(data[i][3].trim()))
				out.println("<td class='boldEleven'><font color=red>Should be received...</font>");
			else
				out.println("<td class='boldEleven'>"+data[i][3]);
		}
	}
	else
	{
		out.println("<tr colspan=5><td class='boldEleven'>Data not found");
	}
	
	out.println("</table></center>");
}
catch(Exception e)
{
	out.println(e.getMessage());
}	
%>
</p>
</body>
</html>

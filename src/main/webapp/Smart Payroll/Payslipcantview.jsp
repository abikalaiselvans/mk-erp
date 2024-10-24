<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
 
<title> :: PAYROLL ::</title>


 
 
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
<!--
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">

<%@ include file="index.jsp"%>
<!--PaySlipView.jsp-->
 

<table width="100%" height="412" border="0" align="center"
	cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		  <div align="center">
		    <%
		 String sql="";
		String loginemp = ""+session.getAttribute("EMPID");
		sql= " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,a.CHR_EMAILID,a.CHR_MOBILE,a.CHR_TYPE ";
		sql = sql + " FROM com_m_staff  a, com_m_office  b,com_m_company c,com_m_branch d   ";
		sql = sql + " WHERE a.INT_OFFICEID= b.INT_OFFICEID  AND  a.CHR_TYPE!='T' AND a.CHR_HOLD!='Y' ";
		sql = sql + " AND a.INT_COMPANYID=c.INT_COMPANYID AND a.INT_BRANCHID=d.INT_BRANCHID ";
		sql = sql + " AND a.CHR_REPTO ='"+loginemp+"'  ";
		sql = sql + " ORDER BY a.CHR_STAFFNAME  ";
		 
		String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			out.println("<br><br><br>");
			out.println("<table width='50%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'><td class='boldEleven' colspan=24 align='center'><b>THE FOLLOWING EMPLOYEES PAY SLIP ARE ALLOWED TO VIEW ....");
			out.println("<tr class='MRow2'><td class='boldEleven'><b>S.No");
			out.println("<td class='boldEleven'><b>Emp Id");
			out.println("<td class='boldEleven'><b>Name");
			 
			
			for(int u=0;u<data.length;u++)
			{
				if(u%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");
					
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][0]);
			out.println("<td class='boldEleven'>"+data[u][1]);
			 
							
			}
			out.println("</table>");
		}
		else
		{
			out.println("<br><br><br><center><font class=bolddeepred>Resume not found...</font></center>");
		}
		%>
		    
		    
          </div></td>
	</tr>
	<tr>
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td height="37">&nbsp;</td>
	</tr>
</table>
 

<%@ include file="../footer.jsp"%>
</body>
</html>

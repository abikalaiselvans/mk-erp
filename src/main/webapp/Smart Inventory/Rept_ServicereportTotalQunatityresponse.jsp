 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%
try
{
%>
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<body >
<%@ include file="indexinv.jsp"%>

<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	<%
	String fromdate=request.getParameter("fromdate");
	String todate=request.getParameter("todate");
	String servicecenter=request.getParameter("servicecenter");
	String customerid=request.getParameter("customerid");
	String Customergroup=request.getParameter("Customergroup");
	String sparecall=request.getParameter("sparecall");
	
	String sql=" SELECT c.CHR_GROUPNAME,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),b.CHR_STREET,a.CHR_SERIALNO,d.CHR_SERVICEITEMNAME, ";
	sql = sql + " DATE_FORMAT(a.DT_STARTDATE,'%d-%m-%Y'),DATE_FORMAT(a.DT_ENDDATE,'%d-%m-%Y'),a.INT_NOOFYEAR " ;
	sql = sql + " FROM inv_m_serviceamc a ,inv_m_servicecustomerinfo b,inv_m_servicecustomergroup c,inv_m_serviceitems d";
	sql = sql + "  WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.INT_SERVICEITEMID=d.INT_SERVICEITEMID  ";
	sql = sql + " AND b.INT_GROUPID= c.INT_GROUPID ";
	 
	if(!"0".equals(servicecenter))
		sql = sql + " AND b.INT_SERVICECENTERID="+servicecenter;
		
	 if(!"0".equals(Customergroup))
		sql = sql + " AND b.INT_GROUPID="+Customergroup;
		
	if(!"0".equals(customerid))
		sql = sql + " AND a.INT_CUSTOMERID="+customerid;
	
	sql = sql + " AND date(a.DT_STARTDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
	sql = sql + " AND date(a.DT_STARTDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
	sql = sql + " ORDER BY c.CHR_GROUPNAME,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)";
	



 

	
	
	//out.print(sql);
	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(readData.length>0)
	{
		out.println("<center>");
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1' >");
		out.println("<td class='boldEleven' align='center'><b>S.No");
		out.println("<td class='boldEleven' align='center'><b>Group Name");
		out.println("<td class='boldEleven' align='center'><b>Customer Name");
		out.println("<td class='boldEleven' align='center'><b>Address");
		out.println("<td class='boldEleven' align='center'><b>Serial Number");
		out.println("<td class='boldEleven' align='center'><b>Item name");
		out.println("<td class='boldEleven' align='center'><b>Starting Date");
		out.println("<td class='boldEleven' align='center'><b>Ending Date");
		out.println("<td class='boldEleven' align='center'><b>Warranty");
		
		for(int u=0;u<readData.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1' >");
			else
				out.println("<tr class='MRow2' >");
				
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+readData[u][0]);
			out.println("<td class='boldEleven'>"+readData[u][1]);
			out.println("<td class='boldEleven'>"+readData[u][2]);
			out.println("<td class='boldEleven'>"+readData[u][3]);
			out.println("<td class='boldEleven'>"+readData[u][4]);
			out.println("<td class='boldEleven'>"+readData[u][5]);
			out.println("<td class='boldEleven'>"+readData[u][6]);
			out.println("<td class='boldEleven'>"+readData[u][7]);
			
		}
		out.println("<center>");
		out.println("</table>");
		
		
		
	}
	else
		out.println("<center><font class='bolddeepred'>Data not found...</font></center>");
	%>
	 </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>
	  <table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('sample.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('sample.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('sample.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>
	</tr>
</table>
	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>

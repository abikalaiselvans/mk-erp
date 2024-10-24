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
	String serialnumber=request.getParameter("serialnumber");
	String sql="SELECT a.CHR_SERIALNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),b.CHR_PHONE,b.CHR_MOBILE,b.CHR_EMAIL,c.CHR_CENTERNAME, DATE_FORMAT(a.DT_STARTDATE,'%d-%M-%Y %H:%i:%s'), DATE_FORMAT(a.DAT_UPDATION,'%d-%M-%Y %H:%i:%s'), DATE_FORMAT(a.DT_ENDDATE,'%d-%M-%Y %H:%i:%s'),a.CHR_CATEGORY FROM inv_m_serviceamc  a ,inv_m_servicecustomerinfo b,inv_m_servicecenter c WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID=c.INT_SERVICECENTERID AND  a.CHR_SERIALNO LIKE '"+serialnumber+"%'";
	//out.println(sql);
	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(readData.length>0)
	{
		out.println("<center>");
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1' >");
		out.println("<td class='boldEleven' align='center'><b>S.No");
		out.println("<td class='boldEleven' align='center'><b>Serial Number");
		out.println("<td class='boldEleven' align='center'><b>Customer Name");
		out.println("<td class='boldEleven' align='center'><b>Phone");
		out.println("<td class='boldEleven' align='center'><b>Mobile");
		out.println("<td class='boldEleven' align='center'><b>Email");
		out.println("<td class='boldEleven' align='center'><b>Center");
		//out.println("<td class='boldEleven' align='center'><b>Creation Date");
		out.println("<td class='boldEleven' align='center'><b>Starting Date");
		out.println("<td class='boldEleven' align='center'><b>Ending  Date");
		out.println("<td class='boldEleven' align='center'><b>Category");
		 
		
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
			//out.println("<td class='boldEleven'>"+readData[u][7]);
			out.println("<td class='boldEleven'>"+readData[u][8]);
			out.println("<td class='boldEleven'>");
			if("W".equals(readData[u][9]))
				out.println("Warranty");
			else if("A".equals(readData[u][9]))
				out.println("AMC");	
			else if("O".equals(readData[u][9]))
				out.println("On Call");	
			
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

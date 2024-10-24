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
	String callstatus=request.getParameter("callstatus");
	
	String sql=" SELECT a.INT_SERVICEID,a.CHR_SERVICECALLNO, c.CHR_GROUPNAME,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),d.CHR_CENTERNAME, ";
	sql = sql + " a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%M-%Y %H:%i:%s'), " ;
	sql = sql + " DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%M-%Y %H:%i:%s'), ";
	sql = sql + " DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%M-%Y %H:%i:%s'), ";
	sql = sql + " a.CHR_SERVICEDESC,a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS,a.CHR_ENGGSTATUS, ";
	sql = sql + " a.CHR_BOOKINGEMPID,e.CHR_STAFFNAME,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE, ";
	sql = sql + " a.CHR_CONTACTEMAIL ";
	sql = sql + " FROM inv_t_servicecallbooking a ,inv_m_servicecustomerinfo b,inv_m_servicecustomergroup c, ";
	sql = sql + " inv_m_servicecenter d,com_m_staff e ";
	sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID ";
	sql = sql + " AND b.INT_GROUPID=c.INT_GROUPID ";
	sql = sql + " AND b.INT_SERVICECENTERID=d.INT_SERVICECENTERID ";
	sql = sql + " AND a.CHR_BOOKINGEMPID=e.CHR_EMPID ";
	
	if(!"0".equals(servicecenter))
		sql = sql + " AND b.INT_SERVICECENTERID= "+servicecenter;
		
	if(!"0".equals(customerid))
		sql = sql + " AND a.INT_CUSTOMERID= "+customerid;
	if(!"0".equals(callstatus))	
		sql = sql + " AND a.CHR_STATUS= '"+callstatus+"' ";
		
	sql = sql + " AND date(a.DT_BOOKINGDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
	sql = sql + " AND date(a.DT_BOOKINGDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
	//out.print(sql);
	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(readData.length>0)
	{
		out.println("<center>");
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1' >");
		out.println("<td class='boldEleven' align='center'><b>S.No");
		out.println("<td class='boldEleven' align='center'><b>Service CallNo");
		out.println("<td class='boldEleven' align='center'><b>Group Name");
		out.println("<td class='boldEleven' align='center'><b>Customer Name");
		out.println("<td class='boldEleven' align='center'><b>Center Name");
		out.println("<td class='boldEleven' align='center'><b>Serial Number");
		out.println("<td class='boldEleven' align='center'><b>Booking Date");
		out.println("<td class='boldEleven' align='center'><b>Assign Date");
		out.println("<td class='boldEleven' align='center'><b>Close Date");
		out.println("<td class='boldEleven' align='center'><b>Service Description");
		out.println("<td class='boldEleven' align='center'><b>Booking Type");
		out.println("<td class='boldEleven' align='center'><b>Booking Under");
		out.println("<td class='boldEleven' align='center'><b>Status");
		out.println("<td class='boldEleven' align='center'><b>Engg Status");
		out.println("<td class='boldEleven' align='center'><b>Booking EmpId");
		out.println("<td class='boldEleven' align='center'><b>Emp Name");
		out.println("<td class='boldEleven' align='center'><b>Contact Persion");
		out.println("<td class='boldEleven' align='center'><b>Contact Address");
		out.println("<td class='boldEleven' align='center'><b>Contact Mobile");
		out.println("<td class='boldEleven' align='center'><b>Contact Email");
		 
		
		for(int u=0;u<readData.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow1' >");
			else
				out.println("<tr class='MRow2' >");
				
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+readData[u][1]);
			out.println("<td class='boldEleven'>"+readData[u][2]);
			out.println("<td class='boldEleven'>"+readData[u][3]);
			out.println("<td class='boldEleven'>"+readData[u][4]);
			out.println("<td class='boldEleven'>"+readData[u][5]);
			out.println("<td class='boldEleven'>"+readData[u][6]);
			out.println("<td class='boldEleven'>"+readData[u][7]);
			out.println("<td class='boldEleven'>"+readData[u][8]);
			out.println("<td class='boldEleven'>"+readData[u][9]);
			
			out.println("<td class='boldEleven'>");
			if("P".equals(readData[u][10]))
				out.println("Phone");
			else if("D".equals(readData[u][10]))
				out.println("Direct");	
			else if("O".equals(readData[u][10]))
				out.println("Others");

			
			out.println("<td class='boldEleven'>");
			if("W".equals(readData[u][11]))
				out.println("Warranty");
			else if("A".equals(readData[u][11]))
				out.println("AMC");	
			else if("O".equals(readData[u][11]))
				out.println("On Call");
				
			out.println("<td class='boldEleven'>");
			if("C".equals(readData[u][12]))
				out.println("Completed");
			else if("P".equals(readData[u][12]))
				out.println("Pending");	
			else if("N".equals(readData[u][12]))
				out.println("New Call");
			else if("R".equals(readData[u][12]))
				out.println("Cancelled / Rejected");	
			
						
			out.println("<td class='boldEleven'>");
			if("N".equals(readData[u][13]))
				out.println("Not Assign");
			else if("Y".equals(readData[u][13]))
				out.println("Assigned");	
			else if("R".equals(readData[u][13]))
				out.println("Re-Assign");
			

			out.println("<td class='boldEleven'>"+readData[u][14]);
			out.println("<td class='boldEleven'>"+readData[u][15]);
			out.println("<td class='boldEleven'>"+readData[u][16]);
			out.println("<td class='boldEleven'>"+readData[u][17]);
			out.println("<td class='boldEleven'>"+readData[u][18]);
			out.println("<td class='boldEleven'>"+readData[u][19]);
			
			
			
			/*
			if("W".equals(readData[u][9]))
				out.println("Warranty");
			else if("A".equals(readData[u][9]))
				out.println("AMC");	
			else if("O".equals(readData[u][9]))
				out.println("On Call");	*/
			
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

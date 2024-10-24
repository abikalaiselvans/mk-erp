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
	String callstatus=request.getParameter("callstatus");
	 

	String sql =   " SELECT  ";
	sql = sql + " g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME,d.CHR_CENTERNAME,f.CHR_SERVICEITEMNAME,  ";
	sql = sql + " a.CHR_SERVICECALLNO, a.CHR_EMPID,a.CHR_SERIALNO,DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ATTENDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_CLOSEDATE,'%d-%b-%Y'),  ";
	sql = sql + " a.CHR_CALLSTATUS,a.CHR_SPARE,a.CHR_SPAREDESC,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,h.CHR_STAFFNAME  ";
	sql = sql + " FROM inv_t_servicecallbookingtrack a,inv_t_servicecallbooking b,inv_m_servicecustomerinfo c,inv_m_servicecenter d,  ";
	sql = sql + " inv_m_serviceamc e,inv_m_serviceitems f,inv_m_servicecustomergroup g ,com_m_staff h ";
	sql = sql + " WHERE a.CHR_SERVICECALLNO = b.CHR_SERVICECALLNO  ";
	sql = sql + " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID  ";
	sql = sql + " AND c.INT_SERVICECENTERID = d.INT_SERVICECENTERID   ";
	sql = sql + " AND a.CHR_SERIALNO=e.CHR_SERIALNO  ";
	sql = sql + " AND c.INT_CUSTOMERID = e.INT_CUSTOMERID  ";
	sql = sql + " AND e.INT_SERVICEITEMID = f.INT_SERVICEITEMID  ";
	sql = sql + " AND c.INT_GROUPID = g.INT_GROUPID  AND a.CHR_EMPID =h.CHR_EMPID";
	if(!"0".equals(servicecenter))
		sql = sql + " AND d.INT_SERVICECENTERID="+servicecenter;
	if(!"0".equals(Customergroup))
		sql = sql + " AND g.INT_GROUPID="+Customergroup;
	if(!"0".equals(customerid))
		sql = sql + " AND c.INT_CUSTOMERID="+customerid;
	if(!"0".equals(callstatus))
		sql = sql + " AND a.CHR_CALLSTATUS="+callstatus;	
	if(!"0".equals(sparecall))
		sql = sql + " AND a.CHR_SPARE='"+sparecall+"' ";	
	sql = sql + " AND date(a.DT_ASSIGNDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
	sql = sql + " AND date(a.DT_ASSIGNDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
	sql = sql + " ORDER BY g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME";





 

	
	
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
		out.println("<td class='boldEleven' align='center'><b>Service Center");
		out.println("<td class='boldEleven' align='center'><b>Service Item");
		out.println("<td class='boldEleven' align='center'><b>Service Call Number");
		out.println("<td class='boldEleven' align='center'><b>Empid / Staff Name");
		out.println("<td class='boldEleven' align='center'><b>Serial Number");
		out.println("<td class='boldEleven' align='center'><b>Assign Date");
		out.println("<td class='boldEleven' align='center'><b>Atten Date");
		out.println("<td class='boldEleven' align='center'><b>Close Date");
		out.println("<td class='boldEleven' align='center'><b>Call Status");
		out.println("<td class='boldEleven' align='center'><b>Spare");
		out.println("<td class='boldEleven' align='center'><b>Spare Description");
		out.println("<td class='boldEleven' align='center'><b>Contact Person");
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
			out.println("<td class='boldEleven'>"+readData[u][0]);
			out.println("<td class='boldEleven'>"+readData[u][1]);
			out.println("<td class='boldEleven'>"+readData[u][2]);
			out.println("<td class='boldEleven'>"+readData[u][3]);
			out.println("<td class='boldEleven'>"+readData[u][4]);
			out.println("<td class='boldEleven'>"+readData[u][5] +" / "  +readData[u][17]);
			out.println("<td class='boldEleven'>"+readData[u][6]);
			out.println("<td class='boldEleven'>"+readData[u][7]);
			out.println("<td class='boldEleven'>"+readData[u][8]);
			out.println("<td class='boldEleven'>"+readData[u][9]);
			 
			if("1".equals(readData[u][10]))
				out.println("<td class='boldEleven'>Pending for Spare");
			else if("2".equals(readData[u][10]))	 
				out.println("<td class='boldEleven'>Pending for Response");
			else if("3".equals(readData[u][10]))	 
				out.println("<td class='boldEleven'>Pending for Customer");
			else if("4".equals(readData[u][10]))	 
				out.println("<td class='boldEleven'>Under Observation");
			 else if("5".equals(readData[u][10]))	 
				out.println("<td class='boldEleven'>Closed");
			       
			 
			
			
		 
								
											
			if("Y".equals(readData[u][11]))
				out.println("<td class='boldEleven'>Yes");
			else	
				out.println("<td class='boldEleven'>No");
			out.println("<td class='boldEleven'>"+readData[u][12]);
			out.println("<td class='boldEleven'>"+readData[u][13]);
			out.println("<td class='boldEleven'>"+readData[u][14]);
			out.println("<td class='boldEleven'>"+readData[u][15]);
			out.println("<td class='boldEleven'>"+readData[u][16]);
			//out.println("<td class='boldEleven'>"+readData[u][17]);
			
			
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

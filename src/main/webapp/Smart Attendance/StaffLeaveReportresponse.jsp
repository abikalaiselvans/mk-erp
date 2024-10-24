<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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
.style3 {
	color: #FFFFFF;
	font-weight: bold;
}
.style4 {color: #FFFFFF}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js">
</script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p><%@ include file="index.jsp"%></p>
<br><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="200">
	
<%
try
{
	String ename=request.getParameter("ename");
	String fromdate=request.getParameter("fromdt");
	String todate = request.getParameter("todt");
	String sql="";
	sql =" SELECT date_format(a.DT_LDATE,'%d-%m-%Y'),(SELECT c.CHR_LEAVENAME FROM att_m_leavetype c WHERE c.CHR_SYMBOL=a.CHR_LEAVETYPE),a.CHR_DAYTYPE, b.DT_DOJCOLLEGE, CHR_HOLD ,b.CHR_STAFFNAME ,a.CHR_EMPID ";
	sql = sql + " FROM att_t_leave a ,com_m_staff b WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	sql = sql + " AND  a.DT_LDATE >= '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"'";
	sql = sql + " AND  a.DT_LDATE <= '"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"'";
	sql = sql + " AND a.CHR_EMPID = '"+ename+"'";
	sql = sql + " ORDER BY a.DT_LDATE ";
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	out.println("<center><table id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' width=600><tr  bgcolor='#ffffff'><td colspan=7 class='boldEleven' align='center'><b> L E A V E   R E P O R T   ");
	
	out.println("<tr  bgcolor='#ffffff'><td colspan=7 class='boldEleven' align='center'><b> Emp Id :: "+ename+" ");
	out.println("<tr  bgcolor='#ffffff'>");
	out.println("<td class='boldEleven' align='center'><b>S.No");
	out.println("<td class='boldEleven' align='center'><b>Emp Name");
	out.println("<td class='boldEleven' align='center'><b>Emp Id");
	out.println("<td class='boldEleven' align='center'><b>Date");
	out.println("<td class='boldEleven' align='center'><b>Leave Type");
	out.println("<td class='boldEleven' align='center'><b>Day Type");
	if(data.length>0)
	{
		for(int u=0;u<data.length;u++)
		{
			if(u%2 ==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][5]);
			out.println("<td class='boldEleven'>"+data[u][6]);
			out.println("<td class='boldEleven'>"+data[u][0]);
			out.println("<td class='boldEleven'>"+data[u][1]);
			out.println("<td class='boldEleven'>"+data[u][2]);
		}
		out.println("<tr  bgcolor='#ffffff'><td colspan=7 class='boldEleven' align='center'><b>ABESENT DETAILS</b> </td> ");
		
		sql="SELECT b.CHR_STAFFNAME,a.CHR_EMPID,a.DT_ABSENTDATE,a.CHR_TYPE FROM att_t_absent  a ,com_m_staff b";
		sql = sql+ " WHERE a.CHR_EMPID = b.CHR_EMPID  AND a.CHR_EMPID='"+ename+"' AND  ";
		sql = sql+ " a.DT_ABSENTDATE>='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"'";
		sql = sql+ "  AND a.DT_ABSENTDATE <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"'";
		String absdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(absdata.length>0)
		{
			for(int u=0;u<absdata.length;u++)
			{
				if(u%2 ==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td class='boldEleven'>"+(u+1));
				out.println("<td class='boldEleven'>"+absdata[u][0]);
				out.println("<td class='boldEleven'>"+absdata[u][1]);
				out.println("<td class='boldEleven'>"+absdata[u][2]);
				out.println("<td class='boldEleven'>Absent");
				if("P".equals(absdata[u][3]))
					out.println("<td class='boldEleven'>Full Day");
				else if("F".equals(absdata[u][3]))
					out.println("<td class='boldEleven'>Forenoon ");	
				else
					out.println("<td class='boldEleven'>Afternoon");	
			}
		}	
		out.println("<tr  bgcolor='#ffffff'><td colspan=7 class='boldEleven' align='center'>");
		%>
		<table width="184" align="center" cellpadding="15" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td width="100" height="44" class="boldEleven"><span class="style3">Export
		</span></td>
		<td class="boldEleven">
		<div align="center" class="style4"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>		</div>		</td>

		<td class="boldEleven">
		<div align="center" class="style4"><a title="Text" href=javascript:;
			onClick="windowSave('lop.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>		</td>
		<td class="boldEleven">
		<div align="center" class="style4"><a title="Document" href=javascript:;
			onClick="windowSave('lop.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>		</td>
		<td class="boldEleven">
		<div align="center" class="style4"><a title="HTML" href=javascript:;
			onClick="windowSave('lop.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>		</td>
	</tr>
</table>
		<p>
		  <%
	}
	else
	{
		out.println("<tr  bgcolor='#ffffff'><td colspan=7 class='boldEleven' align='center'><b> Data not found...");
	}

	out.println("</table></center>");

}
catch(Exception e)
{
}
%>
    </p>
	    <table border="0" align="center" cellpadding="2"
										cellspacing="2">
          <tr>
            <td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												  /></td>
            <td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="javascript:redirect('StaffLeaveReport.jsp')" /></td>
          </tr>
        </table>      <p>&nbsp;    </p></td>
  </tr>
</table>
<p><%@ include file="../footer.jsp"%></p>
</body>
</html>

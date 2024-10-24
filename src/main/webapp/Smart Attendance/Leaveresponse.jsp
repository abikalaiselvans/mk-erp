<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<br>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
	 
		String company = request.getParameter("company");
		String branch = request.getParameter("branch");
		String Office = request.getParameter("Office");
		String dept = request.getParameter("dept");
		String year = request.getParameter("year");
		String cpy="";
		String bid="";
		String off="";
		String dep="";
		if(!"-1".equals(company))
			cpy =" AND `com_m_staff`.`INT_COMPANYID` = "+company;
			
		if(!"-1".equals(branch))
			bid =" AND `com_m_staff`.`INT_OFFICEID`="+branch;
			
		if(!"0".equals(Office))
			off =" AND `com_m_staff`.`INT_OFFICEID`="+Office;
		
		String sql = "SELECT CHR_LEAVENAME from att_m_leavetype ORDER BY INT_LEAVEID";
		String header = "S.No,Emp Id, Emp Name,";
		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		int noofleave=data.length;
		for(int u=0;u<data.length;u++)
			header= header+data[u][0]+",";
		String repdata[]=header.split(",");
		
	sql=" SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME` , ";

	for(int y=1;y<=noofleave;y++)
	{
		sql=sql+" `att_m_leave`.`INT_NOD"+y+"`,";
		sql=sql+" `att_m_leave`.`INT_NOD"+y+"BALANCE`,";
		sql=sql+" (`att_m_leave`.`INT_NOD"+y+"`-`att_m_leave`.`INT_NOD"+y+"BALANCE`),";

	}
sql =sql.substring(0,sql.length()-1);	
sql=sql+" FROM  `smartcampus`.`com_m_staff`,  `smartcampus`.`com_m_depart`   ,  ";
sql=sql+" `smartcampus`.`com_m_branch`, `smartcampus`.`com_m_company` ,`smartcampus`.`com_m_office` ";
sql=sql+" ,`smartcampus`.`att_m_leave` ";
sql=sql+" WHERE `com_m_staff`.`INT_DEPARTID`=`com_m_depart`.`INT_DEPARTID`  ";
sql=sql+" AND `com_m_staff`.`INT_OFFICEID`=`com_m_office`.`INT_OFFICEID` ";
sql=sql+" AND `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID` ";
sql=sql+" AND `com_m_staff`.`INT_BRANCHID` = `com_m_branch`.`INT_BRANCHID` ";
sql=sql+" AND `com_m_staff`.`CHR_EMPID` = `att_m_leave`.`CHR_EMPID` ";
sql=sql+" AND `com_m_staff`.`CHR_TYPE` !='Y'  ";
sql=sql+" AND `com_m_staff`.`CHR_HOLD`!='Y'   ";
sql = sql+cpy;
sql = sql+bid;
sql = sql+off;
sql=sql+" AND `att_m_leave`.`INT_YEAR`= "+year;
sql=sql+" AND year(`com_m_staff`.`DT_DOJCOLLEGE`) <= "+year;
sql=sql+" order BY  `com_m_staff`.`CHR_STAFFNAME` ";



		String reportdata[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
		if(reportdata.length>0)
		{
			out.println("<center> <table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			out.println("<tr class='MRow1'><td colspan=\""+((noofleave*3)+3)+"\" ><center><h3>Leave Master</h3></center></td></tr>");
			out.println("<tr class='MRow2'>");
			out.println("<td class=\"boleEleven\"  align='center'><b>"+repdata[0]);
			out.println("<td class=\"boleEleven\"  align='center'><b>"+repdata[1]);
			out.println("<td class=\"boleEleven\"  align='center'><b>"+repdata[2]);
			for(int x=3;x<repdata.length;x++)
				out.println("<td colspan=3 class=\"boleEleven\" align='center'><b>"+repdata[x]);
			
			out.println("<tr class='MRow1'>");
			out.println("<td class=\"boleEleven\" >&nbsp;");
			out.println("<td class=\"boleEleven\" >&nbsp;");
			out.println("<td class=\"boleEleven\" >&nbsp;");
			for(int x=3;x<repdata.length;x++)
			{
				out.println("<td class=\"boleEleven\"><b>Eligible");
				out.println("<td class=\"boleEleven\"><b>Leave Taken");
				out.println("<td class=\"boleEleven\"><b>Available");
			}	
					
			
			for(int x=0;x<reportdata.length;x++)
			{
				if(x%2==0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td  class=\"Report\">"+(x+1));
				out.println("<td  class=\"Report\" >"+reportdata[x][0]);
				out.println("<td  class=\"Report\" >"+reportdata[x][1]);
				for(int y=2;y<((3*noofleave)+2);y++)
					out.println("<td  class=\"Report\" align=\"right\">"+reportdata[x][y]);
			}
			out.println("</table></center>");
			
			%>
		<!--/*<table width="184" align="center" cellpadding="15" cellspacing="0">
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
					onClick="windowSave('leavemaster.txt')"><img
					src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="Document" href=javascript:;
					onClick="windowSave('leavemaster.doc')"><img
					src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a title="HTML" href=javascript:;
					onClick="windowSave('leavemaster.html')"><img
					src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
				</td>
			</tr>
		</table>*/-->


		<%
		}	 
	
			
	%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

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


<title> :: PAYROLL ::</title>


 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {
font-size: 8.5px;

}
-->
</style>
</head>

<body  onpaste='return false;'>
<p>
<%
	try
	{
		String Company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String Office=request.getParameter("Office");
		String Month=request.getParameter("Month");
		String month =com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(Month));
		String Year=request.getParameter("Year");
		String noofmonth=request.getParameter("noofmonth");
		int nootm = Integer.parseInt(noofmonth);
		String  sql = "";
		String off="";
		String cpy ="";
		String bid="";
		if(!"0".equals(Company))
			cpy = " AND `com_m_staff`.`INT_COMPANYID` = "+Company; 
			
		if(!"-1".equals(branch))
			bid = " AND `com_m_staff`.`INT_BRANCHID` = "+branch; 
			
		if(!"0".equals(Office))
			off = " AND `com_m_staff`.`INT_OFFICEID` = "+Office; 
				
			
		
		sql = "SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME`,`com_m_staff`.`CHR_PFNO`,";
		sql = sql+"`com_m_staff`.`CHR_STAFFFNAME`,  date_format(`com_m_staff`.`DT_DOB`,'%d-%b-%Y'),`com_m_staff`.`CHR_GENDER`, ";
		sql = sql+" date_format(`com_m_staff`.`DT_DOJCOLLEGE`,'%d-%b-%Y')";
		sql = sql+" FROM `smartcampus`.`com_m_staff`, `smartcampus`.`com_m_company`,`smartcampus`.` com_m_office `,";
		sql = sql+" `smartcampus`.`com_m_branch` WHERE ";
		sql = sql+" `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID`";
		sql = sql+" AND `com_m_staff`.`INT_BRANCHID`  = `com_m_branch`.`INT_BRANCHID`";
		sql = sql+" AND `com_m_staff`.`INT_OFFICEID`  = `com_m_office`.`INT_OFFICEID`";
		sql = sql+" AND month(`com_m_staff`.`DT_DOJCOLLEGE`) = "+Month;
		sql = sql+" AND year(`com_m_staff`.`DT_DOJCOLLEGE`) =  "+Year;
		sql = sql+cpy;
		sql = sql+bid;
		sql = sql+off;
		//out.println(sql);
		String repHeader="S.No,Employee id,Name of the Employee,Account No,Fathers Name,Date of Birth,Sex,Date of Joining,Remarks,";
		String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String repdata[]=repHeader.split(",");
		
		if(reportdata.length>0)
		{
			out.println("<center> <table id='myTable' cellpadding=5 cellspacing=1   border=1 >");
			String h="Return  of Employees qualifying for membership of the employees provident Fund, Employees Pension Fund& Employee Deposit Linked Insurance Fund for the first time during the month(to be sent to the Commissioner with For 2(EPF & EPS))";
			out.println("<tr><td colspan=\""+repdata.length+"\"><center><h3>Form-5</h3></center></td></tr>");
			out.println("<tr><td colspan=\""+repdata.length+"\"><b>Name & Address of the Factory Establishment ::</b></td></tr>");
			out.println("<tr><td colspan=\""+repdata.length+"\"><b>"+h+"</b></td></tr>");
			out.println("<tr>");
			for(int x=0;x<repdata.length;x++)
				out.println("<td class=\"boleEleven\"><b>"+repdata[x]);
			 
			for(int x=0;x<reportdata.length;x++)
			{
				out.println("<tr  >");
				out.println("<td  class=\"Report\">"+(x+1));
				for(int y=0;y<repdata.length-2;y++)
					out.println("<td  class=\"Report\"  >"+reportdata[x][y].trim());
				out.println("<td  class=\"Report\"  >&nbsp;");
			}
			out.println("<tr><td colspan=\""+repdata.length+"\"><b>Indicate the following in the remarks</b></td></tr>");
			String remarks=" 1. Previous A/c No & service particulars with Form-13(revised) 2). The scheme certificatr Control No. if any enclosing the certificate 3).details of pension being drawn, if any under EPS,95 (such member should be enrolled for PF & EDLI only) 4).Enclose form-2 (revised) giving nomination for PF & also for Pension by all members 5).An employee who has attained the age of 58 will be eligible to become a member of EPS,95 only";
			out.println("<tr><td colspan=\""+repdata.length+"\">"+remarks+"</td></tr>");
			out.println("</table></center>"); 
			%>
			
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
			onClick="windowSave('Form5.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Form5.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Form5.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>
			<%
		}
		else
		{
			out.println("<h3><center>Data not found...</center></h3>");
		}	
	 	
		 
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}	 
%>
</p>
</body>
</html>

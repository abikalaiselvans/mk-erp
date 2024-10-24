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
				
			
		
		
		
		sql = "SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME`,`com_m_staff`.`CHR_PFNO`,  ";
		sql = sql+" `com_m_staff`.`CHR_STAFFFNAME`,  date_format(`pay_m_emp_termination`.`DT_TERM_DATE`,'%d-%b-%Y')  ";
		sql = sql+" ,`com_m_staff`.`CHR_GENDER`,   "; 
		sql = sql+" `pay_m_emp_termination`.`CHR_REASON`  ";
		sql = sql+" FROM `smartcampus`.`com_m_staff`, `smartcampus`.`com_m_company`,`smartcampus`.` com_m_office `,   ";
		sql = sql+" `smartcampus`.`com_m_branch` ,`smartcampus`.`pay_m_emp_termination` WHERE    "; 
		sql = sql+" `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID`   ";
		sql = sql+" AND `com_m_staff`.`INT_BRANCHID`  = `com_m_branch`.`INT_BRANCHID`    ";
		sql = sql+" AND `com_m_staff`.`INT_OFFICEID`  = `com_m_office`.`INT_OFFICEID`    ";
		sql = sql+" AND `com_m_staff`.`CHR_EMPID` = `pay_m_emp_termination`.`CHR_EMPID`  ";
		sql = sql+" AND month(`pay_m_emp_termination`.`DT_TERM_DATE`) =  "+Month;
		sql = sql+" AND year(`pay_m_emp_termination`.`DT_TERM_DATE`) =  "+Year;
		sql = sql+cpy;
		sql = sql+bid;
		sql = sql+off;
		
		String repHeader="S.No,Employee id,Name of the Employee,Account No,Fathers Name,Date of Leaving Service,Sex,Reason for Leaving Service,Remarks,";
		String reportdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String repdata[]=repHeader.split(",");
		
		if(reportdata.length>0)
		{
			out.println("<center> <table id='myTable' cellpadding=5 cellspacing=1   border=1 >");
			String h="Return  of the members leaving service during the month";
			out.println("<tr><td colspan=\""+repdata.length+"\"><center><h3>Form-10</h3></center></td></tr>");
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
			String remarks="<b>*</b> Please state whether the member is (a) retiring according to para 69(1) or (b) of the cheme: (b). Leaving India for permenant for settlement abroad.Reterenchment (d) discharges 9e) Resigning from or leaving service (f) taking up employement eleswhere (The Name & address should be stated). (g). Date of Death A member, on attaining the age of 58, is ceased to be a member of EPS-95 subject to eligibility he may apply for drawal of pension.";
			out.println("<tr><td colspan=\""+repdata.length+"\">"+remarks+"</td></tr>");
			out.println("<tr><td colspan=\""+repdata.length+"\">");
				out.println("<table width='100%' border=0>");
				out.println("<tr><td width ='60%'>");
				out.println("<td  height=40>");
				out.println("<tr><td width ='60%'><b>Date</b>");
				out.println("<td  ><b>Signature of the employer  or other authorised officer</b>");
				out.println("<tr><td  >");
				out.println("<td width ='60%'><b>Stamp of the Factory/Establishment</b>");
				out.println("</table>");
			
			out.println("</td></tr>"); 
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
			onClick="windowSave('Form10.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Form10.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Form10.html')"><img
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

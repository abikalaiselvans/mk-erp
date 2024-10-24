<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>
<%
	FileReader fr = new FileReader("Report.sys");
	BufferedReader br  = new BufferedReader(fr);
	String strfline ="";
	StringTokenizer filecontents;
	int linecount=0;
	while((strfline=br.readLine())!= null )
	{
		linecount = linecount+1;
	}
	int noofpage;
	int nooflineperpage = 30;
	linecount = linecount-2;
	noofpage = linecount / nooflineperpage;
 	fr = new FileReader("SReport.sys");
	br  = new BufferedReader(fr);
	int fline=1;
	 
%>
<%@ include file="../PrintHeader.jsp"%>

<%

	out.println("<table  id='myTable' width='100%' border='1' cellpadding='2' cellspacing='0' bordercolor='#94C1E4'>");
	while((strfline=br.readLine())!= null )
	{	
		//System.out.println(fline);
		if (fline == 1 )
			out.print("<tr  class='bolddeepblue'><td colspan=50><center><b>"+strfline+"</b></center>");
		if (fline == 2)
		{
				filecontents = new StringTokenizer(strfline,",");
				out.println("<tr  class='tablehead'>");
				while(filecontents.hasMoreElements())
				{
					String gh=""+filecontents.nextElement();
					gh.trim();
					/*if(gh.length()>=5)
						gh=gh.substring(0,4).toUpperCase();
					 else
					 	gh =gh.toUpperCase(); */
			   		out.print("<td   class='bolddeepblue1' ><b>"+gh+"</b>");
				}
		}
		if (fline >= 3)
		{
				filecontents = new StringTokenizer(strfline,",");
				out.println("<tr>");
				int x=0;
				while(filecontents.hasMoreElements())
				{
					
					if(x>3)
						out.print("<td  class=\"bolddeepblue1\" align='right' >");
					else
						out.print("<td align=\"left\" class=\"bolddeepblue1\" >")	;
					x=x+1;
					
			   		out.print(filecontents.nextElement());
					out.println("</td>");
				}
		}
				fline = fline + 1;
	}
	out.println(" </table> ");
	br.close();
	fr.close();
%>

<%
	if(request.getParameter("flag").equals("Y" ))
	{
		String q= " select sum(DOU_BASIC),sum(DOU_MONTHSAL),sum(DOU_CPYPF1),sum(DOU_CPYPF2),sum(DOU_CPYESI),sum(DOU_SUM),sum(DOU_CTC) from pay_t_salary "; 
		q = q+ " where INT_YEAR="+request.getParameter("year");
		q = q+ " AND CHR_MONTH='"+request.getParameter("month")+"'";
		String salary[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(q);
		if(salary.length>0)
		{
			out.println("<br>Basic Salary :"+salary[0][0]);
			out.println("<br>Month Salary :"+salary[0][1]);
			out.println("<br>Company PF-1  :"+salary[0][2]);
			out.println("<br>Company PF-2 :"+salary[0][3]);
			out.println("<br>Company ESI :"+salary[0][4]);
			out.println("<br>SUM :"+salary[0][5]);
			out.println("<br>CTC :"+salary[0][0]);
			
		}
					
	%>
<br>
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
			onClick="windowSave('Salary.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Salary.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Salary.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>

<br>
<table width="80%" border="1" cellpadding="5" cellspacing="0"
	bordercolor="#CCCCCC" align="center">
	<tr>
		<td>
		<table cellspacing=0 cellpadding=0 align="center" width="99%">
			<tr>
				<td class='bolddeepblue' align='left'><b>BPay :: </b></td>
				<td class='bolddeepblue' align='left'>Basic Pay</td>
				<td class='bolddeepblue' align='left'><b>WD :: </b></td>
				<td class='bolddeepblue' align='left'>Working Day</td>
				<td class='bolddeepblue' align='left'><b>ELD :: </b></td>
				<td class='bolddeepblue' align='left'>Extra or Losspay Days</td>
				<td class='bolddeepblue' align='left'><b>LD :: </b></td>
				<td class='bolddeepblue' align='left'>Late Days</td>
				<td class='bolddeepblue' align='left'><b>Allo :: </b></td>
				<td class='bolddeepblue' align='left'>Allowance</td>
			</tr>
			<tr>
				<td class='bolddeepblue' align='left'><b>GPay :: </b></td>
				<td class='bolddeepblue' align='left'>Gross Pay</td>
				<td class='bolddeepblue' align='left'><b>Recv :: </b></td>
				<td class='bolddeepblue' align='left'>Recovery</td>
				<td class='bolddeepblue' align='left'><b>ATot :: </b></td>
				<td class='bolddeepblue' align='left'>Total Advance</td>
				<td class='bolddeepblue' align='left'><b>ADec :: </b></td>
				<td class='bolddeepblue' align='left'>Advance Decution</td>
				<td class='bolddeepblue' align='left'><b>ALeft :: </b></td>
				<td class='bolddeepblue' align='left'>Advance Left</td>
			</tr>
			<tr>
				<td class='bolddeepblue' align='left'><b>Dect :: </b></td>
				<td class='bolddeepblue' align='left'>Dection</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<% }%>

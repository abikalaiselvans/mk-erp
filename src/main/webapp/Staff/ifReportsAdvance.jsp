<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<%@include file="Redirect.jsp" %>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='ATT' ")[0][0]%></title>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>


<%
String staffid=""+session.getAttribute("EMPID");

String sql="";
double sum=0.0;
double sum1=0.0;
double sum2=0.0;
%>
<br>
<br>
<table width='56%' border="1" align="center"     cellpadding=3 cellspacing=2 bordercolor="#9900CC"  class='boldEleven'  id='myTable' >	
  <tr>
		<td colspan="2">
		<div align="center" class="boldThirteen">Advance Informations ::
		<%=staffid%></div>		</td>
  </tr>
	<tr>
		<td width="48%" class="boldThirteen">
		<div align="center">Advance</div>		</td>
		<td width="52%" class="boldThirteen">
		<div align="center">Detection</div>		</td>
	</tr>
	<tr>
		<td align="center" valign="top">
		<div align="center" id="divscroll"
			style="OVERFLOW: auto;width:400x;height:auto">
		<%
			sql=" SELECT  INT_ADVAMT,CHR_MONTH,INT_YEAR  FROM pay_m_advance WHERE CHR_EMPID='"+staffid+"'";
			String datas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			if(datas.length>0)
			{
				out.println("<table cellpadding=3 cellspacing=2 border=0>");
				out.println("<tr><td><b>S.No<td><b>Month<td><b>Year<td><b>Amount");
				for(int u=0;u<datas.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow2'>");
					else
						out.println("<tr class='MRow3'>");
					out.println("<td>"+(u+1)+"<td>"+datas[u][1]+"<td>"+datas[u][2]+"<td align=right>"+datas[u][0]);	
					sum1=sum1+Double.parseDouble(datas[u][0]);
				}
				out.println("</table>");
			}	
		%>
		</div>		</td>
		<td align="center" valign="top">
		<div align="center" id="divscrol2"
			style="OVERFLOW: auto;width:400x;height:auto">
		<%
			sql=" SELECT  INT_DUEAMT,CHR_MONTH,INT_YEAR  FROM pay_t_advance WHERE CHR_EMPID='"+staffid+"'";
			String Rdatas[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
			if(Rdatas.length>0)
			{
				out.println("<table cellpadding=3 cellspacing=2 border=0>");
				out.println("<tr><td><b>S.No<td><b>Month<td><b>Year<td><b>Amount");
				for(int u=0;u<Rdatas.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr class='MRow2'>");
					out.println("<td>"+(u+1)+"<td>"+Rdatas[u][1]+"<td>"+Rdatas[u][2]+"<td align=right>"+Rdatas[u][0]);	
					sum2=sum2+Double.parseDouble(Rdatas[u][0]);
				}
				out.println("</table>");
			}	
		%>
		</div>		</td>
	</tr>
	<tr>
		<td>
		<div align="right"><%=sum1%></div>		</td>
		<td>
		<div align="right"><%=sum2%></div>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td class="boldthikass">&nbsp;</td>
	</tr>
	<tr>
		<td>Balance</td>
		<td class="boldthikass">
		<div align="right"><%=(sum1-sum2)%></div>		</td>
	</tr>
	<tr>
	  <td colspan="2"><div align="center"><a href="javascript:window.print()">Print</a></div></td>
  </tr>
</table>

<table   border="0" align="center" cellpadding="2"
								cellspacing="2">
            <tr>
              
              <td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										 onClick="redirect('iframeStaffMain.jsp')"></td>
            </tr>
          </table>
</body>
</html>

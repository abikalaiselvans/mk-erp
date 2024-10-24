<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*" %>
<%
try
{
%>
<html>

<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: PAYROLL ::</title>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" topmargin="0" leftmargin="0">
<p>
  <%

	String company =request.getParameter("company");
	String branch =request.getParameter("branch");
	String office =request.getParameter("Office");
	String year =request.getParameter("Year");
	String cpy  ="";
	String bid  ="";
	String off="";
	String yer="";
	
	String sql="";
	sql=" SELECT a.CHR_EMPID,a.CHR_EMPNAME,CONCAT(c.CHR_PFNUMBER,b.CHR_PFNO),ROUND(sum(a.DOU_BASIC)),ROUND(sum(a.DOU_PF)),ROUND(sum(a.DOU_CPYPF2)),ROUND(sum(a.DOU_CPYPF1))";
	sql = sql+",b.CHR_TYPE,b.CHR_HOLD	FROM pay_t_salary a, com_m_staff b,com_m_company c ";                               
	sql = sql+"	WHERE a.CHR_EMPID =b.CHR_EMPID  AND a.CHR_PF !='N'   AND  b.INT_COMPANYID=c.INT_COMPANYID  ";
	if(!"0".equals(company))
		sql = sql+"	AND b.INT_COMPANYID = "+company;
	
	if(!"0".equals(branch))
		sql = sql+"	AND b.INT_BRANCHID = "+branch;
	
	if(!"0".equals(office))
		sql = sql+"	AND b.INT_OFFICEID = "+office;
		
	sql = sql+"	"+cpy;
	sql = sql+"	"+bid;
	sql = sql+"	"+ off;
	sql = sql+" AND (((a.CHR_MONTH in('April','May','June','July','August','September','October','November','December')) AND";
	sql = sql+"  (a.INT_YEAR= "+(Integer.parseInt(year)-1)+")) or((a.CHR_MONTH in('January','February','March')) ";
	sql = sql+" AND (a.INT_YEAR= "+year+")  )) group BY CHR_PFNO  "; //ORDER BY replace(CHR_PFNO,'TN/50360/','')
	 
	 
	String data[][] =CommonFunctions.QueryExecute(sql);
	String cdata[][] =CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID ="+company);
		 double sumA=0.0;
		 double sumB=0.0;
		 double sumC=0.0;
		 double sumD=0.0;
%>
</p>
 
 <center>
<table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'  align="center">
  <tr bgcolor='#ffffff'>
    <td colspan="10" class="boldEleven"><div align="center"><%= cdata[0][0] %></div></td>
    <td class="boldEleven"><a href='<%="../SmartLoginAuth?filename=PF&actionS=PAYForm6A&Year="+year+"&company="+company+"&branch="+branch+"&Office="+office%>' target="_blank"><img border="0" src="../images/icon_pdf.gif" width="47" height="49" /></a></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">YEAR :: <%=(Integer.parseInt(year)-1) %> - <%= year %></div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">FORM 6A</div></td>
  </tr bgcolor='#ffffff'>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">The Employee's Provident Fund   Scheme 1962</div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">(paragraph 43) and</div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">The Employee's Pension Scheme,   1995</div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><div align="center">paragraph 15(4)</div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <TH width="24" height="78" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">SlNo</div></TH>
    <TH width="50" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Account Number</div></TH>
    <TH width="105" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col">Empid</TH>
    <TH width="105" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Name of the Member(in   Block letter) </div></TH>
    <TH width="54" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Wages</div></TH>
    <TH width="88" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">EPF Amount of workers   contribution deducted from the wages </div></TH>
    <td colspan="2" bordercolor="#000000" class="boldEleven"><div align="center">Employer's con</div></td>
    <TH width="46" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Refund of Advance</div></TH>
    <TH width="69" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Rate of Higher voluntary   contribution (if any)</div></TH>
    <TH width="50" rowSpan="2" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Remarks</div></TH>
  </tr>
  <tr bgcolor='#ffffff'>
    <TH height="59" bordercolor="#000000" class="boldEleven" scope="col"><div align="center">EPF DIFFERENCE   10%&amp;8/3%</div></TH>
    <TH bordercolor="#000000" class="boldEleven" scope="col"><div align="center">Pension Fund 8 1/3%</div></TH>
  </tr>
  <%
	String emp="";
  	for(int u=0;u<data.length;u++)
	{
			emp="";
			emp=data[u][0];
			
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
					
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][2]);
			out.println("<td class='boldEleven'>"+emp+"</td>");
			if(data[u][7].equals("T"))
				out.println("<td class='boldEleven'>"+data[u][1]+" <font color='red'>*</font>");
			else if(data[u][8].equals("Y"))
				out.println("<td class='boldEleven'>"+data[u][1]+" <font color='red'>**</font>");
			else
				out.println("<td class='boldEleven'>"+data[u][1]);
				
			out.println("<td class='boldEleven' align='right'>"+data[u][3]);
			out.println("<td class='boldEleven' align='right'>"+data[u][4]);
			out.println("<td class='boldEleven' align='right'>"+data[u][5]);
			out.println("<td class='boldEleven' align='right'>"+data[u][6]);
			out.println("<td class='boldEleven'>&nbsp;");
			out.println("<td class='boldEleven'>&nbsp;");
			out.println("<td class='boldEleven'>&nbsp;");
			sumA= sumA + Double.parseDouble(data[u][3]);
			sumB= sumB + Double.parseDouble(data[u][4]);
			sumC= sumC + Double.parseDouble(data[u][5]);
			sumD= sumD + Double.parseDouble(data[u][6]);
			
		}%>
  <tr bgcolor='#ffffff'>
    <td width="24" class="boldEleven"><div align="center">&nbsp;</div></td>
    <td width="50" class="boldEleven"><div align="center">&nbsp; </div></td>
    <td width="210" colspan="2" class="boldEleven"><div align="center">&nbsp; </div></td>
    <td width="54" class="boldEleven"><div align="right"><%= (sumA) %><!--com.my.org.erp.common.CommonFunctions.Round--></div></td>
    <td width="88" class="boldEleven"><div align="right"><%= (sumB) %></div></td>
    <td width="70" class="boldEleven"><div align="right"><%= (sumC) %></div></td>
    <td width="61" class="boldEleven"><div align="right"><%= (sumD) %></div></td>
    <td width="46" class="boldEleven"><div align="right">&nbsp; </div></td>
    <td width="69" class="boldEleven"><div align="right">&nbsp; </div></td>
    <td width="50" class="boldEleven"><div align="right">&nbsp; </div></td>
  </tr>
  <tr bgcolor='#ffffff'>
    <td colspan="11" class="boldEleven"><span class="style3">Note ::</span><font color="#FF0000"> *</font> - Resigned <font color="#FF0000">**</font> - Hold</td>
  </tr>
</table>
 </center>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>

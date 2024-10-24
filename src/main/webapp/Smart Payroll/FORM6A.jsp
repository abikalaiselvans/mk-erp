<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*" %>
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


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste='return false;'>
<p>
  <%@ include file="index.jsp"%>
  <br>
</p><%
   	String company =request.getParameter("company");
	String branch =request.getParameter("branch");
	String office =request.getParameter("Office");
	String year =request.getParameter("Year");
	String cpy  ="";
	String bid  ="";
	String off="";
	String yer="";
	if(!"-1".equals(company))
		cpy =" AND b.INT_COMPANYID = "+company;
	
	if(!"-1".equals(branch))
		bid ="  AND b.INT_BRANCHID = "+branch;
	
	if(!"0".equals(office))
		off ="  AND b.INT_OFFICEID = "+office;
		
	String sql="";
	sql=" SELECT a.CHR_EMPID,a.CHR_EMPNAME,b.CHR_PFNO,sum(a.DOU_BASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2)";
	sql = sql+",b.CHR_TYPE,b.CHR_HOLD	FROM pay_t_salary a, com_m_staff b ";                               
	sql = sql+"	WHERE a.CHR_EMPID =b.CHR_EMPID ";
	sql = sql+"	"+cpy;
	sql = sql+"	"+bid;
	sql = sql+"	"+ off;
	sql = sql+" AND (((a.CHR_MONTH in('April','May','June','July','August','September','October','November','December')) AND";
	sql = sql+"  (a.INT_YEAR= "+(Integer.parseInt(year)-1)+")) or((a.CHR_MONTH in('January','February','March')) ";
	sql = sql+" AND (a.INT_YEAR= "+year+")  )) group BY a.CHR_EMPID ";
	
	//out.print(sql);
	 
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	String cdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID ="+company);
	if(data.length>0)
	{
		 double sumA=0.0;
		 double sumB=0.0;
		 double sumC=0.0;
		 double sumD=0.0;
		 
		
		out.println("<center><table bordercolor='#D8D8D8'  id='myTable' width='95%'  border='1' align='center' cellpadding='0' cellspacing='0'>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b>"+cdata[0][0]+"</b>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b>YEAR :: "+(Integer.parseInt(year)-1)+" - " +year+"</b>");
		
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b> FORM 6A</b>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b> The Employee's Provident Fund Scheme 1962</b>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b>(paragraph 43) and</b>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b>The Employee's Pension Scheme, 1995</b>");
		out.println("<tr>");
		out.println("<td colspan=10 class='boldEleven' align='center'><b>paragraph 15(4)</b>");
		out.println("<tr>");
		out.println("<th width='33' height='78' rowspan='2' class='boldEleven' scope='col'><b>SlNo</th>");
		out.println("<th width='64' rowspan='2' class='boldEleven' scope='col'><b>Account Number</th>");
		out.println("<th width='101' rowspan='2' class='boldEleven' scope='col'><b>Name of the Member(in Block letter) </th>");
		out.println("<th width='46' rowspan='2' class='boldEleven' scope='col'><b>Wages</th>");
		out.println("<th width='139' rowspan='2' class='boldEleven' scope='col'><b>EPF Amount of workers contribution deducted from the wages </th>");
		out.println("<th colspan='2' class='boldEleven' scope='col'><b>Employer's con </th>");
		out.println("<th width='105' rowspan='2' class='boldEleven' scope='col'><b>Refund of Advance</th>");
		out.println("<th width='110' rowspan='2' class='boldEleven' scope='col'><b>Rate of Higher voluntary contribution (if any)</th>");
		out.println("<th width='62' rowspan='2' class='boldEleven' scope='col'><b>Remarks</th>");
	  	out.println("</tr>");
	  	out.println("<tr>");
		out.println("<th width='95' height='59' class='boldEleven' scope='col'><b>EPF DIFFERENCE 10%&8/3%</th>");
		out.println("<th width='103' class='boldEleven' scope='col'><b>Pension Fund 8 1/3%</th>");
	  	out.println("</tr>");
		for(int u=0;u<data.length;u++)
		{
		

			out.println("<tr><td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+data[u][2]);
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
			
		}
		out.println("<tr><td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sumA));
		out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sumB));
		out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sumC));
		out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.Round(sumD));
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("<td class='boldEleven'>&nbsp;");
		out.println("</table></center>");
		out.println("<div align='left'>Note : <font color='red'>*</font> - Terminated <font color='red'>**</font> - Hold</div>");
		out.println("<div align='right'><a href='FORM6APrint.jsp?company="+company+"&branch="+branch+"&Office="+office+"&Year="+year+"'><font class='bolddeepred'>Print</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>");
		%>
		<table width="184" align="center" cellpadding="15" cellspacing="0" bordercolor="#CCCCCC">
             <tr>
		   <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
             <td class="boldEleven"><div align="center"><a  title="Excel" href=javascript:; onClick=" CreateExcelSheet()"><img src="../Image/report/Excel.png" width="15" height="14" border="0"></a> </div></td>
		       
		       <td class="boldEleven"><div align="center"><a title="Text" href=javascript:; onClick="windowSave('Form6a.txt')"><img src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div></td>
		       <td class="boldEleven"><div align="center"><a title="Document" href=javascript:; onClick="windowSave('Form6a.doc')"><img src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div></td>
		       <td class="boldEleven"><div align="center"><a title="HTML" href=javascript:; onClick="windowSave('Form6a.html')"><img src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div></td>
			   
           </tr>
</table>
		<%	
		 
	}
  %>
   <%@ include file="../footer.jsp"%>
</p>
</body>
</html>

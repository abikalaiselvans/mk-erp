<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

 
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

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	 >
<%@ include file="indexacct.jsp"%>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>
	  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:100%" 	class="boldEleven">
	  <%
	  	String Financialyear = request.getParameter("Financialyear");;
		String branch = request.getParameter("branch");;
		String sql=" SELECT date_format(a.DAT_DATE,'%d-%m-%Y'),b.CHR_GROUPNAME,a.DOU_AMOUNT FROM   acc_t_receipts   a,acc_m_group b WHERE a.INT_GROUPID=b.INT_GROUPID AND INT_FINANCIALYEARID="+Financialyear+"  AND a.INT_BRANCHID="+branch+" ORDER BY a.DAT_DATE";
		String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		double income=0;
		double expense=0;
		
		out.println("<table width=600  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  align='center'>");
		out.println("<tr bgcolor='#ffffff'><td colspan='2' class='boldEleven' align='center'><b>CASH  BOOK  LIST</b></td>");
		out.println("</tr>");
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td class='boldEleven' align='center'> <b>INCOME</b>");
		out.println("</td>");
		out.println("<td class='boldEleven' align='center'><b>EXPENSE</b></td>");
		out.println("</tr>");
		
		out.println("<tr bgcolor='#ffffff'>");
		out.println("<td valign='top' align='center'>");
		
		//Income 
		if(data.length>0)
		{			
			out.println("<br><table  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  width=95%  border='0' cellspacing='2' cellpadding='2'>");
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow1'>	");
					else
						out.println("<tr class='MRow2'>	");	
					out.println("<td class='boldEleven' align='right'>"+(u+1)+".</td>");	
					out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
					out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
					out.println("<td align='right' class='boldEleven'>"+data[u][2]+"</td>");
					income = income+Double.parseDouble(data[u][2]);
				}
				out.println("</table><br>");
		}	
		out.println("</td>");
		
		//Expense
		
		sql = "SELECT b.CHR_GROUPNAME,date_format(a.DAT_DATE,'%d-%m-%Y'),a.DOU_AMOUNT FROM  acc_t_payments  a,acc_m_group b WHERE a.INT_GROUPID=b.INT_GROUPID  AND INT_FINANCIALYEARID="+Financialyear+"  AND a.INT_BRANCHID="+branch+"  ORDER BY a.DAT_DATE" ;
		String data1[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    out.println("<td  valign='top'  align='center'>");
			if(data1.length>0)
			{	
				out.println("<br><table cellpadding=2 cellspacing=1 bgcolor='#9900CC'  width=95% border='0' cellspacing='2' cellpadding='2'>");
				for(int u=0;u<data1.length;u++)
				{
					if(u%2==0)
						out.println("<tr class='MRow1'>	");
					else
						out.println("<tr class='MRow2'>	");	
					out.println("<td class='boldEleven' align='right'>"+(u+1)+".</td>");
					out.println("<td class='boldEleven'>"+data1[u][1]+"</td>");	
					out.println("<td class='boldEleven'>"+data1[u][0]+"</td>");
					out.println("<td align='right' class='boldEleven'>"+data1[u][2]+"</td>");
					expense = expense+Double.parseDouble(data1[u][2]);
				}
				out.println("</table><br>");
			}	
  			out.println("</td>");
			out.println("</tr>");
			out.println("<tr bgcolor='#ffffff'>");
    		out.println("<td class='boldEleven' align='right'> <b> "+com.my.org.erp.common.CommonFunctions.keep2DigitString(income)+" </b>");
			out.println("</td>");
	    	out.println("<td class='boldEleven' align='right'><b>"+com.my.org.erp.common.CommonFunctions.keep2DigitString(expense)+" </b></td>");
  			out.println("</tr>");

			
			out.println("</tr>");
			out.println("<tr bgcolor='#ffffff'>");
    		out.println("<td class='boldEleven' align='center'> <b> Income and Expense </b>");
			out.println("</td>");
	    	out.println("<td class='boldEleven' align='right'><b>"+(income-expense)+"</b></td>");
  			out.println("</tr>");
			out.println("</table>");

		 
	  %>
	  </div>
	  </td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td width="1000"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
          <tr>
            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AccountsMain.jsp')"></td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>

 
<%@ page import="java.io.*,java.util.*"%>

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
<script language="JavaScript" src="../JavaScript/calendar1.js"
	type="text/javascript"></script>
<body >
 
	  <%
	  	try
			{
	  			String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String bank = request.getParameter("Bank");
				String customer = request.getParameter("customer");
				String Branch = request.getParameter("Branch");
				
				String sql="";
				String fdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				String tdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				sql = sql+" SELECT a.CHR_SALESORDERNO , FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKNAME_NAME(c.INT_BANKGROUPID),a.CHR_PAYNO, ";
				sql = sql+" date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'), a.DOU_PAIDAMOUNT,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ";
				sql = sql+"  ,date_format(d.DAT_SALESDATE,'%d-%b-%Y') FROM inv_t_customersalespayment a,";
				sql = sql+" inv_m_customerinfo b,com_m_bankgroup c  ,inv_t_directsales d WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
				sql = sql+"   AND a.CHR_SALESORDERNO =d.CHR_SALESNO AND a.CHR_BANKNAME = c.INT_BANKGROUPID ";
				sql = sql +" AND a.INT_BRANCHID ="+Branch;
				if(!"0".equals(bank))
					sql = sql+" AND a.CHR_BANKNAME='"+bank+"' ";
				if(!"0".equals(customer))	
					sql = sql+" AND a.INT_CUSTOMERID="+customer;
					
				sql = sql+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
				sql = sql+" ORDER BY a.CHR_SALESORDERNO ";
				String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					out.println("<center><table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr bgcolor='#ffffff' ><td colspan=9 class='boldEleven' align=center><b>Payment Collection ");
					out.println("( FROM -"+fromdate +"  TO-  "+ todate +")");
					out.println("<tr bgcolor='#ffffff' ><td colspan=9 class='boldEleven' align=center><b>");
					out.println(com.my.org.erp.common.CommonFunctions.companyName(Branch));
					out.println("<tr bgcolor='#ffffff' ><td class='boldEleven'><b>S.No<td class='boldEleven'><b>Invoice No");
					out.println("<td class='boldEleven'><b>Invoice Date");
					out.println("<td class='boldEleven'><b>Customer Name");
					out.println("<td class='boldEleven'><b>Bank Name <td class='boldEleven'><b>Payment-Details");
					out.println("<td class='boldEleven'><b>Cheque Date");
					out.println("<td class='boldEleven'><b>Payment collect Date");
					out.println("<td class='boldEleven'><b>Paid Amount");
					double sum=0.0;
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");	
						
						out.println("<td class='boldEleven'>"+(u+1));	
						out.println("<td class='boldEleven'>"+data[u][0]);	
						out.println("<td class='boldEleven'>"+data[u][7]);
						out.println("<td class='boldEleven'>"+data[u][1]);	
						out.println("<td class='boldEleven'>"+data[u][2]);
						out.println("<td class='boldEleven'>"+data[u][3]);		
						out.println("<td class='boldEleven'>"+data[u][6]);	
						out.println("<td class='boldEleven'>"+data[u][4]);	
						out.println("<td class='boldEleven' align='right'>"+data[u][5]);	
						sum = sum+Double.parseDouble(data[u][5]);
						
						 
					}
					out.println("<tr bgcolor='#ffffff' ><td colspan=8 class='boldEleven' align=right><b>Total ::  ");
					out.println("<td class='boldEleven' align='right'><b>"+Math.round(sum));
					out.println("<tr bgcolor='#ffffff' ><td colspan=9 class='boldEleven' align=center><b> ");
					%>
					<div align="center" id="Rupees">
						<script	language="javascript">numberWord("<%=(sum)%>","Rupees")</script>
					</div>
				<%					  
					out.println("</table></center>");
				}
				else
				{
					out.println("<center><font class='boldred'>Data not found...</font><center>");
					
				}

			}
			catch(Exception e)
			{
			}
	  %>
	 
</body>
</html>

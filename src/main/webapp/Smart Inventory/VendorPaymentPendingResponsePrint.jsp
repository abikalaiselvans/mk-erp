<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
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

<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<body >
 <%
 
 	
	  String link="";
	  	try
			{
	  			
				String Vendortype = request.getParameter("Vendortype");
				String order=request.getParameter("order");
				String From=request.getParameter("From");
				String To=request.getParameter("To");
				 link = "VendorPaymentPendingResponsePrint.jsp?Vendortype="+Vendortype+"&order="+order+"&From="+From+"&To="+To;
				String sql="";
				 
				
				if("Direct".equals(Vendortype))
				{
					 
					sql = " SELECT b.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,DATE_FORMAT(b.DAT_ORDERDATE,'%c-%M-%Y'), ";
					sql = sql+ "datediff(now(),b.DAT_ORDERDATE), b.DOU_TOTALAMOUNT,";
					sql = sql+ "(SELECT sum(a.DOU_PAIDAMOUNT) FROM inv_t_vendorpurchasepayment a WHERE a.CHR_PURCHASEORDERNO =b.CHR_PURCHASEORDERNO ) ";
					sql = sql+ " FROM inv_t_directpurchase b,  inv_m_vendorsinformation  c     ";
					sql = sql+ " WHERE  b.INT_VENDORID= c.INT_VENDORID";
					sql = sql+ " AND datediff(now(),b.DAT_ORDERDATE)>="+From;
					sql = sql+ "  AND datediff(now(),b.DAT_ORDERDATE) <="+To;
					sql = sql+ " Group by b.CHR_PURCHASEORDERNO ORDER BY "+order;
					
					
					

					 
 	 
				}
				else if("Purchase".equals(Vendortype))
				{
					
				}
				 
				double sum=0;
				double sum1=0;
				double sum2=0;
				String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					out.println("<center><table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr bgcolor='#ffffff' ><td colspan=9 class='boldEleven' align=center><b>Vendor Payment Pending ");
					out.println("<tr bgcolor='#ffffff' ><td class='boldEleven'><b>S.No<td class='boldEleven'><b>PO. Ref. No");
					out.println("<td class='boldEleven'><b>Vendor Name");
					out.println("<td class='boldEleven'><b>Vendor Mobile");
					out.println("<td class='boldEleven'><b>PO. Date");
					out.println("<td class='boldEleven'><b>Days Left");
					out.println("<td class='boldEleven'><b>Bill Amount");
					out.println("<td class='boldEleven'><b>Paid Amount");
					out.println("<td class='boldEleven'><b>Balance Amount");
					
					for(int u=0;u<data.length;u++)
					{
						if(u%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow2'>");	
						
						out.println("<td class='boldEleven'>"+(u+1));	
						out.println("<td class='boldEleven'>"+data[u][0].trim());	
						out.println("<td class='boldEleven'>"+data[u][1].trim());
						out.println("<td class='boldEleven'>"+data[u][2].trim());	
						out.println("<td class='boldEleven'>"+data[u][3].trim());
						out.println("<td class='boldEleven'>"+data[u][4].trim());		
						out.println("<td class='boldEleven' align='right'>"+data[u][5].trim());
						
						if("-".equals(data[u][6].trim()) || "null".equals(data[u][6].trim()))
							sum1=0;
						else
							sum1 =Double.parseDouble(data[u][6].trim());	
							
						sum2 = Double.parseDouble(data[u][5].trim())-sum1;
						out.println("<td class='boldEleven' align='right'>"+sum1);	
						out.println("<td class='boldEleven' align='right'>"+sum2);	
						sum = sum+Double.parseDouble(data[u][5].trim());
						
						 
					}
					out.println("<tr bgcolor='#ffffff' ><td colspan=8 class='boldEleven' align=right><b>Total ::  ");
					out.println("<td class='boldEleven' align='right'><b>"+Math.round(sum));
					out.println("<tr bgcolor='#ffffff' ><td colspan=9 class='boldEleven' align=center><b> ");
					%>
					<div align="center" id="Rupees">
						<script	language="javascript">numberWord("<%=Math.round(sum)%>","Rupees")</script>
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

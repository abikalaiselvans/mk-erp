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
	  			String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String vendorid = request.getParameter("vendorid");
				String Vendortype = request.getParameter("Vendortype");
				String Chequedt=request.getParameter("Chequedt");
				link = "VendorPaymentResponseprint.jsp?fromdate="+fromdate+"&todate="+todate+"&vendorid="+vendorid+"&Vendortype="+Vendortype+"&Chequedt="+Chequedt;
				String sql="";
				String fdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				String tdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String mode="";
				
				
				if("Direct".equals(Vendortype))
				{
					mode = "DIRECT PURCHASE PAYMENT ";
					sql = " SELECT a.CHR_PURCHASEORDERNO,c.CHR_VENDORNAME,c.CHR_MOBILE,b.DOU_TOTALAMOUNT,b.DAT_ORDERDATE , ";
					sql = sql+ "d.CHR_PAYMENTNAME,e.CHR_BANKNAME,a.CHR_DDNUMBER,a.DAT_DDDATE,a.DAT_PAYMENTDATE,a.DOU_PAIDAMOUNT ";
					sql = sql+ " FROM inv_t_vendorpurchasepayment a ,inv_t_directpurchase b,  inv_m_vendorsinformation  c,  ";
					sql = sql+ "inv_m_paymentterms d, com_m_bank e WHERE a.CHR_PURCHASEORDERNO = b.CHR_PURCHASEORDERNO ";
					sql = sql+ "AND b.INT_VENDORID= c.INT_VENDORID ";
					sql = sql+ "AND d.INT_PAYMENTTERMID= a.INT_PAYMENTTERMID ";
					sql = sql+ "AND a.INT_BANKID = e.INT_BANKID ";
					sql = sql+ "AND a.CHR_INVOICEFOR ='D' ";
					if("1".equals(Chequedt))
					{
						sql = sql+ " AND  a.DAT_DDDATE >='"+fdt+"'";
						sql = sql+ " AND  a.DAT_DDDATE <='"+tdt+"'";
						sql = sql+ " ORDER BY a.DAT_DDDATE ";
					}
					else
					{
						sql = sql+ " AND  a.DAT_PAYMENTDATE >='"+fdt+"'";
						sql = sql+ " AND  a.DAT_PAYMENTDATE <='"+tdt+"'";
						sql = sql+ " ORDER BY a.DAT_PAYMENTDATE ";
					}
						
					 
				}
				else if("Purchase".equals(Vendortype))
				{
					mode = "PURCHASE ORDER PAYMENT ";
				}
				 
				
				String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(data.length>0)
				{
					out.println("<center><table  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					out.println("<tr bgcolor='#ffffff' ><td colspan=12 class='boldEleven' align=center><b>Vendor Payment  ");
					out.println("<tr bgcolor='#ffffff' ><td class='boldEleven'><b>S.No<td class='boldEleven'><b>PO. Ref. No");
					out.println("<td class='boldEleven'><b>Vendor Name");
					out.println("<td class='boldEleven'><b>Vendor Mobile");
					out.println("<td class='boldEleven'><b>Bill Amount");
					out.println("<td class='boldEleven'><b>PO. Date");
					out.println("<td class='boldEleven'><b>Payment Mode <td class='boldEleven'><b>Bank");
					out.println("<td class='boldEleven'><b>Cheque / DD / Other Details");
					out.println("<td class='boldEleven'><b>Cheque Date");
					out.println("<td class='boldEleven'><b>Entry Date ");
					out.println("<td class='boldEleven'><b>Paid Amount");
					double sum=0.0;
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
						out.println("<td class='boldEleven'>"+data[u][5].trim());
						out.println("<td class='boldEleven'>"+data[u][6].trim());	
						out.println("<td class='boldEleven'>"+data[u][7].trim());	
						out.println("<td class='boldEleven'>"+data[u][8].trim());	
						out.println("<td class='boldEleven'>"+data[u][9].trim());	
						out.println("<td class='boldEleven' align='right'>"+data[u][10].trim());	
						sum = sum+Double.parseDouble(data[u][10].trim());
						
						 
					}
					out.println("<tr bgcolor='#ffffff' ><td colspan=11 class='boldEleven' align=right><b>Total ::  ");
					out.println("<td class='boldEleven' align='right'><b>"+Math.round(sum));
					out.println("<tr bgcolor='#ffffff' ><td colspan=12 class='boldEleven' align=center><b> ");
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

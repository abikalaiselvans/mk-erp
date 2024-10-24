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


<title> :: PAYROLL ::</title>


 

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<br><br><br>
<%
								
								String sql = "SELECT A.CHR_EMPID, A.CHR_STAFFNAME, B.INT_RIVISIONID, B.INT_BASIC, B.INT_INCREMENT, B.DT_RIVISION from  com_m_staff  A, pay_t_rivision B ";
                    			sql=sql+ " where A.CHR_EMPID=B.CHR_EMPID AND B.CHR_EMPID='"+request.getParameter("empid")+"' ORDER BY  B.INT_RIVISIONID";
                    			String WDatas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
								out.println("<tr class='MRow1'>");
								out.println("<td width='150' class='boldEleven' align='center'><b>S.No</b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Emp Id</b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Emp Name</b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Rivision </b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Basic</b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Increment</b>");
								out.println("<td width='150' class='boldEleven' align='center'><b>Rivision Date</b>");
								
								for(int u=0; u<WDatas.length;u++)
								{
									if(u%2==0)
										out.println("<tr height='25' class='MRow2'>");
									else
										out.println("<tr height='25' class='MRow1'>");
									out.println("<td width='150' class='boldEleven'>"+(u+1));	
									out.println("<td width='150' class='boldEleven'>"+WDatas[u][0]);
									out.println("<td width='150' class='boldEleven'>"+WDatas[u][1]);
									out.println("<td width='150' class='boldEleven'>"+WDatas[u][2]);
									out.println("<td width='150' class='boldEleven'>"+WDatas[u][3]);
				    				out.println("<td width='150' class='boldEleven'>"+WDatas[u][4]);
				    				out.println("<td width='150' class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(WDatas[u][5]));	
								}
								out.println("</table>");	
								%>
</body>
</html>

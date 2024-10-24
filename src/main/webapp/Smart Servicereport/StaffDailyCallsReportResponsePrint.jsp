 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
  <%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
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


<title> :: SERVICE REPORT :: </title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<body  onpaste="return false;" onLoad="window.print()" >


<p>
  <%
try
{
	String fdate = request.getParameter("fdate");
	 
	String userid = ""+session.getAttribute("USRID");
	String empid = ""+session.getAttribute("EMPID");
	String sql = "";
	String date = DateUtil.FormateDateSQL(fdate);
	String next7day = CommonFunctions.getNext7Day(7, date) ;
	String next7dayname = CommonFunctions.getNext7DayName(7, date) ;
	 
	 String plink = " StaffDailyCallsReportResponse.jsp?fdate="+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+date+"', INTERVAL 1 DAY),'%d-%m-%Y'))")[0][0]+"";
	 String nlink = " StaffDailyCallsReportResponse.jsp?fdate="+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_ADD('"+date+"', INTERVAL 1 DAY),'%d-%m-%Y'))")[0][0]+"";
	 String nweek = " StaffDailyCallsReportResponse.jsp?fdate="+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+date+"', INTERVAL 7 DAY),'%d-%m-%Y'))")[0][0]+"";
	 
	String day[] = next7day.split(",");
	String days[] = next7dayname.split(",");
	out.println("<br><br><br><center>");
	out.println("<table width='100%' height='500' border='1' class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'> <td  class='boldEleven' colspan='12'><center><img src=\"../images/logo.jpg\"></center> </b>&nbsp;&nbsp;&nbsp;<center> <b>ENGINEER WEEKLY REPORT FOR [ "+CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_EMPID='"+empid+"'")[0][1]+" / "+empid+ "] </center> </b></td> </tr>");
	out.println("<tr class='MRow2'>");
	out.println("<td  class='MRow4' ><b>S.No</td>");
	out.println("<td  class='MRow4' ><b>Details</td>");
	for(int u=0;u<day.length;u++)
		out.println("<td  class='MRow4' ><b>"+day[u]+" / "+days[u] +"</td>");
	out.println("<td  class='MRow4' ><b>Total</td>");
	out.println("<td  class='MRow4' ><b>Pre Week</td>");	
	out.println("</tr>"); 
	
	
	
	
	out.println("<tr class='MRow2'>");
	out.println("<td  class='boldEleven' ><b>1");
	out.println("<td  class='boldEleven' ><b>'01' Calls");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 sql = sql + "	  AND CHR_CALLTYPE= '1'   ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	
	 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 sql = sql + "	  AND CHR_CALLTYPE= '1'   ";
	 String data1[][] = CommonFunctions.QueryExecute(sql);
	 if(data1.length>0)
		out.println("<td  class='boldEleven' >"+data1[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
		
		
	 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	  AND CHR_CALLTYPE= '1'   ";
	 String pdata1[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata1.length>0)
		out.println("<td  class='MRow4' >"+pdata1[0][0]+"</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	 
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' ><b>2");
	out.println("<td  class='boldEleven' ><b>'02' Calls");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 sql = sql + "	  AND CHR_CALLTYPE= '2' ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 sql = sql + "	  AND CHR_CALLTYPE= '2'   ";
	 String data2[][] = CommonFunctions.QueryExecute(sql);
	 if(data2.length>0)
		out.println("<td  class='boldEleven' >"+data2[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	  AND CHR_CALLTYPE= '2'   ";
	 String pdata2[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata2.length>0)
		out.println("<td  class='MRow4' >"+pdata2[0][0]+"</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	
	
	
	
	
	
	out.println("<tr class='MRow2'>");
	out.println("<td  class='boldEleven' ><b>3");
	out.println("<td  class='boldEleven' ><b>Calls Pending ");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 sql = sql + "	  AND CHR_CALLSTATUS= 'P'  ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 sql = sql + "	  AND CHR_CALLSTATUS= 'P'    ";
	 String data3[][] = CommonFunctions.QueryExecute(sql);
	 if(data3.length>0)
		out.println("<td  class='boldEleven' >"+data3[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	 sql = " SELECT  COUNT(CHR_CALLSTATUS)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	  AND  CHR_CALLSTATUS= 'P'   ";
	 String pdata3[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata3.length>0)
		out.println("<td  class='MRow4' >"+pdata3[0][0]+"</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' ><b>4");
	out.println("<td  class='boldEleven' ><b>Calls Closed");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 sql = sql + "	  AND CHR_CALLSTATUS= 'C'   ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 sql = sql + "	  AND CHR_CALLSTATUS= 'C'    ";
	 String data4[][] = CommonFunctions.QueryExecute(sql);
	 if(data4.length>0)
		out.println("<td  class='boldEleven' >"+data4[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	 sql = " SELECT  COUNT(CHR_CALLSTATUS)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	  AND  CHR_CALLSTATUS= 'C'   ";
	 String pdata4[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata4.length>0)
		out.println("<td  class='MRow4' >"+pdata4[0][0]+"</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow2'>");
	out.println("<td  class='boldEleven' ><b>5");
	out.println("<td  class='boldEleven' ><b>Hand on Hours");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT ( SUM(INT_HANDSONHOURS)+FLOOR(SUM(INT_HANDSONMINUTES)/60)) ,MOD(SUM(INT_HANDSONMINUTES),60)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' > "+data[0][0]+"hrs. "+data[0][1]+"mts.</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	 sql = " SELECT ( SUM(INT_HANDSONHOURS)+FLOOR(SUM(INT_HANDSONMINUTES)/60)) ,MOD(SUM(INT_HANDSONMINUTES),60)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 String data5[][] = CommonFunctions.QueryExecute(sql);
	 if(data5.length>0)
		out.println("<td  class='boldEleven' >"+data5[0][0]+"hrs. "+data5[0][1]+"mts.</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	 sql = " SELECT ( SUM(INT_HANDSONHOURS)+FLOOR(SUM(INT_HANDSONMINUTES)/60)) ,MOD(SUM(INT_HANDSONMINUTES),60) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 String pdata5[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata5.length>0)
		out.println("<td  class='MRow4' >"+pdata5[0][0]+"hrs. "+pdata5[0][1]+"mts.</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' ><b>6");
	out.println("<td  class='boldEleven' ><b>Travel Hours/KM");
	for(int u=0;u<day.length;u++)
	{
		 sql = " SELECT ( SUM(INT_TRAVELHOURS)+FLOOR(SUM(INT_TRAVELMINUTES)/60)) ,MOD(SUM(INT_TRAVELMINUTES),60) ,SUM(INT_KM)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' > "+data[0][0]+"hrs. "+data[0][1]+"mts.  "+data[0][2]+"Kms.</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	sql = " SELECT ( SUM(INT_TRAVELHOURS)+FLOOR(SUM(INT_TRAVELMINUTES)/60)) ,MOD(SUM(INT_TRAVELMINUTES),60) ,SUM(INT_KM)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 String data6[][] = CommonFunctions.QueryExecute(sql);
	 if(data6.length>0)
		out.println("<td  class='boldEleven' >"+data6[0][0]+"hrs. "+data6[0][1]+"mts.  "+data6[0][2]+"Kms.</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	sql = " SELECT ( SUM(INT_TRAVELHOURS)+FLOOR(SUM(INT_TRAVELMINUTES)/60)) ,MOD(SUM(INT_TRAVELMINUTES),60) ,SUM(INT_KM) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 String pdata6[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata6.length>0)
		out.println("<td  class='MRow4' >"+pdata6[0][0]+"hrs. "+pdata6[0][1]+"mts.  "+pdata6[0][2]+"Kms.</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow2'>");
	out.println("<td  class='boldEleven' ><b>7");
	out.println("<td  class='boldEleven' ><b>No of Spare Demanded");
	for(int u=0;u<day.length;u++)
	{
		sql = " SELECT SUM(INT_NOOFSPARE)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		sql = sql + "	 AND DAT_DATE ='"+DateUtil.FormateDateSQL(day[u])+"' ";
		 
		 String data[][] = CommonFunctions.QueryExecute(sql);
		 if(data.length>0)
		 	out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
	}
	sql = " SELECT SUM(INT_NOOFSPARE)   FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+DateUtil.FormateDateSQL(day[0])+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+DateUtil.FormateDateSQL(day[6])+"' ";
	 String data7[][] = CommonFunctions.QueryExecute(sql);
	 if(data7.length>0)
		out.println("<td  class='boldEleven' >"+data7[0][0] +"Spare</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	
	sql = " SELECT SUM(INT_NOOFSPARE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[0])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+CommonFunctions.QueryExecute("SELECT (DATE_FORMAT(DATE_SUB('"+DateUtil.FormateDateSQL(day[6])+"', INTERVAL 7 DAY),'%Y-%m-%d'))")[0][0]+"' ";
	 String pdata7[][] = CommonFunctions.QueryExecute(sql);
	 if(pdata7.length>0)
		out.println("<td  class='MRow4' >"+pdata7[0][0]+"Spares</td>");
	 else
		out.println("<td  class='MRow4' >-</td>");
	out.println("</tr>"); 
	 
	out.println("</table>");
	out.println("</center>");
	
%>
  
 
 
 <%
 }
catch(Exception e)
{
	out.println(e.getMessage());
}	
%> 
 </body>
</html>

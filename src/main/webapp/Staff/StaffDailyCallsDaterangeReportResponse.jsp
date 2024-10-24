<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
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


<title>:: STAFF ::</title>

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<body  onpaste="return false;" >


<p>
  <%
 
	String fdate = request.getParameter("fdate");
	String tdate = request.getParameter("tdate");
	String userid = ""+session.getAttribute("USRID");
	String empid = ""+session.getAttribute("EMPID");
	String fdate1=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fdate);
	String tdate1=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(tdate);
	String sql = "";
	 
	 
	out.println("<br><br><br><center>");
	out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'> <td colspan='9' class='boldEleven' ><center> <b>ENGINEER WEEKLY REPORT FOR [ "+CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_EMPID='"+empid+"'")[0][1]+" ]  FROM : "+fdate+"  TO : "+tdate+"</center> </b></td> </tr>");
	out.println("<tr class='MRow2'>");
	out.println("<td  class='MRow4' ><b>S.No</td>");
	out.println("<td  class='MRow4' ><b>Details</td>");
	out.println("<td  class='MRow4' ><b>Total</td>");
	out.println("</tr>"); 
	
	
	
	
	 out.println("<tr class='MRow2'>");
	 out.println("<td  class='boldEleven' ><b>1");
	 out.println("<td  class='boldEleven' ><b>'01' Calls");
	 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	 sql = sql + "	  AND CHR_CALLTYPE= '1'   ";
	 String data[][] = CommonFunctions.QueryExecute(sql);
	 if(data.length>0)
		out.println("<td  class='boldEleven' >"+data[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	 
	
	  
	
	
	
	
	
	
	

	
	
		 out.println("<tr class='MRow1'>");
		 out.println("<td  class='boldEleven' ><b>2");
		 out.println("<td  class='boldEleven' ><b>'02' Calls");
		 sql = " SELECT  COUNT(CHR_CALLTYPE) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
		 sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
		 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
		 sql = sql + "	  AND CHR_CALLTYPE= '2' ";
		 String data1[][] = CommonFunctions.QueryExecute(sql);
		 if(data1.length>0)
			out.println("<td  class='boldEleven' >"+data1[0][0]+"</td>");
		 else
			out.println("<td  class='boldEleven' >-</td>");
		 out.println("</tr>"); 
	
	
	
	
		
	
	 out.println("<tr class='MRow2'>");
	 out.println("<td  class='boldEleven' ><b>3");
	 out.println("<td  class='boldEleven' ><b>Calls Pending ");
	 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	 sql = sql + "	  AND CHR_CALLSTATUS= 'P'    ";
	 String data3[][] = CommonFunctions.QueryExecute(sql);
	 if(data3.length>0)
		out.println("<td  class='boldEleven' >"+data3[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	 out.println("</tr>"); 
	
	
	 out.println("<tr class='MRow1'>");
	 out.println("<td  class='boldEleven' ><b>4");
	 out.println("<td  class='boldEleven' ><b>Calls Closed");
	 sql = " SELECT  COUNT(CHR_CALLSTATUS) FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	 sql = sql + "	  AND CHR_CALLSTATUS= 'C'    ";
	 String data4[][] = CommonFunctions.QueryExecute(sql);
	 if(data4.length>0)
		out.println("<td  class='boldEleven' >"+data4[0][0]+"</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	 
	out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	 out.println("<tr class='MRow2'>");
	 out.println("<td  class='boldEleven' ><b>5");
	 out.println("<td  class='boldEleven' ><b>Hand on Hours");
	 sql = " SELECT ( SUM(INT_HANDSONHOURS)+FLOOR(SUM(INT_HANDSONMINUTES)/60)) ,MOD(SUM(INT_HANDSONMINUTES),60)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	  sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	 String data5[][] = CommonFunctions.QueryExecute(sql);
	 if(data5.length>0)
		out.println("<td  class='boldEleven' >"+data5[0][0]+"hrs. "+data5[0][1]+"mts.</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	 out.println("</tr>"); 
	
	
	
	
	
	
	
	
	
	
	
	out.println("<tr class='MRow1'>");
	out.println("<td  class='boldEleven' ><b>6");
	out.println("<td  class='boldEleven' ><b>Travel Hours/KM");
	sql = " SELECT ( SUM(INT_TRAVELHOURS)+FLOOR(SUM(INT_TRAVELMINUTES)/60)) ,MOD(SUM(INT_TRAVELMINUTES),60) ,SUM(INT_KM)  FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	  sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	 String data6[][] = CommonFunctions.QueryExecute(sql);
	 if(data6.length>0)
		out.println("<td  class='boldEleven' >"+data6[0][0]+"hrs. "+data6[0][1]+"mts.  "+data6[0][2]+"Kms.</td>");
	 else
		out.println("<td  class='boldEleven' >-</td>");
	
	 
	out.println("</tr>"); 
	
	
	
	
	
	
	
	  
	out.println("<tr class='MRow2'>");
	out.println("<td  class='boldEleven' ><b>7");
	out.println("<td  class='boldEleven' ><b>No of Spare Demanded");
	 
	 
	sql = " SELECT SUM(INT_NOOFSPARE)   FROM  servicecall_t_report  WHERE CHR_EMPID='"+empid+"' ";
	 sql = sql + "	 AND DAT_DATE >='"+fdate1+"' ";
	 sql = sql + "	 AND DAT_DATE <='"+tdate1+"' ";
	String data7[][] = CommonFunctions.QueryExecute(sql);
	if(data7.length>0)
		out.println("<td  class='boldEleven' >"+data7[0][0] +"Spare</td>");
	else
		out.println("<td  class='boldEleven' >-</td>");
	out.println("</tr>"); 
	
	 
	 
	out.println("</table>");
	out.println("</center>");
	
%>
 <p> 
 <p align="center"><a href="javascript:Print('StaffDailyCallsDateRangeReportResponsePrint.jsp?fdate=<%=fdate%>&tdate=<%=tdate%>')">Print</a>
 
 <script language="javascript">
  
	function Print(query)
	{  
		var width=screen.width, height=screen.heigh;
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
 </script>
 
 
 
 </body>
</html>
<%
 }
catch(Exception e)
{
	out.println(e.getMessage());
}	
%> 
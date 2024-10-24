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

<body >

<%
	  String callid = request.getParameter("callid");
	  
	  
	  
	  
	  String sql = " SELECT b.CHR_STAFFNAME , DATE_FORMAT(a.DT_ATTENDATE,'%d-%m-%Y %H :%i :%s %p'), DATE_FORMAT(a.DT_CLOSEDATE,'%d-%m-%Y %H :%i :%s %p'),a.CHR_ENGGDESC,a.CHR_SPARE, ";
	  sql = sql + " a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL ,a.CHR_CALLSTATUS";
	  sql = sql + "  FROM   inv_t_servicecallbookingtrack a ,com_m_staff b ";
	  sql = sql +  " WHERE a.CHR_EMPID =b.CHR_EMPID ";
	  sql = sql + " AND a.CHR_SERVICECALLNO='"+callid+"' ORDER BY INT_TRACKID ";
	   String Previousdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	  if(Previousdata.length>0)
	  {
	  	out.println("<br><br><br><br><center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' ><tr class='MRow1'><td class='boldEleven' ><b>S.No");
		out.println("<td class='boldEleven'><b>Call Number");
		out.println("<td class='boldEleven'><b>Engineer Name");
		out.println("<td class='boldEleven'><b>Starting date");
		out.println("<td class='boldEleven'><b>Closing Date");
		out.println("<td class='boldEleven'><b>Description");
		out.println("<td class='boldEleven'><b>Spare Request");
		out.println("<td class='boldEleven'><b>Contact Person");
		out.println("<td class='boldEleven'><b>Contact Address");
		out.println("<td class='boldEleven'><b>Contact Mobile");
		out.println("<td class='boldEleven'><b>Contact Email");
		out.println("<td class='boldEleven'><b>Call Status");
	  	for(int u=0;u<Previousdata.length;u++)
		{
			
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
		    	out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+callid);
			out.println("<td class='boldEleven'>"+Previousdata[u][0]);
			out.println("<td class='boldEleven'>"+Previousdata[u][1]);
			out.println("<td class='boldEleven'>"+Previousdata[u][2]);
			out.println("<td class='boldEleven'>"+Previousdata[u][3]);
			if("Y".equals(Previousdata[u][4]))
				out.println("<td class='boldEleven'>Yes,Spare Wanted");
			else
				out.println("<td class='boldEleven'>No ");	
			//out.println("<td class='boldEleven'>"+Previousdata[u][4]);
			out.println("<td class='boldEleven'>"+Previousdata[u][5]);
			out.println("<td class='boldEleven'>"+Previousdata[u][6]);
			out.println("<td class='boldEleven'>"+Previousdata[u][7]);
			out.println("<td class='boldEleven'>"+Previousdata[u][8]);
			if("1".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Spare");
			else if("2".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Response");
			else if("3".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Customer");
			else if("4".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Under Observation");
			else if("5".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Closed");
				 
			
		}
		out.println("</table></center>");
	  }
   
  %>
  <br><br><br><br><br>
  <center><a href="javascript:window.print()">Print</a></center>
  <br><br><br><br><br>
  
</body>
</html>

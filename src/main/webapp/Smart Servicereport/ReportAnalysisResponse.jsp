 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
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
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<title> :: SERVICE REPORT :: </title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 	
	 <%
 
 try
 {
	String fdate = request.getParameter("fdate");
	String tdate = request.getParameter("tdate");
	String ename[] = request.getParameterValues("ename");
	 
	String fdate1=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fdate.trim());
	String tdate1=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(tdate.trim());
	String sql = "";
	String staffids="";
	for (int i = 0; i < ename.length; i++) 
	 	staffids=staffids+"'"+ename[i]+"' ,";
	staffids = staffids.substring(0,staffids.length()-1);	
	out.println("<br><br><br><center>");
	 
	String reportheader="ENGINEER  ANALYSIS REPORT  FROM : "+fdate+" TO :"+tdate+"";
	sql="";
	sql = " SELECT a.CHR_EMPID,b.CHR_STAFFNAME,a.CHR_MONTH ,a.INT_YEAR, ";
	sql = sql+ " (SELECT c.DOU_TOTALDAYS FROM att_t_register c WHERE c.CHR_EMPID= a.CHR_EMPID AND c.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND c.INT_YEAR =a.INT_YEAR), COUNT(CHR_CALLSTATUS),";
	
	sql = sql+ " (SELECT COUNT(a1.CHR_CALLSTATUS) FROM servicecall_t_report a1 WHERE a1.CHR_EMPID= a.CHR_EMPID AND a1.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND a1.INT_YEAR =a.INT_YEAR AND a1.CHR_CALLSTATUS='C'), ";
	
	sql = sql+ " (SELECT COUNT(a2.CHR_CALLSTATUS) FROM servicecall_t_report a2 WHERE a2.CHR_EMPID= a.CHR_EMPID AND a2.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND a2.INT_YEAR =a.INT_YEAR AND a2.CHR_CALLSTATUS='P'), ";
	
	/*sql = sql+ " (SELECT COUNT(a3.INT_NOOFSPARE) FROM servicecall_t_report a3 WHERE a3.CHR_EMPID= a.CHR_EMPID AND a3.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND a3.INT_YEAR =a.INT_YEAR  ), ";
	
	sql = sql+ " (SELECT COUNT(a4.INT_NOOFSPARE) FROM servicecall_t_report a4 WHERE a4.CHR_EMPID= a.CHR_EMPID AND a4.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND a4.INT_YEAR =a.INT_YEAR AND a4.CHR_CALLSTATUS='C'), ";
	*/
	sql = sql+ " (SELECT COUNT(a5.INT_NOOFSPARE) FROM servicecall_t_report a5 WHERE a5.CHR_EMPID= a.CHR_EMPID AND a5.CHR_MONTH = a.CHR_MONTH  ";
	sql = sql+ " AND a5.INT_YEAR =a.INT_YEAR AND a5.CHR_CALLSTATUS='P') ";
	
	sql = sql+ " FROM servicecall_t_report a,com_m_staff b  ";
	sql = sql+ " WHERE a.CHR_EMPID= b.CHR_EMPID ";
	sql = sql+ " AND  a.CHR_EMPID IN ("+staffids+") ";
	sql = sql+ " AND  a.DAT_DATE <='"+tdate1+"'";
	sql = sql+ " AND  a.DAT_DATE >='"+fdate1+"'";
	sql = sql+ " GROuP BY a.CHR_EMPID ,a.CHR_MONTH ,a.INT_YEAR ";
	sql = sql+ " ORDER BY b.CHR_STAFFNAME ";
	//out.println(sql);
	 
	String data[][] = CommonFunctions.QueryExecute(sql);	
	Vector mn = new Vector();
	Vector child= null;
	double wrkdays=0;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			child.addElement(data[u][1]);
			child.addElement(data[u][2]);
			child.addElement(data[u][3]);
			child.addElement(data[u][4]);
			child.addElement(data[u][5]);
			child.addElement(data[u][6]);
			child.addElement(data[u][7]);
			child.addElement(data[u][8]);
			wrkdays = Double.parseDouble(data[u][4]);
			if(wrkdays>0)
				child.addElement( Math.round((Integer.parseInt(data[u][6])/wrkdays)*100.0)/100.0 +"%");	
			else
				child.addElement("");
				
				
			if(wrkdays>0)
				child.addElement( Math.round((Integer.parseInt(data[u][5])/wrkdays)*100.0)/100.0 +"%");	
			else
				child.addElement("");
			
			
			if(wrkdays>0)
				child.addElement( Math.round((Integer.parseInt(data[u][8])/wrkdays)*100.0)/100.0+"%");	
			else
				child.addElement("");
				
 			mn.add(child);
     } 
 	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 
  
			%>
			
			
			
			
			
	<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="ID" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="NAME" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="MONTH" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="YEAR" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="No of Working Days" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Attended" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Closed" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Pending" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Spare Used" sortable="true"><%=temp.elementAt(9)%></display:column>
					<display:column title="closed call Avg" sortable="true"><%=temp.elementAt(10)%></display:column>
					<display:column title="Attened Avg" sortable="true"><%=temp.elementAt(11)%></display:column>
					<display:column title="spare consuption" sortable="true"><%=temp.elementAt(12)%></display:column>
					  
					<display:setProperty name="export.csv.filename" value="ReportAnalysis.csv"/>
					<display:setProperty name="export.excel.filename" value="ReportAnalysis.xls"/>
					<display:setProperty name="export.xml.filename" value="ReportAnalysis.xml"/>
					<display:setProperty name="export.pdf.filename" value="ReportAnalysis.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     
<br />	<center>	<a href='ReportAnalysis.jsp'> CLOSE</a></center>
 
	 		
	
<%	
	
	
	
	/*if(data.length>0)
	{
		
		out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td colspan='13' class='boldEleven'><center><b>ENGINEER  ANALYSIS REPORT  FROM : "+fdate+" TO :"+tdate+"</center> </b></td> </tr>");
		out.println("<tr class='MRow2'>");
		out.println("<td  class='boldEleven' ><b>S.No</td>");
		out.println("<td  class='boldEleven' ><b>Emp Id</td>");
		out.println("<td  class='boldEleven' ><b>Name</td>");
		out.println("<td  class='boldEleven' ><b>Month</td>");
		out.println("<td  class='boldEleven' ><b>Year</td>");
		out.println("<td  class='boldEleven' ><b>No. Working days</td>");
		out.println("<td  class='boldEleven' ><b>Attended</td>");
		out.println("<td  class='boldEleven' ><b>Closed</td>");
		out.println("<td  class='boldEleven' ><b>Pending</td>");
		out.println("<td  class='boldEleven' ><b>Spare Used</td>");
		out.println("<td  class='boldEleven' ><b>closed call Avg</td>");
		out.println("<td  class='boldEleven' ><b>Attened Avg</td>");
		out.println("<td  class='boldEleven' ><b>spare consuption %</td>");
		
		 



		out.println("</tr>"); 
		for (int i = 0; i < ename.length; i++) 
		{
			if(i%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
				
			out.println("<td  class='boldEleven' >"+(i+1)+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][0]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][1]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][2]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][3]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][4]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][5]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][6]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][7]+"</td>");
			out.println("<td  class='boldEleven' >"+data[i][8]+"</td>");
			out.println("<td  class='boldEleven' >&nbsp;</td>");
			out.println("<td  class='boldEleven' >&nbsp;</td>");
			out.println("<td  class='boldEleven' >&nbsp;</td>");
			
			//out.println("<td  class='boldEleven' >"+(data[i][6]/data[i][4])+"</td>");
			//out.println("<td  class='boldEleven' >"+(data[i][5]/data[i][4])+"</td>");
			//out.println("<td  class='boldEleven' >"+(data[i][8]/data[i][4])+"</td>");
 		
			
			out.println("</tr>"); 	
				
		}
		out.println("</table>");
		out.println("</center>");
	}	
*/		
 
	  
	
 
 }
catch(Exception e)
{
	out.println(e.getMessage());
}	
%>	 

 
</body>
</html>

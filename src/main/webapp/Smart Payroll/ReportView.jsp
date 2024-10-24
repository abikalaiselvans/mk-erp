<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
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

<style type="text/css">
<!--
.style52 {font-size: 10px}
.style54 {font-family: Verdana}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	FileReader fr = new FileReader("Report.sys");
	BufferedReader br  = new BufferedReader(fr);
	String strfline ="";
	StringTokenizer filecontents;
	int linecount=0;
	while((strfline=br.readLine())!= null )
	{
		linecount = linecount+1;
	}
	
	int totalline = linecount;
	int startline=0;
	String sline="";
	int pageline =10;
	int noofpage = totalline/pageline;
	int remainline = totalline - (noofpage*pageline);
	if (remainline >=1)
		noofpage = noofpage +1;
	
	
	sline = request.getParameter("start");
	if(sline == null )
		startline = 3;
	else
		startline = Integer.parseInt(request.getParameter("start"));
	
	fr = new FileReader("Report.sys");
	br  = new BufferedReader(fr);
	int fline=1;
	int i=0;
	boolean flag = false;
	String secondline="";
	out.println("<center><table width='75%'><tr><td align=right><a href='ReportPrint.jsp' target='_blank'>Print </a> ");
	out.println("<tr><table width='75%' border='1' cellpadding='0' cellspacing='1' bordercolor='#94C1E4'>");
	out.println("<tr  bgcolor='#202B78'><td align = center colspan =40>");
	while((strfline=br.readLine())!= null )
	{	
		if (fline == 1 )
			out.println("<table  bgcolor='#202B78' class='tablehead'><tr><td align=center><b>"+strfline+"</b></table>");
		
		if (fline == 2)
		{
			filecontents = new StringTokenizer(strfline,"^");
			out.println("<tr bgcolor='6E8FBC' class='tablehead'>");
			while(filecontents.hasMoreElements())
			{
		   	out.print("<td align=center><b>"+filecontents.nextElement()+"</b>");
		   	i = i+1;
			}
		}
				
		 if (fline >= 3 && fline >=startline && fline < (startline+10))
			 
		{
			 filecontents = new StringTokenizer(strfline,"^");
				if (! strfline.equals("Record not found..."))
				{	
					out.println("<tr >");
					while(filecontents.hasMoreElements())
					{
			   			out.print("<td>"+filecontents.nextElement());
					}
				}	
		}
		 
		 if (strfline.equals("Record not found..."))
			{
				out.println("<tr >");
				out.println("<td align=center colspan = 40><font color=red><b>");
				out.println(strfline +"</b></font>");
			}
		fline = fline + 1;
	}
	
	out.println("</center></table><table>");
	out.println("<table width='80%' border='0' align='center' cellpadding='0' cellspacing='0'>");
	out.println("<tr><td align = center>");
	out.println("<table><tr>");
	for( i=1; i<=noofpage;i++){
		out.println("<td align=center width=25>");
		out.println("<a href='ReportView.jsp?start="+(((i*10)+2)-(pageline-1))+"'>");
		out.println(i+"</a>");
		}	
	out.println("</table>");
	
	br.close();
	fr.close();
%>
<%@ include file="../footer.jsp"%>
</body>
</html>

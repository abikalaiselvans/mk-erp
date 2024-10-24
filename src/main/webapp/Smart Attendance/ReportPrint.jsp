<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
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
	FileReader fr = new FileReader("SReport.sys");
	BufferedReader br  = new BufferedReader(fr);
	String strfline ="";
	StringTokenizer filecontents;
	int linecount=0;
	while((strfline=br.readLine())!= null )
	{
		linecount = linecount+1;
	}
	int noofpage;
	int nooflineperpage = 30;
	linecount = linecount-2;
	noofpage = linecount / nooflineperpage;
 	fr = new FileReader("SReport.sys");
	br  = new BufferedReader(fr);
	int fline=1;
%>
<%@ include file="../PrintHeader.jsp"%>

<%
	out.println("<table width='98%'  align='center'  border='1' cellspacing=0 cellpadding=2 bordercolor='CCCCCC'>");
	while((strfline=br.readLine())!= null )
	{	
		if (fline == 1 )
			out.print("<tr align='center' height=20><td colspan=40><center><h2>"+strfline+"</h2></center>");
		if (fline == 2)
		{
				filecontents = new StringTokenizer(strfline,"^");
				out.println("<tr class='boldEleven'>");
				while(filecontents.hasMoreElements())
				{
			   		String gh=""+filecontents.nextElement();
					out.print("<td width='"+(gh.length()*5)+"' class='bolddeepblue1'><b>"+gh+"</b>");
				}
		}
		if(fline >= 3)
		{
				filecontents = new StringTokenizer(strfline,"^");
				out.println("<tr >");
				while(filecontents.hasMoreElements())
				{
					String str=""+filecontents.nextElement();
					int len=str.length();
					len=len*5;
					if(str.equals("S") || str.equals("s"))
					   	out.print("<td class='bolddeepred' align='left' width='"+len+"'><b>"+str+"</b>");
					else
						out.print("<td class='bolddeepblue1' align='left' width='"+len+"'><b>"+str+"</b>");
					   	
				}
		}
		fline = fline + 1;
	}
	out.println("</table>");
	br.close();
	fr.close();
%>

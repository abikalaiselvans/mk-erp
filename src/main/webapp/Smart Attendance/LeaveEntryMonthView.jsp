<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;	
	int totdays;
	int year;
	int i;	
	
	private int totalDays(int mon,int year)
	{
		int[] listTotalDays={0,31,28,31,30,31,30,31,31,30,31,30,31};
		if(year%4==0) listTotalDays[2]=29;
		return(listTotalDays[mon]);
	}
	private String FormateDateSQL(String indate)
	{
		String date= indate.substring(0,2);
		String month= indate.substring(3,5);
		String year= indate.substring(6);
		return(""+year +"-"+month+"-"+date);
	}
%>
<%
	String month=request.getParameter("Month");
	//System.out.println(month);
	year=Integer.parseInt(request.getParameter("Year"));
	//System.out.println("Year:"+year);
	int mon=Integer.parseInt(month);
	//System.out.println(mon);
	totdays=totalDays(mon,year);
	//System.out.println(totdays);
	String fdate="01-"+month+"-"+year;
	//System.out.println(fdate);
	String tdate= totdays+"-"+month+"-"+year;
	//System.out.println(tdate);
	String date1=FormateDateSQL(fdate);
	String date2=FormateDateSQL(tdate);
%>
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
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style79 {font-size: 10px}
.style80 {font-family: Verdana; font-size: 14px; }
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
<br>
<br>
<br>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="129" height="77">&nbsp;</td>
		<td width="793" valign="top">
		<table width="700" border="1" cellpadding="0" cellspacing="1"
			 >
			<tr align="center" valign="middle">
				<td height="25" colspan="5"  class="tablehead">Leave
				Entry Month View</td>
			</tr>
			<tr>
				<td width="9%" height="24" align="center" bgcolor="6E8FBC"
					class="tablehead">S.No
				<td width="9%" align="center" bgcolor="6E8FBC" class="tablehead">Emp
				ID
				</div>
				</td>
				<td width="16%" align="center" bgcolor="6E8FBC" class="tablehead">Name
				</div>
				</td>
				<td width="12%" align="center" bgcolor="6E8FBC" class="tablehead">Date
				</div>
				</td>
				<td width="8%" align="center" bgcolor="6E8FBC" class="tablehead">Leave
				Type
				</div>
				</td>
			</tr>
			<%
	try
		{	
		con=conbean.getConnection();
	   	st=con.createStatement();
		sql="select  l.*,s.chr_staffname from ATT_T_LEAVE l, com_m_staff  s where dt_ldate>='"+date1+"' and dt_ldate<='"+date2+"' and l.chr_empid=s.chr_empid ORDER BY dt_LDATE";
		//System.out.println(sql);
		rs = st.executeQuery(sql);
		i=1;
		while(rs.next())
		{
		%>
			<tr>
				<td><span class="style80"> <% out.println(i); %>
				</td>
				<td><span class="style80"> <% out.println(rs.getString("chr_EMPID")); %>
				</span></td>
				<td><span class="style80"> <% out.println(rs.getString("chr_StaffName")); %>
				</span></td>
				<%
       StringTokenizer tok=new StringTokenizer(rs.getString("dt_LDATE"));
        StringTokenizer tok1=new StringTokenizer(tok.nextToken(),"-");
       String y1=tok1.nextToken();
       String m1=tok1.nextToken();
       String d1=tok1.nextToken();
		%>
				<td><span class="style80"> <% out.println(d1+"-"+m1+"-"+y1); %>
				</span></td>
				<td><span class="style80"> <% out.println(rs.getString("Chr_LeaveType")); %>
				</span></td>
			</tr>
			<%
		i=i+1;
		}
		rs.close();
		st.close();
		 
	}
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
%>
		</table>
		</td>
		<td width="58">&nbsp;</td>
	</tr>
	<tr>
		<td height="99">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<td></td>
<%@ include file="../footer.jsp"%>
</body>
</html>

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
	String deptid;
	int i;	
%>
<%
	  deptid=request.getParameter("OptDepartment");
     //System.out.println("Dept is "+deptid);
%>
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
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style51 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
.style52 {font-size: 10px}
.style53 {font-family: Verdana; font-size: 10px; color: #FFFFFF; }
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
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="56" height="92">&nbsp;</td>
		<td width="11">&nbsp;</td>
		<td width="801" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="49">&nbsp;</td>
		<td width="49">&nbsp;</td>
	</tr>
	<tr>
		<td height="76">&nbsp;</td>
		<td colspan="3" valign="top">
		<table width="867" border="1" cellpadding="0" cellspacing="1"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td height="24" colspan="8" align="center" valign="middle"
					  class="tablehead">Advance Details -
				Department Wise</td>
			</tr>
			<tr>
				<td width="69" height="24" align="center" valign="middle"
					bgcolor="6E8FBC" class="tablehead">Emp Id</td>
				<td width="103" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Name</td>
				<td width="117" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Department</td>
				<td width="111" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Opening Date</td>
				<td width="107" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Advance Amt</td>
				<td width="108" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">No of Installment</td>
				<td width="110" bgcolor="6E8FBC" class="tablehead" align="center"
					valign="middle">Balance Amt</td>
				<td width="115" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Balance Installment</td>

			</tr>
			<%
   	    try
        {
   	    	
   	    sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,C.DT_DATE,C.INT_ADVAMT,C.INT_NOOFINS,C.INT_BALAMT,C.INT_BALINS";
   		sql=sql+" FROM  com_m_staff  A,  com_m_depart   B,PAY_M_ADVANCE C WHERE A.CHR_EMPID=C.CHR_EMPID AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DEPARTID="+deptid;
	   	con =conbean.getConnection();
	   	st=con.createStatement();
		rs = st.executeQuery(sql);
		
	    while(rs.next())
		{
%>
			<tr>
				<td height="19" align="center" valign="middle">
				<% out.println(rs.getString("CHR_EMPID")); %>
				</td>

				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_STAFFNAME")); %>
				</span></td>

				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_DEPARTNAME")); %>
				</span></td>
				<%
        try{
		StringTokenizer dts=new StringTokenizer(rs.getString("DT_DATE"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	    %>
				<td align="center" valign="middle"><span
					class="style54 style52"> <%out.println(d+"-"+m+"-"+y);%> </span></td>
				<%
		}
		catch(Exception e)
		{
			//System.out.println(e);
		}
        %>

				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_ADVAMT")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_NOOFINS")); %>
				</span></td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getInt("INT_BALAMT")); %> </span></td>

				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_BALINS")); %>
				</span></td>

			</tr>
			<%
		}
		rs.close();
     	 
     	st.close();
	 }
        catch(Exception e)
        {
        	//System.out.println(e);
        }
	%>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>


</td>
<%@ include file="../footer.jsp"%>
</body>
</html>

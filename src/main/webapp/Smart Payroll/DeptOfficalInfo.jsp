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
	String depid;
	int i;	
%>
<%
	depid=request.getParameter("Department");
//out.println(depid);
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

<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="75" height="92">&nbsp;</td>
		<td width="817" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="90">&nbsp;</td>
	</tr>
	<tr>
		<td height="108">&nbsp;</td>
		<td valign="top">
		<table width="832" border="1" cellpadding="0" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td height="35" colspan="10" align="center" valign="middle"
					  class="tablehead">Offical Information View </strong></td>
			</tr>
			<tr>
				<td width="53" height="26" bgcolor="6E8FBC" class="tablehead">
				Staff Id</td>
				<td width="74" bgcolor="6E8FBC" class="tablehead">Name</td>
				<td width="79" bgcolor="6E8FBC" class="tablehead">Office
				</div>
				</td>
				<td width="92" bgcolor="6E8FBC" class="tablehead">Department</td>
				<td width="92" bgcolor="6E8FBC" class="tablehead">Designation</td>
				<td width="76" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Type</td>
				<td width="103" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Date of Join</td>
				<td width="101" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Basic Salary</td>
				<td width="71" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">Gratuity</td>
				<td width="58" align="center" valign="middle" bgcolor="6E8FBC"
					class="tablehead">P F</td>
			</tr>
			<%
        try{
    	con=conbean.getConnection();
	   	st=con.createStatement();
		//sql="select  com_m_staff .CHR_EMPID, com_m_staff .CHR_STAFFNAME, com_m_office .CHR_Officename,  com_m_depart  .CHR_DEPARTNAME, com_m_desig .CHR_DESIGNAME, com_m_staff .CHR_TYPE, com_m_staff .DT_DOJCOLLEGE, com_m_staff .INT_SALARY, com_m_staff .INT_GRATUITY, com_m_staff .CHR_PFESI from  com_m_staff , com_m_office , com_m_desig ,  com_m_depart   where  com_m_staff .INT_DEPARTID=  com_m_depart  .INT_DEPARTID and  com_m_staff .INT_DEPARTID="+depid+" and m_staff.INT_OfficeID=m_office.INT_OfficeID and m_staff.INT_DESIGID=m_desig.INT_DESIGID";
		
	sql ="select A.CHR_EMPID,A.CHR_STAFFNAME, B.CHR_Officename,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,A.CHR_TYPE,A.DT_DOJCOLLEGE,A.INT_SALARY,A.INT_GRATUITY,A.CHR_PFESI from  com_m_staff  A, com_m_office  B, com_m_desig  C,  com_m_depart   D  where A.INT_DEPARTID=D.INT_DEPARTID and A.INT_DEPARTID="+depid+" and A.INT_OfficeID=B.INT_OfficeID and A.INT_DESIGID=C.INT_DESIGID";
		rs = st.executeQuery(sql);
		 while(rs.next())
		{
		%>
			<tr>
				<td height="25" align="center" valign="middle"><%=rs.getString("CHR_EMPID")%>
				</td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_STAFFNAME")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_Officename")); %>
				</span></td>
				<td align="center" valign="middle">
				<% out.println(rs.getString("CHR_DEPARTNAME")); %>
				</td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("CHR_DESIGNAME")); %> </span></td>
				<td align="center" valign="top""><span class="style54 style52">
				<% out.println(rs.getString("CHR_TYPE")); %> </span></td>
				<% 
		try{
		StringTokenizer dts=new StringTokenizer(rs.getString("DT_DOJCOLLEGE"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 	%>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(d+"-"+m+"-"+y); %> </span></td>
				<%
			}
			catch(Exception e)
			{
			}
		%>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_SALARY")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getInt("INT_GRATUITY")); %>
				</span></td>
				<td align="center" valign="middle"><span
					class="style54 style52"> <% out.println(rs.getString("CHR_PFESI")); %>
				</span></td>
			</tr>
			<%
		}
		rs.close();
		 
		}
		catch(Exception e){}%>
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
<br>
<br>
<br>
<br>


</td>
<%@ include file="../footer.jsp"%>
</body>
</html>

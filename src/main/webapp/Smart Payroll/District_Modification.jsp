<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;	
	String state,statedes;
	String OptDistrictName;

	/*public void releaseJDBCResource() 	
	{
		try
		{
			
		}
		catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}*/
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
-->
</style>
</head>


<form  AUTOCOMPLETE = "off"   method="post" action="District_Modify.jsp">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
	String userid = null;
	String description = null;
	String password = null;
	int TxtStateId=0,stateid=0,TxtDistrictId;
	
	String sql_Select_Query ="SELECT  INT_DISTRICTID,INT_STATEID,CHR_DISTRICTNAME,CHR_DISTRICTDES FROM  com_m_district  WHERE CHR_DISTRICTNAME = ?";

	//Form Information
	
	
	//Loading JDBC Connection Information
	try
	{	

		
		con = conbean.getConnection();
		TxtStateId=Integer.parseInt(request.getParameter("TxtStateId"));
		OptDistrictName= request.getParameter("OptDistrictName");
		TxtDistrictId=Integer.parseInt(request.getParameter("TxtDistrictId"));
		////System.out.println(distname);	
		
		/*for(int j=0;j<statename.length;j++)
                {
		//System.out.println(statename[j]);*/
		pstm = con.prepareStatement(sql_Select_Query);
		pstm.setString(1,OptDistrictName);
		rst=pstm.executeQuery();			
		while(rst.next())
		{
			state = rst.getString("CHR_DISTRICTNAME");
			//System.out.println(state);
			statedes =rst.getString("CHR_DISTRICTDES");
			//System.out.println(statedes);
			stateid=rst.getInt("INT_DISTRICTID");
		}
		//session.setAttribute("USERID",stateid);
			rst.close();
			pstm.close();
			 
	}
	catch(Exception ex)
	{
		//System.out.println(ex + "TRY");
	}	
 %>
<td width="383">
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="193" height="236">&nbsp;</td>
		<td width="643" align="center" valign="top"><br>
		<br>
		<br>
		<table width="436" border="1"  >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="23" colspan="6"  class="tablehead"><b>District
				Modification View</b></td>
			</tr>
			<tr>
				<td height="26" colspan="3" valign="middle" class="tabledata">District
				Name</td>
				<td><input name="district" type="text" value="<%=state%>"
					size="30"></td>
			</tr>
			<tr>
				<td height="27" colspan="3" valign="middle" class="tabledata">Description
				</td>
				<td colspan="3"><input name="descript" type="text"
					value="<%=statedes%>" size="30"> <input type="hidden"
					name="TxtDistrictId" value="<%=stateid%>"> <input
					type="hidden" name="TxtStateId" value="<%=TxtStateId%>">
			</tr>
		</table>
		<center>
		<table>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
				<td width="57" valign="top"><input type="submit" name="Submit"
					value="Submit"></td>

				<td colspan="2">&nbsp;</td>
			</tr>
		</table>
		<td width="144">&nbsp;</td>
	<tr>
		<td height="44">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
</table>
</td>
<td width="260">&nbsp;</td>
</tr>
</table>
<br>
<br>
<br>

</td>
</tr>
</table>

<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>

</html>

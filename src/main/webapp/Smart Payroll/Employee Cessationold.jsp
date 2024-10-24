
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%String actionStu="PAYcessationAdd"; %>

<%!
	Connection con ;
	PreparedStatement pstm;
	ResultSet rst;
	String userid;
	String no,dist;
	
	String sql_Select_Query ="select * from  com_m_staff ";

	public void releaseJDBCResource() 	
	{
		try
		{
			rst.close();
			pstm.close();
			 

		}catch(NullPointerException ex)
		{
			//System.out.println(ex);
		}catch(SQLException ex)
		{
			//System.out.println(ex);
		}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
function validate(){
	if(checkNull("ename","Select Staff") && checkNull("TxtDoc","Enter Cessation Date") && checkDate("acode","acode")){
		document.a.submit();
		return true;
	}
	return false;
	}
	function mainPage()
	{
	    document.a.action="Payrollmain.jsp";
		document.a.submit();
		return true;
    }					
</script>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
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
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style14 {color: #FFFFFF; font-weight: bold; }
-->
</style>
</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth">
<body  onpaste="return false;" onLoad="init();">
<br>
<br>
<br>

<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="272" height="62">&nbsp;</td>
		<td width="163">&nbsp;</td>
		<td width="74">&nbsp;</td>
		<td width="220">&nbsp;</td>
		<td width="24">&nbsp;</td>
		<td width="221">&nbsp;</td>
	</tr>
	<tr>
		<td height="43">&nbsp;</td>
		<td colspan="4" valign="top">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="509" height="41" valign="top"><%@ include
					file="../JavaScript/ajax.jsp"%></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="30">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="148">&nbsp;</td>
		<td colspan="3" valign="top">
		<table border="1" width="462"  >
			<!--DWLayoutTable-->
			<tr>
				<td height="33" colspan="2" align="center" valign="middle"
					  class="tablehead">Employee Cessation</td>
			</tr>
			<tr>
				<td width="164" height="32" valign="middle" class="bolddeepblue">Type
				of Cessation</td>
				<td width="282" valign="middle"><input name="TxtType"
					type="text" class="tabledata" id="ac"
					onkeypress="charOnly('TxtType','15')" size="40">
			<tr>
				<td height="34" valign="middle" class="bolddeepblue">Date of
				Cessation<font color="#CC0000">*</font></td>
				<td valign="middle"><input name="TxtDoc" type="text"
					class="tabledata" id="acode" onkeypress="dateOnly('acode')">
				<a href="javascript:cal2.popup();"> <img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click here to Pick Up the Date"></a> <script
					language="JavaScript">
			<!--
  			var cal2=new calendar1(document.forms['a'].elements['acode']);
  			cal2.year_scroll=true;
	  		cal2.time_comp=false;
	  		setCurrentDate('acode');
	
	
	  			//--> 
		</script></td>

			</tr>
			<tr>
				<td height="35" valign="middle" class="bolddeepblue">Reason</td>
				<td valign="middle"><input name="TxtReason" type="text"
					class="tabledata" id="tr" onkeypress="charOnly('TxtReason','25')"
					size="40"></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="22">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<input type="HIDDEN" name="filename" value="Cessation">
<input type="HIDDEN" name="actionS" value="<%=actionStu %>">

<center>
<table>
	<tr>
		<td width="56" align="center" colspan="2"><input
			class="buttonbold" type="submit" name="Submit" value="Submit"   accesskey="s"   
			onclick="return validate()"></td>
		<td width="56" valign="top"><input class="buttonbold"
			type="submit" name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()">
		</td>
	</tr>
	<tr>
		<td height="45">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
<CENTER>
<table width="23%" border="1" cellspacing="2" cellpadding="2"
	 >

	<tr>
		<td align="center" class="bolddeepblue"><%=msg%></td>
	</tr>
	<% } %>
</table>
</CENTER>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>

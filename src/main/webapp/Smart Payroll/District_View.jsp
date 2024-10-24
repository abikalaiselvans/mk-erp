<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
		Connection con;
		PreparedStatement pstm;
		String sql;
		ResultSet rs;
		String url;
		String driver;
		String TxtStateId;
		int Count1;
	
	%>
<%
	TxtStateId=request.getParameter("TxtStateId"); 
	%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="javascript">
	 function goHome()
    {     
      document.frmState.action="AttendanceMain.jsp";
      document.frmState.submit();	 	
    }
	function Delete()
 	{		
		document.frmState.action="District_Deletion.jsp";
		document.frmState.submit();
 	}
 	function Edit()
 	{	
 	var count;
		count=0;
		coffee1=document.forms[0].OptDistrictName
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==1){	
			document.frmState.action="District_Modification.jsp";
			document.frmState.submit();
			return true;
		}
		else
		{
		    alert("Select Any Only one Value");
		    return false;
		}
 			
		
 	}
	function Add()
 	{		
		document.frmState.action="District_Addition.jsp";
		document.frmState.submit();
 	}
</script>
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
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
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
<form  AUTOCOMPLETE = "off"   method="post" name='frmState'>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p class="style8">&nbsp;</p>
<p class="style8"><br>
</p>

<table width="400" align="center" border="1"  >
	<tr>

		<td width="350" height="28" align="center" 
			class="tablehead">District</td>
	</tr>
	<%
		 try
		{
		con=conbean.getConnection();
		
		sql="SELECT * FROM  com_m_district  where INT_STATEID=?";
		pstm=con.prepareStatement(sql);
		pstm.setInt(1,Integer.parseInt(TxtStateId));
		rs=pstm.executeQuery();
		while(rs.next())
			    {				
		   %>
	<tr>
		<td valign="middle"><input type="checkbox" name="OptDistrictName"
			value=<%= rs.getString("CHR_DISTRICTNAME")%>> <%= rs.getString("CHR_DISTRICTNAME")%>
		<input type="hidden" name="TxtDistrictId"
			value="<%=rs.getString("INT_DISTRICTID") %>"></td>
	</tr>
	<%		
	     }
			rs.close();
			st.close();
			 
		}
	catch(SQLException e){}
	%>

	<input type="hidden" name="TxtStateId" value=<%=TxtStateId %>>
</table>
<table BORDER="0" ALIGN="CENTER">
	<tr>
		<td><!--<a href="StateAdd.jsp"> Add</a>&nbsp;&nbsp;&nbsp;&nbsp;  -->
		<!--         <a href="State_Modification.jsp" onClick=Edit()>Edit</a>&nbsp;&nbsp;&nbsp;&nbsp; -->
		<input type="submit" value="  Add  " onClick=Add()> <input
			type="submit" value="  Edit  " onClick=Edit()> <input
			type="submit" value="Delete" onClick=Delete()> <input
			type="hidden" value="" name="msg"> <!--         <a href="State_Deletion.jsp" onClick=Delete()>Delete</a>&nbsp;&nbsp;&nbsp;&nbsp; 		-->
</table>
<tr>
	<td align="left" valign="middle">
	</div>
	<td></td>
</tr>
</td>
<td></td>
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
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>

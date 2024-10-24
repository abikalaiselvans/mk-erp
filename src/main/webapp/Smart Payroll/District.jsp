<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%!
		Connection con;
		Statement st;
		String sql;
		ResultSet rs;
		String url;
		String driver;
	
	%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 

<title> :: PAYROLL ::</title>


 
<script language="javascript">
	function validate(){
	var OptStateName=document.getElementById("TxtStateId").value
		submitOK="true"
					    if ( OptStateName=="select")

 							 {

								alert(" Select State Name")

								document.frmState.OptStateName.focus()

                 					         submitOK="false"

							 }
							  if (submitOK=="false")
	
							 {
			
								 return false

 							 }
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

</head>
<form  AUTOCOMPLETE = "off"   method="post" name='frmState' action="District_View.jsp"
	onsubmit="return validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<table align="center" width="1000"  >
	<tr>
		<td>
		<table width="400" align="center" border="1"  >
			<tr>
				<td height="24" align="center"  class="tablehead">
				<strong>State Name</strong></td>
			</tr>
			<td align="center" valign="middle"><B> <select
				name="TxtStateId">
				<option value="select">Select</option>
				<%
			try
				{
				con=conbean.getConnection();
				st=con.createStatement();
				sql="SELECT * FROM  com_m_state ";
				rs=st.executeQuery(sql);
				
		
	while(rs.next())
			    {				
		   %>
				<option value=<%=rs.getString("INT_STATEID")%>><%=rs.getString("CHR_STATENAME")%></option>
				<%		
		
	     }
	
			rs.close();
			st.close();
			 
		}
		catch(SQLException e){}	
	
	%>
			</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table BORDER="0" ALIGN="CENTER">
	<tr>
		<td><input type="submit" value="Submit"   accesskey="s"   ></td>
	</tr>
</table>
</div>
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

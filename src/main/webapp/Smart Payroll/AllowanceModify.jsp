<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>
<%!
	Connection con;
	Statement st;
	ResultSet	rs;
	int a=1,allowance=0;
%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
</head>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">

	function Load()
  	{
		var query="AllowanceTransUpdate.jsp?staffid=" +document.getElementById("staffid").value;
		document.allowance.action=query;
  		document.allowance.submit();
		return "sample";
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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off"   name="allowance" action="AllowanceTransUpdate.jsp" method="get">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2" bgcolor="#dce4f9" class="BackGround">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="180" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2">&nbsp;</td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td width="368" valign="top">
					<table width="368" height="150" border="0" cellpadding="0"
						cellspacing="0">
						<tr>
							<td colspan="2">
							<%
				String staff1=request.getParameter("empId");
				String sId[]=staff1.split("~");
		        String staff=sId[1];
		     	Connection con1 ;
				PreparedStatement pstm;
				ResultSet rst;
				con1 = conbean.getConnection();
				pstm = con1.prepareStatement("SELECT CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_EMPID='"+staff+"'");
				rst = pstm.executeQuery();
				String empname="";
				if(rst.next()){
					empname=rst.getString("CHR_STAFFNAME");					
				}
		     	
				%>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<div align="center">Staff id : <%=staff%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Staff
							Name : <%=empname%> <input name="staffid" type="hidden"
								id="staffid" value="<%=staff%>"></div>
							</td>
						</tr>
						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">

							<div align="center">
							<table width="268" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#FFFF00">
								<tr>
									<td width="321">
									<div align="center">
									<%				  	
					ResultSetMetaData rsmd;
					String query = "";
					query = "Select count(*) from pay_m_allowance";
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					String txtname="",txtcode="";
					int rcount=0;
					if(rst.next())
						rcount =rst.getInt(1);
					//------------
					String month=""+	session.getAttribute("Month");
					String year=""+	session.getAttribute("Year");
					query = "Select * from pay_t_salaryallowance WHERE CHR_EMPID = '"+staff+"'";
					query =query +" AND CHR_MONTH='"+month+"'";
					query =query +" AND INT_YEAR="+year;
					pstm = con1.prepareStatement(query);
					rst = pstm.executeQuery();
					rsmd = rst.getMetaData();
					String s="";
					int u=0;
						if(rst.next())
						{	for(int i=1; i<=rsmd.getColumnCount()-5;i++)
								s = s +rst.getString(i)+"~";
						}
					else
						s = s +"0~0~0~0~0~0~0~0~0~0~0~0~0~0" ;
					//System.out.println(s);
					String asval[] = s.split("~");
					//-------------
					//System.out.println(asval.length +"---"+rcount);
					if(rcount > 0)
					{	
						out.println("<table width='300'  align=1center1 cellpadding='2' cellspacing='2'><tr>");
						out.println("<td colspan='2' bgcolor='#202B78' class='tablehead'><div align='center'>Allowance</div></td>");
						out.println("</tr>");
						out.println(" <tr>");
						query = "Select * from pay_m_allowance";
						pstm = con1.prepareStatement(query);
						rst = pstm.executeQuery();
						u=0;
						while(rst.next())
						{
							txtname=rst.getString("CHR_ANAME");
							txtcode=rst.getString("CHR_ACODE");
							out.println("<tr><td class='boldEleven' width=119>"+txtname);
							out.println("<td><input value='"+asval[u]+"' class='formText135' type='text' name='"+txtcode+"'>" );
							u =u+1;
						}
						out.println("</table>");
					}	
					
				%>
									</div>
									</td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
							<td><input name="filename" type="hidden" id="filename"
								value="StaffAllowanceRecovery" /> <input name="actionS"
								type="hidden" id="actionS"
								value="PAYStaffAllowanceRecoveryUpdate" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold" value="Update" /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:self.close()" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
			</tbody>
		</table>
		</td>
	</tr>
</table>
</form>
</body>

</html>

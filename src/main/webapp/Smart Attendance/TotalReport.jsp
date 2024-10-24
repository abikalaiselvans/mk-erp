<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;	
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/commonAJAX.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNullSelect('company','Select Company','Select'))
  	{
		return true;
	}
	else
	
	return false;
  }
 </script>
<style type="text/css">
<!--
.style11 {font-size: 12px}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
.style14 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" action="../SmartLoginAuth" onsubmit="return Validate()">
<body  onpaste="return false;" topmargin="0" leftmargin="0">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="122">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="310"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="350" align="center" border="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="27" colspan="2" class="BackGround" >Report
							Based on Leaves</td>
						</tr>
						<tr>
							<td width="177" height="28" valign="middle" class="bolddeepblue">
							Company</td>
							<td width="247"><select name="company" id="company"
								class="bolddeepblue" onChange="LoadBranches()">
								<option value="Select">Select</option>
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td height="28" valign="middle" class="bolddeepblue">Branch<span
								class="style11"> <input type="hidden" name="actionS"
								value="COM_ATTTotalReport"> <input type="hidden"
								name="filename" value="Report"> <%
			//String branch[][]  = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME from  com_m_branch ");
			
			%> </span></td>
							<td><!--DWLayoutEmptyCell-->&nbsp;</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('LeaveEntry Details.jsp');"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="69" align="center"></td>
	</tr>
</table>


<script language="JavaScript">
function Branches()
{
	
	<%
	String branch[][]  = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_BRANCHID,INT_COMPANYID,CHR_BRANCHNAME from  com_m_branch ");
	String lvalue="";
	for(int x=0; x<branch.length;x++)
	{
		for(int y=0; y<3;y++)
		{
			lvalue = lvalue+branch[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>
	var cvalue = "<%=lvalue%>";
 	var cvalue1 =cvalue.split("~");
	var str="";
    for(i=0; i<cvalue1.length-1; i++)
 	{
   		var rowvalue = cvalue1[i].split(",");
		var bid = document.getElementById('company').value;
		for(u=0; u<cvalue1.length-1; u++)
 		{	
			if (rowvalue[1] === bid)
			{
				str= str+"<option value='"+rowvalue[0]+"'>"+rowvalue[2]+"</option>";
			}
		}
	}
	
	var x=document.getElementById("branch");
	//x.remove(x.selectedIndex);
	
   			
}
</script>

<%@ include file="../footer.jsp"%>
</body>
</html>

<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>

<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function isNumberFloat(inputString,id)
{

	if(!isNaN(parseFloat(inputString)))
		return true;
	else
		{
		alert("Enter Data...");
		document.getElementById(id).value ="0";
		document.getElementById(id).focus();
		return false;
		}
 // return (!isNaN(parseFloat(inputString))) ? true : false;


}

function validate()
{
	 
    if(checkNull("ename","Select Staff") )
		return true;
    else
    	return false;
}
function list()
  {   
     if(checkNull("ename","Select Staff"))
	 {
        return true;
     }
     else
     {
     	return false;
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

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   method="post" action="../SmartLoginAuth" name="staffleavefrm"
	onSubmit="return validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="54"></td>
	</tr>
	<tr>
		<td height="23">
		<table width="561" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2" class="boldEleven">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="boldEleven"></td>
						</tr>
						<tr>
							<td colspan="2" class="boldEleven"></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<div align="center"><%@ include
								file="../JavaScript/ajax.jsp"%></div>
							</td>
						</tr>
						<tr>
							<td width="49%" height="19" class="boldEleven">&nbsp;</td>
							<td width="51%" class="boldEleven">&nbsp;</td>
						</tr>
						<tr>
							<td height="43" colspan="2" class="boldEleven">
							<div align="center">
							<table width="268" border="1" cellpadding="5" cellspacing="0"
								bordercolor="#FFFF00">
								<tr>
									<td width="321">
									<div align="center">
									<%
						  	String column[] = StaffRegistration.leaveTypeValue().split("~");
							
							int l =column.length;
							String  fs="checkNull('ename','Select Staff')";
							for(int i=0;i<l;i++)
							{
								String d ="txt"+i;
								fs = fs +" && checkNull('" + d + "', 'Enter the "+column[i]+" value')";
								 
							}
							 
	
							String sdf ="txt";
						  	out.println("<table cellspacing=2 cellpadding=5>");
							out.println("<tr>");
							out.println("<tr align='center'><td class='bold1'>Leave Name<td class='bold1'>Limit<td class='bold1'>");
						  	for(int i=0; i<column.length;i++)
						  	{
							out.println("<tr><td class='boldEleven' cellspacing=2 cellpadding=5>"+column[i].toUpperCase());
							out.println("<td  class='boldEleven'>");
							%> <input onKeyPress="return numeric_only(event,'<%=sdf+i%>','8')" id="<%=sdf+i%>" class='formText135' name='<%=column[i]%>' type='text' size='10' maxlength='2' />
							
							
							 
							
							 <%
							}
							out.println("<td>&nbsp;<tr>");
							out.println("<tr>");
							out.println("</table>");	
						  %>
									</div>
									</td>
								</tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<div align="center">
							<%
					  		
							String er=(""+request.getParameter("er")).trim();
							if(! er.equals("null"))
							{
								
								String val[] = er.split("~");
								out.println("<div id='onduty' style='OVERFLOW:auto;width:500px;height:100px' >");
								out.println("<center><table>");
								out.println("<tr class='MRow1'>");
								out.println("<td colspan=3 class='bolddeepred'>Already Entered current year...");
								out.println("<tr class='MRow1'>");
								out.println("<td width='250' class ='boldEleven' ><b>Staffid</b>");
								for(int u=0; u<val.length; u++)
								{
									
									if(u%2==1)
										out.println("<tr class='MRow1'>");
									else
										out.println("<tr  class='MRow2'>");	
									String values[] = val[u].split(",");
									out.println("<td width='250' class ='boldEleven' >"+values[0]);
									
								}
								out.println("</center></table></div>");
							}	
					  %>
							</div>
							</td>
						</tr>

						<tr>
							<td height="19" colspan="2" class="boldEleven"><input
								name="filename" type="hidden" id="filename" value="StaffLeave" />
							<input name="actionS" type="hidden" id="actionS"
								value="ATTStaffLeaveAdd" /></td>
						</tr>
						<tr>
							<td height="19" colspan="2" class="boldEleven">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:history.back()" /></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td width="4" nowrap="nowrap"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">
		<div align="center"></div>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
<script language="JavaScript">
function validate()
{
	if(<%=fs%> )
    		return true;
	else
    	return false;
}
</script>
</html>

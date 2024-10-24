 <%@ page import="java.io.*,java.util.*"%>
<%@page import="com.my.org.erp.bean.payroll.*"%>
<%@page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

 
<html>
<head>

<title> :: CONVEYANCE ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript">
 
	$(function() {
		$( "#opendate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			minDate: -20, maxDate: "+2D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="javascript">
function validate()
{
    if(checkNull("ename","Select Staff")
	&& checkNull("opendate","Select Open Date") 
	&& checkNull("advamount","Enter Advance Amount") 
	&& checkNull("desc","Enter Description") 
	&& checkNullSelect("creditto","Select credited to",'')  
	&& checkNullSelect("authorised","Enter Authorised Signatory",'0') 
	 	
	)
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
 
function due()
{
	var advamt=document.getElementById('advamount')
	var noins=document.getElementById('noinstalment')
	var dueamt=document.getElementById('dueamount')
	var temp;
	if(noins.value=="") 
	  return false;
	else
	{
	   if(advamt.value=="") 
	   {
	   	  alert("Enter Advance Amount");
	   	  advamt.focus();
	   }
	   else
	   {
	   	   dueamt.value=parseInt(advamt.value)/parseInt(noins.value)
   	   temp=parseInt(dueamt.value);
	   	   if(dueamt.value>temp)
			temp=temp+1;
		   dueamt.value=temp;	   	   
	   }
	}
}
function due1()
{
	var advamt=document.getElementById('advamount')
	var noins=document.getElementById('noinstalment')
	var dueamt=document.getElementById('dueamount')
	var temp
	if(dueamt.value=="") 
	  return false;
	else
	{
	   if(advamt.value=="") 
	   {
	   	  alert("Enter Advance Amount");
	   	  advamt.focus();
	   }
	   else
	   {
	   	   noins.value=parseInt(advamt.value)/parseInt(dueamt.value)
	   	   temp=parseInt(noins.value);
	   	   if(noins.value>temp)
				temp=temp+1;
		   noins.value=temp;
	   }
	}
}

function manual()
  {  
	 //document.advance.advamount.disabled=true;
	 document.advance.noofinstal.disabled=true;
	 document.advance.dueamount.disabled=true;
	 //document.advance.advamount.value="0";
	 document.advance.dueamount.value="0";
	 document.advance.noofinstal.value="0";
  }
 
  function automatic()
  {
     //document.advance.advamount.disabled=false;
	 document.advance.noofinstal.disabled=false;
	 document.advance.dueamount.disabled=false;
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

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form action="../SmartLoginAuth" method="get"   name="advance" onSubmit="return validate()"  AUTOCOMPLETE = "off">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="563" border="0" align="center" cellpadding="0"
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
						<tr class="boldEleven">
							<td height="20" colspan="2">
							<div align="center"><strong>CONVEYANCE ADVANCE INFORMATIONS </strong></div>							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div align="right"><span class="boldEleven">* </span><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>

						<tr>
							<td width="49%" height="19">&nbsp;</td>
							<td width="51%">&nbsp;</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><%@ include
								file="../JavaScript/ajax.jsp"%></div>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table width="433" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="108" align="left" valign="middle"
										  class="boldEleven">Opening Date<span class="boldred"> * </span></td>
									<td><input name="opendate" type="text" class="formText135"
										id="opendate" onKeyPress="numericHypenOnly('opendate',10)"
										size="20" maxlength="10" readonly="readonly"> 
									 <script
										language="JavaScript">
<!--
  
  setCurrentDate('opendate');
//-->
</script></td>
								</tr>
								<tr>
									<td align="left" valign="middle"  
										class="boldEleven">Advance Amount<span class="boldred"> * </span></td>
									<td><input name="advamount" type="text" class="formText135"
										id="advamount" onKeyPress="return numeric_only(event,'advamount','10')" 
										size="20" maxlength="8"></td>
								</tr>
								<tr>
									<td align="left" valign="top"  
										class="boldEleven">Description<span class="boldred"> * </span></td>
									<td><textarea name="desc"   cols="40" rows="7"
										class="formText135" id="desc"></textarea></td>
								</tr>
								<tr>
								  <td class="boldEleven">Credit via <span
									class="bolddeepred">* </span></td>
								  <td class="tabledata"><select name="creditto" class="formText135" id="creditto" style="width:200">
                              <option value="">Select</option>
								<%
					  String sql = "SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME";
					   String deposit[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
						      </select></td>
							  </tr>
								<tr>
									<td class="boldEleven">Authorised By<span class="boldred"> * </span></td>
									<td class="tabledata">
									
									  <select name="authorised"  id="authorised" class="formText135" style="width:200" > 
									  <option value="0">Select</option>
									  
									  <%
																		
			
	String empdata[][]= CommonFunctions.QueryExecute("SELECT  CHR_EMPID,CHR_STAFFNAME FROM  com_m_staff ORDER BY CHR_STAFFNAME ");
for(int h=0;h<empdata.length;h++)
	if(empdata[h][0].trim().equals(session.getAttribute("EMPID")))
		out.print("<option selected='selected' value='"+empdata[h][0]+"'>"+ empdata[h][1]+" - "+empdata[h][0]+"</option>");
	else
		out.print("<option value='"+empdata[h][0]+"'>"+ empdata[h][1]+" - "+empdata[h][0]+"</option>");
																		
																		
	
%>
								      </select>							      </td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<div align="center"><input name="filename" type="hidden"
								id="filename" value="ConveyanceAdvance" />
							  <input name="actionS"
								type="hidden" id="actionS" value="CONConveyanceAdvanceAdd" />
							</div>							</td>
						</tr>
						<tr>
							<td height="19" colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('ConveyanceAdvance.jsp')" /></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
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
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>

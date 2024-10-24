<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%@ include file="index.jsp"%>
 <%
try
{
%>

<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>

<title> :: ATTENDANCE ::</title>


<script language="javascript">
function rDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].leavename
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].leavename.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmLeave.action="../SmartLoginAuth";
				
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
function Add()
{		
	document.frmLeave.action="LeaveTypeAction.jsp";
	
}

function mainPage()
{
 document.frmLeave.action="Leave MasterView.jsp";
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
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   method="get" name='frmLeave'><br>
<br>

<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
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

			<table width="400" border="0" align="center">
				<tr>
					<td   align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0" >
                      <tr>
                        <td class="boldgre"><div align="center">LEAVE TYPE </div></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td><div align="center">
                          <%
								int count=0;
								 
								 String data[][] = CommonFunctions.QueryExecute(" SELECT CHR_LEAVENAME,CHR_SYMBOL,IF(CHR_CARRY='Y','YES','NO') FROM ATT_M_LEAVETYPE ");
								
								
								out.println("<center>");
								out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
								out.println("<tr class='MRow1'>");
								out.println("<td align='center'  class=\"boldEleven\"><b>S.NO</b></td>");
								out.println("<td align='center'  class=\"boldEleven\"><b>LEAVE NAME</b></td>");
								out.println("<td align='center'  class=\"boldEleven\"><b>LEAVE SYMBOL</b></td>");
								out.println("<td align='center'  class=\"boldEleven\"><b>LEAVE CARRYFORWARD</b></td>");
								out.println("</tr>");
								for(int i=0;i<data.length;i++)
								{				
									 		
								 	if(i%2==0)
										out.println("<tr class='MRow1'>");
									else
										out.println("<tr class='MRow2'>");	
									out.println("<td align='center'  class=\"boldEleven\">"+(i+1)+".</td>");
									out.println("<td class=\"boldEleven\">");
								 	out.println(data[i][0]);
									out.println("</td>");
									out.println("<td class=\"boldEleven\">"+data[i][1]+"</td>");
									out.println("<td class=\"boldEleven\">"+data[i][2]+"</td>");
									out.println("</tr>");
									count++;
								}
								out.println("</table>");
								out.println("</center>");
									
						%>
                        </div></td>
                      </tr>
                      <tr>
                        <td class="boldElevenlink">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldElevenlink">* Maximum 9 leaves </td>
                      </tr>
                      <tr>
                        <td> <table  align="center">
	<tr>
		<td width="56" valign="top">
		<% 	
			if(count==9)
			{  
            	 
            } 
			else
			{ 
			 
            out.println("<input name='submit2' type='submit' class='buttonbold' onClick=Add() value='  Add  '>");
			out.println("<input type='hidden' name='filename' value='LeaveType'>");
            out.println("<input type='hidden'  name='actionS' value='ATTleaveTypedelete'>");
             out.println("<input type='hidden' value='' name='msg'> ");
            
			}
		%>		</td>
		<!--    <td width="47" valign="top"><input name="submit3" type="submit" class="buttonbold" onClick="return rDelete()" value=" Delete "> -->
		<td width="56" valign="top"><input name="Button" type="button"
			class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('AttendanceMain.jsp')"></td>
	</tr>
</table></td>
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

 


<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

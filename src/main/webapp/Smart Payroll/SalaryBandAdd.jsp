<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<%@ include file="index.jsp"%>
<html>
<head>

<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 
 
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


<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>



<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form action="../SmartLoginAuth" method="get"   name="frm" onSubmit="return Validate()"  AUTOCOMPLETE = "off">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="80">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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

					<table width="400" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" >SALARY BAND  <span class="boldEleven">
							  
							</span></td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="tabledata"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td><input type="hidden" name="filename" value="SalaryBand">
                            <input type="hidden" name="actionS" value="PAYSalaryBandAdd">
                            <input name="grosslimit" type="hidden" id="grosslimit" value="<%= CommonFunctions.QueryExecute("SELECT INT_GROSSLIMIT FROM m_institution  WHERE INT_ID=1")[0][0]%>"></td>
					  </tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Split up in </td>
						  <td class="boldEleven"><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><input name="splitup" type="radio" value="A"></td>
                              <td class="boldEleven">Amount</td>
                              <td class="boldEleven"><input name="splitup" type="radio" value="P" checked></td>
                              <td class="boldEleven">Percentage</td>
                            </tr>
                          </table></td>
					  </tr>
						<tr>
							<td width="223" height="28" valign="middle" class="boldEleven">Greater than or equal<span class="boldred"> ( &gt;= ) </span></td>
							<td width="163" class="boldEleven">
	<input name="GT" type="text" class="formText135" id="GT" onKeyPress="return numeric_only(event,'GT','12')"  value="" size="10" maxlength="10" style="text-align:right">
						  <div id="soValid"></div>	
                            <!--onBlur="upperMe(this), CheckUnique(this,'soValid','pay_m_salaryband','INT_STARTINGSALARY')"-->
				
   						  </td>
						</tr>
						<tr>
						  <td height="28" valign="middle" class="boldEleven">Less than or equal to<span class="boldred"> ( &lt;= ) </span></td>
						  <td class="boldEleven">
<input name="LT" type="text" class="formText135" id="LT"   onKeyPress="return numeric_only(event,'LT','12')"     value="" size="10" maxlength="10" style="text-align:right">	
<div id="soValid1"></div>	<!-- onBlur=" CheckUnique(this,'soValid1','pay_m_salaryband','INT_ENDINGSALARY')"-->			  </tr>
						 
						  <td height="28" valign="middle" class="boldEleven">Basic</td>
						  <td class="boldEleven">
	<input name="Basic" type="text" class="formText135" id="Basic"  onKeyUp="return numeric_only(event,'Basic','8')" value="" size="10" maxlength="5" style="text-align:right">
	<span class="boldElevenlink"> ( % )</span>					  </tr>
						  <%
					  	String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT INT_ALLOWANCEID,CHR_ACODE,CHR_ANAME FROM  pay_m_allowance    WHERE CHR_FLAG='Y'  ORDER BY INT_ALLOWANCEID");
						String cname="";	
						if(AllowanceData.length>0)
							for(int u=0; u<AllowanceData.length;u++)
							{
								out.println("<tr>");
								out.println("<td class='boldEleven'>"+AllowanceData[u][2]+"</td>");
								out.println("<td class='boldEleven'><input name='Allowance"+(u+1)+"' type='text' class='formText135' id='Allowance"+(u+1)+"' onKeyPress=\"return numeric_only(event,'Allowance"+(u+1)+"','8')\"    value='' size='10' maxlength='5' value='0' style=\"text-align:right\"> <span class='boldElevenlink'> ( % )</span> </td>");
								out.println("</tr>"); 
								cname = cname+"Allowance"+(u+1)+",";
							}	
							
						String sname="";	
						if(AllowanceData.length>0)
							for(int u=0; u<AllowanceData.length;u++)
								sname=sname+AllowanceData[u][2]+","	;
					  %>					  
					  
					  
					  
					  
					  
					  
						
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit" name="Submit"  id="Submit"  value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="Button" name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('SalaryBandView.jsp')"></td>
								</tr>
							</table>
							</div>							</td>
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
		<td class="boldred" align="center">
        <%
		String error = ""+request.getParameter("error");
		if(error.length()>5)
			out.println(error);
		%>
        
        </td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
</table></form>

<script language="javascript">
var s1 = "<%=sname%>";
var v1 = s1.split(",");
var s = "<%=cname%>";
var v = s.split(",");


function Validate()
{
	try
	{	
		var gt = parseInt(document.getElementById('GT').value );
		var lt = parseInt(document.getElementById('LT').value );
		if(gt>lt)
		{
			alert("Incorrect Salary Slab then check your data...");
			return false;
		}
					
		 
		if(	
				checkNull('GT','Enter Greaterthan or equal') 
				&& checkNull('LT','Enter Lessthan or equal')
				 
				&& checkNull('Basic','Enter Basic')
				&& individualCheck()
				&& totalpercentage()
			)
		 {
				for( j=0; j<v.length-1; j++)
				{
					var chk =document.getElementById(v[j]).value;
					var ck = "Enter the allowance column..."+v1[j];
					if(checkNull(v[j],ck))
					{
						d=1;
					}
					else
					{
						return false;				
					}	
				}
				
		}
		else
			return false;
	}
	catch(err)
	{
		alert(err)
		return false;
	}		
}
	
	
function individualCheck()
{
	try
	{
		var d=0;
		for( j=0; j<v.length-1; j++)
		{
			var chk =document.getElementById(v[j]).value;
			var ck = "Enter the allowance column..."+v1[j];
			if(checkNull(v[j],ck))
			{
				d=1;
			}	
			else
			{
				d=0;
				break;
						
			}
		}
		
		if(d==1)
			return true;
		else	
			return false;		
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
	
function totalpercentage()
{
		var sum = 0;
		var Basic = parseFloat(document.getElementById('Basic').value);
		sum = Basic;
		
		for( j=0; j<v.length-1; j++)
		{
			var chk =document.getElementById(v[j]).value;
			var ck = "Enter Data..."+v1[j];
			if(checkNull(v[j],ck))
				sum = sum+parseFloat(chk);
			 
		}
		 
		if(sum>=100)
		{
			alert("Your split up percentage exceeds the 100");
			return false;
		}
		else
			return true;
}
</script>
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
		out.println(e.getMessage()); 
}
%>
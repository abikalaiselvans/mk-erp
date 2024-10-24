<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollAjax.js"></script>
<script language="javascript">
function disable()
{
    document.getElementById('Edit').disabled=true; 
	document.getElementById('Delete').disabled=true;
}


function validate()
{
    if(checkNull("ename","Select Staff"))
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
function mainPage()
	{
	    document.allow.action="Payrollmain.jsp";
		document.allow.submit();
		return true;
    }	
	
function RAdd()
{		
	document.allowancefrm.action="AllowanceRecoveryRivisionAdd.jsp";
	document.allowancefrm.submit();
}	
function REdit()
{				
		
		var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }		 
 	     
 	    if(count==1)
 	    {
		document.allowancefrm.action="RivisionEdit.jsp";
		document.allowancefrm.submit();
		return true;
		}
 	}
 function RDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.allowancefrm.action="../SmartLoginAuth";
				document.allowancefrm.submit();
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
	 	
		
		function mainPage()
	{
	    document.allowancefrm.action="Payrollmain.jsp";
		document.allowancefrm.submit();
		return true;
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="loadRivision('0')">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="allowancefrm">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="2">
			<tr>
				<td>
				<table border="0" align="center"
					cellpadding="0" cellspacing="0" class="TableDesign"  >
					<!--DWLayoutTable-->
					<tr align="center" valign="middle">
						<td   class="whiteMedium">						  REVISION</td>
					</tr>
					<tr align="center" valign="middle">
						<td height="31"    >
						  <table width="47%" border="0" align="center" cellpadding="1"
							cellspacing="1" class="whiteMedium">
							<tr>

								<td>Office</td>
								<td class="boldEleven">
								<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
									tabindex="6" onBlur="loadRivision('0')">
									<option value="0">All</option>
									<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
								</select></td>
								<td>Month </td>
								<td>
								<select name="month" class="formText135" id="month" onChange="loadRivision('0')">
								<option value="0">All</option>
									<%@ include file="../JavaScript/months.jsp"%>
								</select></td>
								<td>Year </td>
								<td>
								<select name="year" class="formText135"	id="year" onChange="loadRivision('0')">
									<%@ include file="../JavaScript/years.jsp"%>
								</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></td>
							</tr>
						</table>					  </td>
					</tr>

					<tr>
						<td height="23"  >
						<table width="100%" border="0" class="whiteMedium" >
							<tr >
								<td  >Staff Id</td>
								<td   >Name</td>
								<td   >Company Name</td>
								<td   >Branch</td>
								<td   >Depart</td>
								<td   >Phone</td>
								<td   >Eff. From</td>
							</tr>
						</table>						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td height="23"  >
						<div id="rivisionTable"
							style="OVERFLOW:auto;width:100%;height:300px"></div><br>					  </td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
		  </tr>
			<tr>
				<td>
				<table width="90%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="TableDesign"  >
					<tr class="boldEleven">
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('0')">All</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('A')">A</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('B')">B</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('C')">C</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('D')">D</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('E')">E</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('F')">F</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('G')">G</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('H')">H</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('I')">I</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('J')">J</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('K')">K</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('L')">L</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('M')">M</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('N')">N</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('O')">O</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('P')">P</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('Q')">Q</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('R')">R</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('S')">S</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('T')">T</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('U')">U</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('V')">V</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('W')">W</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('X')">X</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('Y')">Y</a>						</div>						</td>
						<td>
						<div align="center"><a class="whiteMedium" href="javascript:loadRivision('Z')">Z</a>						</div>						</td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
		  </tr>
			<tr>
				<td>
				<table border="0" align="center" cellpadding="2" cellspacing="2">
					<tr>
						<td width="56"><input class="ButtonHead" name="button"
							type="submit"  value="Add"   accesskey="s"   onClick="RAdd()"></td>
						<td width="56"><input name="Delete" type="Button"
							class="ButtonHead" id="Delete" value="Delete"
							onClick="RDelete()"></td>
						<td width="56"><input class="ButtonHead" type="button"
							name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
						<td width="56"><input name="Edit" type="hidden"
							class="buttonbold" id="Edit" value="Edit" onClick="REdit()">						</td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td><input name="filename" type="hidden" id="filename"
					value="StaffAllowanceRecovery"> <input name="actionS"
					type="hidden" id="actionS" value="PAYRivisionDelete"></td>
			</tr>
		</table>

		<%@ include file="../footer.jsp"%>
		</form>
</body>

</html>

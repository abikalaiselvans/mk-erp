<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>

<%!
	String batchName;
    int batchId,companyId;
%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<script language="javascript" src="../JavaScript/common/Branch.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}

.style9 {
	color: #FFFFFF
}

.style10 {
	font-family: Verdana;
	font-size: 12px;
	color: #FFFFFF;
}

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
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<script language="javascript">    
	function BDelete()
 	{		
 	    
		
		var count;	
		count=0;
		coffee1=document.forms[0].branchId;
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
			if (document.forms[0].branchId.checked) { count=1;}
		}
		
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				
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
 	function BEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].branchId
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
			if (document.forms[0].branchId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="BranchAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}		
 	
	function Add()
 	{				
		document.frm.action="BranchAction.jsp";		
 	}
 	 
</script>



<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>

<body onpaste="return false;" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadBranchData('0')">

<form AUTOCOMPLETE="off" method="get" name='frm'><%@ include
	file="insert.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="385" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign">
			<tr>
				<td height="18">
				<div align="center" class="whiteMedium">Branch Informations <%
		 
		%>
				</div>
				</td>
			</tr>
			<tr>
				<td height="26">

				<table border="0" align="center" cellpadding="2" cellspacing="2">
					<tr>
						<td class="whiteMedium">Company</td>
						<td><select name="companyId" id="companyId"
							onChange="loadBranchData('0')" class='formText135'>
							<option value="0">All</option>
							<%  			
        String sql="SELECT * FROM  com_m_company ";
        String	company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
        for(int i=0;i<company.length;i++)
    	 out.println("<option value='"+company[i][0]+"'>"+company[i][1]+"</option>");	
		%>
						</select></td>

					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="31">
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="whiteMedium">
						<td width="50">
						<div align="center">S.No</div>
						</td>
						<td>
						<div align="center">Company</div>
						</td>
						<td>
						<div align="center">Branch</div>
						</td>
						<td>
						<div align="center">Legal Name</div>
						</td>
						<td>
						<div align="center">City</div>
						</td>
						<td>
						<div align="center">Country</div>
						</td>
						<td>
						<div align="center">Email</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="127" valign="top" class="footermenu">
				<table width="100%">

					<tr>
						<td>
						<div id="divscroll"
							style="OVERFLOW: auto; width: 100%; height: 300px"
							class="boldEleven">
						<div id="branchTable"></div>
						</div>
						<br>
						<div align="center" id="totRec"></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadBranchData('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Branch">
		<input type="hidden" name="actionS" value="COMbranchDelete"> <input
			name="path" type="hidden" id="path" value="<%=path%>"></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="275" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>


				<td width="56"><input type="submit" class="ButtonHead"
					onClick="Add()" name="action1" value="Add"></td>
				<td width="56"><input type="submit" class="ButtonHead"
					onClick="return BEdit()" name="action1" value="Edit"></td>
				<%
	 String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56"><input name="Delete" id="Delete" type="submit"
					class="ButtonHead" onClick="return BDelete()" value="Delete"></td>
				<%
	   }
	   else
	   {
	   	out.println("<input name='Delete'  id='Delete' type='hidden'/>");
	   }

	   %>

				<td width="56"><input type="button" class="ButtonHead"
					name="submit" value="Close" accesskey="c"
					onClick="redirect('<%=closefile%>')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>


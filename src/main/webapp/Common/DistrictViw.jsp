<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%int stateId;
 %>


<%@ include file="insert.jsp"%>

<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
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


</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/AttendanceAjax.js"></script>
<script language="JavaScript">
    function Add()
	{ 
		if(Validate()==true)
		{		
			document.frm.action="DistrictAction.jsp";
		}
 	}

	function Edit()
 	{		
		var count;
		count=0;
		if(Validate()==true)
		{
		coffee1=document.forms[0].districtId
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
			if (document.forms[0].districtId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DistrictAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		}
 	}	

 	function Delete()
 	{		
		var count;
		count=0;
		if(Validate()==true)
		{
		coffee1=document.forms[0].districtId
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
			if (document.forms[0].districtId.checked) { count=1;}
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
 	}

 	function mainPage()
	{
	     document.frm.action="AttendanceMain.jsp";
	     document.frm.submit();
    }
 	
 function Validate()
  {
    if(checkNullSelect("state","Select the State","select"))
		return true;
	else
		return false;		
  }
 	
</script>
<%
	ArrayList stateList=(ArrayList)session.getAttribute("disstateList");
	int totalRecord=stateList.size();	 		
%>
<body onpaste="return false;" onLoad="loadDistrict()">

<form AUTOCOMPLETE="off" name="frm" method="get" onSubmit="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="600" height="200" border="1" align="center"
			cellpadding="1" cellspacing="1">
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">State: <select
					name="state" id="state" onChange="assignValue(this)">
					<option value="select">Select</option>
					<%
         for(int i=0;i<totalRecord;i++)
 	 	 {
 	 	 	com.my.org.erp.bean.Attendance.State state=(com.my.org.erp.bean.Attendance.State)stateList.get(i);
 	 	 	out.println("<option value='"+state.getStateId()+"'>"+state.getStateName()+"</option>");
 	 	  }    
        String dis="";
        if(stateList.size()==0) dis="disabled='disabled'";
 		%>
				</select> Search District Name :: <input type="text" name="txtSer"
					id="txtSer" maxlength="10" size="5" class="formText135"
					onKeyUp="loadDistrict()"></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="160">
						<div align="center">District Name</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
					<tr>
						<td class="bolddeepblue" align="center">
						<div align="center" id="totRec"></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="divscroll"
							style="OVERFLOW: auto; width: 600px; height: 130px"
							class="boldEleven">
						<div id="districtTable"></div>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadDistrictC('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="District" /> <input
			type="hidden" name="actionS" value="ATTdistrictDelete" /> <input
			type="hidden" name="stateId" id="stateId" /></td>
	</tr>

	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1" value="Add" accesskey="s"
					onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1" <%=dis %> id="btnEdit"
					value="Edit" onclick="return Edit()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="Submit3" <%=dis %> id="btnDelete"
					value="Delete" onclick="return Delete()" /></td>
				<td width="56"><input type="button" class="buttonbold"
					name="submit" value="Close" accesskey="c"
					onClick="redirect('AttendanceMain.jsp')" /></td>
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
<script language="JavaScript">
function assignValue(val)
{
	document.getElementById('stateId').value= val.value;
	loadDistrict();
}
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>

<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%int stateId;
 %>
<%@ include file="insert.jsp"%>

<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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


<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/commonAJAX.js"></script>
<script language="JavaScript">

function sett()
{
	document.frm.state.focus();
}

    function Add()
	{ 
			document.frm.action="DistrictAction.jsp";
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
			document.frm.action="DistrictAction.jsp?path=<%=path%>&qp=<%=qp%>";
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
<body onpaste="return false;" onLoad="sett()">

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
		<table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign">
			<tr>
				<td height="31">
				<div align="center" class="whiteMedium">STATE <select
					name="state" id="state" onChange="loadDistrict('0')">
					<option value="select">Select</option>
					<%
         for(int i=0;i<totalRecord;i++)
 	 	 {
 	 	 	com.my.org.erp.bean.State state=(com.my.org.erp.bean.State)stateList.get(i);
 
 	 	 	out.println("<option value='"+state.getStateId()+"'>"+state.getStateName()+"</option>");
 	 	  }    
        String dis="";
        if(stateList.size()==0) dis="disabled='disabled'";
 		%>
				</select> <!--          Search District Name :: <input type="text" name="txtSer" id="txtSer" maxlength="10" size="5" class="formText135" onKeyUp="loadDistrict()">    -->

				<input type="hidden" name="txtSer" id="txtSer" value=""></div>



				</td>
			</tr>
			<tr>
				<td height="31">
				<div align="center">
				<table width="100%" border="0" cellpadding="1" cellspacing="1"
					class="whiteMedium">
					<tr>
						<td width="11%">
						<div align="center">S.NO</div>
						</td>
						<td width="89%">
						<div align="center">DISTRICT</div>
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
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="districtTable"
							style="OVERFLOW: auto; width: 100%; height: 200px"
							class="boldEleven"></div>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium"
					href="javascript:loadDistrict('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" id="filename"
			value="District" /> <input type="hidden" name="actionS" id="actionS"
			value="ATTdistrictDelete" /> <input type="hidden" name="qp" id="qp"
			value="<%=qp%>"> <input type="hidden" name="path" id="path"
			value="<%=path%>"></td>
	</tr>

	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Add"
					onclick="return Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" <%=dis %> id="btnEdit"
					value="Edit" onClick="return Edit()" disabled="disabled" /></td>

				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" <%=dis %> id="btnDelete"
					disabled="disabled" value="Delete" onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
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

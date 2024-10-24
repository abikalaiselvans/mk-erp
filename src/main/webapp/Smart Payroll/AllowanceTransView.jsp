<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%
try
{
	
	//AllowanceandRecovery.js
%>


<%! String sl; %>
<html>
<head>

<title> :: PAYROLL ::</title>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
@import url("../bootstrap/css/bootstrap.min.css");
-->
 </style>
 
 
  <script src="../bootstrap/js/jquery.min.js"></script>
 <script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Payroll/PayrollAjax.js"></script>
<script language="javascript" src="../JavaScript/Payroll/AllowanceRecovery.js"></script>


<script language="javascript">

	function AllowanceAdd(staffid)
	{
		var s =staffid;
		var width="600", height="500";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
		left=0;
		top=0;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="AllowanceRecoveryEdit.jsp?staffid="+s;
		 
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
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
	
	
function Add()
{		
	document.frm.action="AllowanceRecoveryAdd.jsp";
	document.frm.submit();
}	


	function AEdit()
 	{	 	    
 	  
	  
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
		  
 	    var count=0;
 	    var sfId="";
 	    sel=document.forms[0].staffid
 	    for(i=0;i<sel.length;i++)
 	    {
 	       if(sel[i].checked){
 	       count=count+1; 
 	       sfId=sel[i].value;
 	       }
 	    }
 	    if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;	}
		}
 	    if(count==0)
 	    {
 	        alert("Select Allowance to Edit");
 	        return false; 
 	    } 	    
 	    if(count==1)
 	    {
     	   alert(document.forms[0].staffid.value)
		    AllowanceAdd(document.forms[0].staffid.value);
			//document.frm.action="AllowanceRecoveryEdit.jsp";
	    	//document.frm.submit();
	    	//return true;
     	   
 	    }
 	    else
 	    {
 	        alert("Select One Record to Edit");
 	        return false; 
 	    }
	}


 function ADelete()
 	{		
		
		
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}
		
		
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
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
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
	    document.frm.action="Payrollmain.jsp";
		document.frm.submit();
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

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;' onLoad="loadAllowRecv('A')" >
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="30">
		<div align="center"></div>		</td>
	</tr>
	<tr>
		<td height="54">
		<table border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"    >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td align="center" width="100%" height="28" colspan="5"><span
					class="boldThirteen"> ALLOWANCE &amp; RECOVERY </span></td>
			</tr>
			<tr align="center" valign="middle">
				<td align="center" width="100%" height="28" colspan="4">
				  <table width="859" height="25" border="0" cellpadding="4" cellspacing="4" class="whiteMedium">
					<tr>
						<td width="68"  ><strong>Office</strong></td>
						<td width="79"  >
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onBlur="loadAllowRecv('0')">
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
						<td width="182"  >&nbsp;</td>
						<td width="182"  >Including Resigner's 
					    <input name="resigner" type="checkbox" class="formText135" id="resigner" value="Y"></td>
						<td width="182"  ><div align="right"><strong>Search by Id/name </strong></div></td>
					  <td width="90"><input name="Search" type="text" class="formText135"
							id="Search"  onBlur="loadAllowRecvs('0')" size="15" maxlength="15"></td>
					</tr>
				</table>			  </td>
			</tr>
			 
			<tr bgcolor="#FFFFFF">
				<td colspan="4" class="tablehead">
				<div id="divscroll" style="OVERFLOW: auto;width:100%;height:300px">
				<div id="AllowRecv"></div>
				</div><br> 
				<div align="center" id="totrec"></div>
				<br>			  </td>
			</tr>
			<tr>
				<td colspan="4">
				<div align="center"   id="totrec"></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="23">&nbsp;</td>
    </tr>
	<tr>
		<td height="23"><input name="filename" type="hidden"
			id="filename" value="StaffAllowanceRecovery"> <input
			name="actionS" type="hidden" id="actionS"
			value="PAYStaffAllowanceRecoveryDelete">
		<table width="900" border="0" align="center" cellpadding="2"
			cellspacing="2" class="TableDesign"  >
			<tr  >
				<td  align="center"><div ><a class="whiteMedium" href="javascript:loadAllowRecv('0')">All</a></div></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('A')">A</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('B')">B</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('C')">C</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('D')">D</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('E')">E</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('F')">F</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('G')">G</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('H')">H</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('I')">I</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('J')">J</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('K')">K</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('L')">L</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('M')">M</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('N')">N</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('O')">O</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('P')">P</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('Q')">Q</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('R')">R</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('S')">S</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('T')">T</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('U')">U</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('V')">V</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('W')">W</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('X')">X</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('Y')">Y</a></td>
				<td  align="center"><a class="whiteMedium" href="javascript:loadAllowRecv('Z')">Z</a></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="40">&nbsp;</td>
    </tr>
	<tr>
		<td height="40">
		<table border="0" align="center" cellpadding="2" cellspacing="2">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				<!--<td width="56"><input class="ButtonHead" name="Edit"
					id="Edit" type="button" onClick="return AEdit()" value="Edit"></td>-->
				
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="button" class="ButtonHead"
					name="Delete" id="Delete" value="Reset"
					onClick="return ADelete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

 
				<td width="56"><input class="ButtonHead" type="submit"
					name="Button"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>

</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>

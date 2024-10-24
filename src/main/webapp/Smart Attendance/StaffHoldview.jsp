<%@ page  import="com.my.org.erp.common.CommonFunctions"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
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
 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/StaffHoldAjax.js"></script>
<script language="javascript">
 	function ONHoldEdit()
 	{		
 	    obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}

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
		document.frm.action="StaffHoldEdit.jsp";
		document.frm.submit();
		return true;
		}
 	}
 	
	 	
		
	function Add()
 	{		
		document.frm.action="StaffHold.jsp";
		document.frm.submit();
 	}	
	
	 function ODelete()
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
	 
function buttondisable()
{
     	document.getElementById('Edit').disabled=true;
		
}
 	</script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="get" name="frm"> 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" 	class="bgcolor" onLoad="loadStaffHold('0')">
<table width="100%" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="21" colspan="6" align="center" class="bolddeepred">		</td>
	</tr>
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="177" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   >
				<td height="28" background=" "
					class="tablehead"><span class="whiteMedium">Staff Hold </span></td>
			</tr>

			<tr   >
				<td height="31" align="center"   >
				<table width="606" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td width="70"  ><strong>Office</strong></td>
						<td width="179"  >
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office" onChange="loadStaffHold('0')" >
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
						<td width="146"  >Search by Id/Name</td>
						<td width="198"  ><input type="text"  class="formText135"   name="search" id="search" onKeyUp="loadStaffHolds(this)"></td>
					</tr>
				</table>				</td>
			</tr>

			<tr  >
				<td height="31" align="left" valign="middle"  >
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>
						<td width="140">Staff Id</td>
						<td width="130">Staff Name</td>
						<td width="140">Company</td>
						<td width="130">Branch </td>
						<td width="130"> Department</td>
						<td width="140">Office</td>
						<td width="100">Status</td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td valign="top" bgcolor="#FFFFFF">
				<div id="StaffHoldable" style="OVERFLOW: auto;width:100%;height:300px"></div><br>
				<div id='totalrecord' align="center"></div>
				<br>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
  </tr>
	<tr>
		<td height="17" colspan="6"><input name="filename" type="hidden"
			id="filename" value="StaffHold"> 
		<input name="actionS"
			type="hidden" id="actionS" value="ATTStaffHoldDeletes">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('A')">A</a></div>				</td>
				<td> 
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffHold('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>

	<tr>
	  <td height="17" colspan="6">    
  <tr>
	  <td height="17" colspan="6">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="button" onClick="Add()" value="Hold" /></td>
				<td width="56"><input name="Edit" type="button"
					class="ButtonHead" id="Edit" onClick="ONHoldEdit()" value="Un Hold" /></td>
				 
				
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="button" class="ButtonHead"
					name="Button" id="Submit" value="Delete"
					onClick="return ODelete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
				
				 
				<td width="56"><input class="ButtonHead" type="button"
					name="Button"  value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')" /></td>
			</tr>
		</table>
		</center>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>

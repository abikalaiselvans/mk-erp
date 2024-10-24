<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%
try
{
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 

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
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Payroll/PayTaxValue.js"></script>
<script language="javascript">

function PayEdit()
{		
  		var count=0;
 	    sel=document.forms[0].allowance;
		for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	       alert("Select Record to Edit");
 	       return false;
 	    
 	    }
		if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
		
 	    if(count==1)
 	    {
			document.frm.action="MinimumWagesAction.jsp";
			document.frm.submit();
			return true;
		}
 	}
 
	function Add()
 	{		
		document.frm.action="MinimumWagesAction.jsp";
		
		//EmployeTransferAdd.jsp		
 	}
	
	
	function PayDelete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].rowid;
		 
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		 
		if(count>0)
		{			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				document.frm.submit();
				return true;			
			}
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
 	</script>
 
<style type="text/css">
<!--
.style3 {color: #000000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 00px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off" method="get"   name="frm">
<table width="100%" height="244" align="center" cellpadding="0" cellspacing="0">
	<tr>
	  <td height="18"><%@ include file="index.jsp"%></td>
    </tr>
	<tr>
		<td height="151" align="center"><br>
		<table width="95%" height="101" align="center" 	cellpadding="0" cellspacing="0" class="TableDesign"    >
			 
			<tr align="center" valign="middle" >
				<td height="28" 
					class="tablehead"><span class="style3">MINIMUM WAGES 
				    <input type="hidden" name="filename" value="MinimumWages">
                  <input type="hidden" name="actionS" value="PAYMinimumWagesDelete">
</span></td>
			</tr>

			 
			<tr>
			  <td height="20" valign="top"><table width="201" border="0" align="center" cellpadding="2" cellspacing="2">
                <tr>
                  <td>State</td>
                  <td>
				  <select name="state"  id="state" class="formText135">
				  		<option value="0">All</option>
						<%
						String stateData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=1 ORDER BY CHR_STATENAME");
						if(stateData.length>0)
						{
							for(int u=0;u<stateData.length;u++)
								out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						}
						%>
                  </select>
                  </td>
                </tr>
              </table></td>
		  <tr bgcolor="#FFFFFF">
			  <td height="28" valign="top">
				<div id="PayTaxvaluetable" style="OVERFLOW: auto;width:100%;height:auto">
				
				<%
				
				
				String sql ="";
				sql = " SELECT a.INT_MINIMUMWAGESROWID,b.CHR_STATENAME,a.DOU_MIN,a.DOU_MAX ";
				sql = sql+ " FROM pay_m_minimumwages a, com_m_state b ";
				sql = sql+ " WHERE a.INT_STATEID = b.INT_STATEID ";
				sql = sql+ " ORDER BY b.CHR_STATENAME ";
				String Data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
						if(Data.length>0)
						{
							out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
							out.println("<tr class='MRow1'>");
							out.println("<td class='boldEleven'><b>S.No</b></td>");
							out.println("<td class='boldEleven'><b>STATE NAME</b></td>");
							out.println("<td class='boldEleven'><b>MINI</b></td>");
							out.println("<td class='boldEleven'><b>MAXI</b></td>");
							out.println("</tr>");
							
							for(int u=0; u<Data.length;u++)
							{
								if(u%2==0)
									out.println("<tr class='MRow1'>");
								else
									out.println("<tr class='MRow2'>");	
								out.println("<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value="+Data[u][0]+"></td>");
								out.println("<td class='boldEleven'><a href='MinimumWagesAction.jsp?rowid="+Data[u][0]+"'><font class='boldgreen'>"+Data[u][1]+"</font></a></td>");
								out.println("<td class='boldEleven'>"+Data[u][2]+"</td>");
								out.println("<td class='bolddeepred'>"+Data[u][3]+"</td>");
								out.println("</tr>"); 
								
							}	
							 
							out.println("</table>");
						}
						else
						{
							out.println("<br><br><center><font class='boldeepred'><b>Data not found...</b></font></center>");
						}	
						
				%>
		    </div><br>				</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="23">&nbsp; </td>
	</tr>
	<tr>
		<td height="17" align="center">
		
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input name="submit" type="Submit" class="ButtonHead" id="submit" onClick="Add()" value="Add"></td>
				<td width="56"><input class="ButtonHead" name="Edit" type="Submit" onClick=" return PayEdit()" value="Edit"></td>
				<td width="56"><input class="ButtonHead" name="Delete" type="Submit" onClick="return PayDelete()" value="Delete"></td>
				<td width="56"><input class="ButtonHead" type="Button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20">
		 
		<%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>

</html>
<%
}
catch(Exception e)
{
}
%>
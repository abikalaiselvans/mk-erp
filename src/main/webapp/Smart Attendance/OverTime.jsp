<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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
<script language="JavaScript" src="../JavaScript/Attendance/OverTimeAjax.js"></script>
<script language="javascript"> 
function HEdit()
 	{					
	   
 	    var count;
		count=0; 				
		coffee1=document.forms[0].overtime;
		txt="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.OverTimefrm.overtime.checked) { count=1;}
		}
		if(count==1){			
			document.OverTimefrm.action="OverTimeEdit.jsp";			
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
		document.OverTimefrm.action="OverTimeAdd.jsp";		
 	}	
 	</script>
 
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadOverTime('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="OverTimefrm">
<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"  >
				<td height="28" 
					class="whiteHead">OverTime</td>
			</tr>
			<tr >
				<td height="31" align="center" >
				<table width="56%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium">
					<tr>
						<td class="boldThirteen"><strong>Office</strong></td>
						<td class="boldThirteen">
						<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office"
							tabindex="6" onChange="loadOverTime('0')">
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
						<td class="boldThirteen">Day</td>
						<td class="boldThirteen"><select name="day" id="day"  onBlur="loadOverTime('0') ">
                          <option value="0">All</option>
                          <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                        </select></td>
						<td class="boldThirteen">Month </td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onBlur="loadOverTime('0')">
							<%@ include file="../JavaScript/months.jsp"%>
						</select> </span></td>
						<td><span class="boldThirteen">Year </span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onBlur="loadOverTime('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1;
						var day=d.getDate()
						if(day<10) day="0"+day;
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
						setOptionValue('day',day);						
				//-->
          </script> </span></td>
					</tr>
				</table>				</td>
			</tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0"  class="whiteMedium"
					  >
					<tr>
						<td width="15%">Staff Id</td>
						<td width="18%">Staff Name</td>
						<td width="13%">Company</td>
						<td width="12%">Branch</td>
						<td width="12%">Department</td>
						<td width="10%">Designation</td>
						<td width="12%">Over Time(ms)</td>
					</tr>
				</table>				</td>
			</tr>
			<tr class="MRow1">
				<td height="28" valign="top">
				<div id="overtimeTable"
					style="OVERFLOW: auto;width:100%;height:250px"></div>
					<br>
					<div id="totRec"></div>
					
									</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="OverTime"> <input name="actionS"
			type="hidden" id="actionS" value="ATTovertimeDelete">		</td>
	</tr>
	<tr>
	  <td height="17" align="center"><table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
        <tr class="para">
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('0')">All</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('A')">A</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('B')">B</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('C')">C</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('D')">D</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('E')">E</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('F')">F</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('G')">G</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('H')">H</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('I')">I</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('J')">J</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('K')">K</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('L')">L</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('M')">M</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('N')">N</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('O')">O</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('P')">P</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('Q')">Q</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('R')">R</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('S')">S</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('T')">T</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('U')">U</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('V')">V</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('W')">W</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('X')">X</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('Y')">Y</a></div></td>
          <td><div align="center"><a class="whiteMedium"
					href="javascript:loadOverTime('Z')">Z</a></div></td>
        </tr>
      </table>    
  <tr>
    <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"  id="submit2" 	type="submit" onClick=Add() value="Add"></td>
				<td width="56"><input class="ButtonHead" name="Edit" id="Edit"  type="submit" onClick="return HEdit()" value="Edit"></td>
				<td width="56"><input class="ButtonHead" type="Button" 	name="Button" id="Button"   value="Close"   accesskey="c" 
					onClick="redirect('AttendanceMain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>




<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<html>
<head>

<title> :: COMMON ::</title>

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
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/Staff_AccountNumber_Search.js"></script>
<script language="javascript">
function  Edit()
 	{		
		obj = findObj("staffid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].staffid;
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="StaffAccountNumberAction.jsp";
			document.frm.submit();
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
</script>
  <%@ include file="index.jsp"%>
 

  




<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad= "document.getElementById('bank').focus()">
<form  AUTOCOMPLETE = "off"   method="get" name="frm" > 
 

<table width="100%" height="437" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="17" colspan="6" align="center">
	<tr>
		<td height="80" colspan="6" align="center">
		<table width="90%" height="327" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle" 
			 background="">
				<td height="14" class="boldgre"   > <div align="center" class="whiteMedium">STAFF ACCOUNT INFORMATIONS </div></td>
			</tr>

			
			<tr  >
				<td height="31" align="center" valign="middle"  >
				<table width="50%" border="0" align="center" cellpadding="0"
					cellspacing="2" class="whiteMedium">
					<tr>
					  <td   >BANK </td>
					  <td   ><select name="bank" class="formText135" id="bank"  style="width:170" tabindex="27" onChange="loadStaffAccountNumberSearch('0')"  >
                                    <option value="0">All</option>
                                    <%
                   
                  		String datas[][]= CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME  FROM com_m_bankgroup  ORDER BY CHR_BANKGROUPNAME");
                  		if (datas.length>0){
                  			for (int i=0; i<datas.length; i++) {
								out.println("<option value="+datas[i][0]+">"+datas[i][1]+"</option>");			
                  			}
                  		}
				%>
                                </select></td>
					  <td ><div align="right"><span >Search by Name / ID / Account no</span></div></td>
					  <td   >
					  
					  
					  <input name="searchstaff" id="searchstaff" type="text" class="formText135" size="15" maxlength="10" onKeyUp="LoadSearchStaff( )">  </td>
			        </tr>
			  </table>				</td>
			</tr>
			 
			<tr>
				<td height="21" valign="top" bgcolor="#FFFFFF"> 
				<div id="staffTable" style="OVERFLOW:auto;width:100%;height:300px"></div><br>
				<div id="totalrecord" align="center"></div><br><br>
		</table>
	<tr>
	  <td height="17" colspan="6"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="17" colspan="6">
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign">
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('0')">ALL</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadStaffAccountNumberSearch('Z')">Z</a></div>				</td>
			</tr>
		</table>
		<a href=javascript:; onClick="windowSave('sample.txt')"></a></td>
	</tr>
	<tr>
		<td id="tables" height="5" colspan="6">
	<tr>
		<td height="17" colspan="6">
		  <div align="center">
		    <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			 
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_GEN FROM m_user_privilege WHERE CHR_USRNAME = '"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			 
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect('commonmain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
	      </div></td>
	<tr>
		<td height="17" colspan="6">
		  <%@ include file="../footer.jsp"%>
		 
</table>
</form>
</body>
</html>

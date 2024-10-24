<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
 
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

 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollCessation.js"></script>

<script language="javascript">

 	 

		
	function Add()
 	{		
		document.EmployeeCessationfrm.action="CessationAdd.jsp";		
 	}		
	
	
	
	function Delete()
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
				var reason = prompt("Enter the reason","");
				document.getElementById('reason').value=reason;
				document.EmployeeCessationfrm.action="../SmartLoginAuth?reason="+reason;
				document.EmployeeCessationfrm.submit();
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
	
 	</script>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadCessations('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="EmployeeCessationfrm">
<table width="100%" height="285" align="center">


	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign" 
			 >
			 
			<tr>
				<td   class="bolddeepred">
				<div align="center">
				<%
		String error = ""+request.getParameter("staffid");
		
		if (error.equals("") || error.equals("null"))
		{
		}
		else
		{
			error = "Employee Promotion record is not available in Staffid :: " +error;
			out.println("<font color=red>"+error+"</font>");
			
		}
	%>
				</div>			  </td>
			</tr>
			<tr align="center" valign="middle"  >
				<td height="28"    
					class="tablehead"><span class="whiteMedium">EMPLOYEE CESSATION </span></td>
			</tr>

			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>
					  <td colspan="13" align="center"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="5" class="whiteMedium">
                        <tr>
                          <td >Month</td>
                          <td  ><select name="month" id="month" onChange="loadCessation('0')">
                              <option value="0">All</option>
                              <%@ include file="../JavaScript/months.jsp"%>
                            </select>                          </td>
                          <td  >Year</td>
                          <td  ><select name="year" id="year"  onChange="loadCessation('0')">
                              <%@ include file="../JavaScript/years.jsp"%>
                            </select>
                              <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						 
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                            </script></td>
                          <td>Mode</td>
                          <td>
						  <select id="mode" name="mode" onChange="loadCessation('0')"  >
						  	<option value="0">All</option>
							<option value="D">Direct</option>
							<option value="S">Suspension</option>
							<option value="P">Resigination Post</option>
						  </select></td>
                          <td>NDC Closed </td>
                          <td>
						  <select name="ndc" id="ndc" onChange="loadCessation('0')"  class="formText135" >
                          <option value="0">All</option>
						  <option value="Y">Closed</option>
						  <option value="N">Pending</option>
						  </select>                          </td>
                          <td>Exit Interview </td>
                          <td><select name="exitinterview" id="exitinterview" onChange="loadCessation('0')"  class="formText135" >
                            <option value="0">All</option>
                            <option value="Y">Closed</option>
                            <option value="N">Pending</option>
                          </select></td>
                          <td>Search Id / Name </td>
                          <td><input name="search" type="text" class="formText135" id="search"   onKeyUp="loadCessations('0')" onBlur="loadCessations('0')"></td>
                        </tr>
                      </table></td>
				  </tr>
					
				</table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
				<div id="CessationTable" style="OVERFLOW: auto;width:100%;height:300px"></div>
				 <br>
			  <div id="totRec"></div>	<br>					</td>
		</table>		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="StaffCessation"> <input name="actionS"
			type="hidden" id="actionS" value="PAYStaffCessationDelete">
	    <input type="hidden" name="reason" id="reason"></td>
	</tr>
	<tr>
		<td height="17">
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('0')">All</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('A')">A</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('B')">B</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('C')">C</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('D')">D</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('E')">E</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('F')">F</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('G')">G</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('H')">H</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('I')">I</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('J')">J</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('K')">K</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('L')">L</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('M')">M</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('N')">N</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('O')">O</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('P')">P</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('Q')">Q</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('R')">R</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('S')">S</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('T')">T</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('U')">U</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('V')">V</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('W')">W</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('X')">X</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('Y')">Y</a></div>				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadCessation('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td height="17" align="center">    
  <tr>
	  <td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick=Add() value="Add"></td>
				
				
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
	  
 <td width="56"><input type="submit" class="ButtonHead" name="submit3"   value="Delete"	onClick="return Delete()" /></td>


     	<%
		}
		else
		{
			out.println("<input type='hidden' id='submit3'>");
		}
		%>
		
		
				
				 
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
	  <td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>

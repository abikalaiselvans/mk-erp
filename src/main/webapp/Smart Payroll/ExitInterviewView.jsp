<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
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
<script language="JavaScript" src="../JavaScript/Payroll/PayrollExitInterview.js"></script>
 
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="loadExit('0')">
<form  AUTOCOMPLETE = "off"   method="get" name="frm">
<table width="100%" height="285" align="center">


	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			
			<tr align="center" valign="middle" >
				<td height="28" 
					class="whiteMedium">Exit Interview </td>
			</tr>

			<tr  >
			  <td height="31" align="center" valign="middle" ><table width="866" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <th width="67" scope="col">Office  
				    <%
				  String oficeid=""+session.getAttribute("OFFICEID");
				  %>				  </th>
                  <th width="68" class="bold1" scope="col"><span class="bolddeepblue">
                    <select name="Office" class="formText135" id="Office" onChange="loadExit('0')">
                      <option value="0">All</option>
                      <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
                    </select>
					<script language="javascript">setOptionValue('Office','<%=oficeid%>')</script>
                  </span></th>
                  <th width="49" scope="col">Status</th>
                  <th width="104" scope="col">
				  <select name="status" id="status"  onchange="loadExit('0')">
					<option value="0">All</option>
				  	<option value="Y">Completed</option>
					<option value="N">Pending</option>
				  </select>
				  </th>
                  <th width="49" scope="col">Month  </th>
                  <th width="110" class="bold1" scope="col"><select name="month" id="month" onChange="loadExit('0')"><option value="0">All</option><%@ include file="../JavaScript/months.jsp"%></select></th>
                  <th width="49" scope="col">Year  </th>
                  <th width="73" class="bold1" scope="col"><select name="year" id="year" onChange="loadExit('0')"><option value="0">Select</option><%@ include file="../JavaScript/years.jsp"%></select>
                  <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();					
						setOptionValue('year',year1);	
						setOptionValue('month',month1);							
				//-->
          </script></th>
                  <td width="153">Search Id / Name </td>
                  <td width="144"><input name="search" type="text" class="formText135" id="search"   onKeyUp="loadExits('0')"   ></td>
                </tr>
              </table></td>
		  </tr>
			<tr  >
				<td height="31" align="left" valign="middle" >
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>
						<td align="center">S.NO</td>
						<td align="center">Staff Id</td>
						<td align="center">Staff Name</td>
						<td align='Center'>Company</td>
						<td align='Center'>Branch</td>
						<td align='Center'>Department</td>
						<td align='Center'>Designation</td>
					    <td align='Center'>Status</td>
					    <td align='Center'>Upload</td>
					</tr>
				</table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
			  <div id="CessationTable" style="OVERFLOW: auto;width:100%;height:300px"></div>
			  <br>
			  <div id="totRec"></div>	<br>			</td>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17"><input name="filename" type="hidden"
			id="filename" value="ExitInterview"> <input name="actionS"
			type="hidden" id="actionS" value="PAYExitInterviewDelete"></td>
	</tr>
	<tr>
		<td height="17">
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('0')">All</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('A')">A</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('B')">B</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('C')">C</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('D')">D</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('E')">E</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('F')">F</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('G')">G</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('H')">H</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('I')">I</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('J')">J</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('K')">K</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('L')">L</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('M')">M</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('N')">N</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('O')">O</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('P')">P</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('Q')">Q</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('R')">R</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('S')">S</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('T')">T</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('U')">U</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('V')">V</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('W')">W</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('X')">X</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('Y')">Y</a></div>
				</td>
				<td>
				<div align="center"><a class="whiteMedium" href="javascript:loadExit('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17" align="center">

<center>
<table border="0" cellspacing="1" cellpadding="1">
<tr>
	 
	<td width="56"><input class="ButtonHead" type="Button"	name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
</tr>
</table>
</center>

	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>

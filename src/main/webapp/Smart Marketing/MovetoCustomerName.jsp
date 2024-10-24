<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%
try
{
	String usertypes=""+session.getAttribute("USRTYPE");	

%>


<html>
<head>
<title> :: MARKETING ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Marketing/MovetoCustomerName.js"></script>
 <body onselectstart="return false" onpaste="return false;" onCopy="return false"  onLoad="LoadCustomerGroup('0')" >
<jsp:include page="index.jsp" />

<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	 
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp; </td>
    </tr>
	<tr>
	  <td><div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='5' cellspacing='1'>");
			out.println("<tr>");
				
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'MarketingMain.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="220" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
			  <td height="31"  ><div align="center" class="whiteMedium">Customer MOVE TO INVENTORY
			      
			  </div></td>
		  </tr>
			<tr  >
				<td height="31" align="center" valign="middle"  ><table width="806" border="0" align="center" class="whiteMedium">
				  <tr>
				    <td width="86">Division</td>
				    <td width="403"><span class="boldThirteen">
				      <select name="division" class="formText135" id="division" tabindex="1"  onChange="LoadCustomerGroup('0')" style="width:200">
				        <option value='0'>All</option>
				        <%
						    String deptname= CommonFunctions.QueryExecute("SELECT FIND_A_DEPARTMENT("+session.getAttribute("DEPARTID")+")")[0][0];
							String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,UPPER(CHR_DIVICODE),CHR_DIVISHORTCODE from inv_m_division   WHERE INT_DIVIID >0 ORDER BY CHR_DIVICODE"); 
							for(int u=0; u<division.length; u++)
								if(deptname.equals(division[u][2]))
									out.print("<option selected='selected' value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
								else
									out.print("<option   value='"+division[u][0]+"'>"+division[u][1]  +"</option>");	
                         %>          
			        </select>
				    </span></td>
				    <td width="49">Status</td>
				    <td width="49">
                    <select name="status" id="status"  onChange="LoadCustomerGroup('0')" >
                    <option value="0">All</option>
                    <option value="Y">Moved</option>
                    <option value="N" selected>Pending</option>
			        </select></td>
				    <td width="49">Search</td>
				    <td width="144"><input name="search" type="text" id="search" maxlength="10" onKeyUp="LoadCustomerGroups(this)"></td>
				    
			      </tr>
		      </table></td>
			</tr>
			 
			 
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" 	class="boldEleven">                  </div>
                  <br>
                      <div id ="totRec" align="center"> </div>
                  <br> 
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadCustomerGroup('Z')">Z</a></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="CustomerName" />
      <input type="hidden" name="actionS" value="MKTCustomerNameDelete" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<jsp:include page="../footer.jsp" /></form>
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

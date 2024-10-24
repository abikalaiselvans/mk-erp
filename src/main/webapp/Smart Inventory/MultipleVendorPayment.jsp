<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>


<%
try
{
%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/vendorinfo.js"></script>
<script language="JavaScript">
function Add()
{ 
	document.frm.action="MultipleVendorPaymentBefore.jsp";		
}

 </script>
 
<body    onLoad="loadAllVendors('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table width="90%" height="307" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
          <tr  >
            <td height="31"  ><div align="center" class="whiteMedium">SINGLE CHECK MULTIPLE ENTRY </div></td>
          </tr>
          <tr  >
            <td height="31"  ><table  border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                 
                <td class="whiteMedium">Search by name</td>
                <td><span class="whiteMedium">
                  <input name="search" type="text" class="formText135" id="search" maxlength="10" onKeyUp="loadAllVendor()" >
                </span></td>
                 
              </tr>
            </table></td>
          </tr>
          
 
          <tr class="MRow1">
            <td height="127" valign="top" class="footermenu">
			
						<div id="CustomerTable" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"></div>	
						<br><br><div align="center" id="totRec"></div>	<br>	<br>						</td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td> <table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
	    <tr class="para">
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('0')">ALL</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('A')">A</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('B')">B</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('C')">C</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('D')">D</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('E')">E</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('F')">F</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('G')">G</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('H')">H</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('I')">I</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('J')">J</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('K')">K</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('L')">L</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('M')">M</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('N')">N</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('O')">O</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('P')">P</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('Q')">Q</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('R')">R</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('S')">S</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('T')">T</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('U')">U</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('V')">V</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('W')">W</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('X')">X</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('Y')">Y</a></div></td>
	      <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:loadAllVendors('Z')">Z</a></div></td>
	      </tr>
      </table></td>
    </tr>
	 
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td height="32"> <div align="center">
        <%
			out.println("<table   border='0' align='center' cellpadding='1' cellspacing='1'>");
			out.println("<tr>");
			 
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_ADD_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='Add()' name='action1' id='action1' value='Add'>");
			else	
				out.println("<input type='hidden' name='action1' id='action1' value='Add'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
			out.println("</td>");
			
			out.println("</tr>");	
			out.println("</table>");
			
			%>
      </div></td>
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

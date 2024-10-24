 <%@ page  language="java" 	import="java.sql.*"  %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 

<%
try
{
%>
<%@include file="Redirect.jsp" %>

 

<html>
<head>
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

 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/staff/Customerinfo.js"></script>

<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="SFACustomerInformationsActions.jsp";
 	}

	function GEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			document.frm.action="SFACustomerInformationsActions.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	 
 </script>
<body  onpaste="return false;" onLoad="LoadCustomerinfos('0')"   >
 <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="get" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
	  <td><table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="31"  ><div align="center">CUSTOMER INFORMATION </div></td>
        </tr>
        <tr  >
          <td height="31" align="center" valign="middle"  ><table width="597" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
              <tr>
                <td>Group</td>
                <td><select name="group" class="formText135" id="group" onChange="LoadCustomerinfos('0')" >
                    <option value="0">All</option>
                    <%
			  String sdata[][] =  CommonFunctions.QueryExecute(" SELECT INT_GROUPID,CHR_GROUPNAME FROM  mkt_m_customergroup ORDER BY CHR_GROUPNAME ");
			  for(int u=0;u<sdata.length;u++)
			  	out.println("<option value='"+sdata[u][0]+"'>"+sdata[u][1]+"</option>");
			  %>
                  </select>                </td>
                
                <td>Verified </td>
                <td> <select name="verified" id="verified" onChange="LoadCustomerinfos('0')">
                <option value="0">All</option>
                <option value="Y">Verified</option>
                <option value="N">Not verified</option>
                </select></td>
                <td>Status</td>
                <td>
                <select name="status" id="status" onChange="LoadCustomerinfos('0')">
                <option value="0">All</option>
                <option value="Y">Active</option>
                <option value="N">Inactive</option>
                </select>
                </td>
                <td>Search</td>
                <td><input name="search" type="text" id="search" maxlength="10" onKeyUp="LoadCustomerinfo(this)"></td>
                </tr>
          </table></td>
        </tr>
        <tr class="MRow1">
          <td class="bolddeepblue"><div id="GroupTable" style="OVERFLOW:auto;width:100%;height:300px" class="boldEleven"></div>
              <br>
            <div id="totalrec"></div></td>
        </tr>
        
	    <tr>        </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadCustomerinfos('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
	    <input type="hidden" name="filename" value="CustomerInfo" />
        <input type="hidden" name="actionS" value="MKTCustomerInfoDelete" />
      </span></td>
    </tr>
	<tr>
		<td><table   border="0" align="center" cellpadding="1"
			cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td valign="top"><input type="Submit" class="ButtonHead" name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td  valign="top"><input type="submit"
					class="ButtonHead" name="Edit" id="Edit" value="Edit"  
					onclick="return GEdit()" /></td>
          
 
            <td><input type="Button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')" /></td>
          </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
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

<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>

<%
try
{
%>
<html>
<head>
<title> :: AMC ::</title><style type="text/css">
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/AMC/ServiceItems.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceItemsAction.jsp";
 	}
	
	function IEdit()
 	{		 
		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}

		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceItemsAction.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		
 	}	
 	
	
	function Delete()
 	{		
		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}

		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
 	
	function PageBack()
	{
	     //future enhancement
    }
 	
	
  function Validate()
  {
    if(checkNullSelect("company","Select the Company","select"))
		return true;
	else
		return false;		
  }	
  
</script>
<body   onLoad="LoadServiceItems('0')">
<%@ include file="index.jsp"%>

   <form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>
	 
	  	  <table width="90%" height="176" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr >
          <td height="22" ><div align="center"><span class="whiteMedium"><strong> SERVICE ITEMS </strong></span></div>
              <div align="right"></div></td>
        </tr>
        <tr >
          <td height="25" >
	
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
			<tr  >
  				<td   ><b>S.No</b></td>
    			<td   ><b>NAME</b></td>
			</tr> 
		  </table>		  </td>
        </tr>
        <tr class="MRow1">
          <td height="127" valign="top" class="footermenu">
		  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" 	class="boldEleven"> </div>
		  <br>
		  <div align="center" id="totRec"></div>
		  <br>
		   </td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td>	  </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('0')">All</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('A')">A</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('B')">B</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('C')">C</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('D')">D</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('E')">E</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('F')">F</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('G')">G</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('H')">H</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('I')">I</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('J')">J</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('K')">K</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('L')">L</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('M')">M</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('N')">N</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('O')">O</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('P')">P</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('Q')">Q</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('R')">R</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('S')">S</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('T')">T</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('U')">U</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('V')">V</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('W')">W</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('X')">X</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('Y')">Y</a></div></td>
          <td ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceItems('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="10"><input name="filename" type="hidden" value="ServiceItem" />
        <input name="actionS" type="hidden" value="AMCServiceItemDelete" /></td>
    </tr>
    <tr>
      <td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Edit" id="Edit" value="Edit"
					onclick="return IEdit()" /></td>
         <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit" id="Submit" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
		
          <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AMCmain.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
  </form>

<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>
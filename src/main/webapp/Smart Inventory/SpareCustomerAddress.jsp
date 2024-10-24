<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 

<%
try
{
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Inventory/SpareCustomerAddress.js"></script>

<script language="JavaScript">
	function Add()
	{
		document.frm.action="SpareCustomerAddressAction.jsp";
	}
 	function Edit()
	{	
		
		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}	
		
		var chkbox=document.forms[0].rowid;
		var len=0;
		var ch=0;
		for(i=0;i<chkbox.length;i++)
		{
			if(chkbox[i].checked)
			{
				len++;
			}
		}
			if(len>1)
			{
				alert("Select Only One Value");
				return false;
			}
			else if(len==0)
			{
				if(chkbox.checked)
				{
					document.frm.action="SpareCustomerAddressAction.jsp";
					return true;
				}
				else
				{
					alert("Select Any One Value");
					return false;
				}
			}
			else
			{
				document.frm.action="SpareCustomerAddressAction.jsp";
				return true;
			}
	}
 	function Delete()
	{

		obj = findObj("rowid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}	
	var chkbox=document.forms[0].rowid;
	var len=0;
	for(i=0;i<chkbox.length;i++)
	{
		if(chkbox[i].checked)
		{
			len++;
		}
	}

	if(len==0)
	{
		if(chkbox.checked)
		{
			document.frm.action="../SmartLoginAuth";
			return true;
		}
		else
		{
			alert("Select Any One Value");
			return false;
		}
	}
	else if(len>=1)
	{
		var name=confirm("Confirm to Delete?");
		if(name == true)
		{
				document.frm.action="../SmartLoginAuth";
				return true;
		}
		else
		{
			return false;
		}
	}	
}
  function mainPage()
  {
    document.frm.action="InventoryMain.jsp";
  }
 	
</script>
<body onLoad="LoadSpareCustomerAddress('0')" >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
<table width="100%" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	 
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="290" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td  >
			  <div align="center" class="whiteHead">SPARE CUSTOMER ADDRESS</div>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				  <table width="471" border="0">
				    <tr>
				      <td class="whiteMedium">Customer Name</td>
				      <td><span class="boldEleven">
				        <select name="customer" class="formText135" id="customer" style="width:200" onChange="LoadSpareCustomerAddress('0')">
				          <option value="0" selected>All</option>
				          <%
String	customerData[][]= CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME  FROM inv_m_sparecustomer   ORDER BY CHR_CUSTOMERNAME");
for(int u=0;u<customerData.length;u++)
	out.println("<option value='"+customerData[u][0]+"'>"+customerData[u][1]+"</option>");
				%>
			          </select>
				      </span></td>
			        </tr>
			      </table>
			  </div>				</td>
			</tr>
			<tr height="20">
				<td colspan=2>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 <div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px" 	class="boldEleven">
                  </div>
                  <br>
                      <div id ="totRec" align="center"> </div>
                  <br> 
		  <tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>
		  <table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
            <tr class="para">
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('0')">All</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('A')">A</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('B')">B</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('C')">C</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('D')">D</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('E')">E</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('F')">F</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('G')">G</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('H')">H</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('I')">I</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('J')">J</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('K')">K</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('L')">L</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('M')">M</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('N')">N</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('O')">O</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('P')">P</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('Q')">Q</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('R')">R</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('S')">S</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('T')">T</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('U')">U</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('V')">V</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('W')">W</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('X')">X</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('Y')">Y</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadSpareCustomerAddress('Z')">Z</a></div></td>
            </tr>
          </table></td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="SpareCustomerAddress" /> 
	  <input
			type="hidden" name="actionS" value="INVSpareCustomerAddressDelete" /></td>
	</tr>
	<tr>
	  <td><div align="center">
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
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_EDIT_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
			 out.println("<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Edit'>");
			else	
				out.println("<input type='hidden'  name='Edit' id='Edit' value='Edit'>");
			out.println("</td>");
			
			out.println("<td ' valign='top'>");
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_DELETE_INV FROM m_user_privilege WHERE CHR_USRNAME ='"+session.getAttribute("USRID").toString()+"'")[0][0]))
				out.println("<input class='ButtonHead' type='submit' onClick='return  Delete()' name='Submit' id='Submit' value='Delete'>");
			else	
				out.println("<input type='hidden'  name='Delete' id='Delete' value='Delete'>");
			out.println("</td>");	
			
			out.println("<td ' valign='top'>");
			out.println("<input type='button' class='ButtonHead' name='Button' value='Close' onClick=\"redirect( 'InventoryMains.jsp')\" />");
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
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
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

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
<!-- TemplateBeginEditable name="doctitle" -->
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Inventory/itemgroup.js"></script>

<script language="JavaScript">
	function Add()
	{
		document.frm.action="ItemGroupAction.jsp";
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
					document.frm.action="ItemGroupAction.jsp";
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
				document.frm.action="ItemGroupAction.jsp";
				return true;
			}
	}
	
function RDelete()
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
<body onLoad="LoadItemGroup('0')" >
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
		<table width="843" height="281" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="boldThirteen">ITEM GROUP </div>				</td>
			</tr>
			<tr  >
				<td height="20"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="whiteMedium">
					<tr  >
						<td width="8%"  ><div align="center">S.No</div></td>
						<td width="92%"> <div align="center">GROUPNAME</div></td>
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
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('0')">All</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('A')">A</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('B')">B</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('C')">C</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('D')">D</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('E')">E</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('F')">F</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('G')">G</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('H')">H</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('I')">I</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('J')">J</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('K')">K</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('L')">L</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('M')">M</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('N')">N</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('O')">O</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('P')">P</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('Q')">Q</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('R')">R</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('S')">S</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('T')">T</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('U')">U</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('V')">V</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('W')">W</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('X')">X</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('Y')">Y</a></div></td>
              <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadItemGroup('Z')">Z</a></div></td>
            </tr>
          </table></td>
	</tr>
	<tr>
		<td> <input name="filename" type="hidden" value="ItemGroup" />
          <input
			name="actionS" type="hidden" value="INVItemGroupDelete" /></td>
	</tr>
	<tr>
		<td>
		  <div align="center">
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
				out.println("<input class='ButtonHead' type='submit' onClick='return  RDelete()' name='Submit' id='Submit' value='Delete'>");
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

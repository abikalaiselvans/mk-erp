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
<script language="javascript" src="../JavaScript/Inventory/Model.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ModelAction.jsp";
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
					document.frm.action="ModelAction.jsp";
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
				document.frm.action="ModelAction.jsp";
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
 	

 	
  
 	
</script>
<body onLoad="LoadModel('0')" >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
<table width="100%" height="150" border="0" cellpadding="2"
	cellspacing="2">
	 
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="boldThirteen">BRAND</div>				</td>
			</tr>
		 
			
			<tr class="MRow1">
				<td>
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:200px" 	class="boldEleven">
                  </div>
                  <br>
                      <div id ="totRec" align="center"> </div>
                  <br>            
				   </td>
			<tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('0')">All</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('A')">A</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('B')">B</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('C')">C</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('D')">D</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('E')">E</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('F')">F</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('G')">G</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('H')">H</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('I')">I</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('J')">J</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('K')">K</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('L')">L</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('M')">M</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('N')">N</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('O')">O</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('P')">P</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('Q')">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('R')">R</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('S')">S</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('T')">T</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('U')">U</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('V')">V</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('W')">W</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('X')">X</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('Y')">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a class="whiteMedium" href="javascript:LoadModel('Z')">Z</a></div></td>
        </tr>
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Model" /> <input
			type="hidden" name="actionS" value="INVmodelDelete" /></td>
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
<%
}
catch(Exception e)
{
}

%>
<%@ include file="../footer.jsp"%>
</body>
</html>

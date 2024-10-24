<%@ page language="java"	import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<%@ page import="com.my.org.erp.SmartInventory.Model"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 

<title>:: ASSET ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="JavaScript" src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ItemGroupAction.jsp";
 	}

	function Edit()
	{	
		var chkbox=document.forms[0].optprogroupid;
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
 	function Delete()
	{

	var chkbox=document.forms[0].optprogroupid;
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
<body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="get">
<table width="100%" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
 	 
 %>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="200" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="boldThirteen">ITEM GROUP </div>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr  >
						<td width="36" class="bold1">
						<div align="center"></div>						</td>
						<td width="274">
						<div align="left" class="whiteMedium">Group Name</div>					  </td>
						<td class="bold1">&nbsp;</td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" class="boldEleven">
						<%
		  	try
			{ 
			String query ="";
			String req =""+request.getParameter("startLetter") ;
			if("null".equals(req) || "AL".equals(req) || "".equals(req))
				query ="SELECT INT_ITEMGROUPID,CHR_GROUPNAME FROM asset_m_itemgroup ORDER BY CHR_GROUPNAME  ";
			else 
				query = " SELECT INT_ITEMGROUPID,CHR_GROUPNAME FROM asset_m_itemgroup WHERE CHR_GROUPNAME LIKE '"+req+"%'   ORDER BY CHR_GROUPNAME ";
			 
			String tableData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(query);
			out.print("<table width='98%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			boolean bgflag = false;
			String branch ="";
			String sql ="";
			String active="";
			if(tableData.length >0)
			{
			 	for(int u=0; u<tableData.length; u++)
			 	{
					if(bgflag)
					{
						bgflag = false;
						out.print("<tr class='MRow1'>");
					}
					else
					{
						bgflag = true;
						out.print("<tr  class='MRow2'>");
					}				
				out.print("<td width='10' class='boldEleven' align='left'><input name='optprogroupid' type='checkbox' value='"+tableData[u][0].trim()+"'> </div></td>");
				out.print("<td width='274' class='boldEleven' align='left'>"+tableData[u][1]);
				out.print("</tr>");
			  }	
			 }
			 else
			 {
			 	out.println("<tr  class='MRow2'><td height=100><font color =red><center>Record not found ... "+req+"</center></font>");
			 } 
			out.print("</table>");
			 }
			 catch(Exception e)
			 {
			 }
		  %>
						</div>
						<br />
						<div align="center"><font color='red'>Total no of Records :: <%=com.my.org.erp.common.CommonInfo.intRecordCount("SELECT count(*) FROM inv_m_itemgroup")%></font></div>
						<br />			  </td>
		  </tr>
		  </table>	  </td>
  </tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td class="boldEleven"><div align="center"><a class="whiteMedium" 
					href="ItemgroupView.jsp?startLetter=null">All</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=A">A</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=B">B</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=C">C</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=D">D</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=E">E</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=F">F</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=G">G</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=H">H</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=I">I</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=J">J</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=K">K</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=L">L</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=M">M</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=N">N</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=O">O</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=P">P</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=Q">Q</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=R">R</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=S">S</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=T">T</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=U">U</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=V">V</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=W">W</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=X">X</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=Y">Y</a></div></td>
          <td class="boldEleven"><div align="center"><a  class="whiteMedium" href="ItemgroupView.jsp?startLetter=Z">Z</a></div></td>
        </tr>
      </table></td>
  </tr>
	<tr>
	  <td><input name="filename" type="hidden" value="ItemGroup" />
        <input
			name="actionS" type="hidden" value="ASSAssetGroupDelete" /></td>
  </tr>
	<tr>
	  <td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onclick=" Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick=" return Edit()" /></td>
         
		 <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>

 
          <td width="56"><input name="Close" type="button"
					class="ButtonHead" id="Close"  value="Close"   accesskey="c" 
					onclick="redirect('Assetmain.jsp')" /></td>
        </tr>
      </table></td>
  </tr>
</table>
		</td>
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
%> <%@ include file="../footer.jsp"%>
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

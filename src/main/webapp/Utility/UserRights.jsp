<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%
	Connection con ;
	Statement st=null; 
	ResultSet rs; 
	String str=null;
%>
<html>
<head>

<title> :: UTILITY :: </title>


 

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript">
function formAction()
{
  if( checkNull('ename','Select Employee Name') &&  checkNullSelect('Rights','Select Rights','0'))
    	return true;
  else
  	return false
		
}
 
</script>
<body  onpaste="return false;" topmargin="0" leftmargin="0" onLoad="init()"><br>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	 
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		<form name="a" method="post" action="ApplyRights.jsp" onSubmit="return formAction()">

		<table width="42%" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="405" valign="top">

					<table width="390" height="25" border="0" align="center"
						 >
						<tr>
							<td height="30" align="center"
								class="BackGround">User Rights</td>
						</tr>
						<tr>
						  <td valign="middle" class="tabledata"><div align="center">
						    <%@ include
										file="../JavaScript/ajax.jsp"%>
					      </div></td>
					  </tr>
						<tr>
						  <td valign="middle" class="tabledata">
						  
						  <div align="center"></div>						  </td>
					  </tr>
						<tr>
						  <td valign="middle" class="tabledata"><table width="310" border="0" align="center" cellpadding="5" cellspacing="5">
                            <tr>
                              <td class="boldEleven">Select Module <span class="errormessage">*</span></td>
                              <td>
							  
<select name="Rights" class="formText135"  id="Rights" style="width:150;">
<option value="0">Select Module</option>
<%
String sql="SELECT CHR_SHORTNAME,CHR_MODULE FROM   m_projectmodule  WHERE CHR_STATUS='Y' ORDER BY CHR_MODULE";
String data[][]= CommonFunctions.QueryExecute(sql);
for(int u=0;u<data.length;u++)
	out.println("<option value='"+data[u][0]+"'>"+data[u][1]+"</option>");
%>
</select>

							  </td>
                            </tr>
                          </table></td>
					  </tr>
						<tr>
						  <td valign="middle" class="tabledata"> </td>
					  </tr>
						<tr>
							<td valign="middle" class="tabledata">
							<table align="center">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"     >									</td>
									<td width="56"><input name="Button" type="button"
										class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
					</table>					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
				  <td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"></td>
				</tr>
			</tbody>
		</table>
		</form>
		
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="155">&nbsp;</td>
	</tr>
	 
</table>

</body>
</html>

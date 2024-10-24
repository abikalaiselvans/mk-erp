<%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.*"%>
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


 
</head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript">
function formAction()
{
  if( SEdit()  )
    	return true;
  else
  	return false
		
}


 function SEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Rights
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
			if (document.forms[0].Rights.checked) { count=1;}
		}
		if(count>=1)
		{			
			 
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}
	
		 
</script>
<form name="a" method="post" action="ApplyOfficeRights.jsp" onSubmit="return formAction()">
<body  onpaste="return false;" topmargin="0" leftmargin="0"  ><br>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	 
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
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
								class="BackGround">USER OFFICE 
								<%
						 String pdata[][]=  CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICELIST FROM com_m_staff a,m_user b WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID='"+request.getParameter("ename")+"'");
						  %>
						  </td>
						</tr>
						<tr>
						  <td valign="middle" class="tabledata"><div align="center">
						     </td>
					  </tr>
						<tr>
						  <td valign="middle" class="tabledata">
						 
						  
						  <div align="center" class="boldgre">
						    <div align="center">USER ID/NAME :: <%=pdata[0][0]%> / <%=pdata[0][1]%> 
						      <input name="ename" type="hidden" id="ename" value="<%=pdata[0][0]%>"> 
						    </div>
						  </div>						  </td>
					  </tr>
						<tr>
						  <td valign="middle" class="tabledata"><div align="center">
						    <%
			
			
			String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE  a.CHR_EMPID='"+request.getParameter("ename")+"' ")[0][0]+" )");
			
			 
			
			
			out.println("<table width='239' border='0' align='center' cellpadding='0' cellspacing='0'>");
			out.println("<tr><td colspan='2' class='boldEleven'><div align='center'>Set Rights To:</div></td></tr>");
			String sql="SELECT INT_OFFICEID,CHR_OFFICENAME FROM    com_m_office   ORDER BY CHR_OFFICENAME";
			String data[][]= CommonFunctions.QueryExecute(sql);
			String check=" ";
			
			for(int u=0;u<data.length;u++)
			{
				check="";
				if(OfficeData.length>0)
				{
					for(int j=0;j<OfficeData.length;j++)
					{
						if(data[u][0].equals(OfficeData[j][0]))
							check=" checked = 'checked' ";
					}
				}		
				out.println("<tr>");	
				out.println("<td width='21' class='boldEleven'><input "+check+" type='checkbox' value='"+data[u][0]+"' name='Rights'  id='Rights'></td>");
				out.println("<td width='204' class='boldEleven'>"+data[u][1]+"</td>");
				check="";
			}							
			out.println(" </table>");
		%>
					      </div></td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="155">&nbsp;</td>
	</tr>
	 
</table>
</form>
</body>
</html>

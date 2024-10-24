<%@ page import="java.io.*,java.util.*"%>
<%
	try
 	{
%>
		
<html>
<head>
<title></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/SmartCommon/CommonAjax.js"> </script>
<style type="text/css">
<!--
	a:visited {
			color: #663366;
			}
	a:hover {
			color: #FF0000;
			}
	a:active {
			color: #0000FF;
			}
-->
</style>
<script language="javascript">
 function validate()
  {
  	if(	checkNull('name','Enter  Fuel Type')	)
		return true;
	else
		return false;
		
  }
  
 function upperMe(field)
  {
  		field.value=field.value.toUpperCase();
  }    
  
  </script>
<style type="text/css">
<!--
.style11 {color: #FF0000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ include file="index.jsp"%>
<body  onpaste="return false;"   onLoad="document.frm.name.focus()">
<form  AUTOCOMPLETE = "off"   method="get" name='frm' action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="80">
		<% 
		 String fuelname,sql;
		 String msg,action,actionS;
		 String fuelid="";
		 		 		  
				msg=""+request.getParameter("msg");	
				action=""+request.getParameter("action1");
				
				if(action.equals("Add"))
				{
					
					actionS="TRSFuelAdd";
					fuelname="";
					
				}
				else
				{
					fuelid=request.getParameter("id");	
					actionS="TRSFuelEdit";
					sql="SELECT INT_FUELTYPEID,CHR_FUELTYPENAME FROM   veh_m_fueltype  WHERE INT_FUELTYPEID="+fuelid;
					String	readData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					fuelid=readData[0][0];
					fuelname=readData[0][1];
			  }
		 
		
%>
		</td>
	</tr>
	<tr>
		<td align="center">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0">  </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6">  </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1">  </td>
					<td width="6">  </td>
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="437" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
						<tr>
                    <td height="16" colspan="3" align="center" valign="top" class="boldThirteen">FUEL TYPE </td>
                  </tr>
					<tr>
                    <td height="19" colspan="3" align="right" valign="top"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span> </span> </td>
					</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td width="186"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="29" valign="middle" class="bolddeepblue">Fuel Type <span class="bolddeepred">*</span></td>
								<td width="246" valign="top">
<input name="name" 	type="text" class="formText135" id="name" onBlur="TxtTrim(this)" 	onKeyPress="charOnly('name','25')"  
value="<%=fuelname %>" size="35">
 							  </td>
							</tr>
							<tr class="bolddeepblue">
								<td height="29" valign="middle" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="30" colspan="3" valign="top"><input
									type="hidden" name="filename" value="FuelType" /> <input
									type="hidden" name="actionS" value="<%=actionS %>" /> <input
									type="hidden" name="id" value="<%=fuelid %>" />  
									
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="submit" type="submit"
											id="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
										<td width="56">
										<div align="center"><input name="button" type="button"
											class="buttonbold"  value="Close"   accesskey="c" 
											onClick="redirect('Fueltype.jsp')">
										</div>										</td>
									</tr>
								</table>
							<td width="2">							</tr>
						</tbody>
					</table>
					</td>
					<td nowrap="nowrap" width="4">  </td>
					<td class="BorderLine" width="1">  </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6">  </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0">  </td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	<td>
	<br><br>
	<%
	try
	{
		 	if(!msg.equals("0") && !msg.equals("null"))
		 	{
				 out.println("<table id='table' width='200' border='1' align='center' cellpadding='1' ");
				 out.println("cellspacing='0' bordercolor='#570CD3'> <td>");
				 out.println("<td align='center' class='boldEleven'><b><font color='green'>"+msg+"</td>");
				 out.println("</tr>");
				 out.println("</table>");
	 		}	
	 }
	 catch(NullPointerException e) 
	 {
	 
	 }
	 
     %>
     <br>
	</td>
	</tr>
	 
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
 </form>
</body>
</html>

<%
	}
	catch(Exception ex)
	{
		out.println(ex.getMessage());
	}  
		 
 %>

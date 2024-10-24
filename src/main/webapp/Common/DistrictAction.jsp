<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.bean.District"%>

<%!
	String stateName,statId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/AJAX.js"> </script>
<script language="javascript">

function sett()
{
	document.frmState.stateId.focus();
	
}
function validate()
  {
  	if(checkNullSelect("stateId", "Select the State", "select") && checkNull('TxtDistrictName','Enter District Name'))
  		return true;
  	else
  		return false;  	
  }
</script>
<link href="../Styles/styles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {
	color: #FF0000
}
-->
</style>
</head>
<%
	ArrayList stateList=(ArrayList)session.getAttribute("disstateList");
	int totalRecord=stateList.size();	 		
%>

<body onpaste="return false;" onLoad="sett()">
<form AUTOCOMPLETE="off" method="post" name='frmState'
	action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="insert.jsp"%> <% 
  		String action=request.getParameter("action1");    
		statId=request.getParameter("state");
		if(action.equals("Edit"))
		{
		 	actionStu="ATTdistrictEdit";
		 	districtId=request.getParameter("districtId");		
		 	String query="select INT_STATEID,INT_DISTRICTID,CHR_DISTRICT,CHR_DISTRICTDES from  com_m_district  where INT_DISTRICTID="+Integer.parseInt(districtId);
			String tableData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(query);
			districtName=tableData[0][2];
			districtDes=tableData[0][3]; 
   		}
		else
		{
			actionStu="COMdistrictAdd";
			districtName="";	
			districtDes="";	
	}	 	
	
	%>
		</td>
	</tr>
	<tr>
		<td height="92">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">


					<table width="425" border="0" align="center" cellpadding="2"
						cellspacing="2" class="bolddeepblue">

						<tr align="center" valign="middle">


							<td height="29" align="left" valign="middle" class="bolddeepblue">State
							</td>
							<td height="28" align="left"><select name="stateId"
								id="stateId" class="boldEleven">
								<option value="select">Select</option>
								<%
		         for(int i=0;i<totalRecord;i++)
 	 			 {
		 	 	 	com.my.org.erp.bean.State state=(com.my.org.erp.bean.State)stateList.get(i);
 

					if (action.equals("Edit")){
						if (request.getParameter("state").equals(String.valueOf(state.getStateId()))){
							out.println("<option value='"+state.getStateId()+"' selected>"+state.getStateName()+"</option>");
						}
						else	
							out.println("<option value='"+state.getStateId()+"'>"+state.getStateName()+"</option>");
					}else
						out.println("<option value='"+state.getStateId()+"'>"+state.getStateName()+"</option>");
 	 			 }
		        String dis="";
        		if(stateList.size()==0) dis="disabled='disabled'";
		 		%>
							</select></td>
						</tr>
						<tr class="bolddeepblue">
							<td width="150" height="29" valign="middle" class="bolddeepblue">District
							Name <span class="style3">* </span></td>
							<td width="246" valign="top"><input name="TxtDistrictName"
								type="text" class="tabledata" id="district"
								onKeyUp="upperMe(this), LoadUniqueCheck('district', 'dis', 'com_m_district', 'CHR_DISTRICT', 'submit')"
								onKeyPress="charOnly('TxtDistrictName','30')"
								value="<%= districtName %>" size="35" maxlength="25">
							<div id="dis"></div>
							</td>
						</tr>
						<tr>
							<td height="29" valign="top" class="bolddeepblue">Description</td>
							<td valign="top"><textarea name="TxtDistrictDes" cols="35"
								rows="5" class="tabledata"><%= districtDes%></textarea></td>
						</tr>
						<tr>
							<td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="hidden" name="filename" value="District"> <input
								type="hidden" name="actionS" value="<%=actionStu %>"> <!--             <input type="hidden" name="stateId" value="stateId ">  -->

							<input type="hidden" name="districtId" value="<%= districtId %>">
							<input name="path" type="hidden" value="<%=qp%>">
							<table width="112" align="center" cellpadding="1" cellspacing="1">
								<tr>
									<td width="56" align="center" valign="top"><input
										name="Submit" id="submit" type="submit" class="buttonbold"
										value="Submit" onClick="return validate()"></td>
									<td width="56" valign="top"><input class="buttonbold"
										type="button" name="Submit" value="Close" accesskey="c"
										onClick="redirect('../Common/DistrictView.jsp?&qp=<%=qp %>')"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>

					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
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
		<td height="19">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>

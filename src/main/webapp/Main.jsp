
<script language="javascript" src="JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="JavaScript/Inventory/branches.js"></script>
<script language="javascript" src="JavaScript/comfunction.js"></script>
<script language="javascript">
  function Validate()
  {
	 
	if(	checkNullSelect("office","Select Office","0"))
		return true;	
	else
		return false;			
  } 
 
 
 

</script>

</script>
<html>
<head>
<title>::Smart Inventory::</title>
  <%@ include file="JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	bgcolor="#b7e9ff">
<%@ include file="header.jsp"%>


<center>

<table width=100%>
	<tr>
		<td height="400" align=center>

		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412" valign="top">
					<form action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate()">
					<table width="239" border="0" align="center" cellpadding="5"
						cellspacing="5">
						<tr>
							<td colspan="2" valign="top" class="paramenu"></td>
						</tr>
						<tr>
							<td width="99" valign="top" class="paramenu">
							<div align="right"><input type="hidden" name="filename"
								value="Control" /> <input type="hidden" name="actionS"
								value="INVControlAssign" /> <span class="bold1">Office</span></div>
							</td>
							<td width="113" valign="top" class="paramenu">
							<%
				 	String usertype=""+session.getAttribute("USRTYPE");
					String officename= ""+session.getAttribute("OFFICENAME");
					String officeid= ""+session.getAttribute("OFFICEID");
				 %> <select name="office" class="boldEleven" id="office"
								onChange="LoadBranchess()">
								<option value="0">Select</option>
								<%                  
     				if("F".equals(usertype)) 
					{
						String queryoffice="SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office  ";
     					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
     					for(int i=0;i<officedata.length;i++)
 	 						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
					}
					if("A".equals(usertype)) 
					{
						String queryoffice="SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   WHERE INT_OFFICEID="+officeid;
     					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
     					for(int i=0;i<officedata.length;i++)
 	 						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
					}
					
					
					
 			    	%>
							</select></td>
						</tr>
						<tr>
							<td colspan="2" valign="top" class="paramenu">
							<div id='branchTable'></div>
							</td>
						</tr>

						<tr>
							<td colspan="2" class="paramenu">
							<table width="56" border="0" align="center" cellpadding="0"
								cellspacing="2">
								<tr>
									<td><input name="Submit" type="submit"
										class="buttonbold13" value="Submit"   accesskey="s"   ></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="Image/Smart Inventory/BRCorner.gif" width="7" /></td>
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
		<td><%@ include file="footer.jsp"%></td>
	</tr>
</table>
</center>
</html>

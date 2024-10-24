<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title>:: ASSET ::</title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 <%!	String proGroupName,proGroupId,actionStu;%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

 

<script language="JavaScript">
function validate()
    {
		if(checkNull("TxtproGroup","Enter the  Group Name"))
		{
			return true;			
		}
		else
		{
			return false;
		}	    
 } 
 function mainPage()
 {
 	document.proGroup.action="ProductGroupView.jsp";
 }
 function set()
 {
 	document.getElementById('TxtproGroup').focus(); 
 }
 function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  } 
</script>
<body  onpaste="return false;" leftmargin="0" rightmargin="0" topmargin="0" onLoad="set()">
<form  AUTOCOMPLETE = "off"   name="proGroup" method="post" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<%   
  	String action=request.getParameter("action1");
	proGroupId=request.getParameter("optprogroupid");	
	String value="";
   if(action.equals("Edit")){
		 actionStu="ASSAssetGroupEdit";
		 proGroupId=request.getParameter("optprogroupid");		 
		 String sql ="SELECT CHR_GROUPNAME FROM asset_m_itemgroup   WHERE INT_ITEMGROUPID="+proGroupId;
		 proGroupName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_GROUPNAME" );;				
		 value="Update";
	}else{
		actionStu="ASSAssetGroupAdd";
		proGroupName="";value="Add";				
		
	}	
	%>
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="82">&nbsp;</td>
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
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Item GROUP</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Item Group Name<font
									color="ff0000"> *</font></td>
								<td colspan="2" align="left"><input type="text"
									maxlength="49" name="TxtproGroup" id="TxtproGroup" size="30"
									value="<%=proGroupName%>" onBlur="TxtTrim(this)"
									 >
								 
								</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table border="0" align="center">
									<tr>
										<td width="61"><input type="HIDDEN" name="filename"
											value="ItemGroup"> <input type="HIDDEN"
											name="actionS" value="<%=actionStu %>"> <input
											type="HIDDEN" name="proGroupId" value="<%= proGroupId %>"></td>
										<td width="51"><input name="Submit" type="submit"
											class="buttonbold13" value="<%=value%>"
											onClick="return validate()"></td>
										<td width="56">
										<div align="center"><input name="button" type="button"
											class="buttonbold13"  value="Close"   accesskey="c" 
											onClick="redirect('ItemgroupView.jsp')"></div>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td></td>
							</tr>
						</tbody>

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
		<td height="96">&nbsp;</td>
	</tr>
</table>
<BR>
<BR>
<BR>
<BR>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

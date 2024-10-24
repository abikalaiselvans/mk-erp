
<html>
<head>

<title> :: PAYROLL ::</title>


 


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
 
 
  
		 
	
	
	
function Validate()
{
	
	 
	if(
		 
		 checkNullSelect('empid','Select Staff Name','0') 
		&& checkNull('pfdate','Enter the pfdate')
		&& checkNull('comments','Enter the comments')  
		
		
		)
		return true;
	else
		return false;
}

 
</script>
<%@ include file="index.jsp"%>

<body  onpaste="return false;"  >


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="42">&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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

					<table width="455" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" >PF CLIAM STATUS
							<%
							String rowid = request.getParameter("rowid");
							String sql = " SELECT CHR_EMPID,CHR_STAFFNAME,CHR_PFCLIAMDESCRIPTION,DATE_FORMAT(DAT_PFCLIAMDATE,'%d-%m-%Y') FROM com_m_staff WHERE CHR_EMPID='"+rowid+"' ";
							String rowdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							 
							%>
							
							 </td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="boldEleven">
							Employee id/name </td>
							<td width="178">
							<%=rowdata[0][0]+" / "+rowdata[0][1]%>
							<input name="empid" type="hidden" id="empid" value="<%=rowdata[0][0]%>">
							  </td>
						</tr>
						<tr>
						  <td class="boldEleven">PF Cliam Date </td>
						  <td><input  title="dd/mm/yyyy"   name="pfdate"  id="pfdate" type="text" class="formText135" size="22" maxlength="10" value="<%=rowdata[0][3]%>" />
                                    <a href="javascript:cal2.popup();"> <img src="../JavaScript/img/cal.gif" width="16" border="0" alt="Click here to Pick Up the Date" /></a>
									
									<script language="javascript">
									  
  var cal2=new calendar1(document.forms['frm'].elements['pfdate']);
  cal2.year_scroll=true;
  cal2.time_comp=false; 
   
  
									</script>
									 
									</td>
					  </tr>
						<tr>
							<td class="boldEleven">Comments and suggesstion </td>
                    <td><textarea name="comments" cols="50"
										rows="5" class="formText135" id="comments" tabindex="9" onKeyUp="textArea('comments','2000')"><%=rowdata[0][2]%></textarea></td>
						</tr>
						<tr>
						  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
						  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td><input name="filename" type="hidden" id="filename" value="PFCliamStatus">
                            <input name="actionS" type="hidden" id="actionS" value="PAYPFCliamStatusUpdate"></td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit2" value="Update"></td>
									<td width="56"><input class="buttonbold14" type="Button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('PFCliamStatusView.jsp')"></td>
								</tr>
							</table>
							</div>							</td>
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
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	<tr>
		<td>&nbsp;</td>
</table>
 
<%@ include file="../footer.jsp"%>
</body>

</html>

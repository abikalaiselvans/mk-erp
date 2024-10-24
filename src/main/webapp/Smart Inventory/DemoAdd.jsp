<%@ page import="java.io.*,java.util.*"%>
<html>
<head>
<title>:: INVENTORY ::</title><script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
function validate()
  {
  
  	if(
	 	 checkNull('TxtCustName','Enter the Customer Name')
  		&& checkNull('TxtCustAdd','Enter the Customer Address')
		&& checkNull('TxtDemoDes','Enter the Description')
		&& checkNullSelect('TxtAuthorised',"Select Authorised By","0")
		&& checkNullSelect("TxtHandle","Select  Handle","")  
		 
  	)
  		return true;
  	else
  		return false;  	
  }
</script>



<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 $(function() {
		$( "#fromdt" ).datepicker({ 
		defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			minDate: -5, maxDate: "+5D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
		 
		
		});
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<body >
<form  AUTOCOMPLETE = "off"   method="get" name='frmDemo' action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<td width="415">
					<table cellspacing="2" cellpadding="2" width="409" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td colspan="2" class="boldEleven">
								<div align="center" class="copyright">DEMO</div>
								</td>
							</tr>
							 
							<tr>
								<td width="119" height="29" valign="middle" class="boldEleven">Customer
								Name <font color="#ff0000">*</font></td>
								<td width='276' valign='top'><input
									name="TxtCustName"  type="text" class="formText135" id="TxtCustName"
									 size=30 maxlength="50"></td>
							</tr>
							<tr>
								<td width="119" valign="middle" class="boldEleven"  
									>Date <font color="#ff0000">*</font></td>
								<td width="276"><input name="fromdt" type="text"
									class="formText135" id="fromdt"   readonly="readonly"
									value="" size="15"> 
								  <script
									language='JavaScript'>
		 
			setCurrentDate('fromdt');
		 
	</script></td>
							</tr>
							<tr>
								<td width="119" height="29" valign="top" class="boldEleven">Customer
								Address<font color="#ff0000">*</font></td>
								<td width="276" valign="top"><textarea  id="TxtCustAdd"  name="TxtCustAdd" cols="30"
									rows="5" class="formText135" onKeyPress="textArea('TxtCustAdd','250')"
									 ></textarea></td>
							</tr>
							<tr>
								<td width="119" height="29" valign="top" class="boldEleven">Description<font color="#ff0000">*</font></td>
								<td valign="top"><textarea name="TxtDemoDes"  id="TxtDemoDes"
									cols="30" rows="5" class="formText135"  onKeyPress="textArea('TxtDemoDes','250')"></textarea>
							</tr>

							<tr>
								<td width="119" height="29" valign="middle" class="boldEleven">Authorised
								By <font color="#ff0000">*</font></td>
								<td width='276' valign='top'>
								
								<select name="TxtAuthorised" class="formText135" id="TxtAuthorised"  style="width:200">
                  <option value='0' >Select Authoraised BY</option>
                  <%
		 
			
	String Approved[][] =  CommonFunctions.QueryExecute(" SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE != 'T' AND CHR_REP='Y'");
 if(Approved.length>0)
 	for(int u=0;u<Approved.length;u++)
		out.println("<option value='"+Approved[u][0]+"'>"+Approved[u][0] +" / "+Approved[u][1]+"</option>");
 %>
                </select>
				
								 </td>
							</tr>
							<tr>
								<td width="119" height="29" valign="middle" class="boldEleven">Handled
								By <font color="#ff0000">*</font></td>
								<td width='276' valign='top'>
								
								<select name="TxtHandle" id="TxtHandle" class="formText135" size="5" style="width:250">
                                          <jsp:include page="Staffload.jsp" flush="true" />                                  
                                      </select>
									  
								 </td>
							</tr>
							 
							<tr>
								<td height="29" colspan="2" valign="top" class="boldEleven">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="58"><input type="submit" class="buttonbold13"
											name="Submit" value="Submit"   accesskey="s"    onClick="return validate()"></td>
										<td width="58"><input name="submit" type="button"
											class="buttonbold13" onClick="redirect('Demo.jsp')"
											 value="Close"   accesskey="c" ></td>
									</tr>
								</table>
								</td>
							</tr>
						</tbody>
					</table>
					</td>
					<td nowrap="nowrap" width="1"><spacer height="1" width="1"
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
		<td><input type="hidden" name="filename" value="Demo"> <input
			type="HIDDEN" name="actionS" value="INVdemoAdd"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>

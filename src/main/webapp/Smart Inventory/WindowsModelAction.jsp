<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->
<title>:: INVENTORY ::</title> 
<script language="JavaScript" src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
</head>

<script type="text/javascript">
function valid()
    {
		if(checkNull("ModelCode","Enter the ModelCode"))
			{
			
				return true;			
			}
		else
			{
			
				return false;
			}	    
 	} 
</script>
<body    leftmargin="0" rightmargin="0" topmargin="0" onLoad="set()">
<form  AUTOCOMPLETE = "off"   name="terms" method="get" action="../SmartLoginAuth">


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
							class="boldThirteen">Model</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						<td><!--DWLayoutEmptyCell-->&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" height="17" class="boldEleven">ModelCode<font
							color="ff0000">*</font></td>
						<td><input type="text" name="ModelCode" id="ModelCode"
							size="40" onchange="upperMe(this)"
							onblur="TxtTrim(this), UniqueId('inv_m_model','CHR_MODELCODE','ModelCode')"
							onkeypress="alphaNumeric('ModelCode','25')"
							onkeyup="UniqueId('inv_m_model','CHR_MODELCODE','ModelCode')" />
						<div id="UniqueId"></div>
						</td>
					</tr>
					<tr>
						<td height="17" colspan="3" class="boldEleven"><!-- <div id="model"></div>onKeyUp="UniqueId('inv_m_model','CHR_MODELCODE','ModelCode')"><div id="UniqueId"></div>  -->
						<table border="0" align="center">
							<tr>
								<td width="61"><input type="hidden" name="filename"
									value="Model" /> <input type="hidden" name="actionS" value=" " />
								<input type="hidden" name="ModelId" value=" " /></td>
								<td width="51"><input name="Submit" type="submit"
									class="buttonbold13" value="Submit"   accesskey="s"    onclick="return valid()"></td>
								<td width="56">
								<div align="center"><input name="button" type="submit"
									class="buttonbold13"  value="Close"   accesskey="c"  onclick="mainPage()" /></div>
								</td>
							</tr>
						</table>
						</td>
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

</form>
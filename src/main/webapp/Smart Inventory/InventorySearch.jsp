

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<%@ include file="indexinv.jsp"%>

<script language="javascript" src="../JavaScript/commonAJAX.js"></script>
<script language="javascript">
 
 function check(browser)
  {
  	document.getElementById("tb").value=browser;
	
  }
  function clea()
  {
  	
	document.getElementById("searching").value="";
	document.getElementById("searching").focus();
  }
</script>

</script>
<center>

<table width=100%>
	<tr>
		<td height="20" align=center valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td height="20" align=center valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td height="20" align=center valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td height="20" align=center valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td height="329" align=center valign="top">
		<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">
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
					<td width="412">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center">
							<table width="245" height="18" border="0" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="106"><strong>Search</strong></td>
									<td width="252"><input name="searching" id="searching"
										type="text" class="formText135" size="30" maxlength="50"
										onBlur="LoadSearch('searching')"></td>
								</tr>
							</table>
							<label></label></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="461" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="20" class="boldEleven"><input name="choice"
										type="radio" id="choice" onclick="check(this.value),clea()"
										value="SN"></td>
									<td width="71" class="boldEleven">Staff Name</td>
									<td width="20" class="boldEleven"><input name="choice"
										id="choice" type="radio" value="PD"
										onclick="check(this.value),clea()"></td>
									<td width="77" class="boldEleven">Product Desc</td>
									<td width="20" class="boldEleven"><input name="choice"
										id="choice" type="radio" value="ID"
										onclick="check(this.value),clea()"></td>
									<td width="59" class="boldEleven">Item Desc</td>
									<td width="17" class="boldEleven"><input name="tb" id="tb"
										type="hidden" value=""></td>
									<td width="127">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div id="SearchTable"
								style="OVERFLOW:auto;width:800px;height:160px"></div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">&nbsp;</td>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</center>
</html>

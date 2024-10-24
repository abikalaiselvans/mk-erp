<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title> :: PAYROLL ::</title>


 
</head>

<body  onpaste='return false;'>
<table width="89%" border="0" align="center" cellpadding="0"
	cellspacing="0" bgcolor="#dce4f9" class="BackGround">
	<tbody>
		<tr>
			<td colspan="2" rowspan="2"><img height="7"
				src="../Image/General/TLCorner.gif" width="7" /></td>
			<td class="BorderLine" height="1"><spacer height="1" width="1"
				type="block" /></td>
			<td colspan="2" rowspan="2"><img height="7"
				src="../Image/General/TRCorner.gif" width="7" /></td>
		</tr>
		<tr>
			<td height="6"><spacer height="1" width="1" type="block" /></td>
		</tr>
		<tr>
			<td class="BorderLine" width="1"><spacer height="1" width="1"
				type="block" /></td>
			<td width="6"><spacer height="1" width="1" type="block"></td>
			<td width="851" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="19" colspan="2">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						bordercolor="#336699">
						<tr>
							<td height="279">
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="100%" height="262" valign="top">
									<table width="400" border="0" align="center" cellpadding="1"
										cellspacing="2" bordercolor="#D4D0C8" class="boldEleven">
										<tr>
											<td colspan="2">&nbsp;</td>
										</tr>
										<tr>
											<td colspan="2">
											<div align="center"><span class="tabledata">Personal
											Informations </span></div>
											</td>
										</tr>
										<tr>
											<td width="167">
											<%
											String msg="",empId="",empName="";
    if(msg.equalsIgnoreCase("List"))  {
   	  out.println("<table border='0' width='100%'><tr><td width='40%' class='tabledata' align='center'>Emp Id&nbsp;&nbsp;&nbsp;"+empId 
   	  +"</td><td width='60%' class='tabledata' align='center'>Name&nbsp;&nbsp;&nbsp;"+empName+"</td></tr></table>");
    }
   	%>
											</td>
											<td width="233">&nbsp;</td>
										</tr>
										<tr>
											<td>Staff Id <font class="redcol" align="absmiddle">*</font></td>
											<td><input name="id" type="text" class="formText135"
												id="id" tabindex="1" onkeypress="alphaNumeric('id','25')"
												onkeyup="validateUserId()" size="25" />
											<div id="userIdMessage"></div>
											</td>
										</tr>
										<tr>
											<td>Staff Name<font class="redcol" align="absmiddle">*</font></td>
											<td><input class="formText135" type="text" name="name"
												id="name" size="25" tabindex="2"
												onkeypress="charOnly('name','35')" /></td>
										</tr>
									</table>
									</td>
									<td width="0%" valign="top">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td width="49%" height="19">&nbsp;</td>
					<td width="51%">&nbsp;</td>
				</tr>
				<tr>
					<td height="19" colspan="2">
					<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="0" bordercolor="#336699">
						<tr>
							<td height="210">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="99%" height="210">
									<table width="400" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td height="15" colspan="2" class="tabledata">&nbsp;</td>
										</tr>
										<tr>
											<td height="15" colspan="2" class="tabledata">
											<div align="center">Permanent Address</div>
											</td>
										</tr>
										<tr>
											<td class="boldEleven">&nbsp;</td>
											<td width="231" class="boldEleven">&nbsp;</td>
										</tr>
										<tr>
											<td width="162" class="boldEleven">Address1</td>
											<td class="boldEleven"><input type="text"
												class="formText135" name="padd1" id="ad1" size="25"
												onkeypress="alphaNumeric('ad1','40')" tabindex="1" /></td>
										</tr>
										<tr>
											<td class="boldEleven">Address2</td>
											<td class="boldEleven"><input type="text"
												class="formText135" name="padd2" id="ad2" size="25"
												onkeypress="alphaNumeric('ad2','40')" /></td>
										</tr>
										<tr>
											<td class="boldEleven">City</td>
											<td class="boldEleven"><input name="city1" type="text"
												class="formText135" id="ci" size="25" /></td>
										</tr>
										<tr>
											<td class="boldEleven">State <input type="hidden"
												name="staffid" value="<%="staffid"%>" /></td>
											<td class="boldEleven">
											<table width="150" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><select name="select" id="st1" class="comboWidth">
														<option value="Select">Select</option>
														<%
              
          
	//Loading JDBC Connection Information
	    try
       {      
		/* con = conbean.getConnection();
		pstm = con.prepareStatement(sql_Select_Query);
		rst = pstm.executeQuery();

		while(rst.next())
		{
			out.println("<option>"+rst.getString("chr_STATENAME")+"</option>");		
		} */
       }
       catch(Exception e)
       {
    	   //System.out.println(e);
    	   
    	   
       }

	
%>
													</select></td>
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td class="boldEleven">Pin Code</td>
											<td class="boldEleven"><input name="pin1" type="text"
												class="formText135" id="pc1"
												onkeypress="numericValue('pin1','6')" size="25" /></td>
										</tr>
										<tr>
											<td class="boldEleven">Phone No</td>
											<td class="boldEleven"><input name="phno1" type="text"
												class="formText135" id="ph1"
												onkeypress="numericValue('phno1','10')" size="25" /></td>
										</tr>
									</table>
									</td>
									<td width="1%">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
			<td nowrap="nowrap" width="7"><spacer height="1" width="1"
				type="block" /></td>
			<td class="BorderLine" width="1"><spacer height="1" width="1"
				type="block" /></td>
		</tr>
		<tr>
			<td colspan="2" rowspan="2"><img height="7"
				src="../Image/General/BLCorner.gif" width="7" /></td>
			<td height="6"><spacer height="1" width="1" type="block"></td>
			<td colspan="2" rowspan="2" valign="bottom">
			<div align="right"><img height="7"
				src="../Image/General/BRCorner.gif" width="7" /></div>
			</td>
		</tr>
		<tr>
			<td class="BorderLine" height="1"><spacer height="1" width="1"
				type="block" /></td>
		</tr>
		<tr>
			<td bgcolor="#b7e9ff" colspan="5" height="10"><spacer height="1"
				width="1" type="block" /></td>
		</tr>
	</tbody>
</table>
</body>
</html>

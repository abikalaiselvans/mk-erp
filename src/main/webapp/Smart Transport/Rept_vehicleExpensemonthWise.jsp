 <%@ page import="java.io.*,java.util.*"%>
 		
<html>
<head>
<title> </title>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
 
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<%@ include file="index.jsp"%>
<body  onpaste="return false;" >
<form  AUTOCOMPLETE = "off"   method="post" name='frm' action="Rept_vehicleExpensemonthWiseresponse.jsp" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="80">
		 
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
					<td class="BorderLine" height="0"> </td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"> </td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"> </td>
					<td width="6"> </td>
					<td width="412">
					  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                        <tr>
                          <td colspan="2"><div align="center"><span class="boldThirteen">VEHICLE EXPENSE </span></div></td>
                        </tr>
                        <tr>
                          <td colspan="2"><div align="right"><span class="bolddeepred">* </span><span class="fairyHead"><span class="changePos">- Mandatory</span></span></div></td>
                        </tr>
                        <tr>
                          <td colspan="2"><span class="bolddeepblue">

 
 
                        
 
							
							
                          </span></td>
                        </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td>Month</td>
                          <td><span class="bold1">
                            <select name="Month" class="boldEleven" id="Month" style="width:100"  >
                              <option value="Select">Select</option>
                              <%@ include file="../JavaScript/months.jsp" %>
                            </select>
                          </span></td>
                        </tr>
                        <tr>
                          <td>Year</td>
                          <td><select name="Year" class="boldEleven" id="Year" style="width:100" >
                <!--<option value="Select">Select</option>-->
                <%@ include file="../JavaScript/years.jsp" %>
              </select>
                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Month',month1);
						setOptionValue('Year',year1);							
				//-->
          </script></td>
                        </tr>
                        <tr>
                          <td width="47%">&nbsp;</td>
                          <td width="53%">&nbsp;</td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2"><table border="0" align="center" cellpadding="1" cellspacing="1">
                            <tr>
                              <td width="56"><input name="submit" type="submit"
											id="submit" class="buttonbold" value="Submit"   accesskey="s"   ></td>
                              <td width="56"><div align="center">
                                <input name="button" type="button"
											class="buttonbold"  value="Close"   accesskey="c" 
											onClick="redirect('VehicleReport.jsp')">
                              </div></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table>
					  <p>&nbsp;</p>
				  </td>
					<td nowrap="nowrap" width="4"> </td>
					<td class="BorderLine" width="1"> </td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"> </td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"> </td>
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
 
 
	</td>
	</tr>
	 
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>
 

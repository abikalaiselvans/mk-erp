<%@ page import="java.sql.*,java.io.*,java.util.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>

<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>



<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>



<script language="javascript">
function Validate()
{
	if(checkNull("ename","Select Staff...") && checkNullSelect( "reportType","Select Export Type" ,'0') )
		return true;
	else
		return false;
}
</script>

<title> :: COMMON ::</title>


 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td width="100"></td>
	</tr>
	<tr>
		<td width="100" height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="371">
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
		<table width="598" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="594">&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="591" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block"></td>
							<td width="577" valign="top">
							<table width="577" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2">
									<div align="center" class="boldEleven"><strong>SERVICE CARD </strong></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><font color='red'>* </font><span
										class="changePos">Mandatory</span></div>									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">&nbsp;									</td>
								</tr>

								 
								<tr>
                                  <td width="50%" height="30" class="boldEleven"><div align="right">Export Type <font
																class="bolddeepred" align="absmiddle">*&nbsp;&nbsp;&nbsp; </font></div></td>
								  <td width="50%" class="boldEleven"><script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#reportType").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
                                </script>
                                      <select name="reportType" id="reportType" style="width:170px;" >
                                        <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
                                        <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
                                        <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
                                        <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
                                        <option value="pdf"  selected="selected" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
                                        <option value="rtf"  title="../DropDown - Image/icons/rtf.jpg">Word </option>
                                        <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
                                        <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
                                    </select></td>
							  </tr>
								<tr>
									<td height="19" colspan="2">
									<span class="boldEleven">
									<input name="filename" type="hidden" id="filename"
										value="Rept_JServiceCard">
                                    <input name="actionS"
										type="hidden" id="actionS"
										value="RPTRept_JServiceCard">
                                    <input name="rptfilename" type="hidden" id="rptfilename" value="ServiceCard">
									<input name="subrptfilename1" type="hidden" id="subrptfilename1" value="ServiceCadSub1">
									</span>
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('Rept_Staff.jsp')" /></td>
										</tr>
								  </table>									</td>
								</tr>
							</table>
							</td>
							<td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
							<td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="bottom">
							<div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div>
							</td>
						</tr>
						<tr>
							<td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>

					</tbody>
				</table>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
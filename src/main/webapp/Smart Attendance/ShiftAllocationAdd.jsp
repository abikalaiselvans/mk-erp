<%@ page import="java.sql.*,java.io.*,java.util.*"%>
 
<html>
<head>

<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  { 
   	if(checkNull("ename","Select Staff")   
  	&& checkNullSelect("shift","Select Shift Name ","select")
  	&& checkNull("fromdt","Enter From Date")
  	&& checkNull("todt","Enter To Date")
  	&& checkDate("fromdt","todt")){	
		document.frmState.submit();
		return true;
	}
	return false;
	}
	
	
  function Validate1()
  {
  		if(
				checkNull("fromdt","Enter From Date") 
				&& checkNull("todt","Enter To Date") 
  				&& checkDate("fromdt","todt")
			)
			{
				document.frmState.submit();
				return true;
			}
			return false;
  }
  
   
</script>

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.menuBtn {
	width:100%;
}
.style17 {color: #FF0000}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="post" action="../SmartLoginAuth">
<p>
  <%@ include file="index.jsp"%> 
  <br>
</p>
<p>&nbsp;</p>
<table width="516" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
      <td width="499" height="1" class="BorderLine"><spacer height="1"
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
      <td valign="top"><table width="487" height="207" border="0" align="center" cellpadding="2" cellspacing="2"
						 >
        <tr valign="middle">
          <td height="18" colspan="3" align="center" class="BackGround"
								 >Shift Allocation</td>
        </tr>
        <tr>
          <td height="23" colspan="3" valign="middle" class="bolddeepblue"><div align="right"><font color='red'>* </font><span
										class="changePos">Mandatory</span></div></td>
        </tr>
        <tr>
          <td height="35" colspan="3" valign="middle" class="bolddeepblue"><div align="center">
              <%@ include file="../JavaScript/ajax.jsp"%>
          </div></td>
        </tr>
        <tr>
          <td valign="middle" class="bolddeepblue">&nbsp;</td>
          <td valign="middle" class="bolddeepblue"><strong
								class="bolddeepblue">Shift Name <font color="#ff0000">*</font></strong></td>
          <td height="24" valign="middle"><select name="shift"
								class="tabledata">
              <option value="select">Select</option>
              <%
			  
			   
			  String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SHIFTID,CHR_SHIFTNAME FROM ATT_M_SHIFT ");
			  for(int y=0;y<data.length;y++)
			  	out.println("<option value='"+data[y][0]+"'>"+data[y][1]+"</option>");
            
		
%>
          </select></td>
        </tr>
        <tr>
          <td width="86" valign="middle" class="bolddeepblue">&nbsp;</td>
          <td width="142" valign="middle" class="bolddeepblue">From</td>
          <td width="239" height="24" valign="middle"><input
								name="fromdt" type="text" class="tabledata" id="fromdt"
								onkeypress="dateOnly('fromdt')" value="" size="25">
            <a
								href="javascript:cal1.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
        </tr>
        <tr>
          <td align="left" valign="middle" class="bolddeepblue">&nbsp;</td>
          <td align="left" valign="middle" class="bolddeepblue">To</td>
          <td align="left" valign="middle" height="24"><input
								name="todt" type="text" class="tabledata" id="todt"
								onkeypress="dateOnly('todt')" value="" size="25">
            <a
								href="javascript:cal2.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
        </tr>
        <tr>
          <td colspan="3"><table align="center">
              <tr>
                <td width="56"><input class="buttonbold" type="submit"
										name="Submit" value="Submit"   accesskey="s"    onClick="return Validate()"></td>
                <td width="56"><input name="Submit" type="Button"
										class="buttonbold" onClick="redirect('ShiftAllocation.jsp')"
										 value="Close"   accesskey="c" >
                </tr>
          </table></td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="9"><spacer height="1" width="1"
								type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
    </tr>
  </tbody>
</table>
<br>
<center>

<input type="HIDDEN" name="filename" value="ShiftAllocation"> 
<input type="HIDDEN" name="actionS" value="ATTshiftAdd"> 
<script	language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmState'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;	
			setCurrentDate('fromdt');
			setCurrentDate('todt');							
		//-->
	</script></center>
<br>
<%@ include file="../footer.jsp"%>
</form>
</body>
</html>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript">
function validateFields()
{
  if(checkNull('name','Enter Reminder Name')
  && checkNull('desc','Enter Reminder Description')
  )
  	return true;
  else
  	return false;
}
</script>

   
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<form name="frm" method="post" action="../SmartLoginAuth" 	onsubmit="return validateFields()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	>

<%@ include file="index.jsp"%>
<table width="100%" border="0">
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td><TABLE width=572 border=0 align=center cellPadding=0 cellSpacing=0
					bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/TRCorner.gif" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
              <TD width=8><SPACER height="1" width="1" type="block" /></TD>
              <TD width=554 valign="top"><table width="540" border="0" align="center" cellpadding="0"
								cellspacing="0">
                  <tr>
                    <td width="100%" colspan="2"><div align="center"><span class="tablesubhead">INSURANCE REMINDER
					
	<%   
			String action=""+request.getParameter("submit2");
			String id=""+request.getParameter("id");
			String actionS="";
			String remindername="";
			String reminderdesc="";
			String buttonValue="";
			if(action.equals("Add"))
			{
				actionS="TRSInsuranceReminderAdd";	
				remindername="";
				reminderdesc="";
				buttonValue="Add";	 
				id="0";	 
			}
			else
			{
				String sql ="SELECT CHR_REMINDERNAME,CHR_DESC FROM vehicle_m_insurancereminder   WHERE INT_REMINDERID="+id;
				remindername=com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0];
				reminderdesc=com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][1];			
				actionS="TRSInsuranceReminderEdit";
				buttonValue="Update";
			}	
	%>
	 
					 </span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"><div align="right"><span class="boldElevenlink">* </span><span class="changePos">Mandatory</span></div></td>
                  </tr>
                  <tr>
                    <td colspan="2"></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table width="442" border="0" align="center" cellpadding="3" cellspacing="3">
                      <tr>
                        <td>Reminder Name </td>
                        <td>
<input name="name"  id="name"  type="text" class="formText135" value="<%=remindername%>"   size="52" onKeyUp="upperMe(this), CheckUnique(this,'divn','vehicle_m_insurancereminder', 'CHR_REMINDERNAME' )">
						
						 
								 
								<div id="divn"></div>
						</td>
                      </tr>
                      <tr>
                        <td valign="top">Description</td>
                        <td valign="top"><textarea name="desc" cols="50" rows="10" class="formText135" id="desc" onKeyUp="textArea('desc','2500')"><%=reminderdesc%></textarea></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                        <tr>
                          <td>
		<input name="filename" type="hidden" id="filename" value="InsuranceReminder">
		<input name="id" type="hidden" id="id" value="<%=id%>">
		
        <input name="actionS" type="hidden" id="actionS" value="<%=actionS%>"></td>
                          <td width="56">
<input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="<%=buttonValue%>" tabindex="30" /></td>
                          <td width="56">
<input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('Insurancemaster.jsp')" tabindex="31" />



</td>
                        </tr>
                    </table></td>
                  </tr>
              </table></TD>
              <TD noWrap width=8><SPACER height="1" width="1" type="block" /></TD>
              <TD class=BorderLine width=1><SPACER height="1" width="1"
								type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7
								src="../Image/General/BLCorner.gif" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7
								src="../Image/General/BRCorner.gif" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine height=1><SPACER height="1" width="1"
								type="block" /></TD>
            </TR>
          </TBODY>
        </TABLE></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
   <%@ include file="../footer.jsp"%>
</body>
</form>
</html>

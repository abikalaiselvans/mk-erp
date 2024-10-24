<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>

<%
try
{


 String sesUserId1=""+session.getAttribute("EMPID");
	  
	  
	  if( CommonFunction.RecordExist("SELECT COUNT(*) FROM pay_t_resignationletter WHERE CHR_EMPID='"+sesUserId1+"'"))
	  		response.sendRedirect("error.jsp?error=Already put a resign paper...");
			
	  String repto=(""+CommonFunction.stringGetAnySelectField("select CHR_REPTO from com_m_staff where CHR_EMPID='"+sesUserId1+"'","CHR_REPTO")).trim();
	  if(repto.equals("0"))
		  repto="ADMIN";
	  String resignlimit=(""+CommonFunction.stringGetAnySelectField("select INT_RESIGNATIONLIMIT from m_institution ","INT_RESIGNATIONLIMIT")).trim();
	  String cudate=(DateUtil.getCurrentDBDate());
	  String todate=DateUtil.FormateDateSys(""+CommonFunction.stringGetAnySelectField("select ADDDATE('"+cudate.trim()+"',"+(Integer.parseInt(resignlimit)-1)+" ) as addate","addate")).trim();
	  
	  
%>
<html>
<head>

<title>:: STAFF ::</title>

 

 
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">

function checkResginDate(ctr1,ctr2)
{
   try
   {
		var date1=document.getElementById(ctr1).value;
		var d1=date1.substr(0,2);
		var m1=date1.substr(3,2);
		var y1=date1.substr(6,4);
		var date2=document.getElementById(ctr2).value;
	  
		var d2=date2.substr(0,2);
		var m2=date2.substr(3,2);
		var y2=date2.substr(6,4);
		 
		if(!isNaN(d1) && !isNaN(m1) && !isNaN(y1))
		{
			  if(!isNaN(d2) && !isNaN(m2) && !isNaN(y2))
			  { 
				 if((d1<=d2 && m1==m2 && y1==y2) ||(d1<=d2 && m1<=m2 && y1<=y2) ||
				 (m1<m2 && y1==y2) || (y1<y2) )
				  {
					return true;
				  }
				  else
				  {
					alert(" Resign Date Should Be Greater Than or Equal to "+date1);
					document.getElementById(ctr2).value="";
					document.getElementById(ctr2).focus();
					return false;
				  }
			  }
			  else
			  {
				  alert("Enter Correct Date");
				  document.getElementById(ctr2).value="";
				  document.getElementById(ctr2).focus();
				  return false;
			  }	  
		}
		else
		{
		  alert("Enter Correct Date");
		  document.getElementById(ctr1).value="";
		  document.getElementById(ctr1).focus();
		  return false;
		}
	   }
	   catch(err)
	   {
		  alert(err);
	   }
  }




  function Validate()
  {
  
	//alert(DateCompares ("fromdt","todate", "Resign submit is greather than the "+todate+"Date"));
	if(
		checkNull("fromdt","Enter Resing Date") 
  		&& checkNull("reason","Enter The Reason ") 
  		
		 
		&& checkResginDate("todate","fromdt")
		)
			return true;
		else
			return false;
  }
<%@include file="Redirect.jsp" %>
  
</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {font-size: 12px}
-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	class="body">
<form  AUTOCOMPLETE = "off"   name="frmState" method="get" action="../SmartLoginAuth"
	onsubmit="return Validate()">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	
	<tr>
	  <td>&nbsp;<%
	 
	  
	  %>
	  <input type="hidden" name="repto" id="repto" value="<%= repto %>">
      <input type="hidden" name="todate" id="todate" value="<%= todate %>">
	  </td>
  </tr>
	<tr>
		<td>
		<table width="414" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<!--DWLayoutTable-->
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td width="401" height="1" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td width="1" rowspan="2" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
					<td width="6" rowspan="2"><spacer height="1" width="1"
						type="block"></td>
					<td height="164" valign="top"><table width="386" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
                      <!--DWLayoutTable-->
                      <tr align="center">
                        <td height="25" colspan="2" valign="top" class="tablesubhead">Resignation Letter <span class="bolddeepblue">
                          
                        </span></td>
                      </tr>
                      <tr>
                        <td height="30" valign="middle" class="boldEleven">You can resign on or after </td>
                        <td class="bolddeepred"><%= todate %></td>
                      </tr>
                      <tr>
                        <td width="164" height="30" valign="middle" class="boldEleven">Expected Date of resign </td>
                        <td width="208"><input name="fromdt" type="text" class="formText135"
								id="fromdt" value="<%= todate %>" size="15">
                          <a
								href="javascript:cal1.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
                      </tr>
                      <tr>
                        <td height="67" align="left" valign="top" class="boldEleven">Reason&nbsp;</td>
                        <td align="left" valign="top"><textarea name="reason" cols="25" rows="10" class="formText135" id="reason"></textarea></td>
                      </tr>
                      <tr>
                        <td height="40" colspan="2" align="left" valign="middle"
								class="bolddeepblue"><input
								type="hidden" name="actionS" value="PAYResignationStaff">
                          <input name="filename" type="hidden" id="filename" value="Resignation">
<table width="140" border="0" align="center" cellpadding="2"
								cellspacing="2">
                              <tr>
                                <td width="63"><input name="Submit" type="submit" class="buttonbold"
										value=" Submit "></td>
                                <td width="63"><input class="buttonbold" type="Button" name="Submit2"
										 value="Close"   accesskey="c"  onClick="javascript:history.back();"></td>
                              </tr>
                          </table></td>
                      </tr>
                    </table></td>
					<td width="5" rowspan="2" nowrap="nowrap"><spacer height="1"
						width="1" type="block" /></td>
					<td width="1" rowspan="2" class="BorderLine"><spacer
						height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td height="2"></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>		</td>
	</tr>
	
	<tr>
		<td height="24"><script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmState'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			//setCurrentDate('fromdt');
			
		//-->
	</script></td>
	</tr>
</table>
</form>
</body>
<%
}
catch(Exception e)
{
}
%>
</html>

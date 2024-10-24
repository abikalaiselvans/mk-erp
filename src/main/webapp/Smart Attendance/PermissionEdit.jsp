 <%@ page import="java.sql.*,java.io.*,java.util.*"%>
  <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<jsp:directive.page import="com.my.org.erp.ServiceLogin.DateUtil" />
<%
try
{
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];

%>


<html>
<head>
 
 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
 <script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	var dojlock= "<%=dojlock%>";
	$(function() {
		$( "#fromdt" ).datepicker({ minDate: -dojlock, maxDate: "+8D" });
	});
	
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script language="javascript" src="../JavaScript/JTime/jquery.timePicker.js"></script>
<link href="../JavaScript/JTime/timePicker.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
function Validate()
{
	try
	{
		if( 
			checkNull("fromdt","Enter Date") 
			&& checkNull("int","Enter From Time")
			&& checkNull("out","Enter To Time")
			&& checkPermissionTime('int','out','2')
			&& checkNull("reason","Enter Reason")
			
		)
			return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err)
		return false;
	}		
}
  
 
  
   

 
 
 	 	
 </script>

<title> :: ATTENDANCE ::</title>


 
<style type="text/css">
<!--
.style3 {color: #FF0000}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 <%@ include file="index.jsp"%>
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100">
		</td>
	</tr>
	<tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
	<td height="299">
	<table width="600" border="0" align="center" cellpadding="1"
		cellspacing="1">
		<tr>
			<td width="594" height="15">
			  
			</td>
		</tr>
		<tr>
			<td>
			
			<form action="../SmartLoginAuth" method="post"   name="frm" id="frm"  AUTOCOMPLETE = "off" onSubmit=" return Validate()">
			<table width="100" border="0" align="center" cellpadding="0"
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
						<td class="BorderLine" width="1"><spacer height="1" width="1"
							type="block" /></td>
						<td width="6"><spacer height="1" width="1" type="block"></td>
					  <td width="577" valign="top"><table width="500" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="100%"><div align="center" class="boldEleven"><strong>PERMISSION </strong></div></td>
                        </tr>
                        <tr>
                          <td><div align="right"><span class="article style3">
                              <%

String sql ="";
String rowid = request.getParameter("rowid");
sql = " SELECT a.INT_PERMISSIONID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_PDATE,'%d-%m-%Y'),a.CHR_PTYPE,a.CHR_DAYTYPE,a.DT_TIME_FROM, a.DT_TIME_TO, a.CHR_REASON FROM att_t_permission a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID AND  a.INT_PERMISSIONID="+rowid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

//INT_EXTRADAYSID,CHR_EMPID,DT_EXTRADATE,CHR_DAYTYPE,CHR_DESC,INT_VALUE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS
%>
                            * </span><span class="changePos">Mandatory</span></div></td>
                        </tr>
                        <tr>
                          <td><table width="350" border="0" align="center" cellpadding="3" cellspacing="3">
                              <tr>
                                <td width="100" class="boldEleven">EMPID</td>
                                <td width="229" class="boldEleven"><%=readData[0][1]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Name</td>
                                <td class="boldEleven"><%=readData[0][2]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Date</td>
                                <td> 
                                  <input name="fromdt" type="text" class="formText135" 
												id="fromdt" readonly="readonly" value="<%=readData[0][4]%>"
												size="15">                                                                 </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Day Type</td>
                                <td>
								
								<%
								 
								String c2="";
								String c3="";
								
								if("Forenoon".equals(readData[0][6]))
									c2 = " checked = 'checked' " ;
								if("Afternoon".equals(readData[0][6]))
									c3 = " checked = 'checked' " ;
								%>
								
								<table width="176" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              
                                              <td width="20" class="boldEleven"><input name="ComboDay" type="radio" id="ComboDay"
							value="Forenoon" <%=c2%> ></td>
                                              <td width="64" class="boldEleven">Forenoon</td>
                                              <td width="20" class="boldEleven"><div align="left">
                                                <input name="ComboDay"
							type="radio" id="ComboDay" value="Afternoon"  <%=c3%> >
                                              </div></td>
                                              <td width="125" class="boldEleven">Afternoon</td>
                                            </tr>
                                          </table>                                </td>
                              </tr>
                               
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">From Time<font color="#FF0000"> *</font></td>
                                <td class="boldEleven"><span class="bolddeepblue">
                                  <input name="int" type="text" class="formText135"  readonly="readonly" id="int"
												 value="<%=readData[0][7]%>" size="15" maxlength="8">
                                </span></td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">To Time <font color="#FF0000">*</font> </td>
                                <td class="boldEleven"><span class="bolddeepblue">
                                  <input name="out" type="text" class="formText135" readonly="readonly" id="out"
												  value="<%=readData[0][8]%>" size="15"
												maxlength="8">
                                  <script language="javascript">
 $("#int, #out").timePicker();
    
 var oldTime = $.timePicker("#int").getTime();

 $("#int").change(function() {
  if ($("#out").val()) { // Only update when second input has a value.
     var duration = ($.timePicker("#out").getTime() - oldTime);
    var time = $.timePicker("#int").getTime();
     $.timePicker("#out").setTime(new Date(new Date(time.getTime() + duration)));
    oldTime = time;
  }
});
 
 $("#out").change(function() 
 {
  	if($.timePicker("#int").getTime() > $.timePicker(this).getTime()) 
	{
    	$(this).addClass("error");
		document.getElementById('out').value="";
		alert("To Time should be greater than the From Time");
  	}
  	else 
  	{
    	$(this).removeClass("error");
  	}
}); 
                                </script>
                                </span></td>
                              </tr>
                              <tr>
                                <td align="left" valign="middle"  
												class="boldEleven">Reason <font color="#FF0000">*</font></td>
                                <td class="boldEleven"><textarea name="reason" cols="30" rows="5" class="formText135" id="reason" onKeyUp="textArea('reason','250')"><%=readData[0][9]%></textarea>                                </td>
                              </tr>
                              
                          </table></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td></td>
                        </tr>
                        <tr>
                          <td height="28"><table border="0" align="center" cellpadding="1" cellspacing="1">
                              <tr>
                                <td width=56><input name="update" type="Submit"
											class="buttonbold" id="update" onClick="return Edit()"
											value="Update">
                                <td width=56><input name="Submit" type="Button"
											class="buttonbold" onClick="redirect('Permission.jsp')"
											 value="Close"   accesskey="c" ></td>
                                <td> 
                                    <input name="rowid" type="hidden" id="rowid" value="<%=readData[0][0]%>">
                                     
                                     
                                                                        <input name="filename"
										type="hidden" id="filename" value="StaffPermission">
                                                                        <input
										name="actionS" type="hidden" id="actionS"
										value="ATTStaffPermissionUpdate"></td>
                              </tr>
                          </table></td>
                        </tr>
                      </table></td>
						<td nowrap="nowrap" width="6"><spacer height="1" width="1"
							type="block" /></td>
						<td width="1" class="BorderLine"><spacer height="1" width="1"
							type="block" /></td>
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
						<td class="BorderLine" height="1"></td>
					</tr>
				</tbody>
			</table>
			</form>
			</td>
		</tr>
	</table>
	</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
 }
 catch(Exception es)
 {
 	//System.out.println(es.getMessage());
 }
 %>
 
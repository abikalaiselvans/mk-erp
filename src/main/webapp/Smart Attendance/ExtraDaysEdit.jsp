<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%> 

<jsp:directive.page import="com.my.org.erp.ServiceLogin.DateUtil" />
<%
try
{
%>
 <%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>

<html>
<head>
<script src="../JavaScript/AJAXFunction.js"></script>
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



<script language="JavaScript">
function Validate()
{

 
	try
  	{
		if( checkNull("fromdt","Enter the Date...") 
			&& checkNull("hdescription","Enter description...") 
			&&  checkExtradays()
		) 
		
			return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}		
	
 
}
  
 
  
   

 function checkExtradays()
{  
  try
  {
	
	var d1 = document.getElementById('fromdt').value;
	var dd1 = d1.split("-");
	var ds = compute(dd1[0],dd1[1],dd1[2]) ;
	document.getElementById('txtDay').value=ds;
	if(ds=="Sunday")
	{
		
		return true;
	}
	else
	{
		alert("Sunday only possible to extra days ");
		return false;
		
	}	
  }
  catch(err)
  {
  	alert(err);
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



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
                          <td width="100%"><div align="center" class="boldEleven"><strong>EXTRA DAYS  EDIT </strong></div></td>
                        </tr>
                        <tr>
                          <td><div align="right"><span class="article style3">
                              <%

String sql ="";
String rowid = request.getParameter("rowid");
sql = " SELECT a.INT_EXTRADAYSID ,a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_EXTRADATE,'%d-%m-%Y'),a.CHR_DESC,a.CHR_DAYTYPE FROM att_t_extradays a,com_m_staff b,com_m_office c WHERE a.CHR_EMPID= b.CHR_EMPID  AND b.INT_OFFICEID =c.INT_OFFICEID and a.INT_EXTRADAYSID="+rowid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

//INT_EXTRADAYSID,CHR_EMPID,DT_EXTRADATE,CHR_DAYTYPE,CHR_DESC,INT_VALUE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS
%>
                            * </span><span class="changePos">Mandatory</span></div></td>
                        </tr>
                        <tr>
                          <td><table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
                              <tr>
                                <td width="173" class="boldEleven">Empid</td>
                                <td width="227" class="boldEleven"><%=readData[0][1]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Name</td>
                                <td class="boldEleven"><%=readData[0][2]%></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Date <font color="red">*</font></td>
                                <td class="boldEleven"><span class="boldEleven">
                                  <input name="fromdt" type="text" class="formText135" 
												id="fromdt" readonly="readonly" value="<%=readData[0][4]%>"
												size="15">
                                   </span>
                                                                  <span class="boldEleven">
	                    <input name="txtDay" id="txtDay"  value="" type="hidden">
	                    </span></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Day Type <font color="red">*</font></td>
                                <td class="boldEleven">
								
								<%
								String c1="";
								String c2="";
								String c3="";
								if("Full Day".equals(readData[0][6]))
									c1 = " checked = 'checked' " ;
								if("Forenoon".equals(readData[0][6]))
									c2 = " checked = 'checked' " ;
								if("Afternoon".equals(readData[0][6]))
									c3 = " checked = 'checked' " ;
								%>
								
								<table width="259" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td class="boldEleven"><input name="ComboDay"
							id="ComboDay" type="radio" value="Full Day" <%=c1%> ></td>
                                              <td class="boldEleven">Full
						Day</td>
                                              <td class="boldEleven"><input name="ComboDay" type="radio" id="ComboDay"
							value="Forenoon" <%=c2%> ></td>
                                              <td class="boldEleven">Forenoon</td>
                                              <td class="boldEleven"><input name="ComboDay"
							type="radio" id="ComboDay" value="Afternoon"  <%=c3%> ></td>
                                              <td class="boldEleven">Afternoon</td>
                                            </tr>
                                  </table>
										  
										  
								 
                                </td>
                              </tr>
                              <tr>
                                <td class="boldEleven">Description <font color="red">*</font></td>
                                <td class="boldEleven"><span class="boldEleven">
                                  <textarea name="hdescription" cols="30" rows="5" class="formText135" id="hdescription" onKeyUp="textArea('hdescription','250')"><%=readData[0][5]%></textarea>
                                </span></td>
                              </tr>
                              <tr>
                                <td class="boldEleven">&nbsp;</td>
                                <td class="boldEleven">&nbsp;</td>
                              </tr>
                              <tr>
                                <td class="boldEleven">&nbsp;</td>
                                <td class="boldEleven">&nbsp;</td>
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
                                <td width=56>
<input name="update" type="Submit"	class="buttonbold" id="update" 	value="Update">
                                <td width=56>
<input name="Submit" type="Button" 	class="buttonbold" onClick="redirect('ExtraDays.jsp')"  value="Close"   accesskey="c" ></td>
                                <td> 
<input name="rowid" type="hidden"  id="rowid" value="<%=readData[0][0]%>">
<input name="filename" type="hidden" id="filename" value="ExtraDays">
<input name="actionS"  type="hidden" id="actionS" value="ATTExtraDaysUpdate">                                    </td>
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
 	 System.out.println(es.getMessage());
 }
 %>
 
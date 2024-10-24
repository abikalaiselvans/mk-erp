<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%> 
<%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];

String sql = " SELECT DATE_FORMAT(DT_HOLIDATE,'%d-%m-%Y'),datediff(now(),DT_HOLIDATE) FROM att_t_commonholiday  WHERE datediff(now(),DT_HOLIDATE) <= 30 AND datediff(now(),DT_HOLIDATE) >= -30 ORDER BY DT_HOLIDATE ";
String commonData[][]= CommonFunctions.QueryExecute(sql);
String commondate ="";
if(commonData.length>0)
{
		for(int u=0;u<commonData.length;u++)
			commondate = commondate +commonData[u][0]+",";
}
 
%>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	 var dojlock= "<%=dojlock%>";
	$(function() {
			
		$( "#fromdt" ).datepicker({ 
		defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			minDate: "-50D" , maxDate: "+20D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true 
		});
	});
	
	
	 
	
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">



<script language="JavaScript">

 function sunchk()
 {
  	var x = document.getElementById('fromdt').value;
	var myDays=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];         
	var gday = x.substring(0,2);
	var gmonth = x.substring(3,5);
	var gyear = x.substring(6);
	var myDate = new Date(gmonth+"-"+gday+"-"+gyear);	
	var sdate = myDays[myDate.getDay()];

	if (sdate=="Sunday")
	{	
		document.getElementById('txtDay').value=sdate; 
		return true;
	}
	else
		return false;
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

function commondateCheck()
{
	try
	{
		var commondate ="<%=commondate%>";
		var entrydate = document.getElementById('fromdt').value;
		var v = commondate.split(",");
		var flag =false;
		for( i=0; i<v.length-1; i++)
		{
			if(entrydate == v[i])
				flag =  true;
		}
		
		if(!flag)
			alert("Entry date does not falls on common holiday datelist");
			
		return flag;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}

function checksundayOrHoliday()
{
	try
  	{
		var f1 = checkExtradays();
		var f2 = commondateCheck();
		
		if( f1 || f2 )
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
 
function Validate()
{
	 
	try
  	{
		if(checkNull("ename","Select Staff...") 
			&& checkNull("fromdt","Enter the Date...") 
			&& checkNull("hdescription","Enter description...") 
			&& checksundayOrHoliday()
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
  
 </script>

<title> :: ATTENDANCE ::</title>


 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td ><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="29">&nbsp;</td>
	</tr>
	<tr>
		<td height="371">
		<form  AUTOCOMPLETE = "off"   name="frmExtraDaysAdd" method="post" action="../SmartLoginAuth">
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
									<div align="center" class="boldEleven"><strong>EXTRA DAYS </strong></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="right"><span class="article style3"><font
										color="red">*</font></span><span class="changePos"> Mandatory</span></div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
									<div align="center"><%@ include
										file="../JavaScript/ajax.jsp"%></div>
									</td>
								</tr>
								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table width="444" height="114" border="0" align="center" cellpadding="1"
										cellspacing="1">
										 
										<tr>
											<td width="92" valign="middle"  
												class="boldEleven">Date <font color="red">*</font></td>
											<td width="263" class="boldEleven">
<input title="dd/mm/yyyy" readonly name="fromdt" type="text" class="formText135" id="fromdt" size="15">
 <input name="txtDay" id="txtDay"  value="" type="hidden"> 
<script language='JavaScript'>
 			 setCurrentDate('fromdt'); 	
</script> ( dd-mm-yyyy )
</td>
										</tr>
										<tr>										</tr>
										<tr>										</tr>
										<tr>
										  <td align="left" valign="top"  
												class="boldEleven">Day Type  <font color="red">*</font></td>
										  <td valign="top"><table width="259" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td class="boldEleven"><input name="ComboDay"
							id="ComboDay" type="radio" value="Full Day" checked></td>
                                              <td class="boldEleven">Full
						Day</td>
                                              <td class="boldEleven"><input name="ComboDay" type="radio" id="ComboDay"
							value="Forenoon"></td>
                                              <td class="boldEleven">Forenoon</td>
                                              <td class="boldEleven"><input name="ComboDay"
							type="radio" id="ComboDay" value="Afternoon"></td>
                                              <td class="boldEleven">Afternoon</td>
                                            </tr>
                                          </table></td>
									  </tr>
										 
										<tr>
											<td align="left" valign="top"  
												class="boldEleven">Description <font color="red">*</font></td>
											<td valign="top"><textarea name="hdescription"   id="hdescription" cols="40" rows="5" class="formText135" onKeyUp="textArea('hdescription','250')"></textarea></td>
										</tr>
									</table>
									</td>
								</tr>

								<tr>
									<td colspan="2"></td>
								</tr>
								<tr>
									<td colspan="2">
									<table align="center" border="0">
										<tr>
											<td>
											 
											</td>
										</tr>
									</table>

									</td>
								</tr>
								<tr>
									<td width="49%" height="19"><input name="filename"
										type="hidden" id="filename" value="ExtraDays"> <input
										name="actionS" type="hidden" id="actionS"
										value="ATTExtraDaysAdd"></td>
									<td width="51%"><span class="boldEleven"> <font color="red">* Sunday only possible </font></span></td>
								</tr>
								<tr>
									<td height="19" colspan="2">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
										<tr>
											<td width="56"><input type="submit" name="Submit"
												id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"   
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" name="submit"
												class="buttonbold"  value="Close"   accesskey="c" 
												onClick="redirect('ExtraDays.jsp')" /></td>
										</tr>
									</table>
									</td>
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
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
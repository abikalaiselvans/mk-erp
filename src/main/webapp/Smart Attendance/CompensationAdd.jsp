<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%String actionStu="ATTcompensationAdd"; %>
<html>
<head>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff") && checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkNull("holiname","Enter Description")&& checkDate("fromdt","todt")){
		document.frmState.submit();
		return true;
	}
	return false;
  }
    function Validate1()
  {
  	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") 
  	&& checkDate("fromdt","todt")){
		document.frmState.submit();
		return true;
	}
	return false;
  }
  	function mainPage()
	{
	    document.frmState.action="AttendanceMain.jsp";
		document.frmState.submit();
		return true;
    }
 
</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}
.menuBtn {
	width:100%;
}

-->
</style>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="init()">
<form  AUTOCOMPLETE = "off"   name="frmState" method="post" action="../SmartLoginAuth"><%@ include
	file="index.jsp"%> <br>
<br>
<br>
<br>
<br>
<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
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

			<table width="469" border="0" align="center">
				<!--DWLayoutTable-->
				<tr>
					<td width="100%" height="33" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<!--DWLayoutTable-->
						<tr>
							<td width="455" height="31" valign="top"><%@ include
								file="../JavaScript/ajax.jsp"%></td>
						</tr>
					</table>
					</td>

				</tr>
				<tr>
					<td height="128" colspan="2" align="left" valign="top">
					<table width="463" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr>
							<td height="25" colspan="2" valign="top" align="center"
								class="BackGround" >Compensation</td>
						</tr>
						<tr>
							<td width="153" height="30" valign="middle" class="bolddeepblue">From</td>
							<td><input name="fromdt" type="text" class="tabledata"
								id="fromdt" onKeyPress="dateOnly('fromdt')" value="" size="15">
							<a href="javascript:cal1.popup();"> <img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
						</tr>
						<tr>
							<td height="30" align="left" valign="middle" class="bolddeepblue">
							To</td>
							<td align="left" valign="middle"><input name="todt"
								type="text" class="tabledata" id="todt"
								onKeyPress="dateOnly('todt')" value="" size="15"> <a
								href="javascript:cal2.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a></td>
						</tr>
						<tr>
							<td height="29" align="left" valign="middle" class="bolddeepblue">Description
							<font color="#ff0000">*</font></td>
							<td align="left" valign="middle"><input name="holiname"
								type="text" class="tabledata" id="holiname"
								onKeyPress="charOnly('holiname','25')" size="40"></td>
						</tr>

						<tr>
							<td colspan="2">

							<table width="450" border="0">
								<tr>
									<td>&nbsp; <%

	
			String mess = ""+request.getParameter("mess");   
			//System.out.println("The Mess is : " +mess);

			
			if(mess.equals("") || mess.equals("null"))
			{
				//System.out.println("---------------");	
			}
			else
			{

					//System.out.println("Return to jsp page");
	    	        String sid=request.getParameter("staffID");
	    	        String AlreadDate = request.getParameter("Adate");
	    	        String HoliName = request.getParameter("Hname");	            
	
	    	        //System.out.println("\n"+sid);
	    	        //System.out.println("\n\n"+AlreadDate);

	    	        String val[] = AlreadDate.split("/");
	    	        String hname[] = HoliName.split("/");
	    	        
					out.println("<div id='HolidAdd' style='OVERFLOW:auto;width:450px;height:100px' >");
					out.println("<center><table>");
					out.println("<tr class='MRow1'>");
					out.println("<td colspan=3 class='bolddeepred'>Already Entered the following...");
					out.println("<tr class='MRow1'>");
					out.println("<td width='150' class ='boldEleven'>");
					out.println("&nbsp;<b>Staffid</b><td width='70' class ='boldEleven'>&nbsp;<b>Date</b>");
					out.println("<td width='200' class ='boldEleven' >&nbsp;<b>Holiday Name</b>");

					for(int u=0; u<val.length; u++)
					{
						if(u%2==1)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr  class='MRow2'>");	

							out.println("<td width='200' class ='boldEleven' >&nbsp;"+sid);
							
							out.println("<td width='100' class ='boldEleven' >&nbsp;"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(val[u]));
							out.println("<td width='200' class ='boldEleven' >&nbsp;"+hname[u]);
							
					}

				out.println("</center></table></div>");
	
			
	}	

%>
									</td>
								</tr>
							</table>
							</td>
						</tr>


						<tr>
							<td height="29" colspan="2" align="left" valign="middle"
								class="bolddeepblue">
							<table align="center">
								<!--DWLayoutTable-->
								<tr align="center">
									<td width="56" height="26"><input class="buttonbold"
										type="submit" name="Submit" value="Submit"   accesskey="s"   
										onClick="return Validate()"></td>
									<td width="56" valign="top"><input class="buttonbold"
										type="Button" name="Button"  value="Close"   accesskey="c" 
										onClick="redirect('Compensation.jsp')">
									<td width="10">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
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
			<td height="6"><spacer height="1" width="1" type="block" /></td>
			<td colspan="2" rowspan="2"><img height="7"
				src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
		</tr>
		<tr>
			<td class="BorderLine" height="0"><spacer height="1" width="1"
				type="block" /></td>
		</tr>
	</tbody>
</table>



<center><input type="HIDDEN" name="filename"
	value="Compensation"> <input type="HIDDEN" name="actionS"
	value="<%=actionStu %>"> <br>
<script language='JavaScript'>
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
	</script> <% 
	String msg=""+request.getParameter("message");
	if(!msg.equals("null")){
%>
<CENTER>
<table width="23%" border="1" cellspacing="2" cellpadding="2"
	 >

	<tr>
		<td align="center" class="tabledata"><%=msg%></td>
	</tr>
	<% } %>
</table>
</CENTER>
<%@ include file="../footer.jsp"%>
</form>
</body>
</html>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
 
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
<html>
<head>

<title> :: ATTENDANCE ::</title>


 <script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 <script language="javascript" src="../JavaScript/Attendance/LeaveEditAjax.js"></script>
<script language="JavaScript">
  
  
  function Validate()
  {
  		 
		var b = parseFloat(document.getElementById('leavebalance').value);
		if(b<0)
		{
			alert(" Your are not allowed to modify the Leave...." )
			return false;
		}
			
		if(	 checkNullSelect("leavetype","Select Leave name",'0')   )
				return true;
		else
				return false;
	
  }
   

</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style16 {	font-size: 24px;
	color: #666666;
}


-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="index.jsp"%>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		
		<form  AUTOCOMPLETE = "off"   method="post" name='frm' action="../SmartLoginAuth" 	onSubmit="return Validate()">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="100%" align="center">
						<tr>
						  <td><div align="center" class="bold1">
						    <div align="center">LEAVE EDIT 
						  
						      <%
						  
String leaveid = request.getParameter("leaveid");
String sql ="";
sql = " SELECT a.INT_LEAVEID,a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_LDATE,'%d-%m-%Y'),a.CHR_LEAVETYPE,c.CHR_LEAVENAME,a.CHR_DAYTYPE FROM  att_t_leave a,com_m_staff b ,att_m_leavetype c where a.CHR_EMPID =b.CHR_EMPID AND a.CHR_LEAVETYPE=c.CHR_SYMBOL AND a.INT_LEAVEID="+leaveid;
String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

String empid = readData[0][1];
String leavetype = readData[0][4];
String date = readData[0][3];
date = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(date);
String  leavids = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_LEAVEID FROM att_m_leavetype WHERE CHR_SYMBOL='"+leavetype+"'")[0][0];

sql = " SELECT  CHR_LEAVE"+leavids+" ,INT_NOD"+leavids+",INT_NOD"+leavids+"BALANCE,(INT_NOD"+leavids+" -INT_NOD"+leavids+"BALANCE) FROM  att_m_leave ";
sql = sql + " WHERE CHR_EMPID='"+empid+"' AND  INT_YEAR=Year('"+date+"')";

// System.out.println(sql);
String leaveDataw[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
String balance = leaveDataw[0][3];


						  %>
						    </div>
						  </div></td>
					  </tr>
						<tr>
						  <td><table width="87%" border="0" align="center" cellpadding="2" cellspacing="1">
                            <tr>
                              <td class="boldEleven">Staff ID </td>
                              <td class="boldEleven"><%=readData[0][1]%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Staff Name </td>
                              <td class="boldEleven"><%=readData[0][2]%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Leave Name </td>
                              <td class="boldEleven">
							  <select name="leavetype"  id="leavetype"  class="formText135" onChange="checkLeaveBalance('<%=empid%>','<%=date%>')"    >
						<option value="0">Select</option>
						<%
						
String leaveData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_LEAVENAME,CHR_SYMBOL  FROM att_m_leavetype    ORDER BY CHR_SYMBOL ");
for(int u=0; u<leaveData.length; u++)
	out.print("<option value='"+leaveData[u][1]+"'>"+leaveData[u][0] +"</option>");
 
						%>
						
					      </select>
						  <script language="javascript">setOptionValue('leavetype','<%=readData[0][4]%>')</script>
							  </td>
                            </tr>
                            <tr>
                              <td class="boldEleven">Date</td>
                              <td class="boldEleven"><%=readData[0][3]%></td>
                            </tr>
                            <tr>
                              <td class="boldEleven">session</td>
                              <td class="boldEleven">
  <%
  out.println("<table width='100%' border='0' cellspacing='0' cellpadding='0'>");
  out.println("<tr>");
  String s="";
  if("Full Day".equals(readData[0][6]))
  	s=" checked ='checked' ";
  else
	s="";
	
  out.println("<td class='boldEleven'><input name='ComboDay' id='ComboDay' type='radio' "+s+" value='Full Day'  /></td><td class='boldEleven'>Full Day</td>");
  
   if("Forenoon".equals(readData[0][6]))
  	s=" checked ='checked' ";
  else
	s="";
  out.println("<td class='boldEleven'><input name='ComboDay' type='radio' id='TxtDay1' "+s+"  value='Forenoon' /></td><td class='boldEleven'>Forenoon</td>");
 
  if("Afternoon".equals(readData[0][6]))
  	s=" checked ='checked' ";
  else
	s="";
  out.println("<td class='boldEleven'><input name='ComboDay' type='radio' id='TxtDay2' "+s+" 	value='Afternoon' /></td> <td class='boldEleven'>Afternoon</td>");
  out.println("</tr>");
  out.println("</table>");
   
  
  %>
							  
							  
                                
                                  
                                  
      

                                
                              </td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td class="boldEleven">
							  
					<input name="filename" type="hidden" id="filename" value="StaffLeave" /> 
					<input name="actionS"  type="hidden" id="actionS" value="ATTStaffLeaveEdit" />
					<input name="rowid" type="hidden" id="rowid" value="<%=readData[0][0]%>">
					 <input name="leavebalance" id="leavebalance" type="hidden" value="<%=balance%>">
					</td>
                            </tr>
                          </table></td>
						</tr>
						<tr>
							<td colspan="2" align="left" valign="middle" class="">
							<table align="center" cellpadding="3" cellspacing="3">
								<tr align="center">
									<td width="56"><input class="buttonbold" type="submit"
										name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c"  onClick="redirect('LeaveView.jsp')">									</td>
								</tr>
						</table>						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</form>

		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>

<%
}
catch(Exception e)
{
}
%>
<%@ include file="../footer.jsp"%>
</body>
</html>

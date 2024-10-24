<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import ="com.my.org.erp.common.CommonFunctions"%>
 <%
 try
 {
 %>
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="javascript">



function validateFields()
{
  if(checkNullSelect('reminder','Select Reminder Type','0')
  	&& checkNull('ename','Select Employee Name')
  	&& checkNull('policyno','Enter Policy Number')
	&& checkNullSelect('period','Select Period','0')
	&& checkNull('premiumamount','Enter Premium amount')
    && checkNull('sumassured','Enter Sumassured')
	&& checkNull('entrydate','Enter Entry Date')
	&& checkNullSelect('Issuer','Select Issuer','0')
	&& checkNullSelect('offices','Select Office','0')
	&& checkNull('desc','Select Desc')
  )
  	return true;
  else
  	return false;
}
</script>
 </head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()"	>

<%@ include file="index.jsp"%>
<table width="100%" border="0">
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td>
		
		
		<form name="frm" method="post" action="../SmartLoginAuth" 	onsubmit="return validateFields()">
		<TABLE width=572 border=0 align=center cellPadding=0 cellSpacing=0
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
              <TD width=554 valign="top"><table width="800" border="0" align="center" cellpadding="0"
								cellspacing="0">
                  <tr>
                    <td width="100%" colspan="2"><div align="center"><span class="tablesubhead">INSURANCE 
					
	<%   
			String action=""+request.getParameter("submit2");
			String id=""+request.getParameter("id");
			String actionS="";
			String buttonValue="";
			String sql ="";
			String reminder="";
			String empid="";
			String policyno="";
			String period="";
			String premiumamount=""; 
			String entrydate="";
			String duedate="";
			String matureddate="";
			String sumassured="";
			String regnumber="";
			String make="";
			String model="";
			String Issuer="";
			String validupto="";
			String office="";
			String desc="";
			String Policystatus="";
			String vehiclestatus="";
			if(action.equals("Add"))
			{
				actionS="TRSInsuranceTransactionAdd";	
				buttonValue="Add";	 
				id="0";	 
				reminder="";
				empid="";
				policyno="";
				period="";
				premiumamount=""; 
				entrydate="";
				duedate="";
				matureddate="";
				sumassured="";
				regnumber="";
				make="";
				model="";
				Issuer="";
				validupto="";
				office="";
				desc="";
				Policystatus="";
				vehiclestatus="";
			}
			else
			{
				
				


				sql ="SELECT INT_TRANSACTIONID,CHR_EMPID,INT_REMINDERID,CHR_POLICYNO,CHT_PERIOD, DOU_PREMIUM,DATE_FORMAT(DT_DATE,'%d-%m-%Y'),DATE_FORMAT(DT_DUEDATE,'%d-%m-%Y'),DATE_FORMAT(DT_MATURITY,'%d-%m-%Y'),DOU_SUMASSURED,CHR_REGNUMBER,CHR_MAKE,CHR_MODEL,INT_ISSUERID,DATE_FORMAT(DT_VALIDUPTO,'%d-%m-%Y'),INT_BRANCHID,CHR_DEC,CHR_STATUS,CHR_VECHICLESTATUS  FROM veh_t_insurancereminder   WHERE INT_TRANSACTIONID="+id;
				//out.println(sql);
				String data[][] = CommonFunctions.QueryExecute(sql);
				actionS="TRSInsuranceTransactionEdit";
				reminder=data[0][2];
				empid=data[0][1];
				policyno=data[0][3];
				period=data[0][4];
				premiumamount=data[0][5]; 
				entrydate=data[0][6];
				duedate=data[0][7];
				matureddate=data[0][8];
				sumassured=data[0][9];
				regnumber=data[0][10];
				make=data[0][11];
				model=data[0][12];
				Issuer=data[0][13];
				validupto=data[0][14];
				office=data[0][15];
				desc=data[0][16];
				Policystatus=data[0][17];
				vehiclestatus=data[0][18];
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
                    <td height="19" colspan="2"><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
                      <tr>
                        <td width="127" class="boldEleven">Reminder</td>
                        <td width="392"><select name="reminder" class="formText135" id="reminder">
                          <option value="0">Select</option>
                          <%
		sql ="SELECT INT_REMINDERID,CHR_REMINDERNAME FROM vehicle_m_insurancereminder ORDER BY CHR_REMINDERNAME";
		String reminderData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<reminderData.length;u++)
			out.println("<option value='"+reminderData[u][0]+"'>"+reminderData[u][1]+"</option>");

	%>
                        </select>
						<%
							if(!action.equals("Add"))
							{
								%>
								<script language="javascript">setOptionValue('reminder','<%=reminder%>')</script>
								<%
							}
						%>	<%=empid%>					</td>
                      </tr>
                      <tr>
                        <td colspan="2" bordercolor="#FF0000"><div align="center">
						<h3>Handled BY </h3>
                          <%@ include file="../JavaScript/ajax.jsp"%>
						  
						   
						  <%
							if(!action.equals("Add"))
							{
								%>
								<script language="javascript">
										//setOptionValue('ename','<%=empid%>');
 								</script>
								<%
							}
						%>	
                        </div></td>
                      </tr>
                      <tr id="insurance1">
                        <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="1" cellpadding="1">
                          <tr>
                            <td width="15%" class="boldEleven">Policy Number /Rental Agreement </td>
                            <td width="35%"><input name="policyno" type="text" class="formText135" id="policyno" style="text-align:right" onKeyUp="upperMe(this), CheckUnique(this,'divn','tim_t_insurancereminder', 'CHR_POLICYNO' )" value="<%=policyno%>" size="50" maxlength="25">
                              <div id="divn"></div></td>
                            <td width="17%" class="boldEleven">Entry Date </td>
                            <td width="33%"><input name="entrydate"
												type="text" class="formText135" id="entrydate"
												onKeyPress="numericHypenOnly('entrydate','9')" value="<%=entrydate%>"
												size="15"  >
                              <a
												href="javascript:cal1.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
                              <script
												language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frm'].elements['entrydate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			
				<%
				if(action.equals("Add"))
				{
				%>
				setCurrentDate('entrydate');
			 	<%
				}
				%>
			
		//-->
	                          </script>
                              <span class="boldEleven"> ( dd-mm-yyyy ) </span></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Period</td>
                            <td><select name="period" class="formText135" id="period">
                              <option value="0">Select</option>
                              <option value="Q">Quartly</option>
                              <option value="H">Haly yearly</option>
                              <option value="A">Annually</option>
							  <option value="M">Monthly</option>
							  <option value="2">2-Yyears</option>
							  <option value="3">3-Years</option>
							  <option value="4">4-Years</option>
							  <option value="5">5-Years</option>
							   
							  
                            </select>
                              <%
							if(!action.equals("Add"))
							{
								%>
                              <script language="javascript">setOptionValue('period','<%=period%>')</script>
                              <%
							}
						%></td>
                            <td class="boldEleven">Due Date </td>
                            <td><input name="duedate"
												type="text" class="formText135" id="duedate"
												onKeyPress="numericHypenOnly('duedate','9')" value="<%=duedate%>"
												size="15"  >
                              <a
												href="javascript:cal2.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
                              <script
												language='JavaScript'>
		<!--
			var cal2 = new calendar1(document.forms['frm'].elements['duedate']);
			cal2.year_scroll = true;
			cal2.time_comp = false;
			
				<%
				if(action.equals("Add"))
				{
				%>
				setCurrentDate('duedate'); 
			 	<%
				}
				%>
			
			 	
			
		//-->
	                          </script>
                              <span class="boldEleven">( dd-mm-yyyy ) </span></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Premium Amount </td>
                            <td><input name="premiumamount" type="text" class="formText135" id="premiumamount" style="text-align:right" value="<%=premiumamount%>" size="50" maxlength="10" onKeyPress="return numeric_only(event,'premiumamount','10')" ></td>
                            <td class="boldEleven">Maturity Date </td>
                            <td><input name="matureddate"
												type="text" class="formText135" id="matureddate"
												onKeyPress="numericHypenOnly('matureddate','9')" value="<%=matureddate%>"
												size="15" >
                              <a
												href="javascript:cal3.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
                              <script
												language='JavaScript'>
		<!--
			var cal3 = new calendar1(document.forms['frm'].elements['matureddate']);
			cal3.year_scroll = true;
			cal3.time_comp = false;
			
				<%
				if(action.equals("Add"))
				{
				%>
				 setCurrentDate('matureddate');
			 	<%
				}
				%>
			
			 	
			
		//-->
	                          </script>
                              <span class="boldEleven">( dd-mm-yyyy ) </span></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Sum Assured </td>
                            <td><input name="sumassured" type="text" class="formText135" id="sumassured" style="text-align:right" value="<%=sumassured%>" size="50" maxlength="10" onKeyPress="return numeric_only(event,'sumassured','10')"></td>
                            <td class="boldEleven">Insurance Issuer </td>
                            <td><select name="Issuer" class="formText135" id="Issuer">
                              <option value="0">Select</option>
                              <%
		sql ="SELECT INT_ISSUERID,CHR_ISSUERNAME FROM vehicle_m_insuranceissuer   ";
		String issuerData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<issuerData.length;u++)
			out.println("<option value='"+issuerData[u][0]+"'>"+issuerData[u][1]+"</option>");

	%>
                            </select>
                              <%
							if(!action.equals("Add"))
							{
								%>
                              <script language="javascript">setOptionValue('Issuer','<%=Issuer%>')</script>
                              <%
							}
						%></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Reg No </td>
                            <td><input name="regnumber" type="text" class="formText135" id="regnumber" style="text-align:right"  onKeyUp="upperMe(this), CheckUnique(this,'divns','vehicle_m_insurancereminder', 'CHR_REGNUMBER' )" value="<%=regnumber%>" size="50" maxlength="30">
                              <div id="divns"></div></td>
                            <td class="boldEleven">Valid Upto </td>
                            <td><input name="validupto"
												type="text" class="formText135" id="validupto"
												onKeyPress="numericHypenOnly('validupto','9')" value="<%=validupto%>"
												size="15" >
                              <a
												href="javascript:cal4.popup();"><img
												src="../JavaScript/img/cal.gif" width="16" height="16"
												border="0" alt="Click Here to Pick up the date"></a>
                              <script
												language='JavaScript'>
		<!--
			var cal4 = new calendar1(document.forms['frm'].elements['validupto']);
			cal4.year_scroll = true;
			cal4.time_comp = false;
			setCurrentDate('validupto');
			 	
			
		//-->
	                          </script>
                              <span class="boldEleven">( dd-mm-yyyy ) </span></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Make</td>
                            <td><input name="make" type="text" class="formText135" id="make" style="text-align:right" value="<%=make%>" size="50" maxlength="100"></td>
                            <td class="boldEleven">Office</td>
                            <td><select name="offices" class="formText135" id="offices"  style="width:200;">
                              <option value="0">Select</option>
                              <%
		sql ="SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office ORDER BY CHR_OFFICENAME ";
		String officeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int u=0;u<officeData.length;u++)
			out.println("<option value='"+officeData[u][0]+"'>"+officeData[u][1]+"</option>");

	%>
                            </select>
                              <%
							if(!action.equals("Add"))
							{
								%>
                              <script language="javascript">setOptionValue('offices','<%=office%>')</script>
                              <%
							}
						%></td>
                          </tr>
                          <tr>
                            <td class="boldEleven">Model</td>
                            <td><input name="model" type="text" class="formText135" id="model" style="text-align:right" value="<%=model%>" size="50" maxlength="100"></td>
                            <td class="boldEleven">Policy Status</td>
                            <td><input name="Policystatus" type="checkbox" id="Policystatus" value="Y">
                              <%
							if(!action.equals("Add"))
								if("Y".equals(Policystatus))
								{
									%>
                              <script language="javascript">document.getElementById('Policystatus').checked=true;; </script>
                              <%
							}
						%></td>
                          </tr>
                          <tr>
                            <td align="left" valign="top" class="boldEleven">Description</td>
                            <td valign="top">
							<textarea name="desc" cols="40" rows="5" class="formText135" id="desc"><%=desc%></textarea></td>
                            <td class="boldEleven">Vehicle Status</td>
                            <td><input name="vehiclestatus" type="checkbox" id="vehiclestatus" value="Y" onKeyUp="textArea('desc','2000')">
                              <%
							if(!action.equals("Add"))
								if("Y".equals(vehiclestatus))
								{
									%>
                              <script language="javascript">document.getElementById('vehiclestatus').checked=true;; </script>
                              <%
							}
						%></td>
                          </tr>
                        </table></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="19" colspan="2"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                        <tr>
                          <td>
		<input name="filename" type="hidden" id="filename" value="InsuranceTransaction">
		<input name="id" type="hidden" id="id" value="<%=id%>">
		
        <input name="actionS" type="hidden" id="actionS" value="<%=actionS%>"></td>
                          <td width="56">
<input type="submit" name="Submit" id="submit_btn" class="buttonbold" value="<%=buttonValue%>" tabindex="30" /></td>
                          <td width="56">
<input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect('InsuranceTransaction.jsp')" tabindex="31" />



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
        </TABLE>
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
   <%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</html>

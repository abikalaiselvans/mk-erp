<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">
   
  function Validate()
  {
  	if(	
		checkNull("startdate","Enter Complaint Date")
		&&checkNull("description","Enter Problems")		
		&&checkNull("cperson","Enter Contact Person")		
		&&checkNull("cmobile","Enter Contact mobile")		
		&&checkNull("caddress","Enter Contact Address")		
		&&checkNull("cemail","Enter Contact email")		
		)
		{
		return true;	
		}
	else
		return false;			
  } 
 
 
 
 	
</script>

<body >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<td width="800">
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate()">
					<table cellspacing="2" cellpadding="2" width="95%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Service Call Book</td>
							</tr>
							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td width="22%" height="17" valign="top" class="boldEleven">Call Log Id 
								  <%
				  		String Bookingid = request.getParameter("Bookingid");
						String dbvalue="";
						String  sql = "";
						
						sql =" SELECT INT_CUSTOMERID,CHR_SERIALNO,DATE_FORMAT(DT_BOOKINGDATE,'%d-%m-%Y %H :%i :%s '),";
sql = sql +" DATE_FORMAT(DT_CLOSINGDATE,'%d-%m-%Y  %H :%i :%s '),  CHR_SERVICEDESC,  CHR_BOOKINGTYPE,CHR_BOOKINGUNDER,";
sql = sql +" CHR_STATUS,CHR_ENGGSTATUS,  CHR_BOOKINGEMPID,CHR_CONTACTPERSON,CHR_CONTACTADDRESS,CHR_CONTACTMOBILE,";
sql = sql +" CHR_CONTACTEMAIL   FROM inv_t_servicecallbooking WHERE CHR_SERVICECALLNO='"+Bookingid+"' ";
						System.out.println(sql);
						String readname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
				  %> <input type="hidden" name="Bookingid" value="<%=Bookingid%>"> </td>
								<td width="28%" valign="top" class="boldEleven"><%=Bookingid%></td>
								<td width="18%" align="left" valign="top"><span
									class="boldEleven">Serial number </span></td>
								<td width="32%" align="left" valign="top" class="boldEleven">
								<%= readname[0][1]%>								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Call Log
								Date</td>
								<td height="17" valign="top" class="boldEleven"><input
									name="startdate" type="text" class="formText135" id="startdate"
									onKeyPress="dateOnly(this)"
									value=" "
									size="15" maxlength="10" /> 
								<a href="javascript:cal1.popup();">
								<img src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['startdate']);
							cal1.year_scroll = true;
							cal1.time_comp = true;
							setCurrentDateandTime('startdate'); 
						//-->
                       </script></td>
								<td align="left" valign="top"><span class="boldEleven">Customer
								Name </span></td>
								<td align="left" valign="top" class="boldEleven">
								<%
				  	sql ="";
					sql = "SELECT CHR_CUSTOMERNAME from inv_m_servicecustomerinfo where INT_CUSTOMERID = "+readname[0][0];	
					String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					out.println(readDatas[0][0]);
				  %>								</td>
							</tr>
							<tr>
								<td height="17" rowspan="3" valign="top" class="boldEleven">Problems</td>
								<td height="17" rowspan="3" valign="top" class="boldEleven"><textarea
									name="description" cols="30" rows="5" class="formText135"
									id="description"><%=readname[0][4]%></textarea></td>
								<td align="left" valign="top" class="boldEleven">Complaint
								Type <%
				  	String complainttype=readname[0][5];
					String  direct ="";
					String  phone ="";
					String  others ="";
					if(complainttype.equals("D"))
						direct = " checked = checked" ;
						
					if(complainttype.equals("P"))
						phone = " checked = checked" ;
						
					if(complainttype.equals("O"))
						others = " checked = checked" ;	
				  %>								</td>
								<td align="left" valign="top" class="boldEleven">

								<table width="81%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="10%" class="boldEleven"><label> <input
											name="bookingtype" type="radio" value="D" <%=direct%>>
										</label></td>
										<td width="15%" class="boldEleven">Direct</td>
										<td width="10%" class="boldEleven"><input
											name="bookingtype" type="radio" value="P" <%=phone%>></td>
										<td width="25%" class="boldEleven">Phone</td>
										<td width="11%" class="boldEleven"><input
											name="bookingtype" type="radio" value="O" <%=others%>></td>
										<td width="29%" class="boldEleven">Others</td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="boldEleven">Product
								Under <%
				  	complainttype=readname[0][6];
					out.print(complainttype);
					direct ="";
					phone ="";
					others ="";
					if(complainttype.equals("A"))
						direct = " checked = checked" ;
						
					if(complainttype.equals("W"))
						phone = " checked = checked" ;
						
					if(complainttype.equals("O"))
						others = " checked = checked" ;	
				  %>								</td>
								<td align="left" valign="top">
								<table width="78%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="A" <%=direct%>></td>
										<td width="16%" class="boldEleven">AMC</td>
										<td width="11%" class="boldEleven"><input
											name="complainttype" type="radio" value="W" <%=phone%>></td>
										<td width="25%" class="boldEleven">Warranty</td>
										<td width="10%" class="boldEleven"><input
											name="complainttype" type="radio" value="O" <%=others%>></td>
										<td width="28%" class="boldEleven">Oncall</td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td colspan="2" align="left" valign="top"></td>
							</tr>
							<tr>
                              <td height="17" class="boldEleven">Contact Person </td>
							  <td height="17" class="boldEleven"><input name="cperson" type="text" class="formText135" id="cperson" value="<%=readname[0][10]%>" size="30" maxlength="100"></td>
							  <td align="left" class="boldEleven">Address </td>
							  <td align="left" class="boldEleven"><span class="boldEleven">
                                <input name="caddress" type="text" class="formText135" id="caddress" value="<%=readname[0][11]%>" size="25" maxlength="100">
                              </span></td>
						  </tr>
							<tr>
                              <td height="17" class="boldEleven">Mobile </td>
							  <td height="17" class="boldEleven"><input name="cmobile" type="text" class="formText135" id="cmobile" value="<%=readname[0][12]%>" size="30" maxlength="12"></td>
							  <td align="left" class="boldEleven">Email </td>
							  <td align="left" class="boldEleven"><span class="boldEleven">
                                <input name="cemail" type="text" class="formText135" id="cemail" value="<%=readname[0][13]%>" size="25" maxlength="100">
                              </span></td>
						  </tr>
							
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Call cancel 
								<%
								dbvalue=readname[0][7];
								if("R".equals(readname[0][7]))
									dbvalue= " Checked= 'checked' ";
								else
									dbvalue="";	
								
								%>
								</td>
								<td height="17" class="boldEleven">
								<input name="Cancel" <%=dbvalue%> type="checkbox" id="Cancel" value="Y" >  </td>
								<td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" colspan="2" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="ServiceCall" /> <input name="actionS"
									type="hidden" value="INVServiceUpdate" /></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">

								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56">
										<%
										if(!"R".equals(readname[0][7]))
										{
										%>
										<input type="Submit" class="buttonbold13" value="Submit"   accesskey="s"    id="submits">
										<%
										}
										%>	
											</td>
										<td width="56"><input type="Button" class="buttonbold13"
											onClick="redirect('ServiceCall.jsp')"  value="Close"   accesskey="c" >										</td>
									</tr>
								</table>								</td>
							</tr>
						</tbody>
					</table>

					</form>
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
		</td>
	</tr>

</table>

<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	 
}
%>
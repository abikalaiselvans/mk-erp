<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
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
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript">

					   
  function Validate()
  {
	if(	
		checkNullSelect("ename","Select Staff ","")
		&&checkNull("startdate","Enter Assign Date")
		
		)
		{
		return true;	
		}
	else
		return false;			
  } 
 
 
 
	 
</script>

<body    onLoad="init()">
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" 						onSubmit="return Validate()">
					<table cellspacing="2" cellpadding="2" width="86%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Service Call Assign </td>
							</tr>
							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Call Number </td>
							  <td height="17" valign="top" class="boldEleven">
							  
							  <%
							  String callid = request.getParameter("callid");
							  out.println("<b>"+callid+"</b>");
							  %>
							  
							  <input name="filename"	type="hidden" value="ServiceCallAssign" />
							  <input name="callid" type="hidden" id="callid" value="<%=callid%>">							  <input name="actionS"		type="hidden" value="INVServiceCallAssignAdd" /></td>
							  <td colspan="2" align="left" valign="top">
							  <div id="serialnumberlist"></div>							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  
							  <%

		String sql= " SELECT FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H :%i :%s %p'), ";
		sql = sql + " DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H :%i :%s %p'),a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS, ";
		sql = sql + " a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,CHR_ENGGSTATUS FROM  inv_t_servicecallbooking  a,  inv_m_servicecustomerinfo b   ";
		sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID   AND CHR_SERVICECALLNO='"+callid+"' ";
		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(readData.length>0)
		{
			out.println("<center><table bgcolor='#ffffff' width=100% border=1><tr><td class='boldEleven'><b>Customer Name");
			out.println("<td class='boldEleven'><b>Serial Number");
			out.println("<td class='boldEleven'><b>Booking Date");
			out.println("<td class='boldEleven'><b>Contact Person");
			out.println("<td class='boldEleven'><b>Contact Address");
			out.println("<td class='boldEleven'><b>Contact Mobile");
			out.println("<td class='boldEleven'><b>Contact Email");
			
			for(int u=0;u<readData.length;u++)
			{
				out.println("<tr><td class='boldEleven'>"+readData[u][0]);
				out.println("<td class='boldEleven'>"+readData[u][1]);
				out.println("<td class='boldEleven'>"+readData[u][2]);
				out.println("<td class='boldEleven'>"+readData[u][4]);
				out.println("<td class='boldEleven'>"+readData[u][5]);
				out.println("<td class='boldEleven'>"+readData[u][6]);
				out.println("<td class='boldEleven'>"+readData[u][7]);
				
			}
			out.println("</table></center>");
		}

							  %></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reassign</td>
							  <td height="17" valign="top" class="boldEleven">
							  <%
							  String db="";
							  if("R".equals(readData[0][8]))
							  	db= " checked='checked' ";
							  %>
							  <input name="reassign" type="checkbox" id="reassign" <%=db%>  value="Y"></td>
							  <td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Call Assign 
								Date</td>
								<td height="17" valign="top" class="boldEleven"><input
									name="startdate" type="text" class="formText135" id="startdate"
									onKeyPress="dateOnly(this)" size="27" maxlength="10" /> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['startdate']);
							cal1.year_scroll = true;
							cal1.time_comp = true;
							setCurrentDateandTime('startdate'); 
						//-->
                       </script></td>
								<td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>

							<tr>
							  <td height="17" colspan="4" class="boldEleven">
							  <%@ include file="../JavaScript/ajax.jsp"%>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						      <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">

								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="Submit"
											class="buttonbold13" id="submit" value="Submit"   accesskey="s"   ></td>
										<td width="56"><input type="Button" class="buttonbold13"
											onClick="redirect('servicecallassign.jsp')"  value="Close"   accesskey="c" >										</td>
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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

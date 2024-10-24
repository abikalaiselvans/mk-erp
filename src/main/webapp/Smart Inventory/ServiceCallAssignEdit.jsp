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

<script language="JavaScript">

					   
  function Validate()
  {
	if(	
		checkNull("startdate","Enter Starting Date")
		&&checkNull("enddate","Enter Closing Date")
		&&checkNull("description","Enter Engineer description..")
		&&checkNull("cperson","Enter Contact Person")		
		&&checkNull("cmobile","Enter Contact mobile")		
		&&checkNull("caddress","Enter Contact Address")		
		&&checkNull("cemail","Enter Contact email")	
		&&checkNullSelect("callstatus","Select Call Status",'0')	
		&&checkcalldate()
		)
		{
		return true;	
		}
	else
		return false;			
  } 
 

 function  checkcalldate()
 {
 		var callid = document.getElementById('callid').value;
		var startdate = document.getElementById('startdate').value;
		var enddate = document.getElementById('enddate').value;
		var bookingdate = document.getElementById('bookingdate').value;
		
		
 		var url = "../inventory?actionS=INVCustomerServiceCallCreditLimit&callid="+escape(callid)+"&startdate="+escape(startdate)+"&enddate="+escape(enddate)+"&bookingdate="+bookingdate;
		initRequest(url);
		req.onreadystatechange=creditlimtRequest;
    	req.open("GET", url, true);
    	req.send(null);
		var ch = document.getElementById('credit').value;
		if(ch == "true")
		{
			return true;
		}	
		else
		{
			return false;
		}	
		 
				
	}
	
	function creditlimtRequest() 
 	{
 			if(req.readyState == 4) 
			{    	
				if (req.status == 200) 
				{		  	
				  creditlimtMessages();
				}
			}
	}
	
	
function creditlimtMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Detailss")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Field1 = batch.getElementsByTagName("Valid")[0].childNodes[0].nodeValue;
			if(Field1 == "False")
			{
				alert("Kindly check starting date , ending dat and previous closing date");	
				document.getElementById('credit').value = "false";
			}
			else
				document.getElementById('credit').value = "true";
				
		}
	 	
	
}
 
function sparedisplay1()
{
	sparedesc.style.visibility="hidden";
}

function sparedisplay()
{
	sparedesc.style.visibility="Visible";
}</script>

<body    onLoad="sparedisplay1()"  >
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
									class="boldThirteen">Service Call History </td>
							</tr>
							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							 
							<tr>
							  <td width="19%" height="17" valign="top" class="boldEleven">Call Number </td>
							  <td width="28%" height="17" valign="top" class="boldEleven">
							  
							  <%
							  String callid = request.getParameter("Bookingid");
							  out.println("<b>"+callid+"</b>");
							  
		String sql= " SELECT FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H:%i:%s %p'), ";
		sql = sql + " DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H:%i:%s %p'),a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS, ";
		sql = sql + " a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,CHR_BOOKINGEMPID,DT_ASSIGNDATE FROM  inv_t_servicecallbooking  a,  inv_m_servicecustomerinfo b   ";
		sql = sql + " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID   AND CHR_SERVICECALLNO='"+callid+"' ";
		 
		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							  %>
							 
							  <input name="filename"	type="hidden" value="ServiceCallAssign" />
                              <input name="actionS"		type="hidden" value="INVServiceCallAssignHistoryAdd" />
                              <input name="callid" type="hidden" id="callid" value="<%=callid%>">
							  <input name="empid" type="hidden" id="empid" value="<%=readData[0][8]%>">
							  <input name="serial" type="hidden" id="serial"  value="<%=readData[0][1]%>">
							  <input name="assigndt" type="hidden" id="assigndt" value="<%=readData[0][9]%>">							  <input name="credit" type="hidden" id="credit">
							  <input name="bookingdate" type="hidden" id="bookingdate" value="<%=readData[0][2]%>"></td>
							  <td width="20%" align="left" valign="top" class="boldEleven">Engineer  </td>
						      <td width="33%" align="left" valign="top" class="boldEleven">
							  <%
							  
							  String pdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff  WHERE CHR_EMPID='"+readData[0][8]+"'");
							  out.print(pdata[0][0]+" / "+pdata[0][1]);

%>							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
                              <%

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
                              <td height="17" class="boldEleven">Contact Person </td>
							  <td height="17" class="boldEleven"><input name="cperson" type="text" class="formText135" id="cperson" value="<%=readData[0][4]%>" size="30" maxlength="100"></td>
							  <td align="left" class="boldEleven">Contact Address </td>
							  <td align="left" class="boldEleven"><span class="boldEleven">
                                <input name="caddress" type="text" class="formText135" id="caddress" value="<%=readData[0][5]%>" size="25" maxlength="100">
                              </span></td>
						  </tr>
							<tr>
                              <td height="17" class="boldEleven">Contact Mobile </td>
							  <td height="17" class="boldEleven"><input name="cmobile" type="text" class="formText135" id="cmobile" value="<%=readData[0][6]%>" size="30" maxlength="12"></td>
							  <td align="left" class="boldEleven">Contact Email </td>
							  <td align="left" class="boldEleven"><input name="cemail" type="text" class="formText135" id="cemail" value="<%=readData[0][7]%>" size="25" maxlength="100"></td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Starting 
								Date &amp; Time </td>
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
								<td align="left" valign="top" class="boldEleven">Closing  
								Date &amp; Time </td>
							  <td align="left" valign="top" class="boldEleven"><input
									name="enddate" type="text" class="formText135" id="enddate"
									onKeyPress="dateOnly(this)" size="27" maxlength="10" />
                                <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal2 = new calendar1(document.forms['frm'].elements['enddate']);
							cal2.year_scroll = true;
							cal2.time_comp = true;
							setCurrentDateandTime('enddate'); 
						//-->
                                </script></td>
							</tr>
							<tr>
							  <td height="17" colspan="2" valign="top" class="boldEleven"><strong>Remarks / Reason / Problem Description </strong></td>
							  <td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><div align="center">
							    <textarea name="description" cols="120" rows="3" class="formText135" id="description"></textarea>
						      </div></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Call closed </td>
							  <td height="17" valign="top" class="boldEleven"><%
							  String db="";
							  //if("R".equals(readData[0][8]))
							  	//db= " checked='checked' ";
							  %>
                                <input name="close" type="checkbox" id="close" <%=db%>  value="Y"></td>
							  <td align="left" valign="top" class="boldEleven">Spare Wanted </td>
							  <td align="left" valign="top" class="boldEleven"><table width="95" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td class="boldEleven"><input name="Spare" type="radio" value="Y" onClick="sparedisplay()"></td>
                                  <td class="boldEleven">Yes</td>
                                  <td class="boldEleven"><input name="Spare" type="radio" value="N" checked  onClick="sparedisplay1()">
<script language="javascript">


</script>								  
								  
								  
								  </td>
                                  <td class="boldEleven">No</td>
                                </tr>
                              </table></td>
						  </tr>
							
							
							<tr>
							  <td height="17" colspan="4" class="boldEleven"> 
							  <table id='sparedesc' width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td><strong>Spare Description </strong></td>
                                </tr>
                                <tr>
                                  <td><div align="center">
                                    <textarea name="spare" cols="120" rows="3" class="formText135" id="spare"></textarea>
                                  </div></td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Call Status </td>
							  <td height="17" class="boldEleven">
							  <select name="callstatus" id="callstatus">
							  	<option value="0">Select</option>
							  	<option value="1">Pending for Spare</option>
								<option value="2">Pending for Response</option>
							  	<option value="3">Pending for Customer</option>
							  	<option value="4">Under Observation</option>
							  	<option value="5">Closed</option>
							    </select>							  </td>
							  <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						      <td align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" class="boldEleven"><strong>Previous Call History </strong></td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" class="boldEleven">
  <%
	  sql = " SELECT b.CHR_STAFFNAME , DATE_FORMAT(a.DT_ATTENDATE,'%d-%m-%Y %H :%i :%s %p'), DATE_FORMAT(a.DT_CLOSEDATE,'%d-%m-%Y %H :%i :%s %p'),a.CHR_ENGGDESC,a.CHR_SPARE, ";
	  sql = sql + " a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL ,a.CHR_CALLSTATUS";
	  sql = sql + "  FROM   inv_t_servicecallbookingtrack a ,com_m_staff b ";
	  sql = sql +  " WHERE a.CHR_EMPID =b.CHR_EMPID ";
	  sql = sql + " AND a.CHR_SERVICECALLNO='"+callid+"' ORDER BY INT_TRACKID ";
	  
	  
	  
	  
	  String Previousdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	  if(Previousdata.length>0)
	  {
	  	out.println("<center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' ><tr class='MRow1'><td class='boldEleven' ><b>S.No");
		out.println("<td class='boldEleven'><b>Engineer Name");
		out.println("<td class='boldEleven'><b>Starting date");
		out.println("<td class='boldEleven'><b>Closing Date");
		out.println("<td class='boldEleven'><b>Description");
		out.println("<td class='boldEleven'><b>Spare Request");
		out.println("<td class='boldEleven'><b>Contact Person");
		out.println("<td class='boldEleven'><b>Contact Address");
		out.println("<td class='boldEleven'><b>Contact Mobile");
		out.println("<td class='boldEleven'><b>Contact Email");
		out.println("<td class='boldEleven'><b>Call Status");
	  	for(int u=0;u<Previousdata.length;u++)
		{
			
			if(u%2==0)
				out.println("<tr class='MRow1'>");
			else
		    	out.println("<tr class='MRow2'>");	
			out.println("<td class='boldEleven'>"+(u+1));
			out.println("<td class='boldEleven'>"+Previousdata[u][0]);
			out.println("<td class='boldEleven'>"+Previousdata[u][1]);
			out.println("<td class='boldEleven'>"+Previousdata[u][2]);
			out.println("<td class='boldEleven'>"+Previousdata[u][3]);
			out.println("<td class='boldEleven'>"+Previousdata[u][4]);
			out.println("<td class='boldEleven'>"+Previousdata[u][5]);
			out.println("<td class='boldEleven'>"+Previousdata[u][6]);
			out.println("<td class='boldEleven'>"+Previousdata[u][7]);
			out.println("<td class='boldEleven'>"+Previousdata[u][8]);
			if("1".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Spare");
			else if("2".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Response");
			else if("3".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Pending for Customer");
			else if("4".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Under Observation");
			else if("5".equals(Previousdata[u][9]))
				out.println("<td class='boldEleven'>Closed");
				 
			
		}
		out.println("</table></center>");
	  }
   
  %>							  </td>
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
 out.println(e.getMessage());
}
%>

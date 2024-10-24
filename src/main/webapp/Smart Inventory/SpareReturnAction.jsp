<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 

<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">SPARE ISSUE 
                                  <%
	String branchid=""+session.getAttribute("BRANCHID");
	String usertype=""+session.getAttribute("USRTYPE");
	String user= ""+session.getAttribute("USRID"); 
	
	String action=""+request.getParameter("action1");
	 
	 
	String 	customer="",customeraddress="",calltype="",memo="",callnumber="",demanddate="",despatchlocation="",entryby="",id="", actionS="",value="";
	String sql="";
	String serialnumber="",issueddate="",issuestatus1="",issuestatus2="",issuestatus="" ;
	String returndate="";
	String returnstatus="";
	String returnserialnumber="";
	String through="",description=""	;
	if("Return".equals(action))
	{
		 
		customer="";memo="";callnumber="";demanddate="";despatchlocation="";id="";entryby=""; actionS="";value="";
		returndate="";returnstatus="";returnserialnumber="";customeraddress="";calltype="";
		id=request.getParameter("rowid");
		
		sql =  "  SELECT a.INT_DEMANID,CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,if(CHR_CALLTYPE='N','Not Qualified',if(CHR_CALLTYPE='M','No Machine','Qualified') ),a.CHR_PART_DESC,a.CHR_CALLNUMBER,   ";
		sql = sql+ "  DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y %h:%m:%s %p'),a.CHR_DESPATCH_LOCATION,   ";
		sql = sql+ "  FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY), a.CHR_ISSUED , ";
		sql = sql+ "  a.CHR_ISSUED_SERIALNUMBER,DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y %h:%m:%s'), if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ),a.CHR_ISSUE_DESC ,  ";
		sql = sql+ "  a.CHR_RETURN_STATUS,DATE_FORMAT(a.DAT_RETURN_DATE,'%d-%m-%Y %h:%m:%s'),a.CHR_RETURN_SERIALNUMBER  ";
		sql = sql+ "  FROM inv_t_sparedemand a WHERE a.INT_DEMANID= "+id;
		 
		String data[][]=CommonFunctions.QueryExecute(sql);
		if(data.length>0)
			for(int u=0;u<14;u++)
				if("-".equals(data[0][u]))
					data[0][u] = "";
		id=data[0][0];
		customer=data[0][1]; 
		customeraddress=data[0][2];  
		calltype=data[0][3];   
		memo=data[0][4];  
		callnumber=data[0][5];  
		demanddate=data[0][6];  
		despatchlocation=data[0][7]; 
		entryby=data[0][8]; 
		issuestatus=data[0][9]; 
		serialnumber=data[0][10]; 
		issueddate=data[0][11]; 
		through=data[0][12]; 
		description=data[0][13]; 
		returnstatus=data[0][14]; 
		returndate=data[0][15]; 
		returnserialnumber=data[0][16]; 
		
		actionS="INVSpareReturnadd";
		value="Update";
		 
	}
	else
	{
		id=request.getParameter("rowid");
		sql =  "  SELECT a.INT_DEMANID,CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,if(CHR_CALLTYPE='N','Not Qualified',if(CHR_CALLTYPE='M','No Machine','Qualified') ),a.CHR_PART_DESC,a.CHR_CALLNUMBER,   ";
		sql = sql+ "  DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y %h:%m:%s %p'),a.CHR_DESPATCH_LOCATION,   ";
		sql = sql+ "  FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY), a.CHR_ISSUED , ";
		sql = sql+ "  a.CHR_ISSUED_SERIALNUMBER,DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%b-%Y %h:%m:%s'), if(a.CHR_ISSUE_THROUGH='C','Courier',if(a.CHR_ISSUE_THROUGH='P','Person','Vechicle') ),a.CHR_ISSUE_DESC ,  ";
		sql = sql+ "  a.CHR_RETURN_STATUS,DATE_FORMAT(a.DAT_RETURN_DATE,'%d-%m-%Y %h:%m:%s'),a.CHR_RETURN_SERIALNUMBER  ";
		sql = sql+ "  FROM inv_t_sparedemand a WHERE a.INT_DEMANID= "+id;
		 
		String data[][]=CommonFunctions.QueryExecute(sql);
		if(data.length>0)
			for(int u=0;u<14;u++)
				if("-".equals(data[0][u]))
					data[0][u] = "";
		id=data[0][0];
		customer=data[0][1]; 
		customeraddress=data[0][2];  
		calltype=data[0][3];   
		memo=data[0][4];  
		callnumber=data[0][5];  
		demanddate=data[0][6];  
		despatchlocation=data[0][7]; 
		entryby=data[0][8]; 
		issuestatus=data[0][9]; 
		serialnumber=data[0][10]; 
		issueddate=data[0][11]; 
		through=data[0][12]; 
		description=data[0][13]; 
		returnstatus=data[0][14]; 
		returndate=data[0][15]; 
		returnserialnumber=data[0][16];  
		actionS="INVSpareReturnEdit";
		value="Update";
	}

						
						
%>							  </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							 
							<tr>
								<td width="153" height="17" class="boldEleven"><span class="boldEleven">Customer </span></td>
								<td width="233" colspan="2" align="left"><%=customer%>								</td>
							</tr>
							<tr>
                              <td height="17" align="left" valign="top" class="boldEleven">Customer Address </td>
							  <td colspan="2" align="left" valign="top"><%=customeraddress%></td>
						  </tr>
							<tr>
                              <td height="17" align="left" valign="top" class="boldEleven">Call Type </td>
							  <td colspan="2" align="left" valign="top"><%=calltype%></td>
						  </tr>
							
							<tr>
							  <td height="17" align="left" valign="top" class="boldEleven">Part Description</td>
							  <td colspan="2" align="left" valign="top">
 <%=memo%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Call Number</td>
							  <td colspan="2" align="left"> <%=callnumber%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Demand Raising Date</td>
							  <td colspan="2" align="left"><div align="left">
                                 <%=demanddate%>
								
                              
 
							  
							  
							  
							  </div></td>
						  </tr>
							 
							<tr>
							  <td height="17" class="boldEleven">Despatch Location</td>
							  <td colspan="2" align="left"> <%=despatchlocation%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Demand Raised By </td>
							  <td colspan="2" align="left"><%=entryby%></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Serial Number <span class="boldElevenlink"></span></td>
							  <td colspan="2" align="left"><%=serialnumber%>
							  
							   
							  <input type="hidden" name="dbserialnumber" id="dbserialnumber" value="<%=serialnumber%>"></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Issued Date <span class="boldElevenlink"></span></td>
							  <td colspan="2" align="left"><%=issueddate%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Issue</td>
							  <td colspan="2" align="left"> 
							   <%
							  
							  if("Y".equals(issuestatus))
							  	out.println("Issued");
							  else
							  	 out.println("Not Issue");
							  %>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Despatch Through</td>
							  <td colspan="2" align="left"><%=through%></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Despatch Description </td>
							  <td colspan="2" align="left"><%=description%></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Serial Number <span class="boldElevenlink"> *</span></td>
							  <td colspan="2" align="left"><input name="returnserialnumber" type="text"  class="formText135" id="returnserialnumber"   onkeyup="upperMe(this)" value="<%=returnserialnumber%>" size="25" maxlength="25"  title="Please enter the return serial number" required ></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Return<span class="boldElevenlink"> * </span></td>
							  <td colspan="2" align="left">
							  <select name="returnstatus" id="returnstatus"  title="Please select return status" required >
							  <option value="">Select Return Status</option>
							  <option value="Y">Return Good</option>
							  <option value="B">Return Bad</option>
							  <option value="N">Pending</option>
							  </select>
							  <script language="javascript">setOptionValue('returnstatus','<%=returnstatus%>')</script>							  							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Return Date <span class="boldElevenlink"> * </span></td>
							  <td colspan="2" align="left">
							  
							  <input name="returndate"  type="text" class="formText135" id="returndate" tabindex="2" size="25" maxlength="25" readonly="readonly"  title="Please enter the return date" required >
								<%
								if("Return".equals(action))
								{
								%>
								<script language="javascript">setCurrentDateandTime('returndate')</script>
								<%
								}
								else
								{
								%>
								<script language="javascript">document.getElementById('returndate').value="<%=returndate%>";</script>
								<%
								}
								%>
								
                              
							  
<script language="javascript">


$('#returndate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	minDate: -4, maxDate: "+1D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});

 
</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><span class="boldEleven">
								  <input type="hidden" name="filename" value="SpareDemand" />
                                  <input type="hidden" name="actionS"  value="<%=actionS%>" />
                                  <input name="id" type="HIDDEN" id="id" value="<%=id%>">
                                </span></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="<%=value%>"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SpareIssued.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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

<script>
function  validate()
{
	try
	{
		
		
		if(
			 checkSerialNumber()	
			&& checkNullSelect("returnstatus","Select Return Type","")
			&& checkNull("returndate","Enter return date")	
			&& checkNull("returnserialnumber","Enter return serial number")		
			
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


function checkSerialNumber()
{
	try
	{
		var s1 = document.getElementById('dbserialnumber').value;
		var s2 = document.getElementById('returnserialnumber').value;
		s1 = s1.toLowerCase();
		s2 = s2.toLowerCase();
		if(s1 == s2)
		{
			
			setOptionValue('returnstatus','Y');
			return true;
		}	
		else
		{
			setOptionValue('returnstatus','B');
			alert("Serial Numbers are not same...");
			return true;
		}	
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
</script>
 

<%@ include file="../footer.jsp"%></form>
</body>
</html>
<%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
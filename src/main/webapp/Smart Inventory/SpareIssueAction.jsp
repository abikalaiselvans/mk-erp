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
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
 
<script>
function  validate()
{
	try
	{
		if(
			checkNull( "itype","Select Item/Product" )
			&& checkNull("serialnumber","Enter the serialnumber")
			&& checkNull("issueddate","Enter issued date")		
			&& checkNullSelect("through","Select despatch through",'0')		
			&& checkNull("description","Enter the description")		
				
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
 <script type="text/javascript">
function lookup(serialnumber) 
{
	if(serialnumber.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		
		if(checkNull( "itype","Select Item/Product" ))
		 {
			$.post("serialnumberget.jsp?itype="+document.getElementById('itype').value+"&item="+document.getElementById('item').value, {queryString: ""+serialnumber+""},   function(data)
			{
				if(data.length >0) 
				{
					$('#suggestions').show();
					$('#autoSuggestionsList').html(data);
				}
			});
		}
		
			
	}
}

function fill(thisValue) 
{
	document.getElementById('serialnumber').value=thisValue;
	$('#serialnumber').val(thisValue);
	setTimeout("$('#suggestions').hide();", 200);
}
</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>







 <script type="text/javascript">
var divi="";
function Loaditemproduct(ctr,div) 
{
	if(ctr.value=="")
	{
		alert("Kindly select Product or Item")
		ctr.focus();
	}
	else
	{
		var type="C";
		if(document.getElementById('sparetype2').checked)
			type="S";
		
		var url = "../inventory?actionS=INVItemProductSparemodule&id="+escape(ctr.value)+"&type="+type;
		divi = div;
		initRequest(url);
		req.onreadystatechange = itemproductRequest;
		req.open("GET", url, true);
		req.send(null);
	}	
}

function itemproductRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("items")[0];   
   s1 ='item';
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' style='width:200'>"; 
		if(document.getElementById('sparetype2').checked)
			str = str+"<option value=0>All</option>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
 			str = str+"<option value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById(divi);
  	   tb.innerHTML=str  ; 
 }
</script>



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
	String refno="";
	 
	String 	customer="",customeraddress="",calltype="",productserialnumber="",memo="",callnumber="",demanddate="",despatchlocation="",entryby="",id="", actionS="",value="";
	String through="",description=""	;
	String sql="";
	String serialnumber="",issueddate="",issuestatus1="",issuestatus2="",issuestatus="" ;
	 
	 
	if("Issue".equals(action))
	{
		 
		customer="";productserialnumber=""; memo="";callnumber="";demanddate="";despatchlocation="";id="";entryby=""; actionS="";value="";through="";description=""	; customeraddress="";calltype="";refno="";
		id=request.getParameter("rowid");
		
		sql =  "  SELECT a.CHR_DEMANDNO,CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,if(CHR_CALLTYPE='N','Not Qualified',if(CHR_CALLTYPE='M','No Machine','Qualified') ),a.CHR_PRODUCT_SERIALNUMBER,a.CHR_PART_DESC,a.CHR_CALLNUMBER,   ";
		sql = sql+ "  DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y %h:%m:%s %p'),a.CHR_DESPATCH_LOCATION,   ";
		sql = sql+ "  FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY), a.CHR_ISSUED , ";
		sql = sql+ "  a.CHR_ISSUED_SERIALNUMBER,DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%m-%Y %h:%m:%s'),  ";
		sql = sql+ "  a.CHR_ISSUE_THROUGH,a.CHR_ISSUE_DESC FROM inv_t_sparedemand a WHERE a.INT_DEMANID= "+id;
		String data[][]=CommonFunctions.QueryExecute(sql);
		if(data.length>0)
			for(int u=0;u<14;u++)
				if("-".equals(data[0][u]))
					data[0][u] = "";
		refno=data[0][0];
		customer=data[0][1];  
		customeraddress=data[0][2];  
		calltype=data[0][3];  
		productserialnumber=data[0][4];  
		memo=data[0][5];  
		callnumber=data[0][6];  
		demanddate=data[0][7];  
		despatchlocation=data[0][8]; 
		entryby=data[0][9]; 
		issuestatus=data[0][10]; 
		serialnumber=data[0][11]; 
		issueddate=data[0][12]; 
		through=data[0][13]; 
		description=data[0][14]; 
		actionS="INVSpareIssueadd";
		value="Update";
		 
	}
	else
	{
		id=request.getParameter("rowid");
		sql =  "  SELECT a.CHR_DEMANDNO,CHR_CUSTOMER,CHR_CUSTOMER_ADDRESS,if(CHR_CALLTYPE='N','Not Qualified',if(CHR_CALLTYPE='M','No Machine','Qualified') ),a.CHR_PRODUCT_SERIALNUMBER,a.CHR_PART_DESC,a.CHR_CALLNUMBER,   ";
		sql = sql+ "  DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%b-%Y %h:%m:%s %p'),a.CHR_DESPATCH_LOCATION,   ";
		sql = sql+ "  FIND_A_EMPLOYEE_ID_NAME(a.CHR_DEMAND_RAISED_BY), a.CHR_ISSUED , ";
		sql = sql+ "  a.CHR_ISSUED_SERIALNUMBER,DATE_FORMAT(a.DAT_ISSUED_DATE,'%d-%m-%Y %h:%m:%s'),  ";
		sql = sql+ "  a.CHR_ISSUE_THROUGH,a.CHR_ISSUE_DESC FROM inv_t_sparedemand a WHERE a.INT_DEMANID= "+id;
		
		
		String data[][]=CommonFunctions.QueryExecute(sql);
		if(data.length>0)
			for(int u=0;u<14;u++)
				if("-".equals(data[0][u]))
					data[0][u] = "";
		refno=data[0][0];
		customer=data[0][1];  
		customeraddress=data[0][2];  
		calltype=data[0][3];  
		productserialnumber=data[0][4];  
		memo=data[0][5];  
		callnumber=data[0][6];  
		demanddate=data[0][7];  
		despatchlocation=data[0][8]; 
		entryby=data[0][9]; 
		issuestatus=data[0][10]; 
		serialnumber=data[0][11]; 
		issueddate=data[0][12]; 
		through=data[0][13]; 
		description=data[0][14];  
		actionS="INVSpareIssueEdit";
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
							  <td height="17" class="boldEleven">Spare Ref No </td>
							  <td colspan="2" align="left" class="boldEleven"><%=refno%></td>
						  </tr>
							<tr>
								<td width="153" height="17" class="boldEleven"><span class="boldEleven">Customer </span></td>
								<td width="233" colspan="2" align="left" class="boldEleven"><%=customer%>								</td>
							</tr>
							<tr>
							  <td height="17" align="left" valign="top" class="boldEleven">Customer Address </td>
							  <td colspan="2" align="left" valign="top" class="boldEleven"><%=customeraddress%></td>
						  </tr>
							<tr>
							  <td height="17" align="left" valign="top" class="boldEleven">Call Type </td>
							  <td colspan="2" align="left" valign="top" class="boldEleven"><%=calltype%></td>
						  </tr>
							<tr>
							  <td height="17" align="left" valign="top" class="boldEleven">Product Serial Number</td>
							  <td colspan="2" align="left" valign="top" class="boldEleven"><%=productserialnumber%></td>
						  </tr>
							<tr>
							  <td height="17" align="left" valign="top" class="boldEleven">Part Description</td>
							  <td colspan="2" align="left" valign="top" class="boldEleven">
 <%=memo%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Call Number</td>
							  <td colspan="2" align="left" class="boldEleven"> <%=callnumber%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Demand Raising Date</td>
							  <td colspan="2" align="left" class="boldEleven"><div align="left">
                                 <%=demanddate%>
								
                              
 
							  
							  
							  
							  </div></td>
						  </tr>
							 
							<tr>
							  <td height="17" class="boldEleven">Despatch Location</td>
							  <td colspan="2" align="left" class="boldEleven"> <%=despatchlocation%> </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Demand Raised By </td>
							  <td colspan="2" align="left" class="boldEleven"><%=entryby%></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Spare Type
							  <script language="javascript">
							  	function enable ()
								{
										serialrow.style.visibility="Visible";
										 
										var _targ=document.getElementsByName('itype')[0];       
										_targ.options.length=0;
										_targ.options[0]=new Option('Select','');  
										_targ.options[1]=new Option('Item','1');  
										_targ.options[2]=new Option('Product','2');  
											
								}
								
								
								function disable ()
								{
									serialrow.style.visibility="hidden";
									var _targ=document.getElementsByName('itype')[0];       
									_targ.options.length=0;
									_targ.options[0]=new Option('Select','');  
									_targ.options[1]=new Option('Product','2'); 
								}
								
							  </script>
							      <span class="boldElevenlink">* </span></td>
							  <td colspan="2" align="left" class="boldEleven"><table width="147" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td align="left"><input name="sparetype"   id="sparetype1"  onClick="disable()"  type="radio" value="C" <%=issuestatus1%> ></td>
                                  <td class="boldEleven">Consumables</td>
                                  <td class="boldEleven"><input onClick="enable()"  id="sparetype2"  name="sparetype" type="radio" value="S" checked <%=issuestatus2%>></td>
                                  <td class="boldEleven">SerialNumber</td>
                                </tr>
                              </table></td>
						  </tr>
							<tr  >
							  <td class="boldEleven">Product Type <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"> <select class='formText135'
									name='itype' id='itype' onChange="Loaditemproduct(this,'code')"  style="width:200">
                                <option value="" selected>Select</option>
                                <option value='1'>Item</option>
                                <option value='2'>Product</option>
                                                                                          </select></td>
						  </tr>
							<tr  >
							  <td class="boldEleven">Item / Product Code <span class="boldred">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"> <div id="code"></div></td>
						  </tr>
							<tr id="serialrow">
							  <td height="17" class="boldEleven">Spare Serial Number   <span class="boldElevenlink">* </span></td>
							  <td colspan="2" align="left" class="boldEleven"><input name="serialnumber" type="text"  class="formText135" id="serialnumber"  onBlur="upperMe(this),fill();"   onkeyup="lookup(this.value);" value="<%=serialnumber%>" size="25" maxlength="25"  title="Please enter the serial number" required >
							  
							  <div class="suggestionsBox" id="suggestions" style="display: none;">
											<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
								</div> 
							  <input type="hidden" name="dbserialnumber" id="dbserialnumber" value="<%=serialnumber%>"></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Spare Issued Date   <span class="boldElevenlink">* </span></td>
							  <td colspan="2" align="left" class="boldEleven"><input name="issueddate"  type="text" class="formText135" id="issueddate" tabindex="2" value="<%=issueddate%>" size="25" maxlength="25" readonly="readonly"  title="Please enter the issue date" required >
							  
<%
								if("Issue".equals(action))
								{
								%>
								<script language="javascript">setCurrentDateandTime('issueddate')</script>
								<%
								}
								else
								{
								%>
								<script language="javascript">document.getElementById('issueddate').value="<%=issueddate%>";</script>
								<%
								}
								%>							  
							  
<script language="javascript">
 
$('#issueddate').datetimepicker({
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
							  <td colspan="2" align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Spare Issue 
							  <%
							  
							  if("Y".equals(issuestatus))
							  	issuestatus1 =" checked ='checked' ";
							  else
							  	 issuestatus2 =" checked ='checked' ";	
							  %>
							  
							   <span class="boldElevenlink">* </span></td>
							  <td colspan="2" align="left" class="boldEleven"><table width="147" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="20"><input name="issuestatus" type="radio" value="Y" <%=issuestatus1%> ></td>
                                  <td width="37" class="boldEleven">Issue</td>
                                  <td width="20" class="boldEleven"><input name="issuestatus" type="radio" value="N" <%=issuestatus2%>></td>
                                  <td width="70" class="boldEleven">Not Issue </td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Despatch Through <span class="boldElevenlink">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"><span class="boldEleven">
							    <select name="through" class="formText135"  id="through" style="width:125" onChange="courierEnable()">
                                  <option value="0">Select Despatch</option>
                                  <option value="C">Courier</option>
                                  <option value="P">Person</option>
                                  <option value="V">Vechicle</option>
                                </select>
								<script language="javascript">setOptionValue('through','<%=through%>')</script>
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Despatch details  <span class="boldElevenlink">*</span></td>
							  <td colspan="2" align="left" class="boldEleven"><textarea onKeyUp="textArea('memo','500')" name="description" cols="30"    onBlur="upperMe(this)"    rows="5" class="formText135" id="description" tabindex="9" title="Please enter the part description" required ><%=description%></textarea></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left" class="boldEleven"><span class="boldEleven">
								  <input type="hidden" name="filename" value="SpareDemand" />
                                  <input type="hidden" name="actionS"  value="<%=actionS%>" />
                                  <input name="id" type="HIDDEN" id="id" value="<%=refno%>">
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
								<td colspan="2" align="left" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
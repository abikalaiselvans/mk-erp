<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
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
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {; font-size: 12px; ; color: #202B78; ; font-family: Verdana, Arial, Sans-serief;}
-->
</style>
</head>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">


		   

 
 
function checkcallserialnos()
{
	return checkcallserialno();
}

 
	function createRequestObject() 
	{
			var tmpXmlHttpObject;
			if (window.XMLHttpRequest) 
			{ 
				tmpXmlHttpObject = new XMLHttpRequest();
			  }
			else if (window.ActiveXObject) 
			{ 
				tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return tmpXmlHttpObject;
	}


	var http = createRequestObject();
	function makeGetRequest(wordId) 
	{
		var f ='CustomerInsert.jsp?id=' + wordId.value;
		http.open('get', f);
		http.onreadystatechange = processResponse;
		http.send(null);
	}

	function processResponse() 
	{
		if(http.readyState == 4){
			var response = http.responseText;
			document.getElementById('description').innerHTML = response;
		}	
	}	
	
	
	
	
	
	
	 function  checkcallserialno()
 {
 		var serialno = document.getElementById('select').value;
		var startdate = document.getElementById('startdate').value;
		
		var url = "../inventory?actionS=CustomerServiceCallSerialnumberCheck&serialno="+escape(serialno)+"&startdate="+startdate;
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
				alert("Kindly check this serial number attended last 7 days");	
				document.getElementById('credit').value = "true";
			}
			else
				document.getElementById('credit').value = "true";
				
		}
	 	
	
}
 
	
	
 	  	
function LoadRuntimeCustomer(ctr)
{
 	try
 	{
 		alert();
		var _targ=document.getElementsByName('customerid')[0];
    	_targ.options.length=0;	 
		var opt = document.createElement("option");
		document.getElementById("customerid").options.add(opt); 
       	opt.text = "All";
        opt.value = "0";	 
		
		
		
		var id = ctr.value;
 		var url = "../inventory?actionS=LoadRuntimeCustomer&id="+escape(id);
		alert(url);
		initRequest(url);
    	req.onreadystatechange=RuntimeCustomerRequest;
		req.open("GET", url, true);
    	req.send(null);
		//LoadServiceAMC('0')
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function RuntimeCustomerRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  RuntimeCustomerMessages();
			}
		}
}
	
	
function RuntimeCustomerMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			var opt = document.createElement("option");
			document.getElementById("customerid").options.add(opt); 
       		opt.text = Name;
        	opt.value = Id;
		}
		 
	 	
	
}  
 	 

</script>

<body    onLoad="document.getElementById('customerid').focus()">
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" 	onSubmit="return Validate()">
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
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
							  <td height="17" valign="top" class="boldEleven">Service Center </td>
							  <td height="17" valign="top" class="boldEleven"><span class="copyright style3">
							    <select name="servicecenter" class="formText135"  id="servicecenter"       > <!--onChange="LoadRuntimeCustomer(this)" -->
                                  <option value="0">All</option>
                                  <%
				String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                                </select>
							  </span></td>
							  <td colspan="2" align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Customer
							  Name </td>
							  <td height="17" valign="top" class="boldEleven"><%

    
    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_CUSTOMERID, CHR_CUSTOMERNAME from inv_m_servicecustomerinfo WHERE INT_BRANCHID="+""+session.getAttribute("BRANCHID") +" ORDER BY CHR_CUSTOMERNAME");
								%>
                                <select name="customerid" id="customerid" class="formText135" onBlur="LoadAMCSerialNumberCustomerwise('customerid')">
                                  <option value="0">Select</option>
                                  <%                  
			if(readData.length >= 0)
				for(int i=0;i<readData.length;i++)
					out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
			else
				out.println("<option>Data not found..</option>");
				
		%>
                                </select></td>
							  <td colspan="2" align="left" valign="top"><div id="serialnumberlist"></div></td>
						  </tr>
						
						
						
							<!--<tr>
							  <td height="17" valign="top" class="boldEleven">Machine Serial Number </td>
							  <td height="17" valign="top" class="boldEleven"><input name="serialnumber" type="text" class="formText135" id="serialnumber" size="30" maxlength="100" onBlur="upperMe(this),LoadAMCSerialNumber('serialnumber','serialnumberlist' , 'inv_m_serviceamc','CHR_SERIALNO','Submit')"   onKeyPress="upperMe(this),LoadAMCSerialNumber('serialnumber','serialnumberlist' , 'inv_m_serviceamc','CHR_SERIALNO','Submit')"></td>
							  <td colspan="2" align="left" valign="top"></td>
						  </tr>-->
						  
						  
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="customerinfo"></div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Call Log Date</td>
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
								<td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" rowspan="3" valign="top" class="boldEleven">Problems</td>
								<td height="17" rowspan="3" valign="top" class="boldEleven"><textarea
									name="description" cols="30" rows="5" class="formText135"
									id="description" onKeyPress="charOnly('description','2000')" onBlur="charOnly('description','2000')"></textarea></td>
								<td align="left" valign="top" class="boldEleven">Complaint
								Type</td>
								<td align="left" valign="top" class="boldEleven">
								<table width="81%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="10%" class="boldEleven"><label> <input
											name="bookingtype" type="radio" value="D" checked> </label></td>
										<td width="15%" class="boldEleven">Direct</td>
										<td width="10%" class="boldEleven"><input
											name="bookingtype" type="radio" value="P"></td>
										<td width="25%" class="boldEleven">Phone</td>
										<td width="11%" class="boldEleven"><input
											name="bookingtype" type="radio" value="O"></td>
										<td width="29%" class="boldEleven">Others</td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td align="left" valign="top" class="boldEleven">Product
								Under</td>
								<td align="left" valign="top">
								<table width="78%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="10%" class="boldEleven"><input
											name="complainttype" id="complainttype" type="radio" value="A"></td>
										<td width="16%" class="boldEleven">AMC</td>
										<td width="11%" class="boldEleven"><input
											name="complainttype" id="complainttype"  type="radio" value="W" checked></td>
										<td width="25%" class="boldEleven">Warranty</td>
										<td width="10%" class="boldEleven"><input
											name="complainttype" id="complainttype"  type="radio" value="O"></td>
										<td width="28%" class="boldEleven">Oncall</td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;								</td>
								<td align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>

							<tr>
							  <td height="17" class="boldEleven">Contact Person </td>
							  <td height="17" class="boldEleven"><input name="cperson" type="text" class="formText135" id="cperson" size="30" maxlength="100"></td>
							  <td align="left" class="boldEleven">Address </td>
						      <td align="left" class="boldEleven"><span class="boldEleven">
						        <input name="caddress" type="text" class="formText135" id="caddress" size="25" maxlength="100">
						      </span></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Mobile </td>
							  <td height="17" class="boldEleven"><input name="cmobile" type="text" class="formText135" id="cmobile" size="30" onKeyPress="return numeric_only(event,'cmobile','10')" maxlength="15"></td>
							  <td align="left" class="boldEleven">Email </td>
						      <td align="left" class="boldEleven"><span class="boldEleven">
						        <input name="cemail" type="text" class="formText135" id="cemail" size="25" maxlength="100">
						      </span></td>
						  </tr>
							<tr>
								<td height="17" colspan="2" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="ServiceCall" />
							  <input name="actionS"
									type="hidden" value="INVServiceAdd" />
							    <input name="credit" type="hidden" id="credit" value="false"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">

								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="Submit"
											class="buttonbold13" id="submit" value="Submit"   accesskey="s"   ></td>
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
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="javascript">
  function Validate()
  {
	try
	{
		if(	
			checkNullSelect("select","Select Serial ","")
			&&checkNullSelect("customerid","Select Customer ","0")
			&&checkNull("startdate","Enter Complaint Date")
			&&checkNull("description","Enter Problems")		
			&&checkNull("cperson","Enter Contact Person")		
			&&checkNull("cmobile","Enter Contact mobile")		
			&&checkNull("caddress","Enter Contact Address")		
			&& chkemail("cemail")
			&& checkcallserialnos()
			)
			{ 
				return true;	
			} 
			else
			{
					return false;			
			}		
	}
	catch(err)
	{
		alert(err);
	}
  } 
 
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>

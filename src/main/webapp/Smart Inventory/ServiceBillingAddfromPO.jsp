<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
String dateCheckData[][] =  CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now(),'%d-%m-%Y'), DAT_LOCK,MONTHNAME(NOW()),MONTH(NOW()), YEAR(NOW())  FROM m_institution  WHERE INT_ID=1");

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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>

<%
	String taxsql="";
	taxsql="SELECT  INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax  WHERE DOU_VALUE!=12.36  ORDER BY CHR_TAXNAME";
	String data[][]= CommonFunctions.QueryExecute(taxsql);
	String datas="";
	
	for(int u=0; u<data.length;u++)
		datas= datas+"<option value="+data[u][0]+">"+data[u][1]+"</option>";
	
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerSalesCreditlimit.js"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
/*$(function() {
		$( "#saleDate" ).datepicker({ minDate: -2, maxDate: "+0D" });
	});
 */

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">









<script language="javascript">
var assigncontrol="";
 function resoffval()
{
	if(document.frm.Shipping[0].checked==true)
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval




	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	
	 
	//Intialise the Variables
	var row =1;
 	var r =1;
	var v1="";
 	var v2="";
 	var v3="";
 	var v4="";
 	var v5="";
 	var v6="";
 	var v7="";
 	var v8="";
 	var v9="";
 
 	//Dynamically insert a row in a table  -- ITEM
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s0= "Tax"+r;
		var s1= "Taxvalue"+r;
		var s2 = "Taxamount"+r;
		
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onchange=\"loadTaxcalculation(this,'"+s1+"')\"   onblur=\"loadTaxcalculation(this,'"+s1+"')\"><option value='Select'>Select</option><%=datas%></select>";
		x.insertCell(1).innerHTML="<input type='text' size=10 class='formText135' readonly='readonly'  name='"+s1+"' id ='"+s1+"' style='text-align:right'/>";
		x.insertCell(2).innerHTML="<input type='text' size=10 class='formText135' name='"+s2+"' id ='"+s2+"' value='0' style='text-align:right' readonly='readonly' />";
		x.insertCell(3).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('Tax'+(r-1)).focus();
	}
 
 	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		//if(row<=1)
			//Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		assigntotal() ;
	}

	function display()
	{
		var hs="";
		var hs1="";
		var hs2="";
		for(u=0; u<itemArray.length; u++)
			hs = hs+itemArray[u]+",";
		for(u=0; u<deleteArray.length; u++)
			hs1 = hs1+deleteArray[u]+",";
		
		var Array1 = hs.split(",");
		var Array2 = hs1.split(",");
		for(u=0; u<Array2.length; u++)
		{
			var a1value = Array2[u];
			for(v=0; v<Array1.length; v++)
			{
				if(Array2[u] == Array1[v])
					Array1[v]="";
			}
		}
		hs2="";
		for(v=0; v<Array1.length; v++)
			if(Array1[v]!="")
				hs2 = hs2 +	Array1[v]+",";
		
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		
	}
	
	
	
	
	function loadTaxcalculation(ctr, ctrassign) 
	{
		if(ctr.value !="Select")
		{
			assigncontrol=ctrassign;
			var url = "../inventory?actionS=INVLoadTaxcalculations&id="+escape(ctr.value);
			initRequest(url);
			req.onreadystatechange = TaxcalculationRequest;
			req.open("GET", url, true);
			req.send(null);
		}
		else
		{
			alert("Kindly Select tax...");
			ctr.focus();
		}	
	}

	function TaxcalculationRequest() 
	{	
		if(req.readyState == 4) 
    	{    	
    		if (req.status == 200)
        	{
        	   	TaxcalculationMessages();
        	}
    	}
	}


function TaxcalculationMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Taxs")[0];   
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[0];
        var Taxvalue = batch.getElementsByTagName("Taxvalue")[0];
		document.getElementById(assigncontrol).value=""+Taxvalue.childNodes[0].nodeValue;
		var total =parseFloat(document.getElementById('totals2').value);
		var tax = parseFloat(Taxvalue.childNodes[0].nodeValue);
		var amount = Round((tax/100)*total);
		var postion = assigncontrol.replace("Taxvalue","");
		document.getElementById("Taxamount"+postion).value=""+amount;
		
	 }  
	   assigntotal() ;
}


function assigntotal() 
{
	try
	{
		var controls = document.getElementById('param').value;
		var taxarray = controls.split(",");
		var totals=parseFloat(document.getElementById('totals').value);
		
		
		if(document.getElementById('servicetaxflag').checked)
		{
			var serviceamount12=parseFloat(document.getElementById('servicetax12').value);
			var serviceamount2=parseFloat(document.getElementById('servicetax2').value);
			var serviceamount1=parseFloat(document.getElementById('servicetax1').value);
			document.getElementById('st12').value = (totals * serviceamount12/100).toFixed(2);
			var s1 = parseFloat(document.getElementById('st12').value);
			document.getElementById('st2').value = (s1 * serviceamount2/100).toFixed(2);
			document.getElementById('st1').value = (s1 * serviceamount1/100).toFixed(2);
		}
		else
		{
			document.getElementById('st12').value =0;
			document.getElementById('st2').value =0;
			document.getElementById('st1').value =0;
			
		}
		
		var s1 = parseFloat(document.getElementById('st12').value);
		var s2 = parseFloat(document.getElementById('st2').value);
		var s3 = parseFloat(document.getElementById('st1').value);
		
		var sum=parseFloat( totals+(s1+s2+s3)).toFixed(2) ;
		document.getElementById('totals2').value =sum;
		
		
		var sum1=0;
		for(i=0;i<taxarray.length-1;i++)
		{
			var obj = findObj("Taxvalue"+taxarray[i]);
			if(obj != null)
			{
				var taxid = document.getElementById("Tax"+taxarray[i]).value;
				if(taxid!="Select")
				{
					var taxvalue = document.getElementById("Taxvalue"+taxarray[i]).value;
					var total =parseFloat(document.getElementById('totals2').value);
					var tax = parseFloat(taxvalue);
					var amount = Round((tax/100)*total);
					document.getElementById("Taxamount"+taxarray[i]).value=""+amount;
					sum1 = sum1 +parseFloat(amount);
				}
				else
				{
					alert("Kindly select Tax...");
					document.getElementById("Tax"+taxarray[i]).focus();
				}	
			}	
		}
		var t =parseFloat(sum)+parseFloat(sum1);
		document.getElementById('nettotal').value=Round(t);
	}
	catch(err)
	{
		alert(err.description);
	}	
}
	
</script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
					<td width="680">
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Service Billing Add							    </td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="errormessage">
							    <div align="center">
							      <%
							  	String er="";
								er = ""+request.getParameter("servicebillnumber");
								 
								String balance = ""+request.getParameter("balance");
								double b = Double.parseDouble(balance);
								if(!"null".equals(er))
								{
									%>
									<script language="javascript">
										alert(" Service bill number :: <%=er%>");
										 
									</script>	
									<%
									
									
									 
									
								}
								
							  %>
					            </div></td>
					      </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division <span class="boldred">* </span></td>
								<td width="199" align="left" valign="top">
<select name="divis" class="formText135" id="divis" tabindex="1" style="width:200" >
                    <option value='0'>Select</option>
                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>								</td>
							    <td width="105" class="boldEleven"><div align="left">Order Reference <span class="boldred">* </span></div></td>
							    <td width="148" class="boldEleven"><input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)" value="ORAL" maxlength="100"     
										 />                                                                    </td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Invoice date  <span class="boldred">* </span></td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"  value="<%=dateCheckData[0][0]%>" 
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly>
							   
                                
							  </span></td>
						      <td class="boldEleven"><div align="left">Delivery Note <span class="boldred">* </span></div></td>
						      <td class="boldEleven"><input name="dnote" type="text"
										class="formText135" id="dnote"
										    onBlur="upperMe(this)" value="NIL" maxlength="100"     /></td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">CustomerName <span class="boldred">* </span></div></td>
							  <td class="boldEleven"><div align="left">
							    
                                  <%
			
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			
			
			String CreditLimitData = CommonFunctions.QueryExecute("SELECT CHR_CUSTOMERCREDITLIMIT FROM  m_inventorysetting WHERE INT_ROWID=1")[0][0];
			String climit="";
			if("Y".equals(CreditLimitData))
				climit=" onblur=\"LoadCreditLimt('customer','creditdetail','S')\" ";
			else
				climit="";	
			%>
                                  
								  
								  
<select name="customer" id="customer" class="formText135" style="width: 200px"  onchange="loadAddress('customer','shippingaddress') " onBlur="LoadCreditAmount('customer')"  <%=climit%> >
  <option value="0">Select</option>
  <%
for(int y=0;y<custData.length;y++)
	out.println("<option  value='"+custData[y][0]+"'>"+custData[y][1]+ " ,"+custData[y][2]+ "  ,"+custData[y][3]+ "  ,"+custData[y][4]+ "  ,"+custData[y][5]+ "  ,"+custData[y][6]+ "</option>");	
%>
</select>								  
								  
								  
								  
							      <input name="pendingamount" type="hidden" id="pendingamount" value="0" />
                                  <input name="creditamount" type="hidden" id="creditamount" value="0" />
</div></td>
							  <td class="boldEleven"><div align="left">Despatch Via <span class="boldred">* </span></div></td>
							  <td class="boldEleven"><input name="dthru" type="text"
										class="formText135" id="dthru"
										    onBlur="upperMe(this)" value="INTERNAL COURIER" maxlength="100"     /></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
							  <td class="boldEleven"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                                    <td width="15%" class="boldEleven">Same</td>
                                    <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>
                                    <td width="24%" class="boldEleven">Different</td>
                                  </tr>
                                </table>
							      <div align="left"></div></td>
							  <td class="boldEleven"><div align="left">Destination  &nbsp;<span class="boldred">* </span></div></td>
							  <td class="boldEleven"><input name="destination"
										type="text" class="formText135" id="destination"     onBlur="upperMe(this)" value="CHENNAI"
										maxlength="100"      /></td>
						  </tr>
							<tr>
							  <td rowspan="2" valign="top" class="boldEleven">&nbsp;</td>
							  <td rowspan="2" valign="top" class="boldEleven"><div align="left">
							    <textarea name="shippingaddress"
										cols="35" rows="4" class="formText135" id="shippingaddress"></textarea>
                              </div></td>
							  <td class="boldEleven"><div align="left">Terms of Delivery <span class="boldred">* </span></div></td>
							  <td class="boldEleven"><input name="tdelivery" type="text"
										class="formText135" id="tdelivery"
										    onBlur="upperMe(this)" value="IMMIDIATE" maxlength="100"     /></td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">Contact Person <span class="boldred">* </span></div></td>
							  <td class="boldEleven"><input name="cdetails" type="text"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)" value="Mythra" maxlength="100"     /></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">Project   <span class="boldred">*</span></td>
							  <td valign="top" class="boldEleven"><select name="project"
							class="formText135" id="project" style="width:200"  
							 >
                                <option value='0'>Select</option>
                                <%
								String project[][] =  CommonFunctions.QueryExecute("SELECT INT_PROJECTID,CHR_PROJECTNAME FROM inv_m_project WHERE CHR_STATUS='Y' ORDER BY CHR_PROJECTNAME "); 
								for(int u=0; u<project.length; u++)
									out.print("<option value='"+project[u][0]+"'>"+project[u][1]  +"</option>");
							%>
                              </select></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">Payment Commitment Days <span class="ui-state-error-text">* </span></td>
							  <td valign="top" class="boldEleven"><select name="commitmentdays" class="formText135" id="commitmentdays"  style="width:200"  >
                                <option value="">Select Payment commitment Days</option>
                                <option value="0">Advance Amount</option>
                                <%
								  for(int u=1;u<=30;u++)
								  	out.println("<option value='"+u+"'>"+u+" - Days</option>");
								  %>
                              </select></td>
							  <td class="boldEleven"><div align="left">Contact No <span class="boldred">* </span></div></td>
							  <td class="boldEleven">
<input name="cnumber" type="text" class="formText135" id="cnumber" maxlength="11"   onKeyPress="return numeric_only(event,'cnumber','15')"/></td>
						  </tr>
							 
							
							
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							   <div id="creditdetail"> </div>
							<div id="creditdetailerror"> </div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference  <span class="boldred">* </span></td>
							  <td colspan="3" align="left"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                                <jsp:include page="Staffload.jsp" flush="true" />                              
</select>							    <div align="left"></div></td>
					      </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Description  <span class="boldred">* </span></td>
							  <td colspan="3" align="left"><textarea name="memo" cols="35" style="width:150"
										rows="5" class="formText135" id="memo" tabindex="9"></textarea>
							    <div align="left"></div></td>
					      </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Amount   <span class="boldred">* </span></td>
								<td align="left"><span class="boldEleven">
<input name="totals" type="text" class="formText135" id="totals" style='text-align:right' tabindex="11" onBlur="assigntotal()" value="0" maxlength="10"  onkeyup="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);" />
										
		 



								</span></td>
							    <td valign="top" class="boldEleven"><div align="left"></div></td>
							    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Calculate Service Tax </td>
							  <td align="left"><input name="servicetaxflag" type="checkbox" id="servicetaxflag" onClick="assigntotal()" value="Y" checked></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Tax 12% </td>
							  <td align="left"><input name="servicetax12" type="text" class="formText135" id="servicetax12" onKeyPress="return blockNonNumbers(this, event, true, true);"    onkeyup="extractNumber(this,2,true);" value="12"  maxlength="10" style="text-align:right"  readonly="readonly"></td>
							  <td valign="top" class="boldEleven">Amount</td>
							  <td valign="top" class="boldEleven"><input name="st12" type="text" class="formText135" id="st12" style='text-align:right'  readonly="readonly"/></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Tax &ndash; Education Cess  2% </td>
							  <td align="left"><input name="servicetax2" type="text" class="formText135" id="servicetax2" onKeyPress="return blockNonNumbers(this, event, true, true);"    onkeyup="extractNumber(this,2,true);" value="2"  maxlength="10" style="text-align:right"   readonly="readonly"></td>
							  <td valign="top" class="boldEleven">Amount</td>
							  <td valign="top" class="boldEleven"><input name="st2" type="text" class="formText135" id="st2" style='text-align:right'  readonly="readonly"/></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Tax &ndash; Education Cess  1% </td>
							  <td align="left"><input name="servicetax1" type="text" class="formText135" id="servicetax1" onKeyPress="return blockNonNumbers(this, event, true, true);"    onkeyup="extractNumber(this,2,true);" value="1"  maxlength="10" style="text-align:right"   readonly="readonly"></td>
							  <td valign="top" class="boldEleven">Amount</td>
							  <td valign="top" class="boldEleven"><input name="st1" type="text" class="formText135" id="st1" style='text-align:right'  readonly="readonly"/></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Total Amount <span class="boldred">* </span></td>
							  <td align="left"><span class="boldEleven">
							    <input name="totals2" type="text" class="formText135" id="totals2" style='text-align:right' tabindex="11" onBlur="assigntotal()" value="0" maxlength="10"  onkeyup="extractNumber(this,2,true);" onKeyPress="return blockNonNumbers(this, event, true, true);"  readonly="readonly"/>
							  </span></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:80%;height:100px">
							<table width="80%" border="0" cellpadding="1" cellspacing="1"	id="myTable">
								<tr>
									<th class="boldEleven"><b>TAX NAME</b></th>
									<th class="boldEleven"><b>TAX VALUE</b></th>
									<th class="boldEleven"><b>AMOUNT</th>
								</tr>
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>							  </td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven">Net Total </td>
							  <td valign="top" class="boldEleven"><input name="nettotal" type="text"
										class="formText135" id="nettotal"  
										style='text-align:right' tabindex="11"
										 value="<%=balance%>" readonly /></td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><input name="filename" type="hidden" value="ServiceBilling" />
							    <input name="actionS"
									type="hidden" value="INVServiceBillingAdd" />
							    <input name="param" type="hidden" id="param" value="0,">
							    <input name="noofpaymentcommitment" type="hidden" id="noofpaymentcommitment" value="1">
							    <span class="boldThirteen">
							    <input name="mode" type="hidden" id="mode" value="<%=request.getParameter("mode")%>">
							    <input name="ponumber" type="hidden" id="ponumber" value="<%=request.getParameter("ponumber")%>">
							    <input name="balance" type="hidden" id="balance" value="<%=balance%>">
							    </span></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('ServiceBilling.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
<script language="JavaScript">

function Validate()
  {

	//alert(document.getElementById('creditamount').value);
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one tax...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
		
	if(checkNullSelect("divis","Select Division","0")
	&& checkNull( "saleDate","Enter Invoice Date" )
	&& checkNullSelect("customer","Select Customer","0")
	 
	&& checkNullSelect("commitmentdays","Select commitment days","")
	&& checkNullSelect("project","Select Project","0")
	
	&& checkNull( "oref","Select Order reference" )
	&& checkNull( "dnote","Enter Delivery Note" )
	&& checkNull( "dthru","Enter Despatch" )
	&& checkNull( "destination","Enter Destination" )
	&& checkNull( "tdelivery"," Enter Terms of Delivery" )
	&& checkNull( "cdetails","Enter Contact Details" )
	&& checkNull( "cnumber","Enter Contact Number" )
	&& checkNull( "ref","Select reference" )
	&& checkNull( "memo","Enter Description" )
	&& checkNull( "totals","Enter Total amount" )
	&& ceheckAmount()
	&& amountCheck()
	&& ValidateBill()
	)
		return true;
	else
		return false;				
		
 } 	
 
 
 
 
 function amountCheck()
 {
	 try
	 {
		 	var balance = parseFloat(document.getElementById('balance').value);
			var namount= parseFloat(document.getElementById('nettotal').value);
			if(namount>balance)
			{
				alert("Kindly check the amount...");	
				return false;
			}
			else
				return true;
	 }
	 catch(err)
	 {
		 alert(err);
		 return false;
	 }
 }
  function ValidateBill()
{
		var pamount = parseFloat(document.getElementById('pendingamount').value);
		var camount = parseFloat(document.getElementById('creditamount').value);
		var namount= parseFloat(document.getElementById('nettotal').value);
		 
			if(camount<(pamount+namount)) 
			{
				var tb=document.getElementById("creditdetailerror");
				tb.innerHTML= "<font color='red'><h3><b>This Bill Not Allowed due to Exceed the credit limit  The Credit Limit : "+camount +"  The Pending Amount : "+pamount +" Current Bill Amount : "+namount +"</b></h3></font>";
					return false;
			}
			else
				return true;	
		 
		
}


function ceheckAmount()
{
	var namount= parseFloat(document.getElementById('nettotal').value);
	if(namount<100000)
	{
		setOptionValue('noofpaymentcommitment','1');
	
	}	
	return true;
}
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>

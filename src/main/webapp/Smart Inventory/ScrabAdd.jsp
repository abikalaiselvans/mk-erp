<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/DirectDeliveryChallanserial.js"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
$(function() {
		$( "#saleDate" ).datepicker({
			 minDate: -7, maxDate: "+7D" ,
			 showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
			 });
	});
 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">




<%
	String taxsql="";
	taxsql="SELECT  INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax ORDER BY CHR_TAXNAME";
	String data[][]= CommonFunctions.QueryExecute(taxsql);
	String datas="";
	
	for(int u=0; u<data.length;u++)
		datas= datas+"<option value="+data[u][0]+">"+data[u][1]+"</option>";
	
%>

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
		var s0= "itype"+r;
		var s1= "item"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "serial"+r;
		var s8 = "stock"+r;
		var div ="div"+r;
		var vf1 = "onKeyPress=\"return numeric_only(event,'"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"return numeric_only(event,'"+s4+"','11')\"";
		 
		 
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>Item</option><option  value='2'>Product</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'>&nbsp;</div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		 x.insertCell(3).innerHTML="<input type='text' class='formText135' readonly='readonly' size=4  name='"+s8+"' id ='"+s8+"' value='0'/>";
		 
		x.insertCell(4).innerHTML="<input type='text' size=10  class='formText135' name='"+s3+"' id ='"+s3+"' " +vf1 +" style='text-align:right'/>";
	
		x.insertCell(5).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
	 	display();
 
	}
 
 	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
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
		var total =0;
		var tax = parseFloat(Taxvalue.childNodes[0].nodeValue);
		var amount = Round((tax/100)*total);
		var postion = assigncontrol.replace("Taxvalue","");
		document.getElementById("Taxamount"+postion).value=""+amount;
		
	 }  
	   assigntotal() ;
}


function assigntotal() 
{
	var controls = document.getElementById('param').value;
	var taxarray = controls.split(",");
	var sum=0;
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
				var total =0
				var tax = parseFloat(taxvalue);
				var amount = Round((tax/100)*total);
				sum1 = sum1+amount;
				document.getElementById("Taxamount"+taxarray[i]).value=""+amount;
			}
			else
			{
				alert("Kindly select Tax...");
				document.getElementById("Tax"+taxarray[i]).focus();
			}	
		}	
	}
	//alert(sum+"/"+sum1);
	
}
	
</script>



 <body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>	  </td>
	</tr>
	<tr>
		<td height="291"><table width="80%" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
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
              <td><table width="100%"
						border="0" align="center" cellpadding="2" cellspacing="2">
                  <!--DWLayoutTable-->
                  <tbody>
                    <tr>
                      <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">SCRAB</td>
                    </tr>
                    <tr>
                      <td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="errormessage"><div align="center">
                          <%
							  	String er="";
								er = ""+request.getParameter("servicebillnumber");
								if(!"null".equals(er))
								{
									%>
                          <script language="javascript">
										alert(" Service bill number :: <%=er%>");
										/*if(r == true)
										{
											document.frm.action="ServiceBillingAdd.jsp";
											
										}
										else
										{
											document.frm.action="ServiceBilling.jsp";
											
										}
										*/
									</script>
                          <%
									
									
									 
									
								}
								
							  %>
                      </div></td>
                    </tr>
                    <tr>
                      <td width="104" height="17" valign="top" class="boldEleven">Division <span class="boldred">*</span> </td>
                      <td width="239" align="left" valign="top"><select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                          <option value='0'>Select</option>
                          <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>                      </td>
                      <td width="118" class="boldEleven"><div align="left">Order Reference <span class="boldred">*</span> </div></td>
                      <td width="278" class="boldEleven"><input name="oref" type="text"
										required
										class="formText135" id="oref" title="please enter the order reference"     onBlur="upperMe(this)" value="ORAL"      size="30" maxlength="90" />                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">D.C.  date  <span class="boldred">*</span> </td>
                      <td align="left"><span class="boldEleven">
                        <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate" title="please enter the dc date" required readonly> 
                                        <script language="javascript">setCurrentDate('saleDate')</script>
                      </span></td>
                      <td class="boldEleven"><div align="left">Delivery Note <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><input name="dnote" type="text" 	required
										class="formText135" id="dnote" title="please enter the  delivery note"
										    onBlur="upperMe(this)" value="NIL"     size="30" maxlength="50"/></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">CustomerName <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><div align="left">
                          <%
			String ssql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1  ORDER BY f.CHR_NAME";
			String custData[][] =  CommonFunctions.QueryExecute(ssql);
			%>
                                 
<select name="customer" id="customer" class="formText135"  style="width: 150px" onChange="loadAddress('customer','shippingaddress')" 	required>
<option value="0">Select</option>
<%
for(int y=0;y<custData.length;y++)
	out.println("<option  value='"+custData[y][0]+"'>"+custData[y][1]+ " ,"+custData[y][2]+ "  ,"+custData[y][3]+ "  ,"+custData[y][4]+ "  ,"+custData[y][5]+ "  ,"+custData[y][6]+ "</option>");	

%>
</select>
                      </div></td>
                      <td class="boldEleven"><div align="left">Despatch Thru <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><input name="dthru" type="text" required
										class="formText135" id="dthru" title="please enter the despath through "
										    onBlur="upperMe(this)" value="INTERNAL COURIER"     size="30" maxlength="50" /></td>
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
                      <td class="boldEleven"><div align="left">Destination <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><input name="destination"
										type="text" required class="formText135" id="destination"  title="please enter the destination"     onBlur="upperMe(this)" value="CHENNAI"      size="30"
										maxlength="50"/></td>
                    </tr>
                    <tr>
                      <td rowspan="3" valign="top" class="boldEleven">&nbsp;</td>
                      <td rowspan="3" valign="top" class="boldEleven"><div align="left">
                          <textarea name="shippingaddress"
										cols="25" rows="4" class="formText135" id="shippingaddress" required></textarea>
                      </div></td>
                      <td class="boldEleven"><div align="left">Terms of Delivery <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><input name="tdelivery" type="text" required
										class="formText135" id="tdelivery" title="please enter the terms of delivery"
										    onBlur="upperMe(this)" value="IMMIDIATE"     size="30" maxlength="50"/></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">Contact Person <span class="boldred">*</span> </div></td>
                      <td class="boldEleven"><input name="cdetails" type="text" 	required
										class="formText135" id="cdetails" title="please enter the contact person"
										    onBlur="upperMe(this)" value="Mythra"     size="30" maxlength="50"/></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">Contact No. <span class="boldred">*</span> </div></td>
                      <td class="boldEleven">
                      
                      <input name="cnumber" type="text"
										class="formText135" id="cnumber" onKeyPress="return numeric_only(event,'cnumber','15')" size="34" maxlength="12"/>
                      </td>
                    </tr>

                    <tr>
                      <td height="17" valign="top" class="boldEleven">Reference <span class="boldred">*</span> </td>
                      <td align="left"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200" required title="please select reference">
                        <jsp:include page="Staffload.jsp" flush="true" />                      
</select></td>
                      <td valign="top" class="boldEleven">Others Description</td>
                      <td valign="top" class="boldEleven"><textarea name="memo" cols="58" style="width:200"
										rows="5" class="formText135" id="memo" tabindex="9" title="please enter the description" required></textarea></td>
                    </tr>

                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">
					  <!--<div id="divscroll" style="OVERFLOW:auto;width:'100%';height:100px">-->
                        <table width="100%" id="myTable" border="1"  cellpadding=2 cellspacing=1 bordercolor='#9900CC' >
								 
                          <tr  >
                            <th class="boldEleven"> <div align="left"><strong>Type</strong></div></th>
                            <th class="boldEleven"><b>Item</b></th>
                            <th class="boldEleven"><b>Description</b></th>
                            <th class="boldEleven"><strong>Stock </strong></th>
                            <th class="boldEleven"><b>Quantity/Units</b></th>
                            <th class="boldEleven">&nbsp;</th>
                           
                          </tr>
                        </table>
                      <!--</div>--></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><div align="left">
                        <input name="button" type="button"
								class="tMLAscreenHead" id="buttonitemadd"
								tabindex="8" onClick="insRow()"  value="Add"   accesskey="s"   />
                      </div></td>
                      <td colspan="3" align="left"><div align="center" id="error" class="bolddeepred"></div></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><input name="filename" type="hidden" value="Scrab" />
                        <input
			name="actionS" type="hidden" value="INVScrabAdd" />
<input name="param" type="hidden" id="param" value="0,"><input name="checkserialflag" type="hidden" id="checkserialflag"
								value="false"></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                            <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Scrab.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                  </tbody>
                  <input type="hidden" name="mobileBookingOption" />
              </table></td>
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
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	 
	<tr>
	  <td>&nbsp;</td>
	</tr>
</table>
<script language="JavaScript">

var divi="";
function Loaditemproduct(ctr,div) 
{
	var url = "../inventory?actionS=INVItemProduct&id="+escape(ctr.value) ;
	divi = div;
	initRequest(url);
	req.onreadystatechange = itemproductRequest;
    req.open("GET", url, true);
    req.send(null);
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
   	var idposition = divi.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  style='width:160'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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


var sposition="";  
function assignValues(ctr,pos) 
{
	sposition=pos;
	var type = document.getElementById("itype"+pos).value;
	var typeid = ctr.value;
	var url = "../inventory?actionS=INVItemProductAssign&type="+escape(type)+"&typeid="+typeid ;
	
	initRequest(url);
	req.onreadystatechange = itemproductpriceRequest;
    req.open("GET", url, true);
    req.send(null);

}

function itemproductpriceRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductpriceMessages();
        }
    }
}

function itemproductpriceMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Assigns")[0];   
   	var idposition = sposition; //divi.replace("div","");
	s1 ='item'+idposition;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    	var batch = batchs.childNodes[loop];
	    	Desc= batch.getElementsByTagName("Desc")[0];
	    	Price= batch.getElementsByTagName("Price")[0];
			Stock= batch.getElementsByTagName("Stock")[0];
			Ptype= batch.getElementsByTagName("Ptype")[0];
			Plist= batch.getElementsByTagName("Plist")[0];
			
			//alert(Desc.childNodes[0].nodeValue;);
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue.replace("98650" ,"&");
			document.getElementById("stock"+idposition).value = Stock.childNodes[0].nodeValue;
			var i=parseFloat(Stock.childNodes[0].nodeValue);
			if(i<1)
			{
				document.getElementById("qty"+idposition).value = "";
				alert("Stock Not available");
				document.getElementById("item"+idposition).focus();
			}
			else
			{
				document.getElementById("qty"+idposition).value = "1";	
			}
			
			 
   }
   
 }
 
function DCserailcheck(ctr)
{
	
	var position  = ""+ctr;
	position = position.replace("itype","");
	var r = position;
	var r1=document.getElementById("itype"+r).value;
	if(r1=="1")
		r1="I";
	else if	(r1=="2")
		r1="P";
	var r2=document.getElementById("item"+r).value;
	var sss = "serial"+r;
	var ddd="Valid"+r;
	LoadDCUniqueCheckSales(sss,ddd,'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit',r1,r2);
	//LoadUniqueCheckSales("'"+sss+"','"+ddd+"','inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+r1+"','"+r2+"'") ;
	
	
}
function Validate()
{
	try
	{
	
		
		display();
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one Product...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}
		var sp = (document.getElementById('param').value).split(",");
		
		svalue="";
		for(u=0; u<checkArray.length-1;u++)
			svalue =svalue+"itype"+checkArray[u]+","+"item"+checkArray[u]+","+"qty"+checkArray[u]+",";
		var s = "saleDate,customer,";//
		s = s+svalue;
		var v = s.split(",");
		
		
		
		var salesserialno="";
		salesserialno =document.getElementById("itype1").value;
		for(i=0;i<sp.length-1;i++)
		
		if(checkNullSelect("divis","Select Division","0")
		&& checkNull( "saleDate","Enter Invoice Date" )
		&& checkNullSelect("customer","Select Customer","0")
		&& checkNull( "ref","Select reference" )
		&& checkNull( "oref","Enter Order Reference" )
		&& checkNull( "dnote","Enter Delivery Note" )
		&& checkNull( "dthru","Enter Despatch" )
		&& checkNull( "destination","Enter Destination" )
		&& checkNull( "tdelivery"," Enter Terms of Delivery" )
		&& checkNull( "cdetails","Enter Contact Details" )
		&& checkNull( "cnumber","Enter Contact Number" )
		&& checkNull( "memo","Enter Description" )
		)
		{
			for( i=0; i<v.length-1; i++)
			{
				if(checkfindObject(v[i],v[i]+" not found..."))
				{
					var chk =document.getElementById(v[i]).value;
					var ck = "Enter Data..."+v[i];
					if(checkNull(v[i],ck))
					{
						d=1;
						 
					}
					else
					{
						return false;				
					}	
				}
				else
					return false;				
	
			}
		}
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

 <%@ include file="../footer.jsp"%></form>
</body>
</html>

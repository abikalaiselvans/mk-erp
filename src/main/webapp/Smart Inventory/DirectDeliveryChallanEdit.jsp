<%@ page import="java.io.*,java.util.*"%>
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/customeraddress.js"></script>

<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/DirectDeliveryChallanserial.js"></script>
<%
	String taxsql="";
	taxsql="SELECT  INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax ORDER BY CHR_TAXNAME";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
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
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"doubleValue('"+s4+"','11')\"";
		 
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		 x.insertCell(3).innerHTML="<input type='text' class='formText135' readonly='readonly' size=4  name='"+s8+"' id ='"+s8+"' value='0'/>";
		 
		x.insertCell(4).innerHTML="<input type='text' size=10 readonly='readonly' class='formText135' name='"+s3+"' id ='"+s3+"' " +vf1 +" style='text-align:right'/>";
	
	var h=" onBlur=\"getValues('serial','"+r+"' ,'error' , 'Submit')\" ";
	var h1="onKeyUp=\"DCserailcheck('itype"+r+"')\"";
	
		x.insertCell(5).innerHTML="<div id='Valid"+r+"'></div>";
	
		x.insertCell(6).innerHTML="<input type='text' size=30  class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf1 +" style='text-align:right' "+h+" "+h1+"/>";
	
		x.insertCell(7).innerHTML="<div id='Warranty"+r+"'></DIV>";
		x.insertCell(8).innerHTML="<input name='Warrantys"+r+"' id='Warrantys"+row+"'  type='hidden'  value='1'>";
		x.insertCell(9).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
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



 <body     >
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
		<td height="291"><table width="85%" border="0"
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
									class="boldThirteen">Delivery Challan Modification  </td>
                    </tr>
                    <tr>
                      <td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" valign="top" class="errormessage"><%
 String dcno = request.getParameter("salesid");
 String sql= " SELECT CHR_DCNO,DATE_FORMAT(DAT_DCDATE,'%d-%m-%Y'),INT_CUSTOMERID,CHR_DES,CHR_REF,INT_DCSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,";
 sql=sql+" CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,";
 sql=sql+"	CHR_CONTACTNO,INT_DIVIID FROM inv_t_directdc WHERE CHR_DCNO='"+dcno+"'";
 String dcdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 sql = "SELECT INT_DCID,CHR_ITEMID,CHR_TYPE,CHR_DESC,CHR_SERIALNO,CHR_WARRANTY FROM inv_t_directdcitem WHERE CHR_DCNO='"+dcno+"'";
 String dcserialdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
%></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="errormessage"><div align="center">
                      <div align="left">D.C.Number</div></td>
                      <td height="17" valign="top" class="errormessage"><%=dcno%></td>
                      <td height="17" valign="top" class="errormessage"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td height="17" valign="top" class="errormessage"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    </tr>
                    <tr>
                      <td width="107" height="17" valign="top" class="boldEleven">Division</td>
                      <td width="406" align="left" valign="top"><select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                          <option value='0' disabled="disabled">Select</option>
                          <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                        </select>
                        <script language="javascript">
				  setOptionValue('divis','<%=dcdata[0][15]%>')
				        </script></td>
                      <td width="124" class="boldEleven"><div align="left">Order Reference</div></td>
                      <td width="120" class="boldEleven"><input name="oref" type="text"
										class="formText135" id="oref"     onBlur="upperMe(this)"      value="<%=dcdata[0][8]%>" size="30" maxlength="50"
										 />                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">D.C.  date </td>
                      <td align="left"><span class="boldEleven">
                        <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly" value="<%=dcdata[0][1]%>">
                        <!--<a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>-->
                        <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				
		//-->
                                </script>
								
                      </span></td>
                      <td class="boldEleven"><div align="left">Delivery Note</div></td>
                      <td class="boldEleven"><input name="dnote" type="text"
										class="formText135" id="dnote"
										    onBlur="upperMe(this)"     value="<%=dcdata[0][9]%>" size="30" maxlength="50" /></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">CustomerName</div></td>
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
 <script language="javascript">setOptionValue('customer','<%=dcdata[0][2]%>')</script>
                      </div></td>
                      <td class="boldEleven"><div align="left">Despatch Thru</div></td>
                      <td class="boldEleven"><input name="dthru" type="text"
										class="formText135" id="dthru"
										    onBlur="upperMe(this)"     value="<%=dcdata[0][10]%>" size="30" maxlength="50" /></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven"><div align="left">Shipping Address
					  <%
							  	String option="";
								if("S".equals(dcdata[0][6]))
									option=" checked=checked ";
								String options="";
								if("D".equals(dcdata[0][6]))
									options=" checked=checked ";
							  %>
					  </div></td>
                      <td class="boldEleven"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S"  <%=option%>/></td>
                            <td width="15%" class="boldEleven">Same</td>
                            <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"  <%=options%>></td>
                            <td width="24%" class="boldEleven">Different</td>
                          </tr>
                        </table>
                          <div align="left"></div></td>
                      <td class="boldEleven"><div align="left">Destinaion</div></td>
                      <td class="boldEleven"><input name="destination"
										type="text" class="formText135" id="destination"     onBlur="upperMe(this)"      value="<%=dcdata[0][11]%>" size="30"
										maxlength="100" /></td>
                    </tr>
                    <tr>
                      <td rowspan="3" valign="top" class="boldEleven">&nbsp;</td>
                      <td rowspan="3" valign="top" class="boldEleven"><div align="left">
                          <textarea name="shippingaddress"
										cols="25" rows="4" class="formText135" id="shippingaddress"><%=dcdata[0][7]%></textarea>
                      </div></td>
                      <td class="boldEleven"><div align="left">Terms of Delivery</div></td>
                      <td class="boldEleven"><input name="tdelivery" type="text"
										class="formText135" id="tdelivery"
										    onBlur="upperMe(this)"     value="<%=dcdata[0][12]%>" size="30" maxlength="50" /></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">Contact Person</div></td>
                      <td class="boldEleven"><input name="cdetails" type="text"
										class="formText135" id="cdetails"
										    onBlur="upperMe(this)"     value="<%=dcdata[0][13]%>" size="30" maxlength="10" /></td>
                    </tr>
                    <tr>
                      <td class="boldEleven"><div align="left">Contact No.</div></td>
                      <td class="boldEleven"><input name="cnumber" type="text"
										class="formText135" id="cnumber" onKeyPress="numericValue('cnumber','15')"
										    onBlur="upperMe(this)"     value="<%=dcdata[0][14]%>" size="30" maxlength="100"/></td>
                    </tr>

                    <tr>
                      <td height="17" valign="top" class="boldEleven">Reference</td>
                      <td align="left"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                        <jsp:include page="Staffload.jsp" flush="true" />                      
</select>
                      <script language="javascript">
				  setOptionValue('ref','<%=dcdata[0][4]%>')
				        </script></td>
                      <td valign="top" class="boldEleven">Others Description</td>
                      <td valign="top" class="boldEleven"><textarea name="memo" cols="58"  style="width:200"
										rows="5" class="formText135" id="memo" tabindex="9"><%=dcdata[0][3]%></textarea></td>
                    </tr>

                    <tr>
                      <td height="17" colspan="4" valign="top" class="boldEleven">
					  <!--<div id="divscroll" style="OVERFLOW:auto;width:'100%';height:100px">-->
                        <table width="100%" border="0" cellpadding="1" cellspacing="1"
								id="myTable">
                          <tr>
                            <th class="boldEleven"> <div align="left"><strong>Type</strong></div></th>
                            <th class="boldEleven"><b>Item</b></th>
                            <th class="boldEleven"><b>Description</b></th>
                            <th class="boldEleven"><strong>Stock </strong></th>
                            <th class="boldEleven"><b>Quantity/Units</b></th>
                            <th class="boldEleven">&nbsp;</th>
                            <th class="boldEleven"><b>Serial Number </b></th>
                            <th class="boldEleven"><b>Warranty </b></th>
                            <th class="boldEleven"><b> </b></th>
                            <th class="boldEleven"><b> </b></th>
                            <th class="boldEleven"><b> </b></th>
                            <th class="boldEleven">&nbsp;</th>
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
                      <td colspan="3" align="left"><input name="filename" type="hidden" value="DirectDeliveryChallan" />
                        <input
			name="actionS" type="hidden" value="INVDirectDeliveryChallanAdd" />
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
											onClick="redirect('DirectDeliverychallan.jsp')"></td>
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
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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



function assignValues(ctr,pos) 
{
	
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
   	var idposition = divi.replace("div","");
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
				document.getElementById("qty"+idposition).value = "0";
			else
				document.getElementById("qty"+idposition).value = "1";	
			
			 
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

	
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one Product...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
	var sp = (document.getElementById('param').value).split(",");
	var salesserialno="";
	for(i=0;i<sp.length-1;i++)
			salesserialno = salesserialno+document.getElementById("serial"+sp[i]).value+"~"+document.getElementById("item"+sp[i]).value+"~"+document.getElementById("itype"+sp[i]).value+"~,";
	
	//checkSerial(salesserialno,'Submit');
	var cfh=document.getElementById('checkserialflag').value;	
	if(checkNullSelect("divis","Select Division","0")
	&& checkNull( "saleDate","Enter Invoice Date" )
	&& checkNullSelect("customer","Select Customer","0")
	&& checkNull( "oref","Select reference" )
	&& checkNull( "dnote","Enter Delivery Note" )
	&& checkNull( "dthru","Enter Despatch" )
	&& checkNull( "destination","Enter Destination" )
	&& checkNull( "tdelivery"," Enter Terms of Delivery" )
	&& checkNull( "cdetails","Enter Contact Details" )
	&& checkNull( "cnumber","Enter Contact Number" )
	&& checkNull( "ref","Select reference" )
	&& checkNull( "memo","Enter Description" )
	//&& (cfh=="true") 
	
	)
		return true;
	else
		return false;				
		
 } 	
</script>

<%
		String ity="";
		for(int u=0; u<dcserialdata.length;u++)
		{
			if("I".equals(dcserialdata[u][2]))
				ity="1";
			else if("P".equals(dcserialdata[u][2]))
				ity="2";	
		%>
		
<script language="javascript" >
		insRow();
		var s0= "itype"+<%=(u+1)%>;
		var s1= "item"+<%=(u+1)%>;
		var s2 = "desc"+<%=(u+1)%>;
		var s3 ="qty"+<%=(u+1)%>;
		var s4 = "serial"+<%=(u+1)%>;
		var s5 = "Warrantys"+<%=(u+1)%>;
		var s8 = "stock"+<%=(u+1)%>;
		var div ="div"+<%=(u+1)%>;
		setOptionValue(s0,"<%=ity%>");
		
		
		<%
				String itypes = dcserialdata[u][2];
				if(itypes.equals("I"))
    		 		sql = " Select CHR_ITEMID,CHR_ITEMNAME from inv_m_item ORDER BY CHR_ITEMNAME ";
    		 	if(itypes.equals("P"))
    		 		sql= " select CHR_PRODUCTID,CHR_PRODUCTCODE from inv_m_produtlist ORDER BY CHR_PRODUCTCODE  ";
					
				
    		 	String readData[][] =  CommonFunctions.QueryExecute(sql);
				String sh="";
				
		
		%>
		 
		var doublestring=""; 
		var str="<select name='item<%=(u+1)%>'  id='item<%=(u+1)%>' size='1' class='formText135' onblur=\"assignValues(this,'<%=(u+1)%>')\">"; 
        
		
		<%
				String sd="";
    		 	if (readData.length > 0)
		 			for(int h=0; h<readData.length;h++)
		 				sd = sd+ "<option value='"+readData[h][0]+"'>"+readData[h][1].replaceAll("\"","")+"</option>";
					
		%>
		str= str+"<%=sd%></select>";
		document.getElementById("div<%=(u+1)%>").innerHTML=str;
		
		document.getElementById(s2).value="<%=dcserialdata[u][3]%>";
		document.getElementById(s4).value="<%=dcserialdata[u][4]%>";
		document.getElementById(s5).value="<%=dcserialdata[u][5]%>";
		document.getElementById(s3).value="1";
		 
		setOptionValue("item"+<%=(u+1)%>,"<%=dcserialdata[u][1]%>");
		document.getElementById(s0).focus();
		</script>
		<%
		}	
		
		%>
		
 <%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
<%@ page import="java.io.*,java.util.*"%>

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

<%
	String taxsql="";
	String datas="";
	String gdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID, CHR_GROUPNAME FROM  inv_m_accessoriesgroup  ORDER BY CHR_GROUPNAME");
	for(int h=0;h<gdata.length;h++)
	{
		taxsql="SELECT INT_PRODUCTID,CHR_PRODUCTNAME FROM inv_m_accessoriesproduct WHERE INT_GROUPID="+gdata[h][0]+" ORDER BY CHR_PRODUCTNAME";
	
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
	
	
	for(int u=0; u<data.length;u++)
		datas= datas+"<option value="+data[u][0]+"> [ "+gdata[h][1]+" ] " +data[u][1]+"</option>";
	}
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="javascript">

var assigncontrol="";


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
		var s0= "Product"+r;
		var s1= "Productdescription"+r;
		var s2 = "Quantity"+r;
		var s3 = "Amount"+r;
		var s4 = "Totalamount"+r;
		
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onchange=\"loadPurchaseProduct(this,'"+s1+"')\"   onblur=\"loadPurchaseProduct(this,'"+s1+"')\"><option value='Select'>[ Group ] Select Product</option><%=datas%></select>";
		
		x.insertCell(1).innerHTML="<input type='text' size=20 class='formText135' readonly='readonly'  name='"+s1+"' id ='"+s1+"' style='text-align:right'/>";
		
		x.insertCell(2).innerHTML="<input type='text' size=10 class='formText135' name='"+s2+"' id ='"+s2+"' value='1' style='text-align:right'  onblur=\"assignQuantity(this,'"+s2+"')\"   onKeyPress=\"numericValue('"+s2+"','6')\"/>";
		
		x.insertCell(3).innerHTML="<input type='text' size=10 class='formText135' name='"+s3+"' id ='"+s3+"' value='0' style='text-align:right'   onblur=\"assignAmount(this,'"+s3+"')\"   onKeyPress=\"doubleValue('"+s3+"','6')\"/>";
		
		x.insertCell(4).innerHTML="<input type='text' size=10 class='formText135' name='"+s4+"' id ='"+s4+"' value='0' style='text-align:right' readonly='readonly' />";
		
		x.insertCell(5).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('Product'+(r-1)).focus();
	}
 
 	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
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
	
	
	
	
	
	
	function loadPurchaseProduct(ctr, ctrassign) 
	{
		document.getElementById('Submit').disabled=false
		if(ctr.value !="Select")
		{
			assigncontrol=ctrassign;
			var url = "../inventory?actionS=loadPurchaseProduct&id="+escape(ctr.value);
			initRequest(url);
			req.onreadystatechange = PurchaseProductRequest;
			req.open("GET", url, true);
			req.send(null);
		}
		else
		{
			alert("Kindly Select Product...");
			ctr.focus();
		}	
	}

	function PurchaseProductRequest() 
	{	
		if(req.readyState == 4) 
    	{    	
    		if (req.status == 200)
        	{
        	   	PurchaseProductMessages();
        	}
    	}
	}


function PurchaseProductMessages() 
{
	
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Products")[0];   
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[0];
        var Desc = batch.getElementsByTagName("Desc")[0];
		var Amount = batch.getElementsByTagName("Amount")[0];
		document.getElementById(assigncontrol).value=""+Desc.childNodes[0].nodeValue;
		var postion = assigncontrol.replace("Productdescription","");
		document.getElementById("Amount"+postion).value=""+Amount.childNodes[0].nodeValue;
		document.getElementById("Totalamount"+postion).value=""+Amount.childNodes[0].nodeValue;
	 }  
	   assigntotal() ;
}




function assigntotal() 
{
	var controls = document.getElementById('param').value;
	var taxarray = controls.split(",");
	var sum1=0;
	for(i=0;i<taxarray.length-1;i++)
	{
		var obj = findObj("Quantity"+taxarray[i]);
		if(obj != null)
		{
			var productid = document.getElementById("Product"+taxarray[i]).value;
			if(productid!="Select")
			{
				
				var amount = document.getElementById("Totalamount"+taxarray[i]).value;
				sum1 = sum1+parseFloat(amount);
				
			}
			else
			{
				alert("Kindly select Product...");
				document.getElementById("Product"+taxarray[i]).focus();
			}	
		}	
	}
	
	document.getElementById('nettotal').value=Round(sum1);
}


function assignQuantity(ctr, ctrassign) 
{
	var v = ctr.value;
	if((v=="") || (parseInt(v)<1))
	{
		alert("Can not empty or Zero");
		ctr.focus();
	}
	else 
	{
		var postion = ctrassign.replace("Quantity","");
		var amount=parseFloat(document.getElementById("Amount"+postion).value);
		document.getElementById("Totalamount"+postion).value=""+(parseInt(v)*amount);
	}
	assigntotal() ;
}




function assignAmount(ctr, ctrassign) 
{
	var v = ctr.value;
	if((v=="") || (parseInt(v)<1))
	{
		alert("Can not empty or Zero");
		ctr.focus();
	}
	else 
	{
		var postion = ctrassign.replace("Amount","");
		var amount=parseFloat(document.getElementById("Quantity"+postion).value);
		document.getElementById("Totalamount"+postion).value=""+(parseInt(v)*amount);
	}
	assigntotal() ;
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
					<table cellspacing="2" cellpadding="2" width="800" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Purchase Indent  Add </td>
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
								<td width="128" height="17" valign="top" class="boldEleven">Department
								
								<%
					String usertype=""+session.getAttribute("USRTYPE");
					String emp=""+session.getAttribute("EMPID");
					String depid =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DEPARTID FROM com_m_staff WHERE CHR_EMPID='"+emp+"'")[0][0]; 
					%>								</td>
								<td width="189" align="left" valign="top">
								<select name="dept" class="formText135"	id="dept" tabindex="1"  >
                      
                      <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			if("F".equals(usertype))
			{
				for(int x=0;x<deptdata.length;x++)
					out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			}
			else
			{
				for(int x=0;x<deptdata.length;x++)
					if(deptdata[x][0].equals(depid) )
						out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			}
		
			%>
                    </select>								</td>
							    <td width="105" class="boldEleven">Contact Person</td>
						      <td width="148" class="boldEleven"><input name="cdetails" type="text"
										class="formText135" id="cdetails" maxlength="100"
										    onBlur="upperMe(this)"      o /></td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Indent date </td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="IndentDate" type="text" class="formText135" id="IndentDate"
										size="15" readonly="readonly">
							    <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['IndentDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('IndentDate'); 
		//-->
                                </script>
							  </span></td>
						      <td class="boldEleven">Contact No.</td>
						      <td class="boldEleven"><input name="cnumber" type="text"
										class="formText135" id="cnumber" maxlength="100"
										    onBlur="upperMe(this)"      onKeyPress="numericValue('cnumber','15')"/></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Expected Date </td>
							  <td colspan="3" align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="ExpectedDate" type="text" class="formText135" id="ExpectedDate"
										size="15" readonly="readonly">
                                <a
										href="javascript:cal3.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal3 = new calendar1(document.forms['frm'].elements['ExpectedDate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('ExpectedDate'); 
		//-->
                                </script>
                              </span></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Description /Remarks </td>
							  <td colspan="3" align="left"><textarea name="memo" cols="60"
										rows="5" class="formText135" id="memo" tabindex="9"   onKeyPress="charOnly('memo',500)"></textarea>
							    <div align="left"></div></td>
					      </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:150px">
							<table width="800" border="0" cellpadding="1" cellspacing="1"	id="myTable">
								<tr>
									<th class="boldEleven"><b>PRODUCT </b></th>
									<th class="boldEleven"><strong>DESCRIPTION</strong></th>
									<th class="boldEleven"><strong>QUANTITY</strong></th>
									<th class="boldEleven"><strong>EXPECTED AMOUNT</strong></th>
									<th class="boldEleven"><strong>TOTAL AMOUNT </strong></th>
									<th class="boldEleven">&nbsp;</th>
								</tr>
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>							  </td>
							  <td colspan="3" align="left"><div id="divname" class="bolddeepred"></div></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left" class="bolddeepred"> </td>
							  <td valign="top" class="boldEleven">Net Amount </td>
							  <td valign="top" class="boldEleven"><input name="nettotal" type="text"
										class="formText135" id="nettotal"  
										style='text-align:right' tabindex="11"
										onKeyPress="doubleValue('totals','12')" value="0" /></td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="PurchaseIndent" />
							    <input name="actionS"
									type="hidden" value="INVPurchaseIndentAdd" />
							    <input name="param" type="hidden" id="param" value="0,"></td>
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
											onClick="redirect('IndentRaise.jsp')"></td>
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

	
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one Product...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
	 
	/*var controls = document.getElementById('param').value;
	var taxarray = controls.split(",");
	var s="";
	for(i=0;i<taxarray.length-1;i++)
		s= s+document.getElementById('Product'+taxarray[i]).value+",";
		
	s = s.substring(0,msg.length-1) ;
	if(duplicateCheckreturn(s ,'name','divname','Submit'));
		return false;*/
	  
	if(checkNullSelect("dept","Select Department","0")
	&& checkNull( "IndentDate","Enter Indent Date" )
	&& checkNull( "ExpectedDate","Enter ExpectedDate" )
	&& checkNullSelect("dept","Select Department","0")
	&& checkNull( "memo","Enter Description" )
	&& checkNull( "cdetails","Enter Contact Details" )
	&& checkNull( "cnumber","Enter Contact Number" )
	&& checkNull( "nettotal","Enter NetTotal amount" )
	
	)
		return true;
	else
		return false;				
		
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>

<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%> 
<html>
<head>
 
<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet"
	type="text/css">
</head>

<%
	String itemsql="";
	itemsql="SELECT CHR_ITEMID,CHR_ITEMNAME  FROM asset_m_item WHERE  INT_ACTIVE = 1 ORDER BY CHR_ITEMNAME";
	String data[][]= CommonFunctions.QueryExecute(itemsql);
	String datas="";
	
	for(int u=0; u<data.length;u++)
		datas= datas+"<option value="+data[u][0]+">"+data[u][1]+"</option>";
	
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
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
		var s0= "Item"+r;
		var s1= "Quantity"+r;
		var s2= "Stock"+r; 
		var vf1 = "onKeyPress=\"numericValue('"+s1+"','5')\"";
		 
		 
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onBlur=\"getStockValue(this,'"+s2+"')\" ><option value='Select'>Select</option><%=datas%></select>";
		
		x.insertCell(1).innerHTML="<input type='text' readonly='readonly' value='0'  maxlength='3' size=8 class='formText135'  name='"+s2+"' id ='"+s2+"'><div id='div"+r+"'></div>";
		 
		 
		x.insertCell(2).innerHTML="<input type='text'  maxlength='3' size=20 class='formText135' value='1'   name='"+s1+"' id ='"+s1+"' style='text-align:right' "+vf1+" onblur=\"checkStockValue(this)\">";
		 
		x.insertCell(3).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('Item'+(r-1)).focus();
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

var assetassign="";
function getStockValue(ctr,assign)
{
	assetassign=assign;
	var url = "../Asset?actionS=getAssetStockValue&id="+escape(ctr.value)+"&Branch="+document.getElementById("Branch").value;
	initRequest(url);
	req.onreadystatechange = getStockValueRequest;
	req.open("GET", url, true);
	req.send(null);
}

function getStockValueRequest() 
{	
	if(req.readyState == 4) 
	{  
		 
		if (req.status == 200)
		{
			getStockValueMessages();
		}
	}
}


function getStockValueMessages() 
{
	 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];  
	 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[0];
        var Stock = batch.getElementsByTagName("Stock")[0].childNodes[0].nodeValue;
		var d =parseInt(Stock);
		var idposition = assetassign.replace("Stock","");
		if(d>0)
			document.getElementById(assetassign).value=Stock;
		else
		{
			alert("Because stock is zero,Kindly select another Item ...");
			document.getElementById("Item"+idposition).focus();
		}	
	}  
	   
}


function checkStockValue(ctr)
{
	var name = ctr.name;
	var idposition = name.replace("Quantity","");
	var stockvalue=parseInt(document.getElementById("Stock"+idposition).value);
	var qtyvalue = parseInt(ctr.value);
	if(qtyvalue>stockvalue)
	{
		alert("Quantity Does not exceed Stock Value....");
		ctr.value="1";
		ctr.focus();
	}
}
	
</script>
<body>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
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
						src="../Image/common/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/common/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="680">
					<table cellspacing="2" cellpadding="2"   align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Asset Track Add 
							  <%
				String branchid=""+session.getAttribute("INVBRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Branch</td>
							  <td align="left" valign="top">
							  
							  <select name="Branch" class="formText135"
							id="Branch" tabindex="6"   >
                    <%
								
				String shipids[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					 
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					 					
				}
						
							%>
                  </select>
                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script>							  </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division</td>
								<td width="199" align="left" valign="top">
								<select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                    <option value='0'>Select</option>
                    <%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select>								</td>
							    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;                                                                     </td>
							</tr>
							
							<tr>
							  <td class="boldEleven"><div align="left">CustomerName</div></td>
							  <td align="left">
							  <div align="left"> 

									<%
			String ssql="SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME,CHR_LEGALNAME FROM inv_m_customerinfo ORDER BY CHR_CUSTOMERNAME";
			String custData[][] =  CommonInfo.RecordSetArray(ssql);
			%> <select name="customerId" id="customerId" class="formText135"
										style="width: 150px" 
										onchange="loadAddress('inv_m_customerinfo','CHR_CUSTOMERNAME,CHR_STREET,CHR_CITY,CHR_POSTAL,CHR_PHONE,CHR_MOBILE ','INT_CUSTOMERID','1','customerId','shippingaddress','3,4,5,','PIN,Phone,Mobile,')">
										<option value="0">Select</option>
										<%
							for(int z=0;z<custData.length;z++)
							{
								out.print("<option value='"+custData[z][0]+"'>"+custData[z][1]+"</option>");
							}	
							%>
									</select></div>							  </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
							  <td align="left"><table width="38%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="9%"><input name="Shipping" type="radio" onClick="return resoffval()"
												value="S" checked /></td>
                                  <td width="15%" class="boldEleven">Same</td>
                                  <td width="52%" class="boldEleven"><input
												onclick="return resoffval()" name="Shipping" type="radio"
												value="D"></td>
                                  <td width="24%" class="boldEleven">Different</td>
                                </tr>
                              </table></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><textarea name="shippingaddress"
										cols="25" rows="5" class="formText135" id="shippingaddress"></textarea></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Sale date </td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="saledate" type="text" class="formText135" id="saledate"
										size="15" readonly="readonly">
							    <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saledate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('saledate'); 
		//-->
                                </script>
							  </span></td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">Sale Invoice Number </div></td>
							  <td class="boldEleven"><input name="salenumber" type="text"
										class="formText135" id="salenumber" maxlength="100"
										onkeyup="upperMe(this)" /></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							
							
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference</td>
							  <td colspan="3" align="left"><select name="ref" id="ref"
										class="formText135" size="5">
                                <jsp:include page="Staffload.jsp" flush="true" />                              
</select>
							   
							    <div align="left"></div></td>
					      </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="error"></div>							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:600px;height:auto">
							<table width="600" border="0" align="center" cellpadding="1" cellspacing="1" 	id="myTable">
								<tr>
									<th class="boldEleven"><strong>ITEM</strong></th>
									<th class="boldEleven"><strong>STOCK</strong></th>
									<th class="boldEleven"><b>QUANTITY</b></th>
									<th class="boldEleven">&nbsp;</th>
									 
									<th class="boldEleven">  </th>
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
							  <td height="17" valign="top" class="boldEleven">							  </td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><input name="filename" type="hidden" value="AssetTrack" />
							    <input name="actionS"
									type="hidden" value="ASSAssetTrackAdd" />
							    <input name="param" type="hidden" id="param" value="0,">
							    <script language="JavaScript">


function duplicateChecked(string ,divname,buttonname,msg) 
	{
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = string.split(",");	
		secondaryArray = string.split(",");	
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			for(j=i+1;j<lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=j;
				}	
				
			
		}
		var d=ss.length
		if(d >1)
		{
			alert(msg);
			document.getElementById(divname).innerHTML="<h3><font color='red'>"+msg+"</font></h3>";
			document.getElementById(buttonname).disabled=true;
			return false;
		}
		else
		{
			document.getElementById(divname).innerHTML="";
			document.getElementById(buttonname).disabled=false;
			return true;
		}	
	}
	
function Validate()
  {

	
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one Item...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
	var svalue="";
	for(u=0; u<checkArray.length-1;u++)
		svalue =svalue+"Item"+checkArray[u]+","+"ItemSerial"+checkArray[u]+","+"statuss"+checkArray[u]+",";
	var s = "Branch,divis,saledate,salenumber,ref,";
	s = s+svalue ;
	var v = s.split(",");
	
	var itemcheck="";
	for(u=0; u<checkArray.length-1;u++)
		itemcheck = itemcheck+document.getElementById("Item"+checkArray[u]).value+",";
		 
 	if(
	
	 checkNullSelect("Branch","Select Branch","0")
	&& checkNullSelect("divis","Select Division","0")
	&& checkNullSelect("customerId","Select Customer","0")
	&& checkNull( "saledate","Enter Sale Date" )
	&& checkNull( "salenumber","Enter Sale Number " )
	&& checkNull( "ref","Select reference" )
	&& duplicateChecked(itemcheck ,'error','Submit','Duplicate Item Selected....')
	)
	{
		for( i=0; i<v.length-1; i++)
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
	}
	else
		return false;				
		
 } 	
                                </script></td>
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
											onClick="redirect('AssetTrack.jsp')"></td>
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
						src="../Image/common/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/common/BRCorner.gif" width="7" /></td>
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

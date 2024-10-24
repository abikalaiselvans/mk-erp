<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage=""%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
			
	var d1=new Date();
	var day1=d1.getDate();	
	var dojlock= "<%=dojlock%>";
	 
 
$(function() {
		$( "#transDate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true,
			minDate: -dojlock, maxDate: "+0D"
		});
	}); 
	

 

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
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
	var str="<select name='"+s1+"'    style='width:160'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
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
	   document.getElementById('item'+idposition).focus();
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
			document.getElementById("desc"+idposition).value = Desc.childNodes[0].nodeValue;
			document.getElementById("stock"+idposition).value = Stock.childNodes[0].nodeValue;
			document.getElementById("stock"+idposition).disabled = true;
			document.getElementById("qty"+idposition).value = "";
			document.getElementById("consumables"+idposition).value =  Ptype.childNodes[0].nodeValue;
   }
    
 }
</script>




<script type="text/javascript"><!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	//totals,tax,salestax,nettotal, these controls are hidden
	function Load()
	{
		totals1.style.visibility="hidden";
		
	}
	
	 

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
		var s4 = "stock"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var s8 = "consumables"+r;
		var div ="div"+r;
		 
		var vf1 = "onKeyPress=\" return numeric_only(event,'"+s3+"','15') \"";
		var vf2 = "onKeyPress=\" return numeric_only(event,'"+s4+"','15') \"";
		var vf3 = "onKeyPress=\" return numeric_only(event,'"+s5+"','15') \"";
		var vf4 = "onKeyPress=\" return numeric_only(event,'"+s6+"','15') \"";
		var vf5 = "onKeyPress=\" return numeric_only(event,'"+s7+"','15') \"";
		
		
		
	 	
		 x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' onblur=Loaditemproduct(this,'"+div+"')> <option  value='1'>I</option><option  value='2'>P</option></select>";
		 x.insertCell(1).innerHTML="<div id='"+div+"'></div>";
		
		 x.insertCell(2).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10     title='Quantity' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf1+" style='text-align:right' readonle='readonly'  value=''  />";
		
		x.insertCell(4).innerHTML="<input type='text' size=10  onblur='calculateValue(this)'     title='Stock' class='formText135'  name='"+s3+"' id ='"+s3+"'  value='' " +vf1+" style='text-align:right'/>";
		 
		x.insertCell(5).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'><input type='hidden' name='"+s8+"' id ='"+s8+"' />";
		document.getElementById("itype"+r).focus();
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		
		
	}
 
	//If any changes in Combobox then the corresponding values are assign to corresponding controls
	function assignValue(itm)
	{
  		var idname = itm.name;
  		//var idposition = (idname.substring(4,(idname.length-4)));
  		var idposition = idname.replace("item","");
 		var  itemid = itm.value;
 		for(i=0; i<cvalue1.length-1; i++)
 		{
   			var rowvalue = cvalue1[i].split(",")
   			if(rowvalue[2]=== itemid)
   			{
   				document.getElementById('desc'+idposition).value = rowvalue[4];
   				document.getElementById('stock'+idposition).value = rowvalue[15];
   				document.getElementById('uprice'+idposition).value = rowvalue[7];
 				document.getElementById('total'+idposition).value = rowvalue[7];
				totals1.style.visibility="visible";
				//totaldiscount1.style.visibility="visible";
				//tax1.style.visibility="visible";
				//salestax1.style.visibility="visible";
				//salestaxamount1.style.visibility="visible";
				//nettotal1.style.visibility="visible";
				//calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
 	}
	//Calculate Nettotal 
	function calculateTotal()
	{
		var tvs =0.0;
		display();
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			tvs= tvs+parseFloat(document.getElementById('total'+checkArray[u]).value);
		document.getElementById("totals").value=tvs;		
	}
	
	function checkStock(qty)
	{
		try
		{
		}
		catch(err)
		{
			alert(err);
		}
	}
	
	
	//Calculate Nettotal in Quantity Changes
	function calculateValue(qty)
	{
		try
		{
			var qtyposition = (qty.name.replace("qty",""));	
			var stock =document.getElementById('stock'+qtyposition).value;
			
			if(stock=="")
			{
				alert("Stock not available...")
				document.getElementById('qty'+qtyposition).value="";
				document.getElementById('item'+qtyposition).focus();
			}
			
			var quantity = qty.value;
			if(parseInt(quantity)<1)
			{
				alert("Quantity Not Zero... ");
				document.getElementById('Submit').disabled=true;
				document.getElementById('qty'+qtyposition).value="";
				document.getElementById('stock'+qtyposition).focus();
				
			}
			else if(parseInt(quantity) > parseInt(stock))
			{
				alert("Stock Error... ");
				document.getElementById('qty'+qtyposition).value="";
				document.getElementById('Submit').disabled=true;
				document.getElementById('stock'+qtyposition).focus();
			}
		}
		catch(err)
		{
			alert("Kindly check the stock...");
			document.getElementById('qty'+qtyposition).value="";
		}			 
	  	
	}
	//Calculate Nettotal in Price Changes
	function calculatePrice(pre)
	{
  		var priceposition = (pre.name.replace("uprice",""));
  		var price = pre.value;
  		var quantity = document.getElementById('qty'+priceposition).value;
  		var discount =document.getElementById('discount'+priceposition).value;
  		document.getElementById('unitdiscount'+priceposition).value = (discount/100)*price;
  		var udiscount =(discount/100)*price;
  		var total = ((quantity * price) - (udiscount*quantity));
  		document.getElementById('total'+priceposition).value =total;
  		calculateTotal();
  		assignGrandTotal();
	}

	//Calculate Nettotal in Discount Changes
	function calculateDiscount(desc)
	{
 		var descposition = (desc.name.replace("discount",""));
  		var discount = desc.value;
  		var quantity = document.getElementById('qty'+descposition).value;
  		var price = document.getElementById('uprice'+descposition).value;
  		var udiscount =(discount/100)*price;
  		document.getElementById('unitdiscount'+descposition).value = udiscount;
  		udiscount = document.getElementById('unitdiscount'+descposition).value;
  		var total = ((quantity * price) - (udiscount*quantity));
  		document.getElementById('total'+descposition).value = total;
  		calculateTotal();
  		assignGrandTotal();
	}

	//Delete Row
	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		calculateTotal();
		assignGrandTotal();
	}

	//******************************
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
	//**********************************
	function paramAssign(svalue)
	{
		document.getElementById(param).value=svalue;
	}
	
<%
	String taxid[][] =  CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
	String lvalue="";
	for(int x=0; x<taxid.length;x++)
	{
		for(int y=0; y<3;y++)
		{
			lvalue = lvalue+taxid[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>

	var taxvalue = "<%=lvalue%>";
	var taxvalue1 =taxvalue.split("~");

	function assignTotals(taxs)
	{
		
		var taxid = taxs.value;
		//var nettotal=0.0;
		for(i=0; i<taxvalue1.length-1; i++)
 		{
   			var rowvalue = taxvalue1[i].split(",")
   			if(rowvalue[0]=== taxid)
			{
				
			}	
   		}   		
	}	
	function assignGrandTotal()
	{
		calculateTotal();
			
	}
--></script>
</head>
<body    onLoad="Load()">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return valid()"> 
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td align="center" class="boldEleven"><strong>Stock
							Transfer </strong></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven"><strong>From </strong></td>
									<td width="229" class="boldEleven"><div align="left">
                                      <%
	String branchid=""+session.getAttribute("BRANCHID");
%>
                                      <input name="fromBranch" id="fromBranch" type="hidden" value="<%=branchid%>">
                                      <%=CommonFunctions.QueryExecute("SELECT CONCAT(a.CHR_COMPANYNAME ,'  @  ',b.CHR_BRANCHNAME) FROM com_m_company a, com_m_branch b WHERE a.INT_COMPANYID=b.INT_COMPANYID AND b.INT_BRANCHID = "+branchid)[0][0]%> </div>									  </td>
									<td width="107" class="boldEleven">
									<div align="left"><strong>Date</strong></div>									</td>
									<td width="201" class="boldEleven">
									<div align="left"><input tabindex="2" name="transDate"
										type="text" class="formText135" id="transDate" size="15"
										readonly="readonly"   value='' />   <script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDate('transDate'); 
		//-->
                          </script></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
								  <div align="left"><strong>Division</strong> <span class="boldred">*</span> </div>									</td>
									<td class="boldEleven"><select name="division" class="formText135" id="division" tabindex="1">
                                      <option value="Select">Select</option>
                                      <%
								String division[][] =CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                    </select></td>
									<td class="boldEleven">
									<div align="left"><strong>To</strong> <span class="boldred">*</span></div>									</td>
									<td class="boldEleven">
									<div align="left"><select name="toBranch"
										class="formText135" id="toBranch" tabindex="6" style="width:200">
										<option value="Select">Select</option>
										<%
								
												
				String sql ="Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ";	
				if("N".equals(CommonFunctions.QueryExecute("SELECT  CHR_DISPLAYINACTIVECOMPANY FROM m_institution  WHERE INT_ID=1")[0][0]))			  
					sql = sql + " AND b.INT_ACTIVE =1 ";
								
				String shipids[][] =  CommonFunctions.QueryExecute(sql);
								for(int u=0; u<shipids.length; u++)
									out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
							%>
									</select></div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr height="20px">
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<table width="800" border="0" bordercolor="#D4D0C8"
								cellpadding="1" cellspacing="1">
								<tr>
									<td width="100" class="boldEleven"><strong>Type</strong></td>
									<td width="200" class="boldEleven"><b>Item / Product </b></td>
									<td width="124" class="boldEleven"><b>Description</b></td>
									<td width="125" class="boldEleven"><strong>Stock
									in Hand </strong></td>
									<td width="150" class="boldEleven"><b>Quantity</b></td>
									<td width="56" class="boldEleven"><b>Action</b></td>
								</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td>
							<div id="divscroll"
								style="OVERFLOW:auto;width:800px;height:100px">
							<table width="100%" border="0" bordercolor="#EFEFEF"
								cellpadding="1" cellspacing="1" id="myTable">
								<tr>
									<td width="100"></td>
									<td width="200"></td>
									<td width="124"></td>
									<td width="125"></td>
									<td width="150"></td>
									<td width="56"></td>
								<tr>
							</table>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"><input type="button" id="buttonitemadd"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8"></div>
							</td>
						</tr>
						<tr>
							<td id="totals1"></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo <span class="boldred">*</span></div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"   onBlur="upperMe(this)"   ></textarea>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">Transfer
									By <span class="boldred">*</span></td>
									<td width="169" valign="top" class="boldEleven"><select
										name="transferBy" id="transferBy" class="formText135" size="7" style="width:200">

										<jsp:include page="Staffload.jsp" flush="true" />
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven"><input name="filename"
										type="hidden" value="StockTransfer" /> <input name="actionS"
										type="hidden" value="INVStockTransAdd" /> <input name="param"
										type="hidden" id="param" value='0,'></td>
									<td width="169" valign="top" class="boldEleven" id="tax1">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"      />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('Stock Transfer.jsp')" /></div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
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
</table>
</div>
</form>
<script language="javascript">
function valid()
{
	try
	{
   		
		if(
			  checkNull("transDate","Enter the Tansfer Date")
			  && checkNullSelect("division","Select Division ","Select")
			  && checkNullSelect("toBranch","Select To Branch ","Select")
			)
			 {
			 }
			 else
			 {
			 	return false;
			 } 
		
		display();
		var svalue="";
		if(parseInt(checkArray.length-1)<1)
		{
			alert("Please Add atleast one Item/Product...");
			document.getElementById('buttonitemadd').focus();
			return false;
		}	
		
		//stock
   		for(u=0; u<checkArray.length-1;u++)
   			svalue =svalue+"item"+checkArray[u]+","+"qty"+checkArray[u]+"," ;
   		var s = "transDate,fromBranch,toBranch,transferBy,";
   		s = s+svalue+"memo"; 
		 
		var v = s.split(",");
   		var flag =false;
		
		if(
			  checkNull("transDate","Enter the Tansfer Date")
			  && checkNullSelect("division","Select Division ","Select")
			  && checkNullSelect("toBranch","Select To Branch ","Select")
			  && checkNull("memo","Enter the description")
			  && checkNull("transferBy","Select  transfer By")
			  	
			)
		{	
			for( i=0; i<v.length-1; i++)
			{
				 
				 
				{
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
				//else
					//return false;		
			}
		}
		else
		{
			return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
}
</script>

<%@ include file="../footer.jsp"%>
</body>
</html>

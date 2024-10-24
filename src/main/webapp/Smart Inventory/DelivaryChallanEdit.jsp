<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<script type="text/javascript"><!--

	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	//totals,tax,salestax,nettotal, these controls are hidden
	function Load()
	{
		totals1.style.visibility="visible";
		totaldiscount1.style.visibility="visible";
		tax1.style.visibility="visible";
		salestax1.style.visibility="visible";
		salestaxamount1.style.visibility="visible";
		nettotal1.style.visibility="visible";
	}
	
	//Loading item into Array using JSP
	<%
	String itemData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select * from inv_m_item");
	int ccount =com.my.org.erp.common.CommonInfo.intGetColumnCount("Select * from inv_m_item");
	String lvalue="";
	for(int x=0; x<itemData.length;x++)
	{
		for(int y=0; y<ccount;y++)
		{
			lvalue = lvalue+itemData[x][y]+",";
		}
		lvalue = lvalue+"~";	
	}
	%>

	//Intialise the Variables
	var cvalue = "<%=lvalue%>";
 	var cvalue1 =cvalue.split("~");
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
 
 	//Dynamically insert a row in a table
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s1= "item"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var s8 = "sqty"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"numericValue('"+s4+"','5')\"";
		var vf3 = "onKeyPress=\"numericValue('"+s5+"','5')\"";
		var vf4 = "onKeyPress=\"numericValue('"+s6+"','5')\"";
		var vf5 = "onKeyPress=\"numericValue('"+s7+"','10')\"";
		var vf6 = "onKeyPress=\"numericValue('"+s8+"','5')\" onblur=\"checkQTY('"+s3+"','"+s8+"')\"";
	<%
		String sa="";
		for(int u=0; u<itemData.length; u++)
			sa = sa +"<option value='"+itemData[u][2]+"'>"+itemData[u][3]+"</option>";		
	%>
		x.insertCell(0).innerHTML="<select readonly='readonly' class='formText135' onblur='assignValue(this)' name='"+s1+"' id ='"+s1+"' ><option>Select Item</option><%=sa%></select>";
		x.insertCell(1).innerHTML="<input readonly='readonly' type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(2).innerHTML="<input readonly='readonly' type='text' size=6  value='0'  onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" />";
		x.insertCell(3).innerHTML="<input type='text' size=6  value='0'   title='SalesQty' class='formText135'  name='"+s8+"' id ='"+s8+"' " +vf6+" />";
		x.insertCell(4).innerHTML="<input readonly='readonly' type='text' size=10  value='0'  onblur='calculatePrice(this)' title='Unit Price' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  />";
		x.insertCell(5).innerHTML="<input  type='text' size=10  value='0'  onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  />";
		x.insertCell(6).innerHTML="<input  type='text' size=10  value='0'  title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly'/>";
		x.insertCell(7).innerHTML="<input  type='text' size=10  value='0'  title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly'/>";
//		x.insertCell(7).innerHTML="<input disabled='disabled' class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
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
   				document.getElementById('uprice'+idposition).value = rowvalue[7];
 				document.getElementById('total'+idposition).value = rowvalue[7];

				calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
 	}

 	function assignValue1(itm1)
	{
		var itm=document.getElementById(itm1);
  		var idname = itm.name;

  		  		var idposition = idname.replace("item","");
 		var  itemid = itm.value;
 		for(i=0; i<cvalue1.length-1; i++)
 		{
   			var rowvalue = cvalue1[i].split(",")
   			if(rowvalue[2]=== itemid)
   			{
   				document.getElementById('desc'+idposition).value = rowvalue[4];
   				document.getElementById('uprice'+idposition).value = rowvalue[7];
 				document.getElementById('total'+idposition).value = rowvalue[7];

				calculateTotal();
   				document.getElementById('discount'+idposition).value = 0;
   				document.getElementById('unitdiscount'+idposition).value = 0;
   				document.getElementById('qty'+idposition).value = 1;
   			}	
 		}
		calculateTotal();
  		assignGrandTotal();
 	}
 	//NEW - BY NPR
 	function checkQTY(oqty,sqty)
 	{
 		var s1=document.getElementById(oqty).value;
 		var s2=document.getElementById(sqty).value;
 		if(s2>s1) 
 		{
 			alert(" Enter Correct Qty");
 			document.getElementById(sqty).focus();
 		}
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

	//Calculate Nettotal in Quantity Changes
	function calculateValue(qty)
	{
  		var qtyposition = (qty.name.replace("qty",""));	
  		var quantity = qty.value;
  		var uprice = document.getElementById('uprice'+qtyposition).value;
  		var discount =document.getElementById('discount'+qtyposition).value;
  		var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
  		udiscount =(discount/100)*uprice;
  		var total = ((quantity * uprice) - (udiscount*quantity));
  		document.getElementById('total'+qtyposition).value = total;
  		calculateTotal();
  		assignGrandTotal();
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
		//alert("Added :: \n"+hs+"\n\n\n Deleted :: \n"+hs1+"\n\nChecked \n"+hs2);
	}
	//**********************************


	function paramAssign(svalue)
	{
		document.getElementById(param).value=svalue;
	}

	function valid()
	{
   		display();
   		var svalue="";
   		for(u=0; u<checkArray.length-1;u++)
   			svalue =svalue+"item"+checkArray[u]+","+"qty"+checkArray[u]+","+"sqty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"total"+checkArray[u]+",";
   		var s = "delivaryNO,delivaryDate,recivedBy,billingTo,shipingTo,";
   		s = s+svalue+"memo,ref,totals,totaldiscount,tax,salestax,nettotal,";
		//paramAssign(s);
   		var v = s.split(",");
   		var flag =false;
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

<%
	String taxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
	lvalue="";
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
		var nettotal=0.0;
		for(i=0; i<taxvalue1.length-1; i++)
 		{
   			var rowvalue = taxvalue1[i].split(",")
   			if(rowvalue[0]=== taxid)
			{
				document.getElementById("salestax").value = rowvalue[2];
				assignGrandTotal(taxs);
				//nettotal = (parseFloat(rowvalue[2])/100 )*document.getElementById("totals").value;
				//document.getElementById("nettotal").value = parseFloat(document.getElementById("totals").value)+nettotal;
			}	
   		}
   		
	}
	
	function assignGrandTotal()
	{
		calculateTotal();
		var tot = parseFloat(document.getElementById("totals").value);
		var discount = parseFloat(document.getElementById("totaldiscount").value);
		var discountamount=0.0;
		if(discount>0)
			discountamount= (discount/100)*tot;
		else
			discountamount	=0.0;
		var salestax = parseFloat(document.getElementById("salestax").value);
		var salestaxamount = parseFloat((salestax/100)*tot);
		document.getElementById("salestaxamount").value = salestaxamount;
		
		var grandtotal = (tot+salestaxamount);
		document.getElementById("nettotal").value=(grandtotal-discountamount);
		
	}
--></script>

</head>
<%
	String poId=request.getParameter("itemId");
	String sql="SELECT INT_QUOTATIONID,INT_SALESORDERID,CHR_SALESORDERNO,INT_CUSTOMERID,"+
				" CHR_ORDERBY,DAT_ORDERDATE,CHR_BILLINGADDRESS,CHR_SHIPINGADDRESS,"+
				" INT_PAYMENTTERMID,CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,"+
				" DOU_TAXAMOUNT,DOU_TOTALAMOUNT "+
				" from  inv_t_customersalesorder   where INT_SALESORDERID="+poId;
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][3];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	sql="Select CHR_QUOTATIONNO,DAT_QUOTATIONDATE from  inv_t_customerquotation  where INT_QUOTATIONID="+purchaseInfo[0][0];
	String quotationNo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql="Select INT_DELIVARYID,CHR_DELIVARYNO,CHR_RECIVEDBY,DAT_DELIVARYDATE "+
	" from inv_t_delivary where INT_SALESORDERID="+poId;
	String delivaryInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
%>
<body    onLoad="Load()">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
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
							<td width="650"></td>
						</tr>
						<tr>
							<td align="center">Delivary Challan Edit</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td class="boldEleven">
									<div align="left">Quotaion Ref No</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=quotationNo[0][0] %></div>
									</td>
									<td class="boldEleven">
									<div align="left">Quotation Date</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(quotationNo[0][1]) %></div>
									</td>
								</tr>
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Purchase Order No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=purchaseInfo[0][2] %></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">Order Date</div>
									</td>
									<td width="201" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(purchaseInfo[0][5]) %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Customer Id / Name</div>
									</td>
									<td class="boldEleven">
									<div align="left"><input type="hidden" name="customerId"
										value="<%=purchaseInfo[0][3] %>"> <%=purchaseInfo[0][3]%>&nbsp;/&nbsp;<%=customerInfo[0][0] %>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left">Billing To</div>
									</td>
									<td class="boldEleven">
									<div align="left"><select disabled="disabled"
										name="billingTo" class="formText135" id="billingTo"
										tabindex="5">
										<option>Select</option>
										<%
								String branchids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch ");
								for(int u=0; u<branchids.length; u++)
									if(purchaseInfo[0][6].equals(branchids[u][0]))
										out.print("<option selected='selected' value='"+branchids[u][0]+"'>"+branchids[u][1]+"</option>");
									else
										out.print("<option value='"+branchids[u][0]+"'>"+branchids[u][1]+"</option>");
							
							%>
									</select></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Order By</div>
									</td>
									<td class="boldEleven">
									<div align="left"><input type="hidden" name="customerId2"
										value="<%=purchaseInfo[0][4] %>"></div>
									</td>
									<td class="boldEleven">
									<div align="left">Shipping To</div>
									</td>
									<td class="boldEleven">
									<div align="left"><select disabled="disabled"
										name="shipingTo" class="formText135" id="shipingTo"
										tabindex="6">
										<option>Select</option>
										<%
								String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch ");
								for(int u=0; u<shipids.length; u++)
									if(purchaseInfo[0][7].equals(shipids[u][0]))
										   out.print("<option selected='selected' value='"+shipids[u][0]+"'>"+shipids[u][1]+"</option>");
										else
									   	   out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1]+"</option>");	
								
							%>
									</select></div>
									</td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">Delivary No</td>
									<td class="boldEleven"><%=delivaryInfo[0][1] %> <input
										name="delivaryNO" type="hidden" id="delivaryNO"
										value="<%=delivaryInfo[0][0] %>"></td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven"><select disabled="disabled"
										name="payment" class="formText135" id="payment" tabindex="3">
										<option>Select</option>
										<%
								String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
								for(int u=0; u<paymentids.length; u++){
									if(paymentids[u][0].equals(purchaseInfo[0][8]))
									 out.print("<option value='"+paymentids[u][0]+"' selected>"+paymentids[u][1]+"</option>");
									else
									 out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");									
								}	
							%>
									</select></td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">
									<div align="left">Delivary Date</div>
									</td>
									<td class="boldEleven">
									<div align="left"><input name="delivaryDate" type="text"
										class="formText135" id="delivaryDate" tabindex="7"
										value="<%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(delivaryInfo[0][3]) %>"
										size="21" readonly="readonly" /> <a
										href="javascript:cal1.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		                  </script></div>
									</td>
									<td class="boldEleven">
									<div align="left">Recived By</div>
									</td>
									<td class="boldEleven">
									<div align="left"><script language='JavaScript'
										type="text/javascript"><!--			
				var cal1 = new calendar1(document.forms['frm'].elements['delivaryDate']);
				cal1.year_scroll = true;
				cal1.time_comp = false;
				//setCurrentDate('reqDate'); 
		//-->
                          </script>
									<div align="left"><input name="recivedBy" type="text"
										class="formText135" id="recivedBy" tabindex="2"
										value="<%=delivaryInfo[0][2]%>" size="25" /></div>
									</div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
					    out.println("<table   border=1  cellpadding='1' cellspacing='1'>");
						out.println("<tr><td width='200px' class='boldEleven'><b>Item</b></td>");
						out.println("<td width='150px' class='boldEleven'><b>Description</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Order Quantity</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Deliv. Quantity</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Unit Price</b></td>");
						out.println("<td width='100px' class='boldEleven'><b>Discount(%)</b></td>");
						out.println("<td width='100px' class='boldEleven'><b>Unit Discount</b></td>");
						out.println("<td width='54px' class='boldEleven'><b>Total</b></td></tr>");
						sql="SELECT b.CHR_ITEMNAME,a.CHR_DESC,a.INT_QUANTITY,"+
						" a.INT_SALESQUANTITY,a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TOTAL "+
						" from inv_t_delivaryitem a,inv_m_item b where "+
						" a.CHR_ITEMID=b.CHR_ITEMID ";
						//and a.INT_DELIVARYID="+delivaryInfo[0][0];
						
						String purchaseItems[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
						for(int i=0;i<purchaseItems.length;i++){
							out.println("<tr><td class='boldEleven'>"+purchaseItems[i][0]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][1]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][2]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][3]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][4]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][5]);
							out.println("<td class='boldEleven'>"+purchaseItems[i][6]);
							out.println("<td class='boldEleven' align='right'>"+purchaseItems[i][7]);
						}
						out.println("</table>");
						
					%>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"><!--   <input type="button" class="tMLAscreenHead" onClick="insRow()"  value="Add"   accesskey="s"    tabindex="8"> -->
							</div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo</div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"><%=purchaseInfo[0][9] %></textarea>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input name="totals" type="text"
										class="formText135" id="totals" tabindex="11"
										onKeyPress="numericValue('totals','12')"
										value="<%=purchaseInfo[0][12]%>" readonly="readonly" /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										name="totaldiscount" value="<%=purchaseInfo[0][13]%>"
										type="text" class="formText135" id="totaldiscount"
										onblur="assignGrandTotal()" /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax1" onChange="assignTotals(this)" tabindex="13">
										<option value="Select">Select</option>
										<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
                              	String taxVal="";
								for(int u=0; u<taxids.length; u++){
									if(taxids[u][0].equals(purchaseInfo[0][11])){
										out.print("<option value='"+taxids[u][0]+"' selected>"+taxids[u][1]+"</option>");	
										taxVal=taxids[u][2];
									}
									else
										out.print("<option value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");							
								}									
							 %>
									</select></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><input name="salestax" type="text"
										class="formText135" id="salestax" readonly="readonly"
										value="<%=taxVal %>" tabindex="14" /></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="DelivaryChallan" /> <input name="actionS"
										type="hidden" value="INVDelivaryChallanEdit" /></div>
									</td>
									<td class="boldEleven">
									<div align="left"><input name="ref"
										value="<%=purchaseInfo[0][10] %>" type="text"
										class="formText135" id="ref" size="25" maxlength="50"
										tabindex="10" /></div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"
										value="<%=purchaseInfo[0][14] %>" type="text"
										class="formText135" id="salestaxamount" readonly="readonly"
										tabindex="14" /></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><input name="param" type="hidden"
										id="leng" value='0,'> <input name="salesOrderId"
										type="hidden" id="salesOrderId" value="<%=poId %>" /> <input
										name="quotationId" type="hidden" id="quotationId"
										value="<%=purchaseInfo[0][0] %>" /></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left">
									<div align="left">Net Total</div>
									</div>
									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" tabindex="15"
										value="<%=purchaseInfo[0][15] %>" /></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"    onClick="return valid()" />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="javascript:history.back(1)" /></div>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>

<script language='JavaScript' type="text/javascript">
<!--			
<%	
	sql="SELECT CHR_ITEMID,CHR_DESC,INT_QUANTITY,INT_SALESQUANTITY,"+
	" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL "+
	" from inv_t_delivaryitem where INT_DELIVARYID="+delivaryInfo[0][0];
	String purchaseItem[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	for(int i=0;i<purchaseItem.length;i++){
%>
		insRow();		
		setOptionValue("item<%=(i+1)%>","<%=purchaseItem[i][0]%>")
 	    assignValue1("item<%=(i+1)%>")
		document.getElementById("desc<%=(i+1)%>").value="<%=purchaseItem[i][1]%>"
		document.getElementById("qty<%=(i+1)%>").value="<%=purchaseItem[i][2]%>"
		document.getElementById("sqty<%=(i+1)%>").value="<%=purchaseItem[i][3]%>"
		document.getElementById("uprice<%=(i+1)%>").value="<%=purchaseItem[i][4]%>"
		document.getElementById("discount<%=(i+1)%>").value="<%=purchaseItem[i][5]%>"
		document.getElementById("unitdiscount<%=(i+1)%>").value="<%=purchaseItem[i][6]%>"
		document.getElementById("total<%=(i+1)%>").value="<%=purchaseItem[i][7]%>"<%
	}
%>
//-->
</script>

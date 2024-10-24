<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>

<script type="text/javascript">
<!--

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
 
 	//Dynamically insert a row in a table
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s1= "item"+r;
		var s11= "ditem"+r;
		var s2 = "desc"+r;
		var s3 ="qty"+r;
		var s4 = "uprice"+r;
		var s5 = "discount"+r;
		var s6 = "unitdiscount"+r;
		var s7 = "total"+r;
		var s8 = "quoQty"+r;
		var s9 = "quprice"+r;
		var vf1 = "onKeyPress=\"numericValue('"+s3+"','5')\"";
		var vf2 = "onKeyPress=\"numericValue('"+s4+"','5')\"";
		var vf3 = "onKeyPress=\"numericValue('"+s5+"','5')\"";
		var vf4 = "onKeyPress=\"numericValue('"+s6+"','5')\"";
		var vf5 = "onKeyPress=\"numericValue('"+s7+"','10')\"";

		x.insertCell(0).innerHTML="<input type='hidden' name='"+s1+"' id ='"+s1+"'/><div class='formText135' name='"+s11+"' id ='"+s11+"'> </div>";
		x.insertCell(1).innerHTML="<input type='text' size=10  title='Description' class='formText135'  name='"+s2+"' id ='"+s2+"' />";
		x.insertCell(2).innerHTML="<input type='text' readonly size=10  value='0'   class='formText135'  name='"+s8+"' id ='"+s8+"' />";
		x.insertCell(3).innerHTML="<input type='text' size=10  value='0'  onblur='calculateValue(this)' title='Quantity' class='formText135'  name='"+s3+"' id ='"+s3+"' " +vf1+" />";
		x.insertCell(4).innerHTML="<input type='text' size=10  value='0'  onblur='calculatePrice(this)' title='QuoPrice' class='formText135'  name='"+s9+"' id ='"+s9+"' readonly  />";
		x.insertCell(5).innerHTML="<input type='text' size=10  value='0'  onblur='calculatePrice(this)' title='SalesPri' class='formText135'  name='"+s4+"' id ='"+s4+"' " +vf2+"  />";
		x.insertCell(6).innerHTML="<input type='text' size=10  value='0'  onblur='calculateDiscount(this)' title='Discount' class='formText135'  name='"+s5+"' id ='"+s5+"' " +vf3+"  />";
		x.insertCell(7).innerHTML="<input type='text' size=10  value='0'  title='UnitDiscount' class='formText135'  name='"+s6+"' id ='"+s6+"' " +vf4+" readonly='readonly'/>";
		x.insertCell(8).innerHTML="<input type='text' size=10  value='0'  title='Total' class='formText135'  name='"+s7+"' id ='"+s7+"' " +vf5+"   readonly='readonly'/>";
		x.insertCell(9).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")'>";
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
   				document.getElementById('uprice'+idposition).value = rowvalue[9];
 				document.getElementById('total'+idposition).value = rowvalue[9];
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
   			svalue =svalue+"item"+checkArray[u]+","+"qty"+checkArray[u]+","+"uprice"+checkArray[u]+","+"discount"+checkArray[u]+","+"unitdiscount"+checkArray[u]+","+"total"+checkArray[u]+",";
   		var s = "custponumber,salesOrderNo,saleBy,quoDate,reqDate,payment,hold,order,ship,";
   		s = s+svalue+"totals,totaldiscount,tax,salestax,nettotal,";
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
	String salesNo =request.getParameter("salesNo");

	String poId=request.getParameter("itemId");
	String sql="SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,INT_CUSTOMERID,"+
				" DAT_QUOTATIONDATE,DAT_REQUESTDATE "+
				" from  inv_t_customerquotation  where INT_QUOTATIONID="+poId;
	
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	
	sql="SELECT CHR_QUOTATIONNO,INT_CUSTOMERID,CHR_CUSTPURCHASENO,CHR_SALESORDERNO,"+
		" CHR_SALEBY,DAT_SALEDATE,CHR_DELIVERYSTATUS,CHR_INVOICENO,DT_INVOICEDATE,"+
		" CHR_INVOICESTATUS,CHR_BILLINGADDRESS,CHR_SHIPINGADDRESS,INT_ONHOLD,INT_CONDITIONID,"+
		" INT_PAYMENTTERMID,CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
		" DOU_TOTALAMOUNT,CHR_PAYMENTSTATUS  "+
		" from  inv_t_customersalesorder  where CHR_SALESORDERNO='"+salesNo+"'";
	String salesInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][2];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	
	sql="SELECT CHR_ITEMID,CHR_DESC,INT_QUANTITY,"+
	" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL "+
	" from  inv_t_customersalesorderitem  where CHR_SALESORDERNO='"+salesNo+"'";
	String purchaseItem[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	
	sql="SELECT CHR_ITEMID,CHR_DESC,INT_QUANTITY,"+
	" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL "+
	" from  inv_t_customerquotationitem  where INT_QUOTATIONID="+poId;
	String quoItem[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
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
					<table width="800" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Sales Order Update </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Quotaion Ref No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=salesInfo[0][0] %> <input
										name="quotationId" type="hidden" id="quotationId"
										value="<%=salesInfo[0][0] %>"></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">Quo Date</div>
									</td>
									<td width="201" class="boldEleven">
									<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(purchaseInfo[0][3]) %></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Customer Id / Name</div>
									</td>
									<td class="boldEleven"><input type="hidden"
										name="customerId" value="<%=salesInfo[0][1] %>"> <%=salesInfo[0][1]%>&nbsp;/&nbsp;<%=customerInfo[0][0] %></td>
									<td rowspan="3" valign="top" class="boldEleven">
									<div align="left">Billing To</div>
									</td>
									<td rowspan="3" class="boldEleven">
									<div align="left"><textarea name="billingTo"
										id="billingTo" rows="5" cols="25" class="formText135"><%=salesInfo[0][10]%></textarea>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Cust Purchase No</td>
									<td class="boldEleven">
									<table>
										<tr>
											<td><input name="custponumber" type="text"
												class="formText135"
												onkeyup="CheckUniqueNO(this,'poValid',' inv_t_customersalesorder  ','CHR_CUSTPURCHASENO')"
												id="custponumber" size="25" maxlength="15"
												value="<%=salesInfo[0][2] %>"></td>
											<td>
											<div id=poValid></div>
											</td>
									</table>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Sale Order No</td>
									<td class="boldEleven">
									<table>
										<tr>
											<td><input name="salesOrderNo" type="text"
												class="formText135"
												onkeyup="CheckUniqueNO(this,'soValid',' inv_t_customersalesorder  ','CHR_SALESORDERNO')"
												id="salesOrderNo" value="<%=salesInfo[0][3] %>" size="25"
												maxlength="15" /></td>
											<td>
											<div id=soValid></div>
											</td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Sale By</div>
									</td>
									<td class="boldEleven">
									<div align="left"> 
										<select name="saleBy" id="saleBy" class="formText135" size="5">
												<jsp:include page="Staffload.jsp" flush="true" />
										</select>
										<script language="javascript" >setOptionValue('saleBy','<%=salesInfo[0][4] %>')</script>
										</div>
									</td>
									<td rowspan="3" valign="top" class="boldEleven">
									<div align="left">Shipping To</div>
									</td>
									<td rowspan="3" class="boldEleven">
									<div align="left"><textarea name="shipingTo" cols="25"
										rows="5" class="formText135" id="shipingTo"><%=salesInfo[0][11]%></textarea>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Sale Date</td>
									<td class="boldEleven"><input name="salDate" type="text"
										class="formText135" id="salDate"
										value="<%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(salesInfo[0][5]) %>"
										size="15" readonly="readonly" /> <a
										href="javascript:cal1.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		                  </script></td>
								</tr>
								<tr>
									<td class="boldEleven">On Hold</td>
									<td class="boldEleven">
									<%
                        	if(salesInfo[0][12].equals("1"))
                        		out.println("<input name='hold' type='checkbox' checked='checked' id='hold' value='checkbox'  />");
                        	else
                        		out.println("<input name='hold' type='checkbox' id='hold' value='checkbox'  />");
                        %> <input name="hold2" type="hidden" id="hold2"
										value="<%=salesInfo[0][12]%>"></td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">Payment Terms</td>
									<td class="boldEleven">
									<%
    		//System.out.println(salesInfo[0][14]);
			String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid="";
			for(int u=0; u<paymentids.length; u++){
				if(paymentids[u][0].equals(salesInfo[0][14]))
				{
				 out.print(paymentids[u][1]);
				 pid = paymentids[u][0];
				} 
				
			}
	%> <input name="payment2" type="hidden" id="payment2" value="<%=pid%>"></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>

								<tr>
									<td height="22" class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"><script language='JavaScript'
										type="text/javascript"><!--			
				var cal1 = new calendar1(document.forms['frm'].elements['salDate']);
				cal1.year_scroll = true;
				cal1.time_comp = false;
//				setCurrentDate('salDate'); 
		//-->
                          </script></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
					  
					     sql="SELECT CHR_TYPE ,CHR_ITEMID,CHR_DESC,INT_QUANTITY,"+
					" DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL "+
					" from  inv_t_customersalesorderitem  where CHR_SALESORDERNO='"+salesInfo[0][3]+"'";
					
					
				String itemDatas[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.print("<tr  class='MRow1'><th  class='boldEleven'><b>Type</b></th>");
				out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven'><b>Description</b></th>");
                out.print("<th  class='boldEleven'><b>Quantity</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
                out.print("<th  class='boldEleven'><b>Total</b></th>");
				String i0,i1,i2,i3,i4,i5,i6,i7,vf1,vf2,vf3,vf4,vf5;
				i0="";
                i1 ="qty";
                i2 ="uprice";
                i3 ="discount";
                i4 ="unitdiscount";
                i5 ="total";
                i6="item";
				i7="desc";
                String args="";
				for(int u=0; u<itemDatas.length;u++)
				{
					args= args+(u+1)+",";
					i0="itype"+(u+1);
					i1 ="qty"+(u+1);
	                i2 ="uprice"+(u+1);
	                i3 ="discount"+(u+1);
	                i4 ="unitdiscount"+(u+1);
	                i5 ="total"+(u+1);
					i6 ="item"+(u+1);
					i7 ="desc"+(u+1);
					vf1 = "onKeyPress=\"numericValue('"+i1+"','5')\"";
	        		vf2 = "onKeyPress=\"numericValue('"+i2+"','5')\"";
	        		vf3 = "onKeyPress=\"numericValue('"+i3+"','5')\"";
	        		vf4 = "onKeyPress=\"numericValue('"+i4+"','5')\"";
	        		vf5 = "onKeyPress=\"numericValue('"+i5+"','10')\"";
	        		if(u%2==1)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr  class='MRow2'>");	 
					
					 
					out.println("<td >&nbsp;");
					if(itemDatas[u][0].equals("I"))
						out.println("Item");
					if(itemDatas[u][0].equals("P"))
						out.println("Product");
					
					out.print("<input value='"+itemDatas[u][0]+"' type='hidden' name='"+i0+"'  id='"+i0+"' />");
						
					sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][1]+"'";
					out.print("<td class='boldEleven'>&nbsp;<input value='"+itemDatas[u][1]+"' type='hidden' name='"+i6+"'  id='"+i6+"' />"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
					
					
					String des = itemDatas[u][2];
					if(des.trim().equals("") || des.trim().equals("null") )
						des ="-";
					out.print("<td class='boldEleven'>&nbsp;<input value='"+des+"' type='hidden' name='"+i7+"'  id='"+i7+"' />"+des+"</td>");
					
                	out.print("<td class='boldEleven'><input class='formText135' type='text' size ='10' name='"+i1+"' id='"+i1+"' value ='"+itemDatas[u][3]+"' "+vf1+" onblur='calculateValues(this)'  style='text-align:right'></td>");
                	out.print("<td class='boldEleven'><input class='formText135' type=text size =10 name='"+i2+"' id='"+i2+"' value ='"+itemDatas[u][4]+"' "+vf2+" readonly='readonly'  style='text-align:right'></td>");
                	out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i3+"' id='"+i3+"' value ='"+itemDatas[u][5]+"' "+vf3+" readonly='readonly' style='text-align:right'></td>");
                	out.print("<td class='boldEleven'  ><input class='formText135' type=text size =10 name='"+i4+"' id='"+i4+"' value ='"+itemDatas[u][6]+"' "+vf4+" readonly='readonly' style='text-align:right'></td>");
                	out.print("<td class='boldEleven'  style='text-align:right'><input class='formText135'type=text size =10 name='"+i5+"' id='"+i5+"' value ='"+itemDatas[u][7]+"' "+vf5+" readonly='readonly'  style='text-align:right'></td>");
				
				}
				out.print("</table> ");
					
					
				   %>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo</div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo"><%=salesInfo[0][15] %></textarea>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="left"><input name="totals"
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly="readonly" style="text-align:right"
										value="<%=salesInfo[0][18] %>" /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input name="totaldiscount"
										value="<%=salesInfo[0][19]%>" type="text"
										onKeyPress="priceOnly(this)" class="formText135"
										id="totaldiscount" onBlur="assignGrandTotal()"  style="text-align:right"/></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)">
										<option value="Select">Select</option>
										<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
                              	String taxVal="";
								for(int u=0; u<taxids.length; u++){
									if(taxids[u][0].equals(salesInfo[0][17])){
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
										value="<%=taxVal %>"  style="text-align:right"/></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="SalesOrder" /> <input name="actionS"
										type="hidden" value="INVSalesOrderUpdate" /> <input
										name="param" type="hidden" id="leng" value='0,'> <input
										name="salesNo" type="hidden" value="<%=salesNo %>" /> <input
										name="params" type="hidden" id="params"
										value="<%=itemDatas.length%>"></div>
									</td>
									<td class="boldEleven">
									<div align="left"> 
										
										<select name="ref" id="ref" class="formText135" size="5">
												<jsp:include page="Staffload.jsp" flush="true" />
									</select>
									<script language="javascript">setOptionValue('ref','<%=salesInfo[0][16] %>')</script>	
										
										</div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"
										value="<%=salesInfo[0][20] %>" type="text" class="formText135"
										id="salestaxamount" readonly="readonly"  style="text-align:right"/></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>
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
										class="formText135" id="nettotal"
										value="<%=salesInfo[0][21] %>"  style="text-align:right"/></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="tMLAscreenHead" value="Update"
												onClick="return valid()" /></td>
											<td width="56"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="javascript:history.back(1)" /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center" valign="bottom"></td>
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
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>

<script language='JavaScript' type="text/javascript">

function calculateValues(qty)
			{
  					
  					var qtyposition = (qty.name.replace("qty",""));	
  					var quantity = qty.value;
  					var uprice = document.getElementById('uprice'+qtyposition).value;
  					var discount =document.getElementById('discount'+qtyposition).value;
  					var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
  					udiscount =(discount/100)*uprice;
  					var total = ((quantity * uprice) - (udiscount*quantity));
  					document.getElementById('total'+qtyposition).value = total;
  					assignGrandTotal();
  					
			}
			function assignGrandTotal()
			{
				var noofcontrols = "<%=itemDatas.length%>";
				var tvs =0.0;
				var svalue="";
   				for(u=1; u<=noofcontrols;u++)
					tvs= tvs+parseFloat(document.getElementById('total'+u).value);
				document.getElementById("totals").value=tvs;
							
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
			<%
			String scrpttaxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
			String tvalue="";
			for(int x=0; x<scrpttaxid.length;x++)
			{	
				for(int y=0; y<3;y++)
					tvalue = tvalue+scrpttaxid[x][y]+",";
			
				tvalue = tvalue+"~";	
			}
			%>
			var taxvalue1 = "<%=tvalue%>".split("~");
			function assignTotals(taxs)
			{
				var taxid = taxs.value;
				var nettotal=0.0;
				for(i=0; i<taxvalue1.length-1; i++)
 				{
   					var rowvalue = taxvalue1[i].split(",")
   					if(rowvalue[0]=== taxid)
						document.getElementById("salestax").value = rowvalue[2];
				}
				assignGrandTotal();
   			}
			

</script>

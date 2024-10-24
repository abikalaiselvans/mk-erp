<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%
try
{
String PR = CommonFunctions.QueryExecute("SELECT CHR_PR_BYPASS FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
String prrequest=PR;
if(PR.equals("Y"))
 PR = "onChange = 'LoadPurchaseRequest()'";
 
String ttaxids[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
String toptiontaxname="";
for(int u=0; u<ttaxids.length; u++)
	toptiontaxname =toptiontaxname+"<option value='"+ttaxids[u][0]+"'>"+ttaxids[u][1]+"</option>";

String warrantyinsert="";
warrantyinsert = warrantyinsert + "<option  value='1' selected='selected'>1 - Year</option>";
warrantyinsert = warrantyinsert + "<option  value='0'>No Warranty </option>";
for(int u=2;u<=10;u++)
	warrantyinsert = warrantyinsert + "<option  value='"+u+"'>"+u+" - Years</option>";


%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDetails.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	/*$(function() {
		$( "#saleDate" ).datepicker({
			changeMonth: true,
			changeYear: true
		});
	});
*/


$(function() {
		$( "#saleDate" ).datepicker({ minDate: -7, maxDate: "+7D" });
	});
 
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>

<script language="javascript">

function LoadPurchaseRequest()
{
	try
	{
		var vendorid = document.getElementById('vendorid').value;
		var url = "../inventory?actionS=LoadPurchaseRequest&vendorid="+vendorid;
		initRequest(url);
		req.onreadystatechange=LoadPurchaseRequestRequest;
   		req.open("GET", url, true);
  		req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}


function LoadPurchaseRequestRequest() 
{
	try
	{
	   if(req.readyState == 4) 
	   { 
			var _targ=document.getElementsByName('purchaserequest')[0];       
			_targ.options.length=0;
			_targ.options[0]=new Option('Select purchase request','0'); 
			if (req.status == 200) 
			{		  	
					LoadPurchaseRequestMessages();
			}
	   }
	}
	catch(err)
	{
		alert(err);
	}
}


function LoadPurchaseRequestMessages() 
{	 
 
 	try
	{   
		var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
		var _targ=document.getElementsByName('purchaserequest')[0];       
		_targ.options.length=0;
		_targ.options[0]=new Option('Select purchase request','0');  
		var str=""; 
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			_targ.options[loop+1]=new Option(  (Id+" For "+Name) ,Id);
		}
	}
	catch(err)
	{
		alert(err);
	}
}



</script>



</script>


</head>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="95%"
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
					<td>
					<table width="100%" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong> DIRECT VENDOR PURCHASE 
							    <%
		String salesid = request.getParameter("Ponumber");
		String sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID ";
		sql = sql +",CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
		sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,DOU_ROUNDED,CHR_POREQUESTNO, ";
		sql = sql +" DOU_BASEAMOUNT,CHR_BASEVALUE,DOU_FRIEGHT_CHARGE_BASE_AMOUNT,DOU_FRIEGHT_CHARGE_PERCENT, DOU_FRIEGHT_CHARGE ";
		sql = sql +" from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
		//out.println(sql);
		String branchid = session.getAttribute("BRANCHID").toString();
		String cashdata[][] =  CommonFunctions.QueryExecute(sql);

	%> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="238" class="boldEleven">
								  <div align="left">Direct Purchase No.</div>									</td>
									<td width="544" class="boldEleven">
								  <div align="left"><%=cashdata[0][1]%> <input
										name="ponumber" type="hidden" id="ponumber"
										value="<%=cashdata[0][1]%>"></div>									</td>
									<td width="221" class="boldEleven">Purchase Date <span class="boldred"> *</span></td>
								  <td width="439" class="boldEleven"><input tabindex="2"
										name="saleDate" type="text"
										value="<%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])%>"
										class="formText135" id="saleDate" size="15"
										readonly="readonly" /> <!--<a href="javascript:cal2.popup();">
									<img src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>--> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				//setCurrentDate('saleDate'); 
		//-->
                          </script></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor Name <span class="boldred"> *</span></div>									</td>
									<td class="boldEleven">
									  <%
						sql =" SELECT  a.CHR_VENDORNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL     ";
sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+cashdata[0][2];  
String vendor[][]=CommonFunctions.QueryExecute( sql);
 						
						%> <select name="vendorid" class="formText135" id="vendorid"
										tabindex="1" style="width:200"  <%=PR%>>
                                        <option value='Select'>Select</option>
                                        <%
								String vendorids[][] =  CommonFunctions.QueryExecute("Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation ");
								for(int u=0; u<vendorids.length; u++)
									if(cashdata[0][2].equals(vendorids[u][0]))
										out.print("<option selected='selected' value='"+vendorids[u][0]+"'>"+vendorids[u][1]+" / "+vendorids[u][0] +"</option>");
									else
										out.print("<option  value='"+vendorids[u][0]+"'>"+vendorids[u][1]+" / "+vendorids[u][0] +"</option>");
									
							%>
									</select> <input name="custid" type="hidden" id="custid"
										value="<%=cashdata[0][2]%>"></td>
									<td class="boldEleven">Payment Terms <span class="boldred"> *</span></td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3"  style="width:200">
										<option value='Select'>Select</option>
										<%
			
			String paymentids[][] =CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print("<option selected='selected' value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
				else
					out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
						
			}	
			%>
									</select></td>
								</tr>
								
								<tr>
									<td valign="top" class="boldEleven">Customer Address</td>
									<td class="boldEleven">
									  <%
						
						out.println(vendor[0][0]+",<br>");
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+",<br>");
						if(!"-".equals(vendor[0][4]))
							out.println(vendor[0][4]+".<br>");
						%>
									<td class="boldEleven">Division</td>
									<td class="boldEleven">
									  <%
						String vsql = "SELECT  CHR_DIVICODE FROM inv_m_division WHERE INT_DIVIID="+cashdata[0][14].trim() ;
						out.print(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(vsql, "CHR_DIVICODE"));
						%>	
						
						<input name="division"  id="division"  type="hidden" value="<%=cashdata[0][14].trim()%>">								</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">                                
								  <td class="boldEleven">Purchase Request <span class="boldred"> *</span> 
								    <%
								 
								  String pr=  "";
								  %>
								  </td>
								  <td class="boldEleven">
<select name="purchaserequest" class="formText135" id="purchaserequest"  onChange="loadPurchaseRequestDetails() "  style="width:200" >
 <option value="WITHOUTPR">Select Purchase Request </option> 
<%
sql = " SELECT  a.CHR_POREQUESTNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
sql = sql + " FROM inv_t_purchaserequest a ,inv_t_purchaserequestitem b  ";
sql = sql + " WHERE a.CHR_POREQUESTNO =b.CHR_POREQUESTNO AND a.CHR_CLOSEDSTATUS='Y' ";
sql = sql + " AND b.INT_VENDORID=" + cashdata[0][2];
sql = sql + " AND a.CHR_PR_PARTIALLY_RECEIVED !='Y'  ";
sql = sql + "  GROUP BY a.CHR_POREQUESTNO  ";
sql = sql + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
String PRequestDatat[][] = CommonFunctions.QueryExecute(sql);
for(int u=0; u<PRequestDatat.length; u++)
	if(PRequestDatat[u][0].equals(cashdata[0][16]))
		out.print("<option selected value='"+PRequestDatat[u][0]+"'>"+PRequestDatat[u][0] +" -- for "+ PRequestDatat[u][1]+"</option>");
	else
		out.print("<option value='"+PRequestDatat[u][0]+"'>"+PRequestDatat[u][0] +" -- for "+ PRequestDatat[u][1]+"</option>");	
 									
							%>
                                  </select>
 								    <%
 

								  String rdata[][] =CommonFunctions.QueryExecute("SELECT a.CHR_POREQUESTNO FROM inv_t_vendorgoodsreceived a WHERE a.CHR_PURCHASEORDERNO='"+salesid+"' GROUP BY a.CHR_POREQUESTNO ");
								  if(rdata.length>0)
								  	pr =rdata[0][0];
								    
								  %>
								  
						 
								  <input name="proposedpurchasedate" type="hidden" id="proposedpurchasedate" value="">
								  Partially Received
                                  <input name="partialreceived" type="checkbox" id="partialreceived" value="Y" checked></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="1" cellpadding="1" cellspacing="1">
							  <tr>
									<td height="23" class="boldEleven"><b>Type</b></td>
									<td height="23" class="boldEleven"><b>Item</b></td>
									<td class="boldEleven"><b>Description</b></td>
									<td class="boldEleven"><b>Quantity/Unit</b></td>
                                    <td class="boldEleven"><b>Warranty</b></td>
									<td class="boldEleven"><b>Unit Price</b></td>
									<td class="boldEleven"><b>Discount(%)</b></td>
									<td class="boldEleven"><b>Unit Discount</b></td>
									<td class="boldEleven"><b>Tax </b></td>
									<td class="boldEleven"><b>Tax (%)</b></td>
									<td class="boldEleven"><b>Tax Amount</b></td>
									<td class="boldEleven" valign="top"><b>Total</b></td>
									<%
		 sql ="SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,INT_TAXID,DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
		
		String itemDatas[][] = CommonFunctions.QueryExecute(sql);
		String i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,vf1,vf2,vf3,vf4,vf5;
		String  i11,i12,i13,i14;
		i0="stock";
		i1 ="qty";
		i2 ="uprice";
		i3 ="discount";
		i4 ="unitdiscount";
		i5 ="total";
		i6="item";
		i7="desc";
		i8="pstock";
		i9="itype";
		
		i11="stax";
		i12="staxpercentage";
		i13="staxamount";
		i14="warranty";


		int lens = itemDatas.length;
		String iname="";
		String itemname="";
		String stock="";
		String ptypes="";
		for(int u=0;u<itemDatas.length;u++)
		{
			i0 ="stock"+(u+1);
			i1 ="qty"+(u+1);
			i2 ="uprice"+(u+1);
			i3 ="discount"+(u+1);
			i4 ="unitdiscount"+(u+1);
			i5 ="total"+(u+1);
			i6 ="item"+(u+1);
			i7 ="desc"+(u+1);
			i8 ="pstock"+(u+1);
			i9 ="itype"+(u+1);
			i10="consumables"+(u+1);
			
			
			i11="stax"+(u+1);
			i12="staxpercentage"+(u+1);
			i13="staxamount"+(u+1);
			i14="warranty"+(u+1);

			
			vf1 = "onKeyPress=\"isNumberFloat('"+i1+"' )\"";
			vf2 = "onKeyPress=\"isNumberFloat('"+i2+"' )\"";
			vf3 = "onKeyPress=\"isNumberFloat('"+i3+"' )\"";
			vf4 = "onKeyPress=\"isNumberFloat('"+i4+"' )\"";
			vf5 = "onKeyPress=\"isNumberFloat('"+i5+"' )\"";
			out.print("<tr>");
			
			if(itemDatas[u][2].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,INT_STOCKINHAND FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][1]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='I' AND INT_BRANCHID="+branchid;					
				stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
				ptypes="";
			}	
			if(itemDatas[u][2].equals("P"))
			{
			  iname="Product";
			  sql= "SELECT CHR_PRODUCTCODE ,INT_STOCKINHAND,CHR_PTYPE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemDatas[u][1]+"'";
			  ptypes=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PTYPE");
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;	
			  stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
			  
			}	
			out.println(" <td   class='boldEleven'  valign='top'>"+iname+"</td>");
			out.println("<td  class='boldEleven'   valign='top'>"+itemname);
				
			
			out.print("<input  type='hidden'  name='"+i6+"' id='"+i6+"' value ='"+itemDatas[u][1]+"'/>");
			out.print("<input  type='hidden'  name='"+i9+"' id='"+i9+"' value ='"+itemDatas[u][2]+"'/>");
			out.print("<input  type='hidden'  name='"+i10+"' id='"+i10+"' value ='"+ptypes+"'/>");
			
			out.print("<td  class='boldEleven'  valign='top'>"+itemDatas[u][3]);
			out.print("<input  type='hidden'  name='"+i7+"' id='"+i7+"' value ='"+itemDatas[u][3]+"'/>");
			 
			out.print("<input  type='hidden'  name='"+i0+"' id='"+i0+"' value ='"+stock+"'/>");
            out.print("<input  type='hidden'  name='"+i8+"' id='"+i8+"' value ='"+itemDatas[u][4]+"'/>");
            
			out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type='text' size ='10' name='"+i1+"' id='"+i1+"'   maxlength='3' onKeyPress=\" return numeric_only(event,'"+i1+"','15') \"  value ='"+itemDatas[u][4]+"' "+vf1+" onblur=\"calculateValues('"+i1+"')\"></td>");
			
			out.print("<td  class='boldEleven'  valign='top'><select class='formText135'   style='width:100'  name='"+i14+"' id ='"+i14+"'   >"+warrantyinsert+"</select></td>");
			
            out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type=text size =10 name='"+i2+"' id='"+i2+"' value ='"+itemDatas[u][5]+"' "+vf2+"  ></td>"); //readonly='readonly'
            out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type=text size =10 name='"+i3+"' id='"+i3+"' value ='"+itemDatas[u][6]+"' "+vf3+" readonly='readonly' ></td>");
            out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type=text size =10 name='"+i4+"' id='"+i4+"' value ='"+itemDatas[u][7]+"' "+vf4+" readonly='readonly' ></td>");
			
			

 out.print("<td  class='boldEleven'  valign='top'>");
 out.print("<select class='formText135' name='"+i11+"' id='"+i11+"'  readonly='readonly'>");
 String taxdata[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax WHERE INT_TAXID="+itemDatas[u][9]);
 if(taxdata.length>0)
	for(int k=0; k<taxdata.length; k++)
		 out.print("<option value='"+taxdata[k][0]+"'>"+taxdata[k][1]+"</option>");
 out.print("</select>");
 out.print("</td>");
 
out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type=text size =10 name='"+i12+"' id='"+i12+"' value ='"+itemDatas[u][10]+"'  readonly='readonly' ></td>");
out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135' type=text size =10 name='"+i13+"' id='"+i13+"' value ='"+itemDatas[u][11]+"'  readonly='readonly' ></td>");
			
	
	
	
            out.print("<td  class='boldEleven'  valign='top'><input style='text-align:right' class='formText135'type=text size =10 name='"+i5+"' id='"+i5+"' value ='"+itemDatas[u][8]+"' "+vf5+" readonly='readonly' ></td>");
				
		}		
	%>
								
							</table>

							</td>
						</tr>
						<tr>
							<td height="9"></td>
						</tr>
						<tr>
								  <td colspan="4" valign="top" class="boldEleven"><div id="prdetails"></div></td>
					  </tr>
							  
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="237" valign="top" class="boldEleven">Base Value </td>
									<td width="582" valign="top" class="boldEleven"><input name="basevalue" type="text"
										class="formText135" id="basevalue" 
										style='text-align:right' tabindex="11"
										onKeyPress="numericValue('basevalue','12')" value="<%=cashdata[0][17]%>" readonly ='readonly' /></td>
									<td width="272" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
									<td width="351" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input tabindex="11" name="totals"
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly
										value="<%=cashdata[0][7]%>" style='text-align:right' /></div>									</td>
								</tr>
								<tr>
								  <td width="237" rowspan="4" valign="top" class="boldEleven"><div align="left">Memo <span class="boldred"> *</span></div></td>
								  <td width="582" rowspan="3" valign="top" class="boldEleven"><div align="left">
								    <textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"><%=cashdata[0][5]%></textarea>
							      </div></td>
									<td valign="top" class="boldEleven">
									<div align="left"><!--Total Discount (%)--></div>									</td>
									<td width="351" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><!--<input
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount"
										style='text-align:right' tabindex="12" onBlur="assignGrandTotal()"
										onKeyPress="return numeric_only(event,'totaldiscount','7') " value="<%=cashdata[0][8]%>"
										maxlength="2">--><input type="hidden" name="totaldiscount" id="totaldiscount" value="<%=cashdata[0][8]%>" />
									</div>									</td>
								</tr>
								<tr>
								  <td height="20" valign="top" class="boldEleven">
									<div align="left"><!--Tax Group--></div>									</td>
									<td width="351" valign="top" class="boldEleven" id="tax1">
									<div align="left"><!--<select name="tax" class="formText135"
										id="tax" onChange="assignTotals(this)" tabindex="13">
										<option value="">Select</option>
										<%
	String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][9];
		for(int u=0; u<taxids.length; u++)
				out.print("<option  value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
		
	%>
									</select>
									<script language="javascript">
									setOptionValue('tax','<%=tid%>') ;
									</script>--><input type="hidden" name="tax" id="tax" value="<%=tid%>" />
									 </div>									</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven"><div align="left"><!--Sales Tax (%)--></div></td>
								  <td valign="top" class="boldEleven" id="salestax2"><div align="left">
								   <!-- <%
  String taxs[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
  %>
								    <input value="<%=taxs[0][0]%>" name="salestax" type="text"
										class="formText135" id="salestax" readonly
										tabindex="14" style='text-align:right' />--><input type="hidden" name="salestax" id="salestax" value="<%=taxs[0][0]%>" />
							      </div></td>
							  </tr>
								<tr>
								  <td width="582" align="right" valign="top" class="boldEleven"><table width="67%" border="0" align="right">
								    <tr>
								       
								      <td align="right" class="boldEleven"><!--Tax calculated from Basevalue 
							          <input  class="formText135" name="basevaluecheck" type="checkbox" id="basevaluecheck" value="Y" onClick="assignGrandTotal()" <%=("Y".equals(cashdata[0][18])?" checked = 'checked' ":" ")%>> -->   <input type="hidden" name="basevaluecheck" id="basevaluecheck" value="<%=cashdata[0][18]%>" />									  </td>
							        </tr>
							      </table></td>
								  <td valign="top" class="boldEleven"><div align="left"><!--Sales Tax Amount--></div></td>
									<td width="351" valign="top" class="boldEleven" id="salestax1"><div align="left">
									  <!--<input name="salestaxamount"
										value="<%=cashdata[0][10]%>" type="text" class="formText135"
										id="salestaxamount" readonly tabindex="14"
										style='text-align:right' />--><input type="hidden" name="salestaxamount" id="salestaxamount" value="<%=cashdata[0][10]%>" />
								    </div></td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td rowspan="3" class="boldEleven"><div align="left">
								    <select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
								      <jsp:include page="Staffload.jsp" flush="true" />                                  
							        </select>
								    <script language="javascript">setOptionValue('ref','<%=cashdata[0][6]%>')</script>
								    </div>
							      <div align="left"></div>									</td>
								  <td class="boldEleven">
								  Frieght charge
                                    <input name="frieghtamount" type="text"
										class="formText135" id="frieghtamount"
										style='text-align:right' title="Fright Charge"  onBlur="calculateFrieght()" onKeyPress="return numeric_priceonly(event,'frieghtamount','7') " value="<%=cashdata[0][19]%>" size="10" maxlength="6" /> &nbsp;&nbsp; &nbsp;&nbsp;<input name="frieghttax" type="text"
										class="formText135" id="frieghttax"
										style='text-align:right'   title="Fright Charge %"    onBlur="calculateFrieght()" onKeyPress="return numeric_priceonly(event,'frieghttax','7') " value="<%=cashdata[0][20]%>" size="10" maxlength="6" />(%)&nbsp;&nbsp;
									
									<script language="javascript">
										function calculateFrieght(){
												try
												{
													var frieghtamount = parseFloat(document.getElementById("frieghtamount").value);
													var frieghttax = parseFloat(document.getElementById("frieghttax").value);
													var value =0;
													value = parseFloat(frieghtamount * (frieghttax/100));
													value = parseFloat(value + frieghtamount); 
													document.getElementById("frieghtcharge").value = value;
													assignGrandTotal();
												}
												catch(err)
												{
													alert(err);
												}
										
										}
									
									</script>
									
								  </td>
								  <td class="boldEleven" id="nettotal1"><input name="frieghtcharge" type="text"
										class="formText135" id="frieghtcharge" readonly
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_priceonly(event,'frieghtcharge','7') " value="<%=cashdata[0][21]%>" maxlength="6" />
								  ;</td>
							  </tr>
								<tr>
								  <td class="boldEleven"><div align="left">Reference <span class="boldred"> *</span>
								    <input name="filename"
										type="hidden" value="DirectPurchase" />
								    <input name="actionS"
										type="hidden" value="INVDirectPurchaseUpdate" />
								    <input
										name="param" type="hidden" id="param" value='<%=lens%>'>
							      </div></td>
								  <td class="boldEleven">Rounded<span class="boldred"> *</span></td>
								  <td class="boldEleven" id="nettotal1">
								  <input name="roundedoption" type="text"
										class="formText135" id="roundedoption"
										style='text-align:right' tabindex="15"  onBlur="assignGrandTotal()" onKeyPress="return numeric_priceonly(event,'frieghtcharge','12') " value="<%=cashdata[0][15]%>" maxlength="5" /> </td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left"></div>									</td>
									<td align="left" valign="top" class="boldEleven">
									<div align="left">Net Total</div>									</td>
									<td align="left" valign="top" class="boldEleven" id="nettotal1">
									<div align="left"><input name="nettotal" readonly type="text"
										class="formText135" id="nettotal" tabindex="15"
										value="<%=cashdata[0][11]%>" style='text-align:right' /></div>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal3">&nbsp;</td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven" id="nettotal2">&nbsp;</td>
							  </tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Update" onClick="return valid()" />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('Direct Purchase.jsp')" /></div>
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>									</td>
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
<script language="javascript">
			
	//Calculate base Value
	function calculateBasevalue()
	{
		try
		{
			var tvs =0.0;
			var noofcontrols = "<%=itemDatas.length%>";
			for(u=1; u<=noofcontrols;u++)
				tvs= tvs+parseFloat(document.getElementById('uprice'+u).value * document.getElementById('qty'+u).value );
			document.getElementById("basevalue").value=Round(tvs);		
		}
		catch(err)
		{
			alert(err);
		}
	}
	
	
	
			function calculateValues(ctr)
			{
  				try
				{
					 
					var quantity = document.getElementById(ctr).value;
					var idposition = ctr.replace("qty","");
					if(quantity>=1)
					{
						var uprice = parseFloat(document.getElementById("uprice"+idposition).value);
						var discount =parseFloat(document.getElementById("discount"+idposition).value);
						var udiscount = parseFloat(document.getElementById("unitdiscount"+idposition).value);
						var staxpercentage = parseFloat(document.getElementById("staxpercentage"+idposition).value);
						udiscount =(discount/100)*uprice;
						 
						document.getElementById("unitdiscount"+idposition).value = udiscount;
					
						uprice = uprice - udiscount;
						document.getElementById("staxamount"+idposition).value = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
						var taxamount = Round((quantity*uprice) *parseFloat(staxpercentage) /100);
						var total =  Round((quantity*uprice) +taxamount);
						document.getElementById("total"+idposition).value = Round( total );
						calculateBasevalue();
						assignGrandTotal(); 
						 
					}
					else
					{
						alert("Quantity Should not be Zero");
						qty.focus();
					}
					
				}
				catch(err)
				{
					alert(err);
				}	
					
				
			}
			
			function assignGrandTotal()
			{
				var noofcontrols = "<%=itemDatas.length%>";
				var tvs =0.0;
				var svalue="";
   				for(u=1; u<=noofcontrols;u++)
					tvs= tvs+parseFloat(document.getElementById('total'+u).value);
				document.getElementById("totals").value=Round(tvs);
				var basevalue = parseFloat(document.getElementById("basevalue").value);			
				var tot = parseFloat(document.getElementById("totals").value);
				var discount = parseFloat(document.getElementById("totaldiscount").value);
				var discountamount=0.0;
				if(discount>0)
					discountamount= (discount/100)*tot;
				else
					discountamount	=0.0;
				
				 tot = tot-	discountamount;	
				 var sstax=document.getElementById("salestax").value;
				 if(sstax == "" )
					sstax=="0";
				 var salestax = parseFloat(sstax);
				 
				 var salestaxamount=0.0;
				 if(document.getElementById("basevaluecheck").checked)
					salestaxamount = parseFloat((salestax/100)*basevalue);
				 else
					salestaxamount = parseFloat((salestax/100)*tot);
					
				 var frieghtcharge = parseFloat(document.getElementById("frieghtcharge").value);
				 tot = tot + frieghtcharge;
			
				 document.getElementById("salestaxamount").value = salestaxamount.toFixed(2);
				 document.getElementById("roundedoption").value= (Math.round(tot) - tot).toFixed(2);
				 var roundedoption = parseFloat(document.getElementById("roundedoption").value);
				 var grandtotal = Round((tot+salestaxamount+roundedoption));
				 document.getElementById("nettotal").value=Round(grandtotal) ;
				
		 
			 
			}
			
			<%
			String scrpttaxid[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
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
						document.getElementById("salestax").value = Round(rowvalue[2]);
				}
				assignGrandTotal();
   			}
			
			
		function valid()
		{
   				
			var svalue="";
			for(u=1; u<="<%=lens%>";u++)
				svalue =svalue+"qty"+u+","+"uprice"+u+","+"discount"+u+","+"unitdiscount"+u+","+"total"+u+",";
			var s = "ponumber,vendorid,saleDate,payment,purchaserequest,ref,";
			s = s+svalue+"totals,totaldiscount,tax,salestax,salestaxamount,nettotal,roundedoption,";
			var v = s.split(",");
			if(checkNullSelect("vendorid","Select Vendor ","Select")
				&& checkNullSelect("payment","Select Payment ","Select")
				&&	checkNullSelect("vendorid","Select Vendor ","Select")
				&& 	checkNullSelect("payment","Select Payment ","Select")
				&& 	checkNullSelect("division","Select Division ","Select")
				//&& 	checkNullSelect("purchaserequest","Select purchaserequest ","0")
				//&& 	proposedpurchasedatecheck()	
				&& 	checkNull("memo","Enter the Desription.....")
			)
			{	
				for( i=0; i<v.length-1; i++)
				{
					var ck = "Data not found ..."+v[i];
					if(checkNull(v[i],ck))
						d=1;
					else
						return false;	
				}
			}
			else
			{
				return false;
			}	
				
		}
		
		
		
		
function proposedpurchasedatecheck()
{
	try
	{
		 
		if(  checkNullSelect("purchaserequest","Select Purchase Request Number",'0')   ) 
			return DateCompares ("proposedpurchasedate","saleDate", "Kindly check your purchase and proposed purchase date....")
		else
			return false;
	}
	catch(err)
	{
		alert(err);
	}
}



 </script>
</form>
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 	System.out.println(""+e.getMessage());
	out.println(""+e.getMessage());
 }
%>
</body>
</html>

<%@ page import="java.io.*,java.util.*" isErrorPage="false"	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>

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
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
 $(function() {
		$( "#receddt" ).datepicker({ 
		   defaultDate: "+1w", buttonImage: "../JavaScript/jquery/images/calendar.gif",showOn: "button",
			buttonImageOnly: true, minDate: -2, maxDate: "+0D" });
	});
</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<body >
<%@ include file="indexinv.jsp"%>
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
					<%	
		   	try
			{
			  	String purchaseno=request.getParameter("ponumber");
				String field = " INT_BRANCHID,INT_PURCHASEORDERID,CHR_PURCHASEORDERNO,FIND_A_VENDOR_NAME(INT_VENDORID),	 ";
				field = field + " CHR_POREQUESTNO,DATE_FORMAT(DAT_ORDERDATE,'%d-%m-%Y'),  ";
				field = field + " DATE_FORMAT(DAT_REQUESTDATE,'%d-%m-%Y'),FUN_GET_BRANCH_NAME(INT_ADDRESSID1), ";	
				field = field + " FUN_GET_BRANCH_NAME(INT_ADDRESSID2),INT_ONHOLD,INT_CONDITIONID,INT_PAYMENTTERMID, ";
				field = field + " CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),CHR_DISCOUNT,FUN_GET_TAX_NAME(INT_TAXID),DOU_AMOUNT,DOU_TAXAMOUNT,	 ";
				field = field + " DOU_TOTALAMOUNT,INT_PURCHASESTATUS,	CHR_RECIVEDID,DAT_RECIVEDDATE,	 ";
				field = field + " CHR_PAYMENTSTATUS,	CHR_RECIVEDBY,	DOU_PAIDAMOUNT,	INT_DIVIID,CHR_USRNAME,	 ";
				field = field + " DT_UPDATEDATE,CHR_UPDATESTATUS,FUN_GET_TAX_PERCENTAGE(INT_TAXID), DOU_FRIEGHT_CHARGE ,";
				field = field + " INT_DIVIID ";
				String sql = "SELECT "+field+" FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				 //out.println(sql);  
				boolean flag = false;
				flag =  CommonInfo.RecordExist("SELECT COUNT(*) FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'");
				if(flag)
				{
				String purchaseData[][]= CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit=" return Validate() ">
					<table width="800" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">GOODS RECEIVED </div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Received Ref.No. <span class="errormessage">*</span>
									  <%
						sql = "SELECT CHR_RECIVEDID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					%>
									</div>
									</td>
									<td width="198" class="boldEleven">
									<input name="received" type="text"
												class="formText135" id="received"
												onBlur="CheckUniqueNO(this,'grnValid','inv_t_vendorgoodsreceived','CHR_RECIVEDID')"
												onkeyup="upperMe(this),CheckUniqueNO(this,'grnValid','inv_t_vendorgoodsreceived','CHR_RECIVEDID')" size="30" maxlength="30" /><div id=grnValid></div>
									
									 
									</td>
									<td width="102" class="boldEleven">
									<div align="left">Delivary No<span class="errormessage">*</span></div>
									</td>
									<td width="237" class="boldEleven">
									<input name="delivaryNo" type="text"
												class="formText135" id="delivaryNo"
												onBlur="CheckUniqueNO(this,'delivValid','inv_t_vendorgoodsreceived','CHR_DELIVARYNO')"
												onkeyup="upperMe(this),CheckUniqueNO(this,'delivValid','inv_t_vendorgoodsreceived','CHR_DELIVARYNO')" size="30" maxlength="30" /><div id=delivValid></div>
									 
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received Date</div>
									</td>
									<td class="boldEleven"><input name="receddt" type="text"
										class="formText135" id="receddt" tabindex="7" size="15"
										maxlength="10" readonly />   <script language='JavaScript'
										type="text/javascript">
		<!--			
				 
				setCurrentDate('receddt'); 
		//-->
                          </script></td>
									<td class="boldEleven">
									<div align="left">Invoice No<span class="errormessage">*</span></div>
									</td>
									<td class="boldEleven">
									<input name="invoiceNo" type="text"
												class="formText135" id="invoiceNo"
												onBlur="CheckUniqueNO(this,'invValid','inv_t_vendorgoodsreceived','CHR_INVOICENO')"
												onkeyup="upperMe(this),CheckUniqueNO(this,'invValid','inv_t_vendorgoodsreceived','CHR_INVOICENO')" size="30" maxlength="30" /><div id=invValid></div>
									
									 
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Purchase Order No</div>
									</td>
									<td class="boldEleven"><%=purchaseno%></td>
									<td class="boldEleven">
									<div align="left">Payment Mode</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_CONDITIONID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymentid = CommonInfo.intGetAnySelectField(sql, "INT_CONDITIONID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+paymentid;
					out.println( CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor</div>
									</td>
									<td class="boldEleven">
								     <%=purchaseData[0][3]%>									</td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_PAYMENTTERMID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymenttermid = CommonInfo.intGetAnySelectField(sql, "INT_PAYMENTTERMID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID="+paymenttermid;
					out.println( CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Order Date</div>
									</td>
									<td class="boldEleven">
									<%=purchaseData[0][5]%>
					 
									</td>
									<td class="boldEleven">
									<div align="left">Order From</div>
									</td>
									<td class="boldEleven"><%=purchaseData[0][7]%>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date</div>
									</td>
									<td class="boldEleven">
								     <%=purchaseData[0][6]%>									</td>
									<td class="boldEleven">
									<div align="left">Shipping To</div>
									</td>
									<td class="boldEleven"><%=purchaseData[0][8]%>									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
				//======================================================================
			  	sql = " SELECT INT_ID,CHR_PURCHASEORDERNO,CHR_ITEMID, CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,CHR_DISCOUNT, ";
				sql = sql +" DOU_UNITDISCOUNT,DOU_TOTAL ,INT_RECIVEDQUANTITY,INT_REMAINQUANTITY,";
				sql = sql +" IF(CHR_TYPE='I','ITEM','PRODUCT') ,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID) , ";
				sql = sql +" IF(CHR_TYPE='I','F',FUN_INV_PRODUCTTYPE(CHR_TYPE,CHR_ITEMID)) ";
				sql = sql +" FROM inv_t_vendorpurchaseorderitem";
				sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				//out.println(sql);
				String itemData[][]=  CommonFunctions.QueryExecute(sql);
				out.print("<table  border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th  class='boldEleven'><b>Type</b></th>");
				out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven'><b>Description</b></th>");
                out.print("<th  class='boldEleven'><b>Order Qty</b></th>");
				out.print("<th  class='boldEleven'><b>Received Qty</b></th>");
				out.print("<th  class='boldEleven'><b>Balance Qty</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
                out.print("<th  class='boldEleven'><b>Total</b></th>");
                String orderqty="";
                String receqty="";
                String idv="";
                String qtyv="";
				String id="";
				String itemid="";
				String dbreceived="";
				String ordered="";
                String receivedqty ="receivedqty";
				String chk="";
				String itype="";
				String uprice="";
				int totItem=0;
				for(int u=0; u<itemData.length;u++)
				{
					
					
                	orderqty = orderqty+itemData[u][5]+"~";
                	receqty=receqty+(receivedqty+(u+1))+"~";
                	idv="receivedqty"+(u+1);
                	qtyv="qty"+(u+1);
					id = "rowid"+(u+1);
					itemid = "item"+(u+1);
					itype = "itype"+(u+1);
					dbreceived ="dbreceived"+(u+1);
					ordered ="ordered"+(u+1);
					uprice ="uprice"+(u+1);
					int r =Integer.parseInt(itemData[u][5])-Integer.parseInt(itemData[u][10]);
					totItem=totItem+r;
					
					out.print("<tr>");
					//IType
					out.print("<td width='52' class='boldEleven'>"+itemData[u][12]+"</td>");
					
					//Product Code
					out.print("<td width='52' class='boldEleven'>"+itemData[u][13]+"</td>");
					
					//Description
					out.print("<td  valign='top' width='102' class='boldEleven'>"+itemData[u][4] +"</td>");
					
					//ORdered quantity
					out.print("<td  valign='top' width='83' class='boldEleven'>"+itemData[u][5]);					
					out.print("<input type='hidden' name='"+qtyv.trim()+"' id='"+qtyv.trim()+"' class='formText135' value='"+r+"'  >");
					out.print("<input type='hidden' name='odqty"+(u+1)+"' id='odqty"+(u+1)+"'  value='"+itemData[u][5]+"'>");
					out.print("<input type='hidden' name='unitprice"+(u+1)+"' id='unitprice"+(u+1)+"'  value='"+itemData[u][6]+"'>");
					out.print("<input type='hidden' name='pmode"+(u+1)+"' id='pmode"+(u+1)+"'  value='"+itemData[u][14]+"'>");
					out.print("</td>");
					
					//Received Qunatity
					out.print("<td  valign='top' class='boldEleven'> &nbsp;"+itemData[u][10]);
					out.println("<input type='hidden' name='prev"+(u+1)+"' id='prev"+(u+1)+"' value='"+Integer.parseInt(itemData[u][10])+"' >");
					//out.print("<input class='formText135' size=10 type='text' value='"+itemData[u][12]+"' name ='"+dbreceived+"'>"+"</td>");
					chk="onKeyPress=\"return numeric_only(event,'"+idv+"','9')\"";
					
					 
					
					out.print("<td  valign='top' width='83' class='boldEleven'>&nbsp;<input  name='"+idv+"' id='"+idv+"' class='formText135' size=10 maxlength='6' "+chk+" onBlur='checkReceivedQty(this)'");
					if(r<1)
						out.println("readonly ='readonly' type='hidden' ");
					else
						out.println(" type='text' ");
					
					out.println(" value='"+r+"' style='text-align:right'></td>");
					//value='"+itemData[u][12]+"'
                	
					//unitprice
					out.print("<td  valign='top' width='98' class='boldEleven'>&nbsp;"+itemData[u][6]);
					
					//discount
					out.print("<td  valign='top' width='123' class='boldEleven'>&nbsp;"+itemData[u][7]+"</td>");
					
                	//Unit discount
					out.print("<td  valign='top' width='133' class='boldEleven'>&nbsp;"+itemData[u][8]);
					out.print("<input type='hidden' value='"+itemData[u][0]+"' name ='"+id+"'>");
					out.print("<input type='hidden' value='"+itemData[u][2]+"' name ='"+itemid+"'>");
					out.print("<input type='hidden' value='"+itemData[u][10]+"' name ='"+dbreceived+"'>");
					out.print("<input type='hidden' value='"+itemData[u][5]+"' name ='"+ordered+"'>");
					out.print("<input type='hidden' value='"+itemData[u][3]+"' name ='"+itype+"'>");
					out.print("<input type='hidden' value='"+itemData[u][6]+"' name ='"+uprice+"'>");
                	out.println("</td>");
					
					//Total
					out.print("<td  valign='top' width='54' class='boldEleven'>&nbsp;"+itemData[u][9]);
					out.print("</td></tr>");
				}
				
				out.print("</table>");
			  	out.println("<input type='hidden' name='length' id='length' value='"+itemData.length+"'>");
			  %>
							</td>
						</tr>
						<tr>
							<td><input type="hidden" name="totItem" id="totItem"
								value="<%=totItem %>"></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="151" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description</div>
									</td>
									<td width="283" rowspan="4" valign="top" class="boldEleven">
									<div style="OVERFLOW:auto;width:200px;height:100px"
										class="boldEleven">
									<%=purchaseData[0][12]%>
									</div>
									</td>
									<td width="192" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td  align="right" class="boldEleven" id="totals1"> <%=purchaseData[0][16]%> </td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="157" align="right" valign="top" class="boldEleven"
										id="totaldiscount1"><%=purchaseData[0][14]%></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Name</div>
									</td>
									<td width="157" align="right" valign="top" class="boldEleven" id="tax1">
								     <span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][15]%></span>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="157" align="right" valign="top" class="boldEleven" id="salestax1">
								     <span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][29]%></span>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="GoodsReceived" /> <input name="actionS"
										type="hidden" value="INVGoodsReceivedAdd" /> <input
										name="purchaseno" type="hidden" id="ponumber"
										value="<%=purchaseno%>">
									  <input name="division" type="hidden" id="division" value="<%=purchaseData[0][31]%>"> 
									</div>
									</td>
									<td class="boldEleven">
								     <span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][13]%></span>									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td align="right" class="boldEleven" id="salestaxamount1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][17]%></span>									</td>
								</tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">Freight Charge</td>
								  <td align="right" class="boldEleven" id="nettotal2"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][30]%></span></td>
							  </tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>
									</td>
									<td class="boldEleven">
									
									<select name="receivedby" id="receivedby"
										class="formText135" size="5" style="width:200">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select>
					<%
						sql = "SELECT CHR_RECIVEDBY FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					%>
					<script language="javascript">setOptionValue('receivedby','<%=CommonFunctions.QueryExecute(sql)[0][0]%>')</script>
					
					
					
					</td>
									<td class="boldEleven">
									<div align="left">Net Total</div>
									</td>
									<td align="right" class="boldEleven" id="nettotal1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][18]%></span>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" id="Submit" type="submit"
												class="buttonbold13" value="Received"
												 /></td>
											<td width="56"><input type="button" class="buttonbold13"
												onClick="redirect('GoodsRecived.jsp')"  value="Close"   accesskey="c"  /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>
					<script language="javascript">
	function checkReceivedQty(control)
  	{
		var order= "<%=orderqty%>";
		var order1 =order.split("~");
		var position = (control.name.replace("receivedqty",""));
		pqty = parseInt(document.getElementById("qty"+position).value); 
		rqty = parseInt(control.value);
		if(rqty <=0)
		{
			alert(" Received Quantity should not be zero");
			control.value="1";
			control.focus();
		}
		if(rqty > pqty)
		{
			alert(" Received Quantity should be less than or equal to ordered quantity");
			control.value="1";
			control.focus();
		}	
		
	}

	function Validate()
  	{
		try
		{
			if(
			    checkNull('received','Enter the Received Reference number')
				&& checkNull('delivaryNo','Enter the delivery number')
				&& checkNull('invoiceNo','Enter the invoice number')
			   )
			{
				var reced= "<%=receqty%>";
				 
				reced="received~delivaryNo~receddt~invoiceNo~receivedby~"+reced;
				var reced1 =reced.split("~");
				for( i=0; i<reced1.length-1; i++)
				{
					var ck = "Enter Data..."+reced1[i];
					 if(checkNull( reced1[i] ,ck))
						d=1;
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
		}			
	} 
</script> <%
		  	}
			else
			{
				response.sendRedirect("GoodsRecived.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>
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
<%@ include file="../footer.jsp"%>
</body>
</html>

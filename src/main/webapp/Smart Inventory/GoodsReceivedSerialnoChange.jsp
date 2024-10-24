<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
var ItemSerial=[
<%	
try
{

  	String delivaryNo = request.getParameter("delivaryNo");
	String invoiceNo = request.getParameter("invoiceNo");
  	String purchaseno=request.getParameter("ponumber");
  	String recNo=request.getParameter("refno");
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where "+
" CHR_SERIALNO IS NOT NULL AND CHR_RECIVEDID<>'"+recNo+"' ORDER BY CHR_ITEMID";
String serialValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
for(int i=0;i<serialValue.length;i++)
{
	out.print("[\""+serialValue[i][0]+"\",\""+serialValue[i][1]+"\"],");
}
%>
];
	function CheckSerialNoValue(ser)	
	{		
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;				
	    var found=0;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			if(itm==valN && itmSer==txt)
			{
				found=1;
				break;
		    }
	    }	    
	    if(txt=="")  {
   			alert("Enter Correct Serial No....");
			return false;	    
	    }		  
		else if(found==1){
			alert("Serail Already Exits!");
			document.getElementById(nam).focus();
			return false;
		}		
	  var slen=document.getElementById('seriallength').value;
      txt=txt.toUpperCase();
	  for(i=1;i<=slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();		
		//alert("TXT :"+txt +" -- TXT1 :"+txt1+ " LEN ::"+slen);
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }		
	}	
	function checkSerialNo(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		var myTab="<div id='divscroll'  class='boldEleven'>";
		var flag=false;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			//if(tlen<=slen)
			//{			
		//	 itmSer1=itmSer.substring(0,tlen)			 
			 if(itm==valN && itmSer==txt)
			 {			     
		 		 flag=true;
		 		 break;
		     } 
		   // }		   
		}
		if(txt=="") 
		  myTab=myTab+"<font color='red'>Enter Valid Serail No</font></div>";
		else if(flag==true)
			myTab=myTab+"<font color='red'>Serial Already Exits</font></div>";
		else
			myTab=myTab+"<font color='blue'>Valid Serial</font></div>";
		document.getElementById('Valid'+namF).innerHTML=myTab;
	}
</script>

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
				sql = "SELECT * FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				boolean flag = false;
				flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
				if(flag)
				{
				String purchaseData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">Goods Received Serial
							Change</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="649" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Received Ref.No.</div>
									</td>
									<td width="198" class="boldEleven"><input name="received"
										type="text" class="formText135" id="received" maxlength="25"
										value="<%=recNo%>" /></td>
									<td width="102" class="boldEleven">Delivary No</td>
									<td width="237" class="boldEleven"><input type="text"
										class="formText135" name="delivaryNo" value="<%=delivaryNo %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received Date</div>
									</td>
									<td class="boldEleven"><input name="receddt" type="text"
										class="formText135" id="receddt" tabindex="7" size="15"
										maxlength="11" readonly="readonly" /> <a
										href="javascript:cald.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cald = new calendar1(document.forms['frm'].elements['receddt']);
				cald.year_scroll = true;
				cald.time_comp = false;
				setCurrentDate('receddt'); 
		//-->
                          </script></td>
									<td class="boldEleven">
									<div align="left">Invoice No</div>
									</td>
									<td class="boldEleven"><input type="text"
										class="formText135" name="invoiceNo" value="<%=invoiceNo %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Purchase Order No</div>
									</td>
									<td class="boldEleven"><%=purchaseno%></td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_PAYMENTTERMID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymenttermid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_PAYMENTTERMID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID="+paymenttermid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_VENDORID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int vendorid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_VENDORID");
					sql = "SELECT CHR_VENDORNAME FROM  inv_m_vendorsinformation  WHERE INT_VENDORID="+vendorid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_VENDORNAME"));
					%>
									</td>
									<td class="boldEleven">
									<div align="left">Order From</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ADDRESSID1 FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int orderid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_ADDRESSID1");
					sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+orderid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Order Date</td>
									<td class="boldEleven">
									<%
					sql = "SELECT DAT_ORDERDATE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DAT_ORDERDATE"));
					%>
									</td>
									<td class="boldEleven">Shipping To</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ADDRESSID2 FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int shipid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_ADDRESSID2");
					sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+shipid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT DAT_REQUESTDATE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DAT_REQUESTDATE"));
					%>
									</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center">
							<%
				 
				sql = "SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,INT_RECIVEDQUANTITY,INT_REMAINQUANTITY FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				String recdData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:550px;height:200px' class='boldEleven'>");
				out.print(" <table width=500 border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th width='52' class='boldEleven'><b>Item</b></th>");
                out.print("<th width='123' class='boldEleven'><b>Serial No</b></th>");
                out.print("<th width='123' class='boldEleven'>&nbsp;</th>");
                out.print("<th width='133' class='boldEleven'><b>Warranty</b></th>");
				int row=1;
				 for(int v=0;v<recdData.length; v++)
				{
					String itemid = recdData[v][1];
					String redqty = recdData[v][2];
					String remQty= recdData[v][3];
					sql = "SELECT * FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					sql = sql +" AND CHR_ITEMID ='"+itemid+"' AND CHR_RECIVEDID='"+recNo+"' AND CHR_SERIALNO IS NOT NULL";					
					String itemRecVData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					sql="UPDATE inv_t_vendorgoodsreceived SET CHR_RECIVEDID='',DAT_RECIVEDDATE=null,";
					sql=sql+"CHR_RECIVEDBY=null,CHR_SERIALNO=null,CHR_WARRANTY=null WHERE ";
					sql=sql+" CHR_ITEMID ='"+itemid+"' AND CHR_RECIVEDID='"+recNo+"'";
					CommonInfo.SQLUpdate(sql);
					
					sql = "SELECT * FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					sql = sql +" AND CHR_ITEMID ='"+itemid+"' AND CHR_SERIALNO IS NULL";
					String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					//System.out.println("REC QTY:"+redqty);
					//System.out.println("REC LEN:"+itemData.length);					
					int totItm=itemData.length-Integer.parseInt(remQty);
					//System.out.println("Cuurent Rec "+totItm);
					String serial="serail";
					String warranty="warranty";
					for(int u=0; u<totItm;u++)
					{
						serial = "serail"+(u+1);
						warranty="warranty"+(u+1);
						out.print("<tr>");
						sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][3]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
						int len=itemRecVData.length;
						if(u<len)
						{
							out.print("<td><input name='serail"+row+"' onblur='CheckSerialNoValue(this)' onkeyup='checkSerialNo(this)'"+
									" value='"+itemRecVData[u][7]+"' class='formText135' maxlength='50' size=20 type='text'  name ='"+serial+"'>");
							out.println("<td class='boldEleven' width='150'><div id='Valid"+row+"'> </div>");
							out.print("<td><input name='warranty"+row+"' value='"+itemRecVData	[u][8]+"'class='formText135' maxlength='50' size=20  type='text'  name ='"+warranty+"'>");
						}else{
							out.print("<td><input name='serail"+row+"' onblur='CheckSerialNoValue(this)' onkeyup='checkSerialNo(this)' value='"+itemData[u][7]+"' class='formText135' maxlength='50' size=20 type='text'  name ='"+serial+"'>");
							out.println("<td class='boldEleven' width='150'><div id='Valid"+row+"'> </div>");
							out.print("<td><input name='warranty"+row+"' value='"+itemData[u][8]+"'class='formText135' maxlength='50' size=20  type='text'  name ='"+warranty+"'>");
						}
						out.print("<input name='item"+row+"' type='hidden' id='item' value='"+itemid+"'>");
						out.print("<input name='row"+row+"' type='hidden' id='item' value='"+itemData[u][0]+"'>");
						out.print("</tr>");
						row= row+1;
					}
				}
				out.print("</table> ");
				out.print("</div> ");
				out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");				
			  %>
							</div>
							<input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>"></td>
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
									<div align="left">Description</div>
									</td>
									<td width="200" rowspan="4" valign="top" class="boldEleven">
									<div style="OVERFLOW:auto;width:200px;height:100px"
										class="boldEleven">
									<%
					sql = "SELECT CHR_DES FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES"));
					%>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<%
					sql = "SELECT DOU_AMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_AMOUNT"));
					%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<%
					sql = "SELECT CHR_DISCOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DISCOUNT"));
					%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<%
					sql = "SELECT INT_TAXID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int taxid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_TAXID");
					sql = "SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_TAXNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<%
					sql = "SELECT INT_TAXID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int taxvid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_TAXID");
					sql = "SELECT DOU_VALUE FROM inv_m_tax WHERE INT_TAXID="+taxvid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_VALUE"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="GoodsReceived" /> <input name="actionS"
										type="hidden" value="INVGoodsReceivedSerialAdd" /> <input
										name="purchaseno" type="hidden" id="ponumber"
										value="<%=purchaseno%>"></div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT CHR_REF FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_REF"));
					%>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<%
					sql = "SELECT DOU_TAXAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_TAXAMOUNT"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>
									</td>
									<td class="boldEleven">
									<%
						sql = "SELECT CHR_RECIVEDBY FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
		  %> <input name="receivedby" type="text" id="receivedby"
										maxlength="25"
										value="<%=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_RECIVEDBY").trim()%>"></td>
									<td class="boldEleven">
									<div align="left">Net Total</div>
									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left">
									<%
					sql = "SELECT DOU_TOTALAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_TOTALAMOUNT"));
		  %>
									</div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold" value="Received" /></td>
											<td width="56"><input type="button" class="buttonbold"
												onClick="redirect('GoodsReceivedEdit.jsp?ponumber=<%=purchaseno%>')"
												 value="Close"   accesskey="c"  /></td>
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
					<%
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

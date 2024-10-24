<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

<script language="javascript">
var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO,CHR_TYPE from inv_t_vendorgoodsreceived where "+
" CHR_SERIALNO IS NOT NULL ORDER BY CHR_ITEMID";
String serialValue[][]= CommonFunctions.QueryExecute(sql);
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
<script language="javascript">
function valid()
{
		var len  = document.getElementById('seriallength').value;
		var s="";
		for(u=1;u<len;u++)
		{
			s=s+document.getElementById("serail"+u).value+",";
		}
		var v = s.split(",");
	
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = s.split(",");	
		secondaryArray = s.split(",");	
		s = "";
		ss="";
		lens = primaryArray.length-1;
		var position=1;
		for(i=0;i<lens-1;i++)
		{
			for(j=i+1;j<lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=i+1;
				}	
		}
		var d=ss.length
		if(d >1)
		{
			alert("Duplicate Entry");
			document.getElementById('error').innerHTML="Duplicate available";
			document.getElementById('Submit').disabled=true;
			document.getElementById("serail"+position).focus()
		}
		else
		{
			document.getElementById('error').innerHTML="";
			document.getElementById('Submit').disabled=false;
		}	
	
		for(u=1;u<len;u++)
			if(checkNull("serail"+u,"Enter data"))
				d=1;
			else
				return false;
		
	
	
}
 </script>
<body >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
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
				String delivaryNo = request.getParameter("delivaryNo");
				String invoiceNo = request.getParameter("invoiceNo");
				
				String field = " INT_BRANCHID,INT_PURCHASEORDERID,CHR_PURCHASEORDERNO,FIND_A_VENDOR_NAME(INT_VENDORID),	 ";
				field = field + " CHR_POREQUESTNO,DATE_FORMAT(DAT_ORDERDATE,'%d-%m-%Y'),  ";
				field = field + " DATE_FORMAT(DAT_REQUESTDATE,'%d-%m-%Y'),FUN_GET_BRANCH_NAME(INT_ADDRESSID1), ";	
				field = field + " FUN_GET_BRANCH_NAME(INT_ADDRESSID2),INT_ONHOLD,INT_CONDITIONID,INT_PAYMENTTERMID, ";
				field = field + " CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),CHR_DISCOUNT,FUN_GET_TAX_NAME(INT_TAXID),DOU_AMOUNT,DOU_TAXAMOUNT,	 ";
				field = field + " DOU_TOTALAMOUNT,INT_PURCHASESTATUS,	CHR_RECIVEDID,DAT_RECIVEDDATE,	 ";
				field = field + " CHR_PAYMENTSTATUS,	CHR_RECIVEDBY,	DOU_PAIDAMOUNT,	INT_DIVIID,CHR_USRNAME,	 ";
				field = field + " DT_UPDATEDATE,CHR_UPDATESTATUS,FUN_GET_TAX_PERCENTAGE(INT_TAXID),CHR_POREQUESTNO ";
				sql = "SELECT "+field+" FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				//out.println(sql);  
				boolean flag = false;
				flag =  CommonInfo.RecordExist("SELECT COUNT(*) FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'");
				 
				if(flag)
				{
					String purchaseData[][]= CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">GoodsReceived</div>							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Received Ref.No.</div>									</td>
									<td width="198" class="boldEleven">
									<%
						sql = "SELECT CHR_RECIVEDID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					%> <input name="received" type="text" class="formText135"
										id="received" maxlength="25"
										value="<%=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_RECIVEDID").trim()%>" /></td>
									<td width="102" class="boldEleven">
									<div align="left">
									<div align="left">Delivary No</div>
									</div>									</td>
									<td width="237" class="boldEleven"><%= delivaryNo.toUpperCase()%>
									<input type="hidden" name="delivaryNo" value="<%=delivaryNo %>">									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received Date</div>									</td>
									<td class="boldEleven"><input name="receddt" type="text"
										class="formText135" id="receddt" tabindex="7" size="15"
										maxlength="11" readonly /> <a
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
									<div align="left">Invoice No</div>									</td>
									<td class="boldEleven"><%= invoiceNo.toUpperCase()%> <input
										type="hidden" name="invoiceNo" value="<%=invoiceNo %>">									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Purchase Order No</div>									</td>
									<td class="boldEleven"><%=purchaseno%></td>
									<td class="boldEleven">
									<div align="left">Payment Mode</div>									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_CONDITIONID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymentid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_CONDITIONID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+paymentid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor</div>									</td>
									<td class="boldEleven"><%=purchaseData[0][3]%> </td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_PAYMENTTERMID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymenttermid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_PAYMENTTERMID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID="+paymenttermid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>									</td>
								</tr>
								<tr>
									<td class="boldEleven">Order Date</td>
									<td class="boldEleven"><%=purchaseData[0][5]%> </td>
									<td class="boldEleven">Order From</td>
									<td class="boldEleven"><%=purchaseData[0][7]%> </td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date</div>									</td>
									<td class="boldEleven"><%=purchaseData[0][6]%> </td>
									<td class="boldEleven">Shipping To</td>
									<td class="boldEleven"><%=purchaseData[0][8]%> </td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<div align="center" id="error" class="bolddeepred" />							</td>
						</tr>
						 
						<tr>
							<td>
							<div align="center">
							<%
				 
				sql = "SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,INT_RECIVEDQUANTITY,INT_REMAINQUANTITY,CHR_TYPE,(INT_RECIVEDQUANTITY-INT_REMAINQUANTITY) FROM  inv_t_vendorpurchaseorderitem WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				//out.println(sql);
				
				sql = " SELECT a.CHR_PURCHASEORDERNO,a.CHR_ITEMID,  ";
				sql = sql + " a.INT_RECIVEDQUANTITY,a.INT_REMAINQUANTITY,  ";
				sql = sql + " a.CHR_TYPE,(a.INT_RECIVEDQUANTITY-a.INT_REMAINQUANTITY) ,  ";
				sql = sql + " if(a.CHR_TYPE ='I' ,'Item','Product'),  ";
				
				sql = sql + " if( a.CHR_TYPE ='I',  ";
				sql = sql + " ( SELECT  b.CHR_ITEMNAME  FROM inv_m_item b WHERE b.CHR_ITEMID =a.CHR_ITEMID),  ";
				sql = sql + " ( SELECT  c.CHR_PRODUCTCODE  FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID =a.CHR_ITEMID)  ";
				sql = sql + " ),  ";
				  
				sql = sql + " if( a.CHR_TYPE ='I',  ";
				sql = sql + " ( SELECT  b1.CHR_WARRANTY  FROM inv_m_item b1 WHERE b1.CHR_ITEMID =a.CHR_ITEMID),  ";
				sql = sql + " ( SELECT  c1.CHR_WARRANTY  FROM inv_m_produtlist c1 WHERE c1.CHR_PRODUCTID =a.CHR_ITEMID)  ";
				sql = sql + " ) ,  ";
				sql = sql + " IF(a.CHR_TYPE='I','F',FUN_INV_PRODUCTTYPE(a.CHR_TYPE,a.CHR_ITEMID)) ";
				sql = sql + " FROM inv_t_vendorpurchaseorderitem  a   ";
				sql = sql + " WHERE a.CHR_PURCHASEORDERNO ='"+purchaseno+"'  ";
				//out.println(sql);
				String recdData[][]=  CommonFunctions.QueryExecute(sql);
				boolean serialflag=false;
				if(recdData.length>0)
				{
					for(int v=0;v<recdData.length; v++)
					{
						if(!"S".equals(recdData[v][9]))
							serialflag = true;
					}
				}
				
				int rcount=0;
 				String h="";
				String h1="";
				String iitype="";
				int row=1;
				if(serialflag)
				{
					out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:800px;' class='boldEleven'>");
					out.print("<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
					out.print("<tr class='MRow1'>");
					out.print("<td  class='boldEleven'><b>S.No</b></td>");
					out.print("<td  class='boldEleven'><b>Type</b></td>");
					out.print("<td  class='boldEleven'><b>Item / Product </b></td>");
					out.print("<td  class='boldEleven'><b>Serial No</b></td>");
					out.print("<td  class='boldEleven'>&nbsp;</td>");
					out.print("<td  class='boldEleven'><b>Warranty</b></td>");
					out.print("</tr>");
					
					String chkserial="";
					int totItm=0;
					
					for(int v=0;v<recdData.length; v++)
					{
						if(!"S".equals(recdData[v][9]))
						{
							String itemid = recdData[v][1];
							String redqty = recdData[v][2];
							String remQty= recdData[v][3];
							String itype = recdData[v][4];
							String iname = recdData[v][6];
							String itemname = recdData[v][7];
							iitype= itype;
							String mwaranty = recdData[v][8];	
							
							sql = "SELECT INT_ID,CHR_PURCHASEORDERNO,CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
							sql = sql +" AND CHR_ITEMID ='"+itemid+"' AND CHR_TYPE='"+iitype+"' AND CHR_SERIALNO IS NULL";
							String itemData[][]=  CommonFunctions.QueryExecute(sql);
							////System.out.println(sql);
							totItm=0;
							totItm = itemData.length-Integer.parseInt(remQty);
							
							String serial="serail";
							String warranty="warranty";
							for(int u=0; u<totItm;u++)
							{
								serial = "serail"+row;
								warranty="warranty"+row;
								rcount = rcount+1;
								if(u%2==0)
									out.print("<tr class='MRow1'>");
								else	
									out.print("<tr class='MRow2'>");
								
								out.println("<td class='boldEleven'>"+row+"</td>");
								out.println("<td class='boldEleven'>"+iname+"</td>");
								out.print("<td  class='boldEleven'>&nbsp;"+itemname+"</td>");
								
							
		//h=" onBlur=\"getValues('serail','"+(recdData.length+1)+"' ,'error' , 'Submit')\" ";
		h1="  onkeyup=\"LoadUniqueCheck('serail"+(row)+"','Valid"+(row)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\"  ";
		
								out.print("<td> <input id='"+serial+"' onBlur='upperMe(this)'   value='"+itemData[u][4]+"' "+h+h1+" class='formText135' maxlength='50' size=20 type='text'  name ='"+serial+"'>");
								out.println("<td class='boldEleven' ><div id='Valid"+row+"'> </div>&nbsp;");
								
								out.print("<td>");
								out.print("<select name='"+warranty+"' id='"+warranty+"' class='formText135' >");
								%> <jsp:include page="Warranty.jsp" flush="true" /> <%
				out.println("</select>");
				%> <script language="javascript">
					setOptionValue('<%=warranty%>','<%=mwaranty%>') 
				</script> <%
								out.println("</select>");
							 
								out.print("<input name='item"+row+"' type='hidden' id='item' value='"+itemid+"'>");
								out.print("<input name='row"+row+"' type='hidden'   value='"+itemData[u][0]+"'>");
								out.print("<input name='itype"+row+"' type='hidden'   value='"+iitype+"'>");
								out.print("</tr>");
								row= row+1;
							}
						}
					}
					out.print("</table> ");
					out.print("</div> ");
				}
				out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");				
				
			  %>
							</div> 
							<input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>">						  </td>
						</tr>
						<tr>
						  <td>
                          <%
                          if(serialflag)
						  {
                          %>
                          <table width="500" border="0" align="right" cellpadding="5" cellspacing="0">
                            <tr>
                              <td width="267" rowspan="2" valign="top" class="bolddeeplogin"><div align="right">
                                  <textarea name="randomserials" cols="25" rows="5" id="randomserials"></textarea>
                              </div></td>
                              <td width="317" valign="top" class="bolddeeplogin" ><a href='javascript:assignrandomserial()'>Serialnumber Assign </a><br>
                                (E.g S12,S10,S5,)</td>
                              <td width="317" rowspan="2" valign="top" class="bolddeeplogin" ><a href='javascript:assignSerialWarranty()'>Warranty Assign</a></td>
                            </tr>
                            <tr>
                              <td valign="top" class="bolddeeplogin" > 
                                  
                              </td>
                            </tr>
                          </table>
                          <%
						  }
						  %>
                          
                          
                          </td>
					  </tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								    <tr>
								      <td width="114" rowspan="5" valign="top" class="boldEleven">
								        <div align="left">Description</div>									</td>
								      <td width="200" rowspan="5" valign="top" class="boldEleven">
								        <div style="OVERFLOW:auto;width:200px;height:100px"
										class="boldEleven">
						                <span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][12]%></span>							            </div>									</td>
								      <td valign="top" class="boldEleven">&nbsp;</td>
								      <td valign="top" class="boldEleven" id="totals1">&nbsp;</td>
						      </tr>
							    <tr>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>									</td>
								    <td width="169" valign="top" class="boldEleven" id="totals1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][16]%></span></td>
							    </tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>									</td>
								    <td width="169" valign="top" class="boldEleven"
										id="totaldiscount1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][14]%></span></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>									</td>
								    <td width="169" valign="top" class="boldEleven" id="tax1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][15]%></span> </td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>									</td>
								    <td width="169" valign="top" class="boldEleven" id="salestax1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][29]%></span> </td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="GoodsReceived" /> <input name="actionS"
										type="hidden" value="INVGoodsReceivedSerialAdd" /> <input
										name="purchaseno" type="hidden" id="ponumber"
										value="<%=purchaseno%>">
									  <input name="purchaserequest" type="hidden" id="purchaserequest" value="<%=purchaseData[0][30]%>">
									  <input name="serialflag" type="hidden" id="serialflag" value="<%=serialflag%>">
									</div>									</td>
									<td class="boldEleven">
										<span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][13]%></span> </td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>									</td>
								    <td class="boldEleven" id="salestaxamount1"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][17]%></span> </td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>									</td>
									<td class="boldEleven">
									
									<select name="receivedby" id="receivedby"
										class="formText135" size="5" style="width:200">
										<jsp:include page="Staffload.jsp" flush="true" />
									</select>
					<%
						sql = "SELECT CHR_RECIVEDBY FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					%>
					<script language="javascript">setOptionValue('receivedby','<%=CommonFunctions.QueryExecute(sql)[0][0]%>')</script>									 </td>
									<td class="boldEleven">
									<div align="left">Net Total</div>									</td>
								    <td class="boldEleven" id="nettotal1"><div align="left"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][18]%></span> </div></td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" id="Submit"
												type="submit" class="buttonbold" value="Received"
												onClick="return valid()" /></td>
											<!--<td width="56">
							<input   type="button" class="buttonbold" onClick="redirect('GoodsReceivedEdit.jsp?ponumber=<%=purchaseno%>')"  value="Close"   accesskey="c" /></td>-->
										</tr>
									</table>									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>									</td>
								</tr>
							</table>							</td>
						</tr>
					</table> 

<script language="javascript">

function assignrandomserial()
 {
 	var l=parseInt("<%=rcount%>");
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Check Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split(",");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);
			for(u=0;u<seriallength;u++)
				{
					var ty="serail"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=trim(arrayarandomserial[u]);
					
				}
				document.getElementById('serail1').focus();
			
				
		}
	}	
 }  





function assignSerialWarranty()
{
 	try
	{
		var l=parseInt("<%=rcount%>");
		var warranty=prompt("Enter the Warranty for an e.g  3 month means 0.3 , 1 Year means 1","1"); 
		for(u=0;u<l;u++)
		{
			var ty="warranty"+(u+1);
			var obj = findObj(ty);
			if(obj != null)
				setOptionValue(ty,warranty);
		}
	}
	catch(err)
	{
		alert(err);
		
	}	
 }  






</script>

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


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
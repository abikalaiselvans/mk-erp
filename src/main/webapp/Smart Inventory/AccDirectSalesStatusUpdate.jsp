<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />


<title>:: INVENTORY ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>




<script language="javascript">
	function  Print(salno)
		{
			
			var width="800", height="400";
			var f =document.getElementById('serial').checked;
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="DirectSalesPrint.jsp?salno="+salno +"&serialyes="+f;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
	
	
	 function disable1()
  {
  	 
	document.getElementById('serialno').checked  = false;
  }
  function disable2()
  {
  	document.getElementById('serialyes').checked = false;
  }
	
	function validate()
{
	if(	checkNull("desc","Enter Description"))
		return true;	
	else
		return false;	
}
</script>



<script language="javascript">


var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY from inv_t_vendorgoodsreceived where CHR_FLAG='N'"+
"AND CHR_GRTFLAG='N' AND CHR_SERIALNO IS NOT NULL ORDER BY CHR_ITEMID";
String serialValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

for(int i=0;i<serialValue.length;i++)
{
	out.print("[\""+serialValue[i][0]+"\",\""+serialValue[i][1]+"\",\""+serialValue[i][2]+"\"],");
}
%>
];
	function CheckSerial1(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("itemid"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		var myTab="<div id='divscroll' style='OVERFLOW:auto;width:200px;height:50px' class='boldEleven'><table>";
		var found=0;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			if(tlen<=slen)
			{			
			 itmSer1=itmSer.substring(0,tlen)			 
			 if(itm==valN && itmSer1==txt)
			 {
			     myTab=myTab+"<tr><td class='boldEleven'><a href=JavaScript:AssignValue('"+itmSer+"','"+nam+"')>"+itmSer+"</a></td></tr>";
//		 		 break;
				 found=1;
		     }		    
		    }
		   
		}	
		if(found==0){
		 myTab=myTab+"<tr><td class='boldEleven'>Enter Correct serial no..</td></tr>";	
		}
		 myTab=myTab+"</table>";	
		document.getElementById('Valid'+namF).innerHTML=myTab;
	}
	function AssignValue(sval,onam)
	{
		document.getElementById(onam).value=sval;
		var namF=onam.substring(6);
		document.getElementById('Valid'+namF).innerHTML="";
	}
function validateValues()
	{
		var valN;
		var j,i;
		var arrLen=ItemSerial.length;
		var slen=document.getElementById('seriallength').value;
		for(j=0;j<slen;j++)
		{  			
  			valN= document.getElementById("itemid"+(j+1)).value;
			found=0;
			txt=document.getElementById("serail"+(j+1)).value;
		  	for(i=0;i<arrLen-1;i++)
			{				
				itm=ItemSerial[i][0];			
				itmSer=ItemSerial[i][1];
				itmSer=itmSer.toUpperCase();
				txt=txt.toUpperCase();						
				if(itm==valN && itmSer==txt)
				{			  
					found=1;
					break;
				}	
			}
			if(found==0)
			{
				alert("InValid Serail ");
				document.getElementById("serail"+(j+1)).focus();
				return false;
			}				
		}
		
	  var slen=document.getElementById('seriallength').value;	
	  txt=txt.toUpperCase();
	  for(i=1;i<=slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();			
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }		
	}
	function CheckSerialNo(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("itemid"+namF).value;
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
				document.getElementById("warranty"+namF).value=ItemSerial[i][2];
				break;
		    }		    
	    }	
		if(found==0){
			alert("Enter Correct Serial No....");
			document.getElementById(nam).focus();
			return false;
		}		
	  var slen=document.getElementById('seriallength').value;	
	  txt=txt.toUpperCase();
	  for(i=1;i<=slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();			
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }
	}
</script>
</head>
<body >

<%
try
{ 
	String salesno = request.getParameter("salno");
	String field ="";
	field = field +"  INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
	field = field +"  INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,  ";
	field = field +"  DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
	field = field +"  CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
	field = field +"  CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
	field = field +"  CHR_ACCOUNTDESC ,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
	field = field +"  DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
	field = field +"  INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
	field = field +"  INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,CHR_COURIER_EMPID,  ";
	field = field +"  CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,CHR_STARTING_PLACE,CHR_ENDING_PLACE,  ";
	field = field +"  INT_COURIER_KILOMETER,CHR_COURIER_DESC,DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,  ";
	field = field +"  DAT_DISPATCHEDDATE,CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,CHR_CANCELDESC,  ";
	field = field +"  CHR_CANCELID,DAT_CANCELDATE,CHR_BYBACKINWARD  ";
	String perdata[][]=CommonFunctions.QueryExecute("SELECT "+field+" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
	 
	
%>
<form  AUTOCOMPLETE = "off"   method="post" name="frm" id="frm" action="../SmartLoginAuth" 	onSubmit="return validate()"><%@ include file="indexinv.jsp"%>

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
							<td>
							<div align="center"><strong>Sale Serial Number </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Sale .No</div>
									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%></div>
									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="right">Sale Date</div>
									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][4]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">CustomerName &amp; Address</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
									
									<%
						
						
							sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6]; 
String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");	
						
						%>
									
								 	  </div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><strong><strong>Description</strong></strong></div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><textarea name="desc" cols="25"
										rows="5" id="desc">Received<%=perdata[0][28]%></textarea>
</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td valign="top" class="boldEleven">
									<td valign="top" class="boldEleven"><strong>Account
									Dept Status </strong></td>
									<td valign="top" class="boldEleven">
									<%
						if("Y".equals(perdata[0][27]))
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" checked>");
						else
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" >");
						%>
									</td>
								</tr>

							</table>
							</td>
						</tr>
						<tr>
							<td height="9">
							<%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,";
					sql = sql +"IF(CHR_TYPE ='I','Item','Product'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID), ";
					sql = sql +"FUN_GET_TAX_NAME(INT_TAXID),DOU_TAX_AMOUNT ";
					sql = sql +"   FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					//out.println(sql);
					String iname="";
					String itemname="";
					String datas[][] =  CommonInfo.RecordSetArray(sql);
					out.println("<table border='1' width=100%  cellpadding=1 cellspacing=0 bgcolor='#9900CC' >");
					out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></th>");
                    out.println("<th class='boldEleven'><strong >Item / Product Code</strong></th>");
					out.println("<th class='boldEleven'><strong >Quantity/Units</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Price</strong></th>");
					out.println("<th class='boldEleven'><strong >Discount(%)</strong></th>");
					out.println("<th class='boldEleven'><strong >Unit Discount</strong></th>");
					out.println("<th class='boldEleven'><strong >Tax</strong></th>");
					out.println("<th class='boldEleven'><strong >Tax Amount</strong></th>");
					out.println("<th class='boldEleven'><strong >Total</strong></th>");
					     
					for(int v=0;v<datas.length; v++)
					{	
						
						if(v%2==0)
							out.print("<tr  class='MRow1'>");
						else	
						 out.print("<tr  class='MRow2'>");
						out.println("<td   class='boldEleven' >"+datas[v][8] +"</td>");
						out.println("<td  class='boldEleven' >"+datas[v][9]+"</td>");
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][3]+"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][4]+"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][5]+"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][6]+"</td>");
						out.println("<td  class='boldEleven'  align='left'>"+datas[v][10]+"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][11]+"</td>");
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][7]+"</td>");
						out.println("</tr>");
					}	
					out.println("</table>");	
					  %>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center">
							<%
	
	sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
	//out.println(sql);
	
	String usertype=""+session.getAttribute("USRTYPE");
	
	
	
	String recdData[][]=  CommonInfo.RecordSetArray(sql);
	int row=1;
	iname="";
	itemname="";
	String masterwarranty="";
	String h="";
	String h1="";
	String typedesc="";
	if(recdData.length>0)
	{
		out.print(" <table width='100%' border='1' cellpadding='0' cellspacing='0' >");
		out.print("<th   class='boldEleven'><b>Type</b></th>");
		out.print("<th   class='boldEleven'><b>Item / Product Code</b></th>");
		out.print("<th   class='boldEleven'><b>Description</b></th>");
		out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
		out.print("<th   class='boldEleven'><b>&nbsp;</b></th> ");
		out.print("<th   class='boldEleven'><b>Warranty</b></th>");
		
		for(int v=0;v<recdData.length; v++)
		{	
			out.print("<tr>");
			if(recdData[v][5].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				masterwarranty=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
				typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
			}	
			if(recdData[v][5].equals("P"))
			{
			  iname="Product";
			  sql="SELECT CHR_PRODUCTCODE,CHR_WARRANTY ,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  masterwarranty=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
			  typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
			}	
			out.println("<tr><td valign='top'  class='boldEleven' >"+iname+"</td>");
			out.println("<td  valign='top' class='boldEleven' >"+itemname);
			
			if(recdData.length>=1)
				h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
	
	h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";
	
		
			out.print("<td  valign='top' class='boldEleven'>"+typedesc+" <br> "+recdData[v][6]+"</td>");
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			
			out.print("<td  valign='top' class='boldEleven'>"+recdData[v][3]+"</td>");

			
			out.print("<td  valign='top' class='boldEleven'>&nbsp;</td>");
			out.print("<td  valign='top' class='boldEleven'>&nbsp;"+recdData[v][4]+" -Years</td>");
			
			
			out.print("</tr>");
			row= row+1;
		}
		out.print("</table> ");
	}		
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  
%> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>"></div>
							</td>
						</tr>
						<tr>
							<td valign="top">
							<table cellspacing="1" cellpadding="1" width="673" align="center"
								border="0">
								<tbody>
									<tr>
										<td valign="top" width="114" rowspan="4">&nbsp;</td>
										<td valign="top" width="197" rowspan="4">&nbsp;</td>
										<td width="107" valign="top" class="boldEleven">
										<div align="left">Total</div>
										</td>
										<td width="169" valign="top" class="boldEleven" id="totals1">
										<div align="right"><%=perdata[0][9]%></div>
										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Total Discount</div>
										</td>
										<td width="169" valign="top" class="boldEleven"
											id="totaldiscount1">
										<div align="right"><%=perdata[0][10]%>(%)</div>
										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Tax Name</div>
										</td>
										<td width="169" valign="top" class="boldEleven" id="tax1">
										<div align="right">
										<%
							sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
							String taxdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
							out.println(taxdata[0][0] );
							%>
										</div>
										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Sales Tax</div>
										</td>
										<td width="169" valign="top" class="boldEleven" id="salestax1">

										<div align="right"><%=taxdata[0][1] %>(%)</div>
										</td>
									</tr>
									<tr>
										<td valign="top">&nbsp;</td>
										<td>&nbsp;</td>
										<td class="boldEleven">
										<div align="left">Sales Tax Amount</div>
										</td>
										<td width="169" class="boldEleven" id="salestaxamount1">
										<div align="right"><%=perdata[0][12]%></div>
										</td>
									</tr>
									<tr>
										<td>
										<div align="left"></div>
										</td>
										<td>
										<div align="left"><input name="filename" type="hidden"
											id="filename" value="Account"> <input name="actionS"
											type="hidden" id="actionS" value="INVDirectSalesDCUpdate">
										<input name="salesno" type="hidden" id="salesno"
											value="<%=salesno%>"></div>
										</td>
										<td class="boldEleven">
										<div align="left">Net Total</div>
										</td>
										<td width="169" class="boldEleven" id="nettotal1">
										<div align="right"><%=perdata[0][13]%></div>
										</td>
									</tr>
								</tbody>
							</table>
							</td>
						</tr>
						<tr>
							<td align="center" class="bold1">
                            <center>
							<div id="Rupees"><script language="javascript">
					  	numberWord("<%=perdata[0][13]%>","Rupees") 
					  </script></div>
                      </center>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<div align="center">
							<table width="112" border="0" cellspacing="2" cellpadding="2">
								<tr>
									<td><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
									<td><input name="Submit2" type="button"
										class="tMLAscreenHead"  value="Close"   accesskey="c" 
										onClick="redirect('AccountDirectSale.jsp')"></td>
								</tr>
							</table>
							</div>
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

<script language="JavaScript">

function Validate()
  {
	var v ="<%=recdData.length%>";
	for( i=1 ;i<=v;i++)
		if(checkNull( ("serial"+i),("Enter Serial Number"+i) ))
		{
				d=1;
		}
		else
		{
				return false;				
		}	
		
  } 	
  
 
  
</script> 
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>
<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>

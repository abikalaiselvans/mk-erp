<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<body >
<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String salesno = request.getParameter("salno");
sql = " SELECT  ";
sql = sql +" INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
sql = sql +" INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,  ";
sql = sql +" DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
sql = sql +" CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
sql = sql +" CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
sql = sql +" CHR_ACCOUNTDESC,IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
sql = sql +" DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
sql = sql +" INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
sql = sql +" INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,  ";
sql = sql +" CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,  ";
sql = sql +" CHR_STARTING_PLACE,CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,  ";
sql = sql +" DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,DAT_DISPATCHEDDATE,  ";
sql = sql +" CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,CHR_USRNAME,  ";
sql = sql +" DT_UPDATEDATE,CHR_UPDATESTATUS, CHR_TCS,DOU_TCS_PERCENTAGE,DOU_TCS_AMOUNT   ";
sql = sql +" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'";
//out.println(sql);
String perdata[][]=CommonFunctions.QueryExecute(sql );
	
%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">


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
							<td width="650">  </td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Sale Serial Number </strong></div>
							<br><br>
							<%
							if("Y".equals(perdata[0][60]))
								out.println("<center><h1 style=\"color:#FF0000\">INVOICE CANCELLED </h1></center>");
							%>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Sale .No</div>									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%></div>									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="right">Sale Date</div>									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][4]%></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">CustomerName &amp; Address</div>									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
									<%
						sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_CUSTOMERID="+perdata[0][6];
String vendor[][]=CommonFunctions.QueryExecute(sql);
						 
						
						
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+".");
						
						%>
									</div>									</td>
									<td valign="top" class="boldEleven">
									<div align="left">



									</div>									</td>
									<td valign="top" class="boldEleven">
									<script language="javascript">
 
function Printquery(query)
	{  
		 
		var width="800", height="600";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}

	
</script>
									<div align="left">
<%
if(!"Y".equals(perdata[0][60]))
	out.println("<a href=\"javascript:Printquery('Swapsalechanges.jsp?salesno="+perdata[0][3]+"')\" >Changes</a>");
%>

									</div>									</td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven">Division</td>
								  <td valign="top" class="boldEleven">
								  <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID="+perdata[0][26])[0][0]%></td>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td height="9">
							<%
					 
					sql = " SELECT a.CHR_SALESNO, ";
					sql = sql +"  if(a.CHR_TYPE='I', ";
					sql = sql +"   (SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID = a.CHR_ITEMID), ";
					sql = sql +"   (SELECT d.CHR_PRODUCTCODE FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID = a.CHR_ITEMID) ";
					sql = sql +"   ), ";
					sql = sql +"  if(a.CHR_TYPE='I','Item','Product'), ";
					sql = sql +"   a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_DISCOUNT, ";
					sql = sql +"  a.DOU_UNITDISCOUNT,b.CHR_TAXNAME,a.DOU_TAX_AMOUNT,a.DOU_TOTAL   ";
					sql = sql +"  FROM inv_t_swapsalesitem a, inv_m_tax b ";
					sql = sql +"  WHERE a.INT_TAXID=b.INT_TAXID AND a.CHR_SALESNO ='"+salesno+"'";
 					 
					
					String iname="";
					String itemname="";
					String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
					out.println("<table  width='100%' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
					out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></td>");
                    out.println("<td class='boldEleven'><strong >Item / Product Code</strong></td>");
					out.println("<td class='boldEleven'><strong >Quantity/Units</strong></td>");
					out.println("<td class='boldEleven'><strong >Unit Price</strong></td>");
					out.println("<td class='boldEleven'><strong >Discount(%)</strong></td>");
					out.println("<td class='boldEleven'><strong >Unit Discount</strong></td>");
					out.println("<td class='boldEleven'><strong >Tax</strong></td>");
					out.println("<td class='boldEleven'><strong >Tax Amount</strong></td>");
					out.println("<td class='boldEleven'><strong >Total</strong></td>");
					     
					for(int v=0;v<datas.length; v++)
					{	
						out.print("<tr   class='MRow1'>");
						out.println("<td  class='boldEleven' >"+datas[v][2] +"</td>");
						out.println("<td  class='boldEleven' >"+datas[v][1] +"</td>");
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][3]+"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][4] +"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][5] +"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][6] +"</td>");
						out.println("<td  class='boldEleven' >"+datas[v][7] +"</td>");
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][8] +"</td>");
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][9] +"</td>");
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
	
	//sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
	//out.println(sql);
	
	
sql = " SELECT a.INT_ID,a.CHR_SALESNO,a.CHR_ITEMID,a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_TYPE,  ";
sql = sql +" if((a.CHR_TYPE ='I') ,'Item','Product'),  ";
sql = sql +" if(  (a.CHR_TYPE ='I'),  ";
sql = sql +"      (SELECT b.CHR_ITEMNAME  FROM inv_m_item  b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql +"      ( SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
sql = sql +" )  ";
sql = sql +" ,  ";
sql = sql +" if(  (a.CHR_TYPE ='I'),  ";
sql = sql +"      (SELECT  b.CHR_WARRANTY FROM inv_m_item  b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql +"      ( SELECT c.CHR_WARRANTY   FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
sql = sql = sql +" )  ";
sql = sql +" ,  ";
sql = sql +" if(  (a.CHR_TYPE ='I'),  ";
sql = sql +"      (SELECT  b.CHR_DES FROM inv_m_item  b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql +"      ( SELECT  c.CHR_PRODUCTDESC FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
sql = sql +" )  ";
sql = sql +" ,  ";
sql = sql +" a.CHR_SWAPDESC,FIND_A_PURCHASE_SALES_DATE_DIFFERENCE(a.CHR_SERIALNO),a.DOU_UNITPRICE    ";
sql = sql +" FROM inv_t_swapsalesserialno  a  ";
sql = sql +" WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID  ";
 


	String usertype=""+session.getAttribute("USRTYPE");
	
	
	
	String recdData[][]= CommonFunctions.QueryExecute(sql);
	int row=1;
	iname="";
	itemname="";
	String masterwarranty="";
	String h="";
	String h1="";
	String typedesc="";
	if(recdData.length>0)
	{
		out.print(" <table width='100%' cellpadding=2 cellspacing=1 bgcolor='#9900CC'><tr  class='MRow1'>");
		out.print("<td   class='boldEleven'><b>Type</b></td>");
		out.print("<td   class='boldEleven'><b>Item / Product Code</b></td>");
		out.print("<td   class='boldEleven'><b>Description</b></td>");
		out.print("<td   class='boldEleven'><b>Days Difference</b></td>");
		out.print("<td   class='boldEleven'><b>Serial No</b></td> ");
		out.print("<td  class='boldEleven'><b>&nbsp;</b></td> ");
		out.print("<td   class='boldEleven'><b>Warranty</b></td>");
		int daydifference=0;
		for(int v=0;v<recdData.length; v++)
		{	
			out.print("<tr  class='MRow1'>");
			iname=recdData[v][6];
			itemname = recdData[v][7];
			masterwarranty=recdData[v][8];
			typedesc=recdData[v][9];
			
			if(!"-".equals(recdData[v][11]))
				daydifference = Integer.parseInt(recdData[v][11]);
			
			 
			
			out.println(" <td valign='top'  class='boldEleven' >"+iname+"</td>");
			out.println("<td  valign='top' class='boldEleven' >"+itemname);
			
			if(recdData.length>=1)
				h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
	
	h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";
	
		
			out.print("<td  valign='top' class='boldEleven'>"+typedesc+" <br> "+recdData[v][6]+"</td>");
			
			if(daydifference>=15)
				out.print("<td  valign='top' class='boldEleven'>"+recdData[v][11]+" - days  <img src='../images/alert.gif'></td>");
			else	
				out.print("<td  valign='top' class='boldEleven'>"+recdData[v][11]+"</td>");
			
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			
			out.print("<td  valign='top' class='boldEleven'>"+recdData[v][3]+"</td>");

			
			if("F".equals(usertype))
			{
				String link="SalesSerialnoupdate.jsp?itype="+recdData[v][5].trim()+"&item="+recdData[v][2].trim()+"&serial="+recdData[v][3].trim()+"&salesno="+salesno+"&saleunitprice="+recdData[v][12];
				
				//Cancel means not update
				if(!"Y".equals(perdata[0][60])) 
					out.print("<td  valign='top' class='boldEleven' class='boldEleven'><a href="+link+" ><font class=boldgeen>update</font></a></td>");
				else	
					out.print("<td  valign='top' class='boldEleven'>&nbsp;</td>");
			}
			else
			{
				out.print("<td  valign='top' class='boldEleven'>&nbsp;</td>");
			}
			
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
										<td width="114" rowspan="4" valign="top" class="boldEleven">
										<%
										if("Y".equals(perdata[0][31]))
					  						out.println("<b>Buy Back Description ::</b>");
									
										%></td>
										<td width="197" rowspan="4" valign="top" class="boldEleven">
										<%
										if("Y".equals(perdata[0][31]))
					  						out.println(perdata[0][32]);
										%>										</td>
										<td width="107" valign="top" class="boldEleven">
										<div align="left">Total</div>										</td>
										<td width="169" valign="top" class="boldEleven" id="totals1">
										<div align="right"><%=perdata[0][9]%></div>										</td>
									</tr>
									<tr>
									  <td valign="top" class="boldEleven">TCS 
									  <%
									  	if("Y".equals(perdata[0][65]))
					  						out.println(""+perdata[0][66] +"%");
									  %>
									  </td>
									  <td align="right" valign="top" class="boldEleven" width="169">
									  <%out.println(perdata[0][67]); %></td>
								  </tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Total Discount</div>										</td>
										<td width="169" valign="top" class="boldEleven"
											id="totaldiscount1">
										<div align="right"><%=perdata[0][10]%>(%)</div>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Tax Name</div>										</td>
										<td width="169" valign="top" class="boldEleven" id="tax1">
										<div align="right">
										<%
							//sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
							//String taxdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
							//out.println(taxdata[0][0] );
							out.println("TDS @ "+perdata[0][11] +"%" );
							%>
										</div>										</td>
									</tr>
									<tr>
									  <td width="114" valign="top" class="boldEleven">
									  <%
									  if("Y".equals(perdata[0][31]))
					  					out.println("<b>Buy Back Amount</b>");
									  %>									  </td>
										<td width="197" valign="top" class="boldEleven">
										
									      <div align="right">
									        <%
										if("Y".equals(perdata[0][31]))
											out.println(perdata[0][33]);
										%>
							            </div></td>
										<td valign="top" class="boldEleven">
										<div align="left"><!--Sales Tax--></div>										</td>
										<td width="169" valign="top" class="boldEleven" id="salestax1">

										<div align="right"><%//=taxdata[0][1] %>(%)</div>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">&nbsp; </td>
										<td class="boldEleven">&nbsp; </td>
										<td class="boldEleven">
										<div align="left">TDS Amount</div>										</td>
										<td width="169" class="boldEleven" id="salestaxamount1">
										<div align="right"><%=perdata[0][12]%></div>										</td>
									</tr>
									<tr>
										<td>
										<div align="left"></div>										</td>
										<td class="boldEleven">
										<div align="left"></div>										</td>
										<td class="boldEleven">
										<div align="left">Net Total</div>										</td>
										<td width="169" class="boldEleven" id="nettotal1">
										<div align="right"><%=perdata[0][13]%></div>										</td>
									</tr>
								</tbody>
							</table>
							</td>
						</tr>
						<tr>
							<td align="center" class="bold1">
							<div id="Rupees"><script language="javascript">
					  	numberWord("<%=perdata[0][13]%>","Rupees") 
					  </script></div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden" value="DirectSale" />
							<input name="actionS" type="hidden"
								value="INVDirectSaleAddserial" /> <span class="boldEleven">Including
							Serial Number</span> <span class="boldEleven">with Description</span> <input
								name="serial" type="checkbox" id="serial" value=" C"></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="68" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="26"><input name="Button" type="button"
										class="tMLAscreenHead" value="Print"
										onClick='javascript:Print("<%=perdata[0][3]%>")'></td>
									<td width="27"><input name="Submit2" type="button"
										class="tMLAscreenHead"  value="Close"   accesskey="c" 
										onClick="redirect('SwapSale.jsp')"></td>
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
  
 
  
</script> <%
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
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
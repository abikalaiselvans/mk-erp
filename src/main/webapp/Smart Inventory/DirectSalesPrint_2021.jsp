 <%@ page contentType="text/html; charset=iso-8859-1" language="java" 	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>

<%
try
{ 
	String sql="";
	String salesno = request.getParameter("salno");
	
	if(  CommonFunction.RecordExist("SELECT   count(*) FROM inv_t_paymentcommitment   WHERE    CHR_SALESNO ='"+salesno+"'  AND  CHR_STATUS='N'"))
	{
		%>
		<script language="javascript">
		alert("Please Payment commitment needed ,Otherwise you can't able to take print out for the invoice <%=salesno%> ");
		window.close();
		</script>
		<%
		 
	}
	String chkserial = ""+request.getParameter("serialyes");
	String chkserialno = ""+request.getParameter("serialno");
	
	sql = " SELECT  ";
sql = sql +" INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,  ";
sql = sql +" INT_CUSTOMERID,CHR_DES,CHR_REF,DOU_AMOUNT,ROUND( (DOU_AMOUNT*(DOU_DISCOUNT/100)),2) discount,INT_TAXID,DOU_TAXAMOUNT,  ";
sql = sql +" ROUND(DOU_TOTALAMOUNT,2),INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,  ";
sql = sql +" UPPER(CHR_SHIPPINGADDRESS),CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION,  ";
sql = sql +" CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,CHR_ACCOUNTFLAG,  ";
sql = sql +" CHR_ACCOUNTDESC,IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,  ";
sql = sql +" DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,  ";
sql = sql +" INT_PAYMENT_COMMITMENT_DAYS,CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,  ";
sql = sql +" INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,CHR_DELIVERYTHROUGH,  ";
sql = sql +" CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DAT_COURIERDATE,  ";
sql = sql +" CHR_STARTING_PLACE,CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,  ";
sql = sql +" DOU_COURIERAMOUNT,CHR_RECEIVERNAME,CHR_RECEIVER_MOBILE,DAT_DISPATCHEDDATE,  ";
sql = sql +" CHR_CLOSEDBY,CHR_RECEIVER_DESC,CHR_CANCEL,INT_PROJECTID,FUN_GET_SUBTOTAL(CHR_SALESNO) , CHR_USRNAME,  ";
sql = sql +" DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_GST_TYPE ,UPPER(CHR_SHIPPING), CHR_DES, CHR_DCREFENCE  ";
sql = sql +" FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'";
//out.println(sql);
String perdata[][]=CommonFunctions.QueryExecute(sql );
 
String cancellimage="";
if("Y".equals(perdata[0][60]))
	cancellimage=" background='../Image/report/cancelled1.jpg' ";
						 				   
String ssql=" ";


ssql = " SELECT UPPER(b.CHR_COMPANYNAME),UPPER(a.CHR_BRANCHNAME),UPPER(a.CHR_STREET),UPPER(e.CHR_CITYNAME),UPPER(d.CHR_STATENAME),a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,UPPER(a.CHR_EMAIL), a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,UPPER(a.CHR_PANNO), "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER,UPPER(a.CHR_WEBSITE),a.CHR_MOBILE,a.CHR_MOBILE1,UPPER(a.CHR_GSTNO),a.CHR_AREACODE FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
//out.println(ssql);
String cpydata[][]=CommonFunctions.QueryExecute(ssql);
String header ="";					   
 header=cpydata[0][0]+"<br>";
if(!"-".equals(cpydata[0][2]))
	header=header+cpydata[0][2]+"<br>";
if(!"-".equals(cpydata[0][3]))	
	header=header+cpydata[0][3]+"<br>";
if(!"-".equals(cpydata[0][4]))
	header=header+cpydata[0][4]+"<br>";
if(!"-".equals(cpydata[0][5]))
	header=header+cpydata[0][5]+"<br>";	
if(!"-".equals(cpydata[0][6]))
	header=header+cpydata[0][6]+"<br>";	


//f.CHR_NAME
						sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),''),IF(LENGTH(a.CHR_MOBILE)>4 ,CONCAT('MOBILE :',a.CHR_MOBILE),''),IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),''),a.CHR_PAN,CHR_GSTNO FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6];
			String vendor[][] =  CommonFunctions.QueryExecute(sql);
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title> 

<style type="text/css">
#header {visibility: hidden;}

#footer{visibility: hidden;}
 
@media print {
    .pagebreak {
        clear: both;
        page-break-after: always;
    }
}
 
</style>

   

 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="javascript">
	function  Change(salno)
		{
			var width="800", height="400";
			var f =document.getElementById('serial').checked;
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			 
			alert(salno);
			newWindow = window.open(salno,"subWind",styleStr);
			newWindow.focus( );
	}
	
	 
	
</script>
<style type="text/css">
<!--
.style3 {
	font-size: 18px;
	font-weight: bold;
}
 
.style9 {font-size: 24pt}
.style10 {color: #CCCCCC}

 -->
 </style>
 

<script language="javascript">
</script>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style12 {
	font-size: 16px;
	font-weight: bold;
}

 
-->
</style>



</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->


<body  style="margin:25;padding:0"   onLoad="javascript:window.print()">


<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" >

 
<div align="center" class="pagebreak"> 
 <table width="700" height="1000" border="1" align="center" cellpadding="2"
			cellspacing="0" bordercolor="#CCCCCC" class="boldEleven"  id="masterTbl" <%=cancellimage%> >
			<tr>
			  <td height="20" colspan="4" valign="top"  ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="150" align="center" valign="middle"><img src="Header.png" ></td>
                  <td   align="center" valign="middle"><div align="center"><span class="style3">TAX INVOICE
                    <% String qrcode=""; %>
                  </span></div></td>
                  <td width="150" align="center" valign="middle">&nbsp;</td>
                </tr>
              </table></td>
		    </tr>
			 
			   
			
			
			
			<tr>
			  <td colspan="2" rowspan="2" valign="top"  ><%
									header="<span class='boldElevenHead'><b>"+cpydata[0][0]+"</b></span><br><span class='boldEleven'> ";
									if(!"-".equals(cpydata[0][2]))
										header=header+cpydata[0][2]+"<br> ";
									if(!"-".equals(cpydata[0][3]))	
										header=header+cpydata[0][3]+", ";
									if(!"-".equals(cpydata[0][16]))	
										header=header+cpydata[0][16]+" - " +cpydata[0][5]+".<br> ";
									//if(!"-".equals(cpydata[0][4]))
										//header=header+cpydata[0][4]+" - " +cpydata[0][5]+".<br> ";
									//if(!"-".equals(cpydata[0][5]))
										//header=header+" - " +cpydata[0][5]+".<br> ";
									
									if(!"-".equals(cpydata[0][6]))
										header=header+" PHONE : " +cpydata[0][22]+" - "+cpydata[0][6]+" <br> ";
									//if(!"-".equals(cpydata[0][19]))
										//header=header+" Mobile : " +cpydata[0][19] +" / "+cpydata[0][20]+",<br> ";
									if(!"-".equals(cpydata[0][8]))
										header=header+" Email : " +cpydata[0][8]+" <br>";
									//if(!"-".equals(cpydata[0][18]))
									//	header=header+" Web : " +cpydata[0][18]+" ";
									header=header+"</span>";	
									 out.println(header);
					   
									%></td>
			  <td height="24" valign="top"  ><span class="boldElevenPrint">Invoice No </span> <br>
                <%=perdata[0][3]%>
                <%qrcode = qrcode+"INVOICE : "+perdata[0][3]+"\n";
										%></td>
			  <td valign="top"  ><span class="boldElevenPrint">Invoice
									  Date </span><br>
			  <%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][4])%></td>
	  </tr>
			<tr>
			  <td height="24" valign="top"  ><span class="boldElevenPrint">PO
									  Reference </span><br>
			  <%=perdata[0][19]%></td>
			  <td valign="top"  ><span class="boldElevenPrint">Payment Term</span> <br>
		        <%=CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID="+perdata[0][5])[0][1]%></td>
	  </tr>
			
	  
			
			<tr>
			  <td height="37" colspan="2" valign="top"  ><span class="boldElevenPrint">Billing Address</span><br>
						 
			  <%
						if(!"-".equals(vendor[0][1]))
							out.println("<span class='boldElevenHead'><b>"+vendor[0][1]+"</b>,</span><br><span class='boldEleven'>");
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
							out.println(vendor[0][7]+".<br>");	
						if(!"-".equals(vendor[0][12]))	
							out.println(" GST : "+vendor[0][12]);		
							
						out.println("<span>");	
						 				
						 qrcode = qrcode+ " BILLING ADDRESS : "	;									
										
						 if(!"-".equals(vendor[0][1]))
							qrcode = qrcode+vendor[0][1]+",\n";
						if(!"-".equals(vendor[0][2]))	
							qrcode = qrcode+vendor[0][2]+",\n";
						if(!"-".equals(vendor[0][3]))
							qrcode = qrcode+vendor[0][3] +",\n";
						if(!"-".equals(vendor[0][4]))	
							qrcode = qrcode+vendor[0][4]+",\n";	
						if(!"-".equals(vendor[0][5]))	
							qrcode = qrcode+vendor[0][5]+",\n";	
							if(!"-".equals(vendor[0][6]))	
							qrcode = qrcode+vendor[0][6]+",\n";
						if(!"-".equals(vendor[0][7]))	
							qrcode = qrcode+vendor[0][7]+".\n";	
						 				
						qrcode = qrcode+ " NETT AMOUNT : "+perdata[0][13]+"\n"; 	
										
										 
						
						
						%></td>
			  <td colspan="2" valign="top"  >
			  				<%//=perdata[0][17]%>
							<%
						  	if("S".equals(perdata[0][17]))
							{
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
							}
							else
							{
								out.println("<span class='boldElevenPrint'>Shipping Address </span><br>");
								out.println(perdata[0][18].replaceAll(",","<br>")); 
							}
							 
						  %></td>
	  </tr>
			 
		<tr>
			  <td height="24" valign="top"  ><span class="boldElevenPrint">Remarks</span><br><%=perdata[0][68]%></td>
			  <td height="24" valign="top"  ><span class="boldElevenPrint">DC Reference</span><br> <%=perdata[0][69]%></td>
			  <td valign="top"  ><span class="boldElevenPrint">Despatch Through</span> <br> <%=perdata[0][21]%></td>
	          <td valign="top"  ><span class="boldElevenPrint">Destination</span><br> <%=perdata[0][22]%></td>
	  		</tr>	 
			
			<tr>
			  <td height="45" colspan="4" valign="top"  >
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					
					<tr>
					  <td height="9" colspan="2"><br><%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT, DOU_UNITDISCOUNT,(INT_QUANTITY*DOU_UNITPRICE),CHR_DESC, INT_TAXID, ROUND(DOU_TAX_PERCENTAGE,0),DOU_TAX_AMOUNT,IF(CHR_TYPE='I','ITEM','PRODUCT'),FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),FUN_INV_PRODUCTDESCRIPTION(CHR_TYPE,CHR_ITEMID),FUN_INV_HSNCODE(CHR_TYPE,CHR_ITEMID),DOU_TOTAL,FUN_INV_UNITS(CHR_TYPE,CHR_ITEMID),CONCAT(INT_WARRANTY,'-Yrs')  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					//out.println(sql);
					
					String iname="";
					String datas[][] = CommonFunctions.QueryExecute(sql);
					if(datas.length>0 )
					{
						out.println("<table  width=99% border='1' bordercolor='#CCCCCC' cellpadding=1 cellspacing=0 align='center'>");
						out.println("<tr  bgcolor='#ffffff'><th width='20' class='boldElevenPrint'><strong>S.No</strong></th>");
						out.println("<th  width='360' class='boldElevenPrint'><strong >Description</strong></th>");
						out.println("<th  width='50' class='boldElevenPrint'><strong >HSN/<br>SAC</strong></th>");
						out.println("<th  width='20' class='boldElevenPrint'><strong >QTY</strong></th>");
						out.println("<th  width='20' class='boldElevenPrint'><strong >UOM</strong></th>");
						out.println("<th  width='50' class='boldElevenPrint'><strong >Warranty</strong></th>");
						out.println("<th  width='50' class='boldElevenPrint'><strong >Unit Price</strong></th>");
						out.println("<th class='boldElevenPrint'><strong >Discount(%)</strong></th>");
						out.println("<th class='boldElevenPrint'><strong >Unit Discount</strong></th>");
						out.println("<th  width='50' class='boldElevenPrint'><strong >Tax (%)</strong></th>");
						out.println("<th class='boldElevenPrint'><strong >Tax Amount</strong></th>");
						out.println("<th  width='50' class='boldElevenPrint'><strong >Total<br>(INR)</strong></th>");
							 
						for(int v=0;v<datas.length; v++)
						{	
							out.println("<tr><td   class='boldEleven' >"+(v+1)+".</td>");
							out.println("<td valign='top'   class='boldEleven' >"+datas[v][8] +"</td>");
							out.println("<td valign='top'   class='boldEleven' align='center'>"+datas[v][15] +"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='center' >"+datas[v][3] +"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='center' >"+datas[v][17]+"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='center'>"+datas[v][18] +"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][4]+"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][5] +"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][6]+"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][10]+" % </td>"); 
							out.println("<td valign='top'   class='boldEleven'  align='right'>"+datas[v][11]+"</td>");
							out.println("<td valign='top'   class='boldEleven'  align='right' >"+datas[v][16] +"</td>");
							out.println("</tr>");
							 
						}	
						sql = " SELECT  ROUND(SUM((INT_QUANTITY*DOU_UNITPRICE)),2) subtotal, ";
						sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT),2) taxamount,  ";
						sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_IGST/100,2) igst, ";
						sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_CGST/100,2) cgst, ";
						sql = sql + " ROUND(SUM(DOU_TAX_AMOUNT)* b.DOU_SGST/100,2) sgst, ";
						sql = sql + " ROUND(SUM(DOU_TOTAL),2) total ";
						sql = sql + " FROM inv_t_swapsalesitem a , inv_m_tax b  WHERE a.INT_TAXID = b.INT_TAXID AND a.CHR_SALESNO ='"+salesno+"'";
						String taxSplit[][] =  CommonFunctions.QueryExecute(sql);
						if(taxSplit.length>0) {
							out.println("<tr class='boldEleven' align='right'>");	
							out.println("<td colspan='11'>Subtotal</td>");
							out.println("<td>"+taxSplit[0][0]+"</td>");
							out.println("</tr>");
							if("D".equals(perdata[0][66])) {
								out.println("<tr class='boldEleven' align='right'>");	
								out.println("<td colspan='11'>IGST</td>");
								out.println("<td>"+taxSplit[0][2]+"</td>");
								out.println("</tr>");
							} else {							
								out.println("<tr class='boldEleven' align='right'>");	
								out.println("<td colspan='11'>CGST</td>");
								out.println("<td>"+taxSplit[0][3]+"</td>");
								out.println("</tr>");
								out.println("<tr class='boldEleven' align='right'>");	
								out.println("<td colspan='11'>SGST</td>");
								out.println("<td>"+taxSplit[0][4]+"</td>");
								out.println("</tr>");
							
							}
							out.println("<tr class='boldEleven' align='right'>");	
							out.println("<td colspan='11'>Round Off</td>");
							out.println("<td>0.0</td>");
							out.println("</tr>");
							out.println("<tr class='boldEleven' align='right'>");	
							out.println("<td colspan='11'><b>Net Total&nbsp;<img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;&nbsp;</b></td>");
							out.println("<td><b>"+perdata[0][13]+"</b></td>");
							out.println("</tr>");
						}
						
					    out.println("</table>");	
					}	
					  %>
					  
					  
                        <%
						
						double tvalue=0;
						double igstvalue=0;
						double sgtvalue=0;
						double gstvalue=0;
						 
						 
						%>                                              </td>
					</tr>
					
					
					<tr>
						<td colspan="2">
						 <div align="left">
					  <%
	int row=1;
	iname="";
	 
	
	 
	sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID) FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
		//out.println(sql);
	String recdData[][]= CommonFunctions.QueryExecute(sql);
	if(recdData.length>0)
		out.println("<span class='boldElevenprint'>Serial Number :<br></span>");
		
	if(datas.length>0)
	{
		for(int ip=0; ip<datas.length;ip++)
		{
			sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID)";
			sql = sql + "  FROM inv_t_swapsalesserialno WHERE CHR_SALESNO = '"+salesno+"' AND CHR_ITEMID ='"+datas[ip][1]+"' AND CHR_TYPE='"+datas[ip][2]+"' ORDER By INT_ID";
			//out.println(sql);
			String serialnumberData[][]= CommonFunctions.QueryExecute(sql);
			String sserial="";
			if(serialnumberData.length>0) {
				out.println("<span class='boldElevenprint'>"+datas[ip][13]+" : &nbsp;&nbsp;</span> ");
				for(int sp=0; sp<serialnumberData.length;sp++)
					sserial = sserial + serialnumberData[sp][3]+",&nbsp;" ;
				sserial = sserial.trim();
				sserial = sserial.substring(0,sserial.length()-1);
				sserial = sserial.trim();
				/*int ind = sserial.lastIndexOf(",");
				if( ind>=0 )
					sserial = new StringBuilder(sserial.length()+1)
								.append(sserial, 0, ind)
								.append("")
								.append(sserial, ind, sserial.length())
								.toString(); .substring(0, sserial.length()-7)*/
				out.println("<span class='boldEleven'>"+sserial+"</span>");
			}
			out.println("<br>");
		}
	}		
			
	 
	/*sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID) FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
		//out.println(sql);
	String recdData[][]= CommonFunctions.QueryExecute(sql);
	chkserial = "false";			
	if("true".equals(chkserial) && recdData.length > 0)
	{
		out.print(" <table  border=1 width=99%   border='1'  cellpadding=2 cellspacing=1 bgcolor='#000000' align='center'>");
		out.print("<tr bgcolor='#ffffff'><th   class='boldElevenPrint'><b>Sl.No</b></th>");
		out.print("<th   class='boldElevenPrint'><b>HSN/SAC Code</b></th>");
		out.print("<th   class='boldElevenPrint'><b>Description</b></th>");
		out.print("<th   class='boldElevenPrint'><b>Serial No</b></th> ");
		out.print("<th   class='boldElevenPrint'><b>Warranty</b></th>");
		
		for(int v=0;v<recdData.length; v++)
		{	
			  
			out.println("<tr bgcolor='#ffffff'><td valign='top'  class='boldElevenPrint' >"+(v+1)+"</td>");
			out.println("<td  valign='top' class='boldElevenPrint' >"+recdData[v][8] +"</td>");
			out.print("<td  valign='top' class='boldElevenPrint'>  "+recdData[v][7] +"</td>");
			
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			out.print("<td  valign='top' class='boldElevenPrint'>"+recdData[v][3]+"</td>");
			out.print("<td  valign='top' class='boldElevenPrint'>&nbsp;"+recdData[v][4]+" -Years</td>");
			out.print("</tr>");
			row= row+1;
		}
		out.print("</table> ");
		out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
		out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  

}
else
{
	
	if(recdData.length>0)
	{
		String spec="Serial Number :<br>";
		if(recdData.length>1)
			spec="Serial Numbers :<br>";
			for(int ip=0; ip<datas.length;ip++)
			{
				
				out.println();
			}
			
		out.println("<table align='left' cellspacing=0 cellpadding=0><tr><td class='boldElevenPrint'><b>"+spec+"</b><tr>");
		 
			int cv=1;
			for(int v=0;v<recdData.length; v++)
			{
				out.println("<td class='boldEleven' >"+recdData[v][3]+"&nbsp;,&nbsp;&nbsp;  ");
				if(cv ==5 )
				{
					cv =0;
					out.println("<tr>");
				}
				cv = cv+1;
			}
		 	
		out.println("</table>");
	}
}
*/		 
%> </div> 						</td>
					</tr>
					 
					<tr>
						<td colspan="2"></td>
					</tr>
					
					 
					<tr>
					  <td colspan="2" valign="top" class="boldElevenPrint">					   </td>
					</tr>
			  </table>			</td>
			</tr>
			<tr>
			  <td height="30" colspan="4" valign="top" class="boldEleven"  >
			  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                            <tr>
                              <td width="29%" height="28" align="left" valign="top" class="boldElevenPrint">&nbsp;Amount Chargeable (In words) INR ::</td>
                              <td width="71%" class="boldElevenHead"><b><div id="Rupees"><script language="javascript">numberWord("<%=perdata[0][13]%>","Rupees") </script></div><b>                                 </td>
                            </tr>
							 <tr>
							 	<td colspan="2">
								
								<%
										sql ="";
										sql = sql + " SELECT  b.CHR_GST_TYPE,FUN_INV_HSNCODE(a.CHR_TYPE,a.CHR_ITEMID),(a.INT_QUANTITY*a.DOU_UNITPRICE), ";
										sql = sql + " Round(a.DOU_TAX_PERCENTAGE,0),  Round(a.DOU_TAX_PERCENTAGE/2,0) ,";
										sql = sql + " Round((a.DOU_TAX_AMOUNT * c.DOU_IGST/100 ),2), ";
										sql = sql + " Round((a.DOU_TAX_AMOUNT * c.DOU_CGST/100 ),2),Round((a.DOU_TAX_AMOUNT * c.DOU_SGST/100 ),2), ";
										sql = sql + " a.DOU_TAX_AMOUNT  ";
										sql = sql + "  FROM inv_t_swapsalesitem a , inv_t_directsales b, inv_m_tax c  ";
										sql = sql + "  WHERE a.CHR_SALESNO =  b.CHR_SALESNO AND a.INT_TAXID = c.INT_TAXID ";
										sql = sql + " AND  a.CHR_SALESNO ='"+salesno+"' ";
										sql = sql + " GROUP BY FUN_INV_HSNCODE(a.CHR_TYPE,a.CHR_ITEMID) ";
										String splitTaxData[][]= CommonFunctions.QueryExecute(sql);
										if(splitTaxData.length>0) {
											out.println("<table width='100%' border='1' cellpadding='1' cellspacing='0'   class='boldEleven' bordercolor='#CCCCCC'>");
											out.println("<tr align='center'>");
											out.println("<th rowspan='2' class='boldElevenPrint'>HSN/SAC</td>");
											out.println("<th rowspan='2' class='boldElevenPrint'>Taxable Value </td>");
											if(splitTaxData[0][0].equals("D")) {
												out.println("<th colspan='2' class='boldElevenPrint'>Central Tax </td>");
											}
											else {	
												out.println("<th colspan='2' class='boldElevenPrint'>Central Tax </td>");
												out.println("<th colspan='2' class='boldElevenPrint'>State Tax </td>");
											}	
											out.println("<th rowspan='2' class='boldElevenPrint'>Total Tax Amount</td>");
											out.println(" </tr>");
											
											out.println("<tr align='center'>");
											if(splitTaxData[0][0].equals("D")) {
												out.println("<td  class='boldElevenPrint'>Rate</td>");
												out.println("<td  class='boldElevenPrint'>Amount</td>");
											} else {	
												out.println("<td  class='boldElevenPrint'>Rate</td>");
												out.println("<td  class='boldElevenPrint'>Amount</td>");
												out.println("<td  class='boldElevenPrint'>Rate</td>");
												out.println("<td  class='boldElevenPrint'>Amount</td>");
											}	
											out.println(" </tr>");
											 
											
											for(int v=0;v<splitTaxData.length; v++)
											{
												out.println("<tr class='boldEleven'>");
												out.println("<td align='center'>"+splitTaxData[v][1]+"</td>");
												out.println("<td align='right'>"+splitTaxData[v][2]+"</td>");
												if(splitTaxData[0][0].equals("D")) {
													out.println("<td align='right'>"+splitTaxData[v][3]+" %</td>");
													out.println("<td align='right'>"+splitTaxData[v][5]+"</td>");
												} else {	
													out.println("<td align='right'>"+splitTaxData[v][4]+" %</td>");
													out.println("<td align='right'>"+splitTaxData[v][6]+"</td>");
													out.println("<td align='right'>"+splitTaxData[v][4]+" %</td>");
													out.println("<td align='right'>"+splitTaxData[v][7]+"</td>");
												}	
												out.println("<td align='right'>"+splitTaxData[v][8]+"</td>");
												out.println(" </tr>");
											}
											
											sql = "SELECT  SUM(a.INT_QUANTITY*a.DOU_UNITPRICE), ";
											sql = sql + " SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_IGST/100 ),2)), ";
											sql = sql + " SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_CGST/100 ),2)), SUM(Round((a.DOU_TAX_AMOUNT * c.DOU_SGST/100 ),2)), ";
											sql = sql + " SUM(a.DOU_TAX_AMOUNT ) ";
											sql = sql + " FROM inv_t_swapsalesitem a , inv_t_directsales b, inv_m_tax c  ";
											sql = sql + " WHERE a.CHR_SALESNO =  b.CHR_SALESNO AND a.INT_TAXID = c.INT_TAXID ";
											sql = sql + " AND  a.CHR_SALESNO ='"+salesno+"' ";
											String sumSplitTaxData[][]= CommonFunctions.QueryExecute(sql);
											if(sumSplitTaxData.length >0) {
												out.println("<tr class='boldElevenPrint' align='right'>");
												out.println("<td>Total</td>");
												out.println("<td>"+sumSplitTaxData[0][0]+"</td>");
												if(splitTaxData[0][0].equals("D")) {
													out.println("<td>&nbsp;</td>");
													out.println("<td>"+sumSplitTaxData[0][1]+"</td>");
												} else {	
													out.println("<td>&nbsp;</td>");
													out.println("<td>"+sumSplitTaxData[0][2]+"</td>");
													out.println("<td>&nbsp;</td>");
													out.println("<td>"+sumSplitTaxData[0][3]+"</td>");
												}	
												out.println("<td>"+sumSplitTaxData[0][4]+"</td>");
												out.println(" </tr>");
											}

											out.println("</table>");
										
										}
									%></td>
							 </tr>
                </table>			  </td>
		    </tr>
			
			<tr>
			  <td width="154" height="24" valign="top" class="boldEleven"  ><span class="boldElevenPrint">GST</span></td>
			  <td width="200" valign="top" class="boldEleven"  ><%=cpydata[0][21]%></td>
			  <td height="24" colspan="2" valign="top" class="boldEleven" align='center'  ><span class="boldElevenPrint">Company's Bank Details </span></td>
		    </tr>
			<tr>
			  <td height="20" valign="top" class="boldEleven"  ><span class="boldElevenPrint">PAN</span></td>
			  <td valign="top" class="boldEleven"  ><%=cpydata[0][14]%></td>
			  <td height="20" valign="top" class="boldEleven"  ><span class="boldElevenPrint">Bank Name &amp; Branch </span></td>
			  <td height="20" valign="top" class="boldEleven"  >SOUTH INDIAN BANK, Mountroad, Chennai</td>
		    </tr>
			<tr>
			  <td colspan="2" rowspan="3" valign="top" class="boldEleven"  ><b>Kindly Note </b>:<br> 1. Goods Once Sold cannot be taken back.<br>
2. Mishandling or Physical Damage will not be covered under warranty.</td>
			  <td height="20" valign="top" class="boldEleven"  ><span class="boldElevenPrint">A/c No</span></td>
			  <td height="20" valign="top" class="boldEleven"  >0043083000002769</td>
		    </tr>
			<tr>
			  <td height="20" valign="top" class="boldEleven"  ><span class="boldElevenPrint">IFSC code </span></td>
			  <td height="20" valign="top" class="boldEleven"  >SIBL0000043</td>
		    </tr>
			<tr>
			  <td height="79" colspan="2" valign="top" class="boldEleven"  >
			  <div align="right"><span class="bold1"><%="For  "+cpydata[0][0] %></span></div>
			  <br>
			  <br><br>
			  <div align="right"><span class="boldElevenPrint">Authorized Signatory </span></div>			  </td>
		    </tr>
			
			<tr>
			  <td height="20" colspan="4" valign="top"  ><div align="center" class="boldEleven"><b>Regd office</b> : 64, VSV koil street, Mylapore, Chennai-600004<br>
		Phone Number : 044-43927600; Website : www.finecons.com ; <b>GSTIN : 33AAACF6323J1ZV</b><br>
		<b>Branches : Bangaluru - Pondicherry - Coimbatore - Madurai</b>
		
                    <%
					   
/*ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
//out.println(ssql);

 header ="<br>";					   
 header=cpydata[0][0]+" ";
if(!"-".equals(cpydata[0][2]))
	header=header+cpydata[0][2]+", ";
if(!"-".equals(cpydata[0][3]))	
	header=header+cpydata[0][3]+", ";
if(!"-".equals(cpydata[0][16]))	
	header=header+cpydata[0][16]+", ";
if(!"-".equals(cpydata[0][4]))
	header=header+cpydata[0][4]+", ";
if(!"-".equals(cpydata[0][5]))
	header=header+"PIN : " +cpydata[0][5]+". ";	
 out.println(header.toUpperCase());
	*/				   
					   
					  %>
              </div></td>
		    </tr>
	</table>
</div>

  <%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>
</div>
</body>
</html>

 
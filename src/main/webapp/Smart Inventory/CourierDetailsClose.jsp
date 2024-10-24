 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>



<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 
 
 <script language="javascript">
 	
	
function dateComparision(ctr,ctr1,msg) 
{
	try
	{
		var f1 =  document.getElementById(ctr).value;
		var f2  = document.getElementById(ctr1).value;
		var t1=f1.split(" ");
	  	var t2=f2.split(" ");
	  	f1 = t1[0].split("-")[2]+"-"+t1[0].split("-")[1]+"-"+t1[0].split("-")[0]+" "+t1[1];
		f2 = t2[0].split("-")[2]+"-"+t2[0].split("-")[1]+"-"+t2[0].split("-")[0]+" "+t2[1];
			
		var time1 = new Date(f1.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		var time2  = new Date(f2.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		 
		if(time1<time2)
		{
			 
			return true; 
		}
		else if(time1.getTime()==time2.getTime())	
		{
			alert("From date&time  and To date&time should not be equals");
			document.getElementById(ctr1).focus();
			return false;
			 
		}
		else if(time1>time2)
		{
			alert("From date&time should be lesser than the to date&time");
			document.getElementById(ctr1).focus();
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


<body >
<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String sql ="";
	String salesno = request.getParameter("salno");
sql ="";
sql = " SELECT ";
sql = sql+ " INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,INT_CUSTOMERID,   ";
sql = sql+ " CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,   ";
sql = sql+ " CHR_PAYMENTSTATUS,CHR_SALESTYPE,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,   ";
sql = sql+ " CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,INT_DIVIID,   ";
sql = sql+ " CHR_ACCOUNTFLAG,CHR_ACCOUNTDESC, CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK,CHR_BYBACKDESC,   ";
sql = sql+ " DOU_BYBACKAMOUNT,CHR_INSTALLATION,CHR_INSTALLATION_STATUS,CHR_INVOICEBLOCK,INT_PAYMENT_COMMITMENT_DAYS,   ";
sql = sql+ " CHR_TAXTYPE,CHR_REF1,CHR_REF2,INT_REF_PERCENTAGE1,INT_REF_PERCENTAGE2,INT_REF_PERCENTAGE3,CHR_DELIVERY,   ";
sql = sql+ " CHR_COURIER_EMPID,CHR_COURIER_EMPID_MOBILE,INT_COURIERID,DATE_FORMAT(DAT_COURIERDATE,'%d-%m-%Y %h:%m:%s'),   ";
sql = sql+ " CHR_ENDING_PLACE,INT_COURIER_KILOMETER,CHR_COURIER_DESC,DOU_COURIERAMOUNT,CHR_USRNAME,   ";
sql = sql+ " CHR_STARTING_PLACE,CHR_DELIVERYTHROUGH,DATE_FORMAT(DAT_COURIERDATE,'%Y-%m-%d'),";
sql = sql+ " CHR_RECEIVERNAME, CHR_RECEIVER_MOBILE, DATE_FORMAT(DAT_DISPATCHEDDATE,'%d-%m-%Y %h:%m:%s'),";
sql = sql+ "   DT_UPDATEDATE,CHR_UPDATESTATUS FROM inv_t_directsales  WHERE CHR_SALESNO='"+salesno+"'";
//out.println(sql); 
 

String perdata[][]=CommonFunctions.QueryExecute(sql);
	
%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="courierfrm" id="courierfrm" onSubmit="return Validate()">


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
							<div align="center"><strong>COURIER DETAILS </strong></div>							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="140" valign="top" class="boldEleven">
									<div align="left">Sale.No</div>									</td>
									<td width="150" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%></div>									</td>
									<td width="149" valign="top" class="boldEleven">
									<div align="right">Sale Date</div>									</td>
									<td width="169" valign="top" class="boldEleven">
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
								  <td valign="top" class="boldEleven"><h1 class="boldEleven"><span id="ContentPlaceHolder1_TitleLabel"> </span><span id="ContentPlaceHolder1_TitleLabel"> </span>Through Engineer </h1></td>
									<td valign="top" class="boldEleven">
									<%
										
										if("Y".equals(perdata[0][54]))
											out.println("Closed");	
										else if("P".equals(perdata[0][54]))
											out.println("Progross");	
										else 
											out.println("Pending");	
											
									%>									</td>
								</tr>
								 
								<tr>
								  <td valign="top" class="boldEleven">Division</td>
								  <td valign="top" class="boldEleven"><%= CommonFunctions.QueryExecute("SELECT CHR_DIVICODE FROM inv_m_division  WHERE INT_DIVIID="+perdata[0][26])[0][0]%></td>
								  <td valign="top" class="boldEleven">Courier Date and Time </td>
								  <td valign="top" class="boldEleven">
								  <input	name="startdate" type="hidden" id="startdate"  value="<%=perdata[0][47]%>" /> 
								<%=perdata[0][47]%> 
                                
                                								  </td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Courier Name<span class="boldElevenlink"> </span> </td>
								  <td valign="top" class="boldEleven">
									<%
									if(!"0".equals(perdata[0][46]))
										out.println(CommonFunctions.QueryExecute("SELECT INT_COURIERID,CHR_COURIERNAME FROM inv_m_courier WHERE INT_COURIERID= "+perdata[0][46]+" ORDER BY  CHR_COURIERNAME")[0][0]);
									else
										out.println("No Courier");	
									
									
									%>								</td>
								  <td valign="top" class="boldEleven">Starting place<span class="boldElevenlink"> </span> </td>
								  <td valign="top" class="boldEleven"><%=perdata[0][53]%></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Engineer Name </td>
								  <td valign="top" class="boldEleven"><%=perdata[0][44]%></td>
								  <td valign="top" class="boldEleven">Ending Place </td>
								  <td valign="top" class="boldEleven"><%=perdata[0][48]%></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Engineer Mobile <span class="boldElevenlink"> </span> </td>
								  <td valign="top" class="boldEleven"><%=perdata[0][45]%></td>
								  <td valign="top" class="boldEleven">Travelling Kilometer </td>
								  <td valign="top" class="boldEleven"><%=perdata[0][49]%></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Courier Amount </td>
								  <td valign="top" class="boldEleven"><p>
								    <%=perdata[0][51]%>
</p>							      </td>
							      <td valign="top" class="boldEleven">Description<span class="boldElevenlink"> </span> </td>
							      <td valign="top" class="boldEleven"> <%=perdata[0][50]%> </td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Receiver Name <span class="boldElevenlink"></span>   <span class="boldElevenlink"> *</span></td>
								  <td valign="top" class="boldEleven"><input name="receivername" type="text" class="formText135" id="receivername" style=" text-transform:uppercase" tabindex="2" value="<%=perdata[0][24]%>" size="23" maxlength="50"></td>
								  <td valign="top" class="boldEleven">Despatched Date &amp; Time <span class="boldElevenlink"> *</span> </td>
								  <td valign="top" class="boldEleven">
 						  
 
<input name="enddate" type="text" class="formText135" id="enddate" size="24" maxlength="10" readonly />
<script language="javascript">
 		setCurrentDateandTime('enddate');
		
		
$('#enddate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	minDate: -5, maxDate: "+1D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});
 
 
 
</script></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Receiver Contact Number   <span class="boldElevenlink"> *</span></td>
								  <td valign="top" class="boldEleven"><input name="receivermobile" type="text" class="formText135" id="receivermobile" style=" text-transform:uppercase" tabindex="2" onKeyPress="return numeric_only(event,'receivermobile','10')" value="<%=perdata[0][25]%>" size="23" maxlength="50"></td>
								  <td valign="top" class="boldEleven">Status<span class="boldElevenlink">*</span></td>
								  <td valign="top" class="boldEleven">
								  <select name="status" class="formText135" id="status">
								  <option value="0">select status</option>
								  	<option value="Y" selected="selected">Closed</option>
									<option value="R">Reject</option>
								    </select>								  </td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">Description<span class="boldElevenlink"> *</span> </td>
								  <td valign="top" class="boldEleven"><textarea name="description" cols="23" rows="5" class="formText135" id="description" onKeyUp="textArea('description','450')"  style=" text-transform:uppercase" tabindex="8" >Delivered</textarea></td>
							  </tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="9">
							  <%
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					String iname="";
					String itemname="";
					String datas[][] = CommonFunctions.QueryExecute(sql);
					out.println("<table  width='100%' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
					out.println("<tr class='MRow1'><th class='boldEleven'><strong>Type</strong></td>");
                    out.println("<td class='boldEleven'><strong >Item / Product Code</strong></td>");
					out.println("<td class='boldEleven'><strong >Quantity/Units</strong></td>");
					out.println("<td class='boldEleven'><strong >Unit Price</strong></td>");
					out.println("<td class='boldEleven'><strong >Discount(%)</strong></td>");
					out.println("<td class='boldEleven'><strong >Unit Discount</strong></td>");
					out.println("<td class='boldEleven'><strong >Total</strong></td>");
					     
					for(int v=0;v<datas.length; v++)
					{	
						out.print("<tr   class='MRow1'>");
						if(datas[v][2].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
						}	
						if(datas[v][2].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
						  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						}	
						out.println(" <td   class='boldEleven' >"+iname+"</td>");
						out.println("<td  class='boldEleven' >"+itemname);
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][3] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][4] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][5] );
						out.println("<td  class='boldEleven'  align='right'>"+datas[v][6] );
						out.println("<td  class='boldEleven'  align='right' >"+datas[v][7] );
					}	
					out.println("</table>");	
					  %>							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center" id="error" class="bolddeepred"></div>							</td>
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
sql = sql +" a.CHR_SWAPDESC   ";
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
		out.print("<td   class='boldEleven'><b>Serial No</b></td> ");
		out.print("<td   class='boldEleven'><b>Warranty</b></td>");
		
		for(int v=0;v<recdData.length; v++)
		{	
			out.print("<tr  class='MRow1'>");
			iname=recdData[v][6];
			itemname = recdData[v][7];
			masterwarranty=recdData[v][8];
			typedesc=recdData[v][9];
			
			 
			
			out.println(" <td valign='top'  class='boldEleven' >"+iname+"</td>");
			out.println("<td  valign='top' class='boldEleven' >"+itemname);
			
			if(recdData.length>=1)
				h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
	
	h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";
	
		
			out.print("<td  valign='top' class='boldEleven'>"+typedesc+" <br> "+recdData[v][6]+"</td>");
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			
			out.print("<td  valign='top' class='boldEleven'>"+recdData[v][3]+"</td>");

			
			 
			
			out.print("<td  valign='top' class='boldEleven'>&nbsp;"+recdData[v][4]+" -Years</td>");
			
			
			out.print("</tr>");
			row= row+1;
		}
		out.print("</table> ");
	}		
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  
%> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>"></div>							</td>
						</tr>
						<tr>
							<td valign="top">
							<table cellspacing="1" cellpadding="1" width="673" align="center"
								border="0">
								<tbody>
									<tr>
										<td valign="top" width="114" rowspan="4">&nbsp; </td>
										<td valign="top" width="197" rowspan="4">&nbsp;</td>
										<td width="107" valign="top" class="boldEleven">
										<div align="left">Total</div>										</td>
										<td width="169" valign="top" class="boldEleven" id="totals1">
										<div align="right"><%=perdata[0][9]%></div>										</td>
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
							sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
							String taxdata[][] = CommonFunctions.QueryExecute(sql);
							out.println(taxdata[0][0] );
							%>
										</div>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven">
										<div align="left">Sales Tax</div>										</td>
										<td width="169" valign="top" class="boldEleven" id="salestax1">

										<div align="right"><%=taxdata[0][1] %>(%)</div>										</td>
									</tr>
									<tr>
										<td valign="top">&nbsp; </td>
										<td>&nbsp;</td>
										<td class="boldEleven">
										<div align="left">Sales Tax Amount</div>										</td>
										<td width="169" class="boldEleven" id="salestaxamount1">
										<div align="right"><%=perdata[0][12]%></div>										</td>
									</tr>
									<tr>
										<td>
										<div align="left"></div>										</td>
										<td>
										<div align="left"></div>										</td>
										<td class="boldEleven">
										<div align="left">Net Total</div>										</td>
										<td width="169" class="boldEleven" id="nettotal1">
										<div align="right"><%=perdata[0][13]%></div>										</td>
									</tr>
								</tbody>
							</table>							</td>
						</tr>
						<tr>
							<td align="center" class="bold1">
							<div id="Rupees"  align="center"><script language="javascript">
					  	numberWord("<%=perdata[0][13]%>","Rupees") 
					  </script></div>							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
						  <td>
							<input name="filename" id="filename" type="hidden" value="SwapSale" />
							<input name="actionS"  id="actionS"  type="hidden"	 value="INVSwapSaleCourierClose" />
							<input name="salno" type="hidden" id="salno" value="<%=salesno%>">
							<input name="saledate" type="hidden" id="saledate" value="<%=perdata[0][4]%>">
							<input name="cdate" type="hidden" id="cdate" value="<%=perdata[0][55]%>">
							<input name="division" type="hidden" id="division" value="<%=perdata[0][26]%>"></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="68" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="26">

<%
String datadiff =CommonFunctions.QueryExecute("SELECT DATEDIFF(now(),'"+perdata[0][55]+"')")[0][0];
int dat = Integer.parseInt(datadiff);
if(dat<40)
	out.println("<input name='Submit' type='submit' class='tMLAscreenHead' value='Update' tabindex='9'>");
else
	out.println("<font class='bolddeepred'>Date execeeded, So we can not Update...</font>");	
%>
</td>
									<td width="27">
<input name="Submit2" type="button" class="tMLAscreenHead"  value="Close"   accesskey="c"  tabindex="10" onClick="redirect('SwapSale.jsp')"></td>
								</tr>
							</table>							</td>
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
	try
	{	
 
		if(
				checkNull("receivername" ,"Enter Receiver Name" )
				&& checkNull("receivermobile" ,"Enter Receiver Mobile" )
				&& checkNull("enddate" ,"Enter Dispatched Date & Time" )
				&& dateComparision('startdate','enddate','Please check Despatched Date & Time') 
				&& checkNullSelect("status" ,"Select Status",'0' )
				&& checkNull("description" ,"Enter description" )
				
			 
				 
		   )
		{
			return true;
		}
		else
		{
				return false;				
		}	
	}	
	catch(err)
	{
		alert(err);
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

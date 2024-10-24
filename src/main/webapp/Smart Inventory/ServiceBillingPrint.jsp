<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>


<%
try
{
%>


<%
 
	String servicebill= ""+request.getParameter("salno");
	
	if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT   count(*) FROM inv_t_paymentcommitment   WHERE    CHR_SALESNO ='"+servicebill+"'  AND  CHR_STATUS='N'"))
	{
		%>
		<script language="javascript">
		alert("Please Payment commitment needed ,Otherwise you can't able to take print out for the invoice <%=servicebill%> ");
		window.close();
		</script>
		<%
		 
	}
	String sql="";
	
	sql = " SELECT INT_DIVIID,CHR_SALESNO,DATE_FORMAT(DAT_SALESDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,DOU_AMOUNT,";
	sql = sql+" CHR_PAYMENTSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,	CHR_DELIVERYNOTE,";
	sql = sql+" CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,";
	sql = sql+"	CHR_TAXID,CHR_TAXVALUE,CHR_TAXAMOUNT,ROUND(DOU_NETAMOUNT) ,   ";
	sql = sql+"	  CHR_SERVICETAX_FLAG,DOU_SERVICETAX12,DOU_SERVICE_AMOUNT12, ";
	sql = sql+"	  DOU_SERVICETAX2,DOU_SERVICE_AMOUNT2, ";
	sql = sql+"	  DOU_SERVICETAX1,DOU_SERVICE_AMOUNT1, ";
	sql = sql+"	  DOU_SERVICE_AMOUNT,CHR_CANCEL,CHR_GST_TYPE    FROM inv_t_servicebilling WHERE CHR_SALESNO='"+servicebill+"'";
	//out.println(sql);
	String data[][] = CommonFunctions.QueryExecute(sql);
	String cancellimage="";
	if("Y".equals(data[0][29]))
		cancellimage=" background='../Image/report/cancelled1.jpg' ";

	String ssql="";	
ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER,a.CHR_WEBSITE,a.CHR_MOBILE,a.CHR_MOBILE1,a.CHR_GSTNO FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
	String cpydata[][]= CommonInfo.RecordSetArray(ssql);
String header ="<br>";			 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style3 {
	font-size: 18px;
	font-weight: bold;
}
.style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
body {
	margin-top: .5in;
	background-color:#FFFFFF;
	scrollbar-face-color: #fffff;
	scrollbar-arrow-color: #ffffff;
	scrollbar-track-color: #fffff;
	scrollbar-shadow-color: #ffffff;
	scrollbar-highlight-color:#fffff;
	scrollbar-3dlight-color: #fffff;
	scrollbar-darkshadow-Color: #fffff;
	margin-left: 2px;
	margin-right: .5px;
	margin-bottom: .5px;
}

 -->
 </style>
 

<script language="javascript">
</script>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style8 {	font-size: 28px;
	font-weight: bold;
}
-->
</style>
</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->
<body >
<br><br>




		<table width="600" height="600" border="1" align="center" cellpadding="1"
			cellspacing="0" bordercolor="#CCCCCC" id="masterTbl" <%=cancellimage%>>
			<tr>
			  <td height="45" colspan="4"   align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="150"><img src="Header.png" width="150" height="41"></td>
                  <td   align="center" valign="middle"><div align="center"><span class="style3">SERVICE INVOICE
                  </span></div></td>
                  <td width="150" align="center" valign="middle">&nbsp;</td>
                </tr>
              </table></td>
		  </tr>
			<tr>
				<td colspan="2" rowspan="5" valign="top"  ><div align="left">
				  <%
									header="<span class='HeadBgColor'>"+cpydata[0][0]+"</span><br><span class='boldEleven'> ";
									if(!"-".equals(cpydata[0][2]))
										header=header+cpydata[0][2]+",<br> ";
									if(!"-".equals(cpydata[0][3]))	
										header=header+cpydata[0][3]+",<br> ";
									if(!"-".equals(cpydata[0][16]))	
										header=header+cpydata[0][16]+",<br> ";
									if(!"-".equals(cpydata[0][4]))
										header=header+cpydata[0][4]+"";
									if(!"-".equals(cpydata[0][5]))
										header=header+" - " +cpydata[0][5]+".<br> ";
									
									if(!"-".equals(cpydata[0][6]))
										header=header+" Phone : " +cpydata[0][6]+",<br> ";
									if(!"-".equals(cpydata[0][19]))
										header=header+" Mobile : " +cpydata[0][19] +" / "+cpydata[0][20]+",<br> ";
									if(!"-".equals(cpydata[0][8]))
										header=header+" Email : " +cpydata[0][8]+" ,<br>";
									if(!"-".equals(cpydata[0][18]))
										header=header+" Web : " +cpydata[0][18]+" ";
									header=header+"</span>";	
									 out.println(header);
					   
									%>
			    </div></td>
			  <td width="178"   height="20" valign="top"  ><div align="left"><span class="boldEleven"><strong> Invoice .No</strong></span><br> <%=servicebill%></div></td>
				<td width="153" valign="top"  ><div align="left"><span class="boldEleven"><strong>Sale
			  Date </strong></span><br><%=data[0][2].toUpperCase()%></div></td>
		  </tr>
			  <tr>
				<td height="20" valign="top"  ><div align="left"><span class="boldEleven"><strong>Delivery
				  Note </strong></span><br><%=data[0][11].toUpperCase()%></div></td>
				<td valign="top"  ><div align="left"><span class="boldEleven"><strong>Order
				  Reference </strong></span><br><%=data[0][10].toUpperCase()%></div></td>
			  </tr>
			  <tr>
				<td height="20" valign="top"  ><div align="left"><span class="boldEleven"><strong>Destinaion</strong></span><br><%=data[0][13].toUpperCase()%></div></td>
				<td valign="top"  ><span class="boldEleven"><strong>Despatch Through</strong></span><br>
				   <%=data[0][12].toUpperCase()%></td>
			  </tr>
			  <tr>
				<td height="20" valign="top"  ><div align="left"><span class="boldEleven"><strong>Contact
				  Person </strong></span><span class="boldEleven"></span><br><%=data[0][15].toUpperCase()%></div></td>
				<td valign="top"  ><div align="left"><span class="boldEleven"><strong>Terms
				  of Delivery </strong></span><span class="boldEleven"></span><br><%=data[0][14].toUpperCase()%></div></td>
			  </tr>
			  <tr>
				<td height="20" valign="top"  ><div align="left"><span class="boldEleven"><strong>Contact
				  No </strong></span><br><%=data[0][16].toUpperCase()%></div></td>
				<td valign="top"  ><div align="left"></div></td>
			  </tr>
			<tr>
			  <td colspan="2" rowspan="2"   align="center" valign="top"><div align="left"><span class="boldEleven"><strong>Billing
			    Address</strong></span><br>
			    <%
						
						
							sql="SELECT a.INT_CUSTOMERID,a.CHR_ALIASNAME ,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),IF(LENGTH(a.CHR_PHONE)>4 ,CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),''), IF(LENGTH(a.CHR_MOBILE)>4 ,CONCAT('MOBILE :',a.CHR_MOBILE),''),IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),''),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+data[0][3];
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
		      </div>			    <div align="left"></div></td>
			  <td colspan="2"   align="center" valign="top"><div align="left"><span class="boldEleven"><strong>Shipping
			    Address</strong></span><br>
			    <%
						  	if("S".equals(data[0][8]))
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
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");									
										
						 										
							}
							else
							{
								out.println(data[0][9]);
							}
							
						  %>
		      </div></td>
		  </tr>
			<tr>
			  <td height="36"   align="center" valign="top"><div align="left"><span class="boldEleven"><strong>TIN
		      Number</strong></span> <br><%=vendor[0][11]%></div></td>
			  <td   align="center" valign="top"><div align="left"><span class="boldEleven"><strong>CST Number </strong></span><br><%=vendor[0][12]%></div></td>
		  </tr>
			<tr>
			  <td colspan="4"   align="center" valign="top"><%
		out.println("<br><center>");
		out.println("<table cellspacing=0 cellpadding=0 border=1 width='99%' bordercolor='#D9D9D9'>");
		out.println("<tr><td class='boldEleven' align='center'><b>S.No</td>");
		out.println("<td class='boldEleven' align='center'><b>Description </td>");
		out.println("<td  class='boldEleven' align='center'><b> Amount(Rs.)</td>");
		out.println("</tr>");
		
		out.println("<tr><td class='boldEleven'>1.</td>");
		out.println("<td class='boldEleven'>"+data[0][5].toUpperCase().replaceAll("\n","<br>")+"</td>");
		out.println("<td  class='boldEleven' align='right'>"+data[0][6]+"</td>");
		out.println("</tr>");
		
		/*if("Y".equals(data[0][21]))
		{
			out.println("<tr><td class='boldEleven'>&nbsp;</td>");
			out.println("<td class='boldEleven'>Service Tax &nbsp;&nbsp;"+data[0][22]+"% </td>");
			out.println("<td  class='boldEleven' align='right'>"+data[0][23]+"</td>");
			out.println("</tr>");
			
			out.println("<tr><td class='boldEleven'>&nbsp;</td>");
			out.println("<td class='boldEleven'>Service Tax - Education Cess  &nbsp;&nbsp;"+data[0][24]+"% </td>");
			out.println("<td  class='boldEleven' align='right'>"+data[0][25]+"</td>");
			out.println("</tr>");
			
			out.println("<tr><td class='boldEleven'>&nbsp;</td>");
			out.println("<td class='boldEleven'>Service Tax - Education Cess  &nbsp;&nbsp;"+data[0][26]+"% </td>");
			out.println("<td  class='boldEleven' align='right'>"+data[0][27]+"</td>");
			out.println("</tr>");
		}			
		out.println("<tr><td class='boldEleven'>&nbsp;</td><td class='boldEleven'>Total");
		out.println("<td  class='boldEleven' align='right'>"+data[0][28]);
		*/
		
	double total=0;
	double nettotal=0;
	total = Double.parseDouble(data[0][23]);
	nettotal = Double.parseDouble(data[0][20]);
	boolean addtaxflag =false;
	if(nettotal >total)
	{
		String taxid[]=data[0][17].split(",");
		String taxvalue[]=data[0][18].split(",");
		String taxamount[]=data[0][19].split(",");
		for(int u=0; u<taxid.length;u++)
		{
			String tdata[][]=CommonFunctions.QueryExecute("SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
			if(!"0".equals(taxamount[u]))
				addtaxflag = true;
		}	
	
	}	
		
		
	if(addtaxflag)
	{
		out.println("<tr><td colspan=3 class='boldEleven'><b>Other Description </td></tr>");
		out.println("<tr><td colspan=3>&nbsp;");
		String taxid[]=data[0][17].split(",");
		String taxvalue[]=data[0][18].split(",");
		String taxamount[]=data[0][19].split(",");
		 
		if("D".equals(data[0][30])) 
		{
			out.println("<table border='1' align='center' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='80%' class='boldEleven'>");
			out.println("<tr>");
			out.println("<td class='boldEleven' align='center'><S.No</td>");
			out.println("<td class='boldEleven' align='center'>IGST</td>");
			out.println("<td class='boldEleven' align='center'>IGST( % )</td>");
			out.println("<td class='boldEleven' align='center'>TOTAL</td>");
			out.println("</tr>");
			for(int u=0; u<taxid.length;u++)
			{
				out.println("<tr>");
				out.println("<td class='boldEleven' align='center'>"+(u+1)+"</td>");
				String tdata[][]=CommonFunctions.QueryExecute("SELECT CHR_TAXNAME,ROUND(DOU_VALUE,1),ROUND(CHR_PERCENTAGE,1),CHR_PERCENTAGE FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
				out.println("<td class='boldEleven' align='center'>"+tdata[0][0]+"</td>");
				out.println("<td class='boldEleven' align='center'>"+tdata[0][1]+"</td>");
				out.println("<td class='boldEleven' align='center'>"+Double.parseDouble(taxamount[u])+"</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		}	
		else
		{
			out.println("<table border='1' align='center' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='80%' class='boldEleven'>");
			out.println("<tr>");
			out.println("<td class='boldEleven' align='center'><S.No</td>");
			out.println("<td class='boldEleven' align='center'>GST</td>");
			//out.println("<td class='boldEleven' align='center'>CGST( % )</td>");
			out.println("<td class='boldEleven' align='center'>CGST</td>");
			//out.println("<td class='boldEleven' align='center'>SGST( % )</td>");
			out.println("<td class='boldEleven' align='center'>SGST</td>");
			out.println("<td class='boldEleven' align='center'>TOTAL</td>");
			out.println("</tr>");
			for(int u=0; u<taxid.length;u++)
			{
				out.println("<tr>");
				out.println("<td class='boldEleven' align='center'>"+(u+1)+"</td>");
				String tdata[][]=CommonFunctions.QueryExecute("SELECT CHR_TAXNAME,ROUND(DOU_VALUE/2,1),ROUND(CHR_PERCENTAGE/2,1),CHR_PERCENTAGE FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
				out.println("<td class='boldEleven' align='center'>"+tdata[0][0]+"</td>");
				//out.println("<td class='boldEleven' align='center'>"+tdata[0][1]+"</td>");
				out.println("<td class='boldEleven' align='center'>"+Double.parseDouble(taxamount[u])/2+"</td>");
				//out.println("<td class='boldEleven' align='center'>"+tdata[0][2]+"</td>");
				out.println("<td class='boldEleven' align='center'>"+Double.parseDouble(taxamount[u])/2+"</td>");
				out.println("<td class='boldEleven' align='center'>"+taxamount[u]+"</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		}
		
		
			
			
			
				
			out.println("&nbsp;</td></tr>	");				
			/*for(int u=0; u<taxid.length;u++)
			{
				String tdata[][]=CommonFunctions.QueryExecute("SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
				if(!"0".equals(taxamount[u]))
				{
				out.println("<tr><td class='boldEleven'>"+(u+1)+"."+tdata[0][0]+"<td class='boldEleven' align='right'>"+taxvalue[u]+" %");
				out.println("<td  class='boldEleven' align='right'>"+taxamount[u]);
				}
			}	*/
			
			out.println("<tr><td colspan=2 class='boldEleven' align='right'><b>Net Total</td><td align='right'><img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;"+data[0][20]+"</td></tr>");
			
		}
		
		//out.println("<tr><td colspan=2  class='boldEleven' align='right'><b>Net Total<td  class='boldEleven' align='right'><img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;"+data[0][20]);
		//out.println("</td></tr>	");	
				
		out.println("</table></center><br>");
		
		
		
						%></td>
		  </tr>
			<tr>
			  <td colspan="4"   align="center" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                <tr>
                  <td width="34%" height="28" align="left" valign="top" class="boldElevenPrint">&nbsp;Amount Chargeable (In words) INR :</td>
                  <td width="66%" class="boldEleven">
				  <div align="center" id="Rupees"><script language="javascript"> numberWord("<%=data[0][20]%>","Rupees") </script> </div>                     </td>
                </tr>
              </table></td>
		  </tr>
			<tr>
			  <td width="126" height="22"   align="center" valign="top"><div align="left"><span class="boldElevenPrint">GST</span></div></td>
			  <td width="125"   align="center" valign="top"><div align="left"><span class="boldEleven"><%=cpydata[0][21]%></span></div></td>
			  <td   align="center" valign="top"><div align="left"><span class="boldEleven"><span class="boldElevenPrint">Company's Bank Details </span></span></div></td>
			  <td   align="center" valign="top"><div align="left"></div></td>
		  </tr>
			<tr>
			  <td height="22"   align="center" valign="top"><div align="left"><span class="boldElevenPrint">PAN</span></div></td>
			  <td   align="center" valign="top"><div align="left"><span class="boldEleven"><%=cpydata[0][14]%></span></div></td>
			  <td   align="center" valign="top"><div align="left"><span class="boldEleven"><span class="boldElevenPrint">BANK Name </span></span></div></td>
			  <td   align="center" valign="top"><div align="left"></div></td>
		  </tr>
			<tr>
			  <td colspan="2" rowspan="3"   align="center" valign="top"><div align="left"><span class="boldEleven"><span class="boldElevenPrint">Declaration :</span><br>
  &nbsp;&nbsp;Kindly Note: Goods Once Sold cannot be taken back.<br>
		      Mishandling or Physical Damage will not be covered under warranty.</span></div></td>
			  <td height="22"   align="center" valign="top"><div align="left"><span class="boldEleven"><span class="boldElevenPrint">A/c No</span></span></div></td>
			  <td   align="center" valign="top"><div align="left"></div></td>
		  </tr>
			<tr>
			  <td height="22"   align="center" valign="top"><div align="left"><span class="boldEleven"><span class="boldElevenPrint">IFSC code </span></span></div></td>
		      <td   align="center" valign="top"><div align="left"></div></td>
		  </tr>
			<tr>
			  <td height="35" colspan="2"   align="center" valign="top">
			    <div align="right"><span class="bold1"><%="For  "+cpydata[0][0] %></span><br>
		      <span class="boldElevenPrint"><br><br><br>Authorized Signatory </span></div></td>
	      </tr>	
			<tr>
			  <td colspan="4"   align="center" valign="top" class="boldEleven">
			  <div align="center" class="boldEleven"> FINECONS PRIVATE LIMITED,  NO.5, FIRST FLOOR, MAHARAJA SURYA ROAD, ALWARPET, ALWARPET, <br>
			    CHENNAI, TAMILNADU, PIN : 600018.			  </td>
		  </tr>
</table>
		
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
<br>

</body>
</html>

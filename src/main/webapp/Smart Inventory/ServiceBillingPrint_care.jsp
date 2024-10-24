<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
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
</head>
<!--onLoad="javascript:window.print(), window.close()" onLoad="formatTableForPrint()"-->
<body    >

<span class="style3">SERVICE INVOICE</span>
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
	sql = sql+"	  DOU_SERVICE_AMOUNT,CHR_CANCEL    FROM inv_t_servicebilling WHERE CHR_SALESNO='"+servicebill+"'";
	//out.println(sql);
	String data[][] = CommonFunctions.QueryExecute(sql);
	String cancellimage="";
	if("Y".equals(data[0][29]))
		cancellimage=" background='../Image/report/cancelled1.jpg' ";

	String ssql="";
	ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
	ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
	ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
	ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
	ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
	ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
	ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
	ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
	String cpydata[][]= CommonInfo.RecordSetArray(ssql);

	 
%>


<table width="10%" border="0" align="center" cellpadding="1" cellspacing="1" >
	 
	<tr>
		<td>
		<table border="1" align="left" cellpadding="0" id="masterTbl"
			cellspacing="0" bordercolor="#000000" <%=cancellimage%>>
			<tr>
				<td height="600" align="center" valign="top">
				<table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
						<td width="650"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					 
					<tr>
						<td>
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">
							<tr>
								<td colspan="3" valign="top" class="boldEleven"> </td>
							</tr>
							<tr>
								<td width="308" valign="top" class="boldEleven">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="36%" valign="top" class="boldEleven"><strong>
										Invoice .No </strong></td>
										<td width="64%" valign="top" class="boldEleven"><%=servicebill%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Billing
										Address </strong></td>
										<td valign="top" class="boldEleven">
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
										
						 										
										
						 
						
						%>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Shipping
										Address </strong></td>
										<td valign="top" class="boldEleven">
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
							
						  %>										</td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>TIN
										Number </strong></td>
										<td valign="top" class="boldEleven"><%=vendor[0][11]%></td>
									</tr>
									<tr>
									  <td valign="top" class="boldEleven"><strong>CST Number </strong></td>
									  <td valign="top" class="boldEleven"><%=vendor[0][12]%></td>
								  </tr>
								</table>								</td>
								<td width="278" valign="top" class="boldEleven">
								<table width="100%" height="185" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<td width="40%" valign="top" class="boldEleven"><strong>Sale
										Date </strong></td>
										<td width="60%" valign="top" class="boldEleven"><%=data[0][2].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Order
										Reference </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][10].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Delivery
										Note </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][11].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Despatch
										Through </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][12].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Destinaion</strong></td>
										<td valign="top" class="boldEleven"><%=data[0][13].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Terms
										of Delivery </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][14].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										Person </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][15].toUpperCase()%></td>
									</tr>
									<tr>
										<td valign="top" class="boldEleven"><strong>Contact
										No </strong></td>
										<td valign="top" class="boldEleven"><%=data[0][16].toUpperCase()%></td>
									</tr>
								</table>								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="9">
						<%
		out.println("<center>");
		out.println("<table cellspacing=0 cellpadding=0 border=1 width='90%' bordercolor='#D9D9D9'>");
		out.println("<tr><td class='boldEleven' align='center'><b>S.No<td class='boldEleven' align='center'><b>Description <td  class='boldEleven' align='center'><b> Amount(Rs.)");
		
		out.println("<tr><td class='boldEleven'>1.<td class='boldEleven'>"+data[0][5].toUpperCase());
		out.println("<td  class='boldEleven' align='right'>"+data[0][6]);
		
		if("Y".equals(data[0][21]))
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
		out.println("<tr><td colspan=3>&nbsp;");
		out.println("<tr><td colspan=3 class='boldEleven'><b>Other Description ");
		out.println("<tr><td colspan=3>&nbsp;");
		String taxid[]=data[0][17].split(",");
		String taxvalue[]=data[0][18].split(",");
		String taxamount[]=data[0][19].split(",");
		for(int u=0; u<taxid.length;u++)
		{
			String tdata[][]=CommonFunctions.QueryExecute("SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid[u]);
			if(!"0".equals(taxamount[u]))
			{
			out.println("<tr><td class='boldEleven'>"+(u+1)+"."+tdata[0][0]+"<td class='boldEleven' align='right'>"+taxvalue[u]+" %");
			out.println("<td  class='boldEleven' align='right'>"+taxamount[u]);
			}
		}	
		
	}
	
	out.println("<tr><td colspan=2  class='boldEleven' align='right'><b>Net Total<td  class='boldEleven' align='right'><img src='../Image/report/Rupee.jpeg' width='10' height='10'>&nbsp;"+data[0][20]);
			
	out.println("</table></center>");
	
		
		
						%>
						</td>
					</tr>
					 
					<tr>
						<td class="bolddeeplogin">Amount in words ::</td>
					</tr>
					<tr>
						<td>
						<table width="80%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td align="center" class="boldEleven">
								
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="center" class="bold1"></td>
					</tr>
					<tr>
						<td> </td>
					</tr>
					<tr>
						<td>
						<div align="center"  id="Rupees">
						<script language="javascript">
					  	numberWord("<%=data[0][20]%>","Rupees") 
					  </script></div></div>
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
						<table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolor='#D9D9D9'>
							<tr>
								<td width="46%" height="204" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                  <tr>
                                    <td align="center" valign="middle"><br>
                                        <table width="95%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#CCCCCC">
                                          <!--<tr>
										<td class="boldElevenPrint"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
                                          <tr>
                                            <td width="25%" class="boldElevenPrint"><strong>PAN </strong></td>
                                            <td width="32%" class="boldElevenPrint"><div align="left"><%=cpydata[0][14]%></div></td>
                                            <td class="boldElevenPrint"><strong>TIN </strong></td>
                                            <td class="boldElevenPrint"><div align="left"><span class="style7"><%=cpydata[0][12]%></span></div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldElevenPrint"><strong>SERVICE TAX </strong></td>
                                            <td class="boldElevenPrint"><div align="left"><%=cpydata[0][15]%></div></td>
                                            <td class="boldElevenPrint"><strong>CST </strong></td>
                                            <td class="boldElevenPrint"><div align="left"><%=cpydata[0][10]%></div></td>
                                          </tr>
                                          <tr>
                                            <td class="boldElevenPrint">CIN</td>
                                            <td class="boldElevenPrint"><div align="left"><%=cpydata[0][17]%></div></td>
                                            <td class="boldElevenPrint">&nbsp;</td>
                                            <td class="boldElevenPrint">&nbsp;</td>
                                          </tr>
                                      </table></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td align="center" valign="middle" bordercolor="#CCCCCC"><table width="95%" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#CCCCCC">
                                        <!--<tr>
										<td class="boldElevenPrint"><strong>Local Tax No</strong>.
										<%=cpydata[0][13]%></td>
									</tr>-->
                                        <tr>
                                          <td colspan="4" class="boldElevenPrint"><strong>NEFT/RTGS Details </strong></td>
                                        </tr>
                                        <tr>
                                          <td class="boldElevenPrint"><strong>A/c NAME</strong></td>
                                          <td class="boldElevenPrint"><div align="left">Mythra IT SOLUTIONS PRIVATE    LIMITED</div></td>
                                          <td width="11%" class="boldElevenPrint"><strong>BANK</strong></td>
                                          <td width="32%" class="boldElevenPrint"><div align="left">STANDARD CHARTERED BANK</div></td>
                                        </tr>
                                        <tr>
                                          <td class="boldElevenPrint"><strong>A/c NO</strong></td>
                                          <td class="boldElevenPrint"><div align="left">42605104898</div></td>
                                          <td class="boldElevenPrint"><strong>IFSC CODE</strong></td>
                                          <td class="boldElevenPrint"><div align="left">SCBL0036079</div></td>
                                        </tr>
                                    </table></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table>								</td>
								<td width="54%" valign="top">
								<table width="100%" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="bolddeeplogin">
										<div align="right">
										  <%
						out.println("For  "+cpydata[0][0]);
						%>
										</div>										</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
									  <td class="boldEleven">&nbsp;</td>
								  </tr>
									<tr>
										<td class="boldEleven">
										<div align="right"><strong>Authorised
										Signatory </strong></div>										</td>
									</tr>
									<tr>
                                      <td class="boldElevenPrint"><strong>Declaration </strong> <strong> </strong> </td>
								  </tr>
									<tr>
                                      <td class="boldElevenPrint"><div align="justify">We declare that this invoice shows
                                        the actual price of the goods described and that all particulars
                                        are true and correct.</div></td>
								  </tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			  </td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div align="center" class="boldElevenPrint">
		  <%
String header ="<br>";					   
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
					   
					   
					  %>		
		</td>
	</tr>
</table>
<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>


</body>
</html>

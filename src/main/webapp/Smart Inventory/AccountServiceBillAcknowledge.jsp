<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
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
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript">
function validate()
{
	if(	checkNull("desc","Enter Description"))
		return true;	
	else
		return false;	
}
</script>
<body >
 
<form  AUTOCOMPLETE = "off"   method="post" name="frm" id="frm" action="../SmartLoginAuth" 	onSubmit="return validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
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
					<table cellspacing="2" cellpadding="2" width="303" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="700" border="0" align="center" cellpadding="1"
					cellspacing="1">
                                <tr>
                                  <td width="650"></td>
                                </tr>
                                <tr>
                                  <td><%
try
{
	String servicebill= ""+request.getParameter("salno");
	 
	String sql="";
sql = " SELECT INT_DIVIID,CHR_SALESNO,DATE_FORMAT(DAT_SALESDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,DOU_AMOUNT,";
	sql = sql+" CHR_PAYMENTSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,	CHR_DELIVERYNOTE,";
	sql = sql+" CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,";
	sql = sql+"	CHR_TAXID,CHR_TAXVALUE,CHR_TAXAMOUNT,DOU_NETAMOUNT , ";
	sql = sql+"	CHR_SERVICETAX_FLAG,DOU_SERVICETAX12,DOU_SERVICE_AMOUNT12, ";
	sql = sql+"	DOU_SERVICETAX2,DOU_SERVICE_AMOUNT2,DOU_SERVICETAX1,DOU_SERVICE_AMOUNT1, ";
	sql = sql+"	DOU_SERVICE_AMOUNT ";
	sql = sql+"	FROM inv_t_servicebilling WHERE CHR_SALESNO='"+servicebill+"'";
	//out.println(sql);
	String data[][] =CommonFunctions.QueryExecute(sql);
	
String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
String cpydata[][]=CommonFunctions.QueryExecute(ssql);



	 
%>                                  </td>
                                </tr>
                                <tr>
                                  <td><div align="center"><strong>SERVICE INVOICE ACKNOWLEDGE </strong></div></td>
                                </tr>
                                <tr>
                                  <td><table width="97%" border="0" align="center" cellpadding="2"
							cellspacing="2">
                                      <tr>
                                        <td colspan="3" valign="top" class="boldEleven"><%
					   
					   
					   String sql1 ="SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,INT_PINCODE,INT_PHONE FROM m_institution";
					   
					   out.println("<b>"+cpydata[0][0]+"</b>,<br>");
						if(!"-".equals(cpydata[0][2]))
							out.println(cpydata[0][2]+",<br>");
						if(!"-".equals(cpydata[0][3]))	
							out.println(cpydata[0][3]+",<br>");
						if(!"-".equals(cpydata[0][4]))
							out.println(cpydata[0][4]+",<br>");
						if(!"-".equals(cpydata[0][5]))
							out.println("PIN  : " +cpydata[0][5]+".");	
						if(!"-".equals(cpydata[0][6]))
							out.println("Phone : " +cpydata[0][6]+".");	
					   
					  %></td>
                                      </tr>
                                      <tr>
                                        <td width="358" valign="top" class="boldEleven"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                                            <tr>
                                              <td width="36%" valign="top" class="boldEleven"><strong> Invoice .No </strong></td>
                                              <td width="64%" valign="top" class="boldEleven"><%=servicebill%></td>
                                            </tr>
                                            <tr>
                                              <td valign="top" class="boldEleven"><strong>Billing
                                                Address </strong></td>
                                              <td valign="top" class="boldEleven"><%
						
						
						sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+data[0][3]; 
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
						
						%>                                              </td>
                                            </tr>
                                            <tr>
                                              <td valign="top" class="boldEleven"><strong>Shipping
                                                Address </strong></td>
                                              <td valign="top" class="boldEleven"><%
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
							
						  %>                                              </td>
                                            </tr>
                                            <tr>
                                              <td valign="top" class="boldEleven"><strong>TIN
                                                Number </strong></td>
                                              <td valign="top" class="boldEleven"><%=vendor[0][4]%></td>
                                            </tr>
                                        </table></td>
                                        <td width="306" valign="top" class="boldEleven"><table width="100%" border="0" cellpadding="0"
									cellspacing="2">
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
                                        </table></td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td height="9"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td><div align="left"><strong><strong>Description</strong></strong></div></td>
                                      <td><textarea name="desc" cols="25"   onBlur="upperMe(this)"   
										rows="5" id="desc">Received</textarea></td>
                                    </tr>
                                    <tr>
                                      <td><strong>Account
									Dept Status 
                                          <input name="filename" type="hidden" 	id="filename" value="Account">
                                          <input name="actionS"  type="hidden" id="actionS" value="INVServiceBillDCUpdate">
                                          <input name="salesno" type="hidden" id="salesno"	value="<%=servicebill%>">
                                      </strong></td>
                                      <td><%
						if("Y".equals(data[0][21]))
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" checked>");
						else
							out.println("<input name=\"flag\" type=\"checkbox\" id=\"flag\" value=\"Y\" >");
						%></td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td height="9"><%
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
	
	out.println("<tr><td colspan=2  class='boldEleven' align='right'><b>Net Total<td  class='boldEleven' align='right'>"+data[0][20]);
			
	out.println("</table></center>");
	
		
		
						%>
		
		 </td>
                                </tr>
                                <tr>
                                  <td valign="top">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="bolddeeplogin">Amount in words ::</td>
                                </tr>
                                <tr>
                                  <td><table width="80%" border="0" align="center" cellpadding="0"
							cellspacing="0">
                                      <tr>
                                        <td align="center" class="boldEleven"></td>
                                      </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td align="center" class="bold1"></td>
                                </tr>
                                <tr>
                                  <td></td>
                                </tr>
                                <tr>
                                  <td><div align="center"  id="Rupees">
                                      <script language="JavaScript" type="text/javascript">
					  	numberWord("<%=data[0][20]%>","Rupees") 
					          </script>
                                    </div>
                                      </div>                                  </td>
                                </tr>
                                <tr>
                                  <td><table width="112" border="0" align="center" cellpadding="2" cellspacing="2">
                                    <tr>
                                      <td><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
                                      <td><input name="Submit2" type="button"
										class="tMLAscreenHead"  value="Close"   accesskey="c" 
										onClick="redirect('AccountDirectSale.jsp')"></td>
                                    </tr>
                                  </table></td>
                                </tr>
                                <tr>
                                  <td><%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>                                  </td>
                                </tr>
                                <tr>
                                  <td></td>
                                </tr>
                              </table></td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>					</td>
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
		</table>	  </td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
  <tr>
	  <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</form>
</body>
</html>

<%
}
catch(Exception e)
{
out.println(e.getMessage());
}
%>

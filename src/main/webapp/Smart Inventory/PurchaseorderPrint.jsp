 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
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

 
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
.style8 {font-size: 18px}
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<body >
<br><br><br><br>
<%	
		   	try
			{
			  	String purchaseno=request.getParameter("pono");
				String sql = "SELECT * FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				
				boolean flag = false;
				flag =  CommonInfo.RecordExist(sql);
				if(flag)
				{
				   
				  	sql = " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME, ";
					sql = sql+ " DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%b-%Y'), ";
					sql = sql+ " d.CHR_PAYMENTNAME,c.CHR_PAYMENTNAME, ";
					sql = sql+ " ( SELECT e.CHR_BRANCHNAME FROM  com_m_branch e WHERE e.INT_BRANCHID= a.INT_ADDRESSID1), ";
					sql = sql+ " a.INT_ADDRESSID2 , ";
					sql = sql+ " a.CHR_DES,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_AMOUNT,a.CHR_DISCOUNT,";
					sql = sql+ "  h.CHR_TAXNAME,h.DOU_VALUE,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.INT_VENDORID,";
					sql = sql+ "   a.INT_TAXID ,a.DOU_FRIEGHT_CHARGE,a.CHR_DISCOUNT ";
					sql = sql+ "  FROM inv_t_vendorpurchaseorder a, inv_m_vendorsinformation b,inv_m_paymentterms c, ";
					sql = sql+ " inv_m_paymentcondition d, inv_m_tax h ";
					sql = sql+ " WHERE a.INT_VENDORID = b.INT_VENDORID ";
					sql = sql+ " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID ";
					sql = sql+ " AND a.INT_CONDITIONID =d.INT_PAYMENTCONDITIONID ";
					sql = sql+ " AND a.INT_TAXID = h.INT_TAXID ";
					sql = sql+ " AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					//out.println(sql);
				    String purchaseData[][]=CommonFunctions.QueryExecute(sql);
		  %>

<table width="600" border="1" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<table width="600" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="650"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="center" class="bold1" ><center>PURCHASE ORDER</center>
				  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="bottom">
				<table width="600" border="0" align="center" cellpadding="1"
					cellspacing="1">
					<tr>
					  <td align="left" valign="top" class="boldEleven"><div align="left"><strong>Billing Address   </strong></div></td>
					  <td width="218" rowspan="5" align="left" valign="top" class="boldEleven"><%
					   
					 String  ssql = " ";
	ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("INVBRANCH");
    String cpydata[][]=CommonFunctions.QueryExecute(ssql);
  	out.println("<b>Mythra IT SOLUTION PVT LTD.</b>");
	out.println("<br>No.9/4, Sriram colony,");
	out.println("<br>Abiramapuram,");
	out.println("<br>Alwarpet, Chennai -600 018,");
	out.println("<br>Tamilnadu, India.");
  
					  
					  %></td>
					  <td align="left" valign="top" class="boldEleven"><div align="left"><strong> Order No </strong></div></td>
					  <td align="left" valign="top" class="boldEleven"><%=purchaseData[0][0]%></td>
				  </tr>
					<tr>
					  <td class="boldEleven">&nbsp;</td>
					  <td class="boldEleven"><strong>Order Date </strong></td>
					  <td class="boldEleven"><%=purchaseData[0][2]%></td>
				  </tr>
					<tr>
					  <td class="boldEleven">&nbsp;</td>
					  <td class="boldEleven"><div align="left"><strong>Request Date </strong></div></td>
					  <td class="boldEleven"><%=purchaseData[0][3]%></td>
				  </tr>
					<tr>
						<td width="84" class="boldEleven">&nbsp;</td>
						<td width="148" class="boldEleven">
						<div align="left"><strong>Payment Mode </strong></div>						</td>
						<td width="137" class="boldEleven"><%=purchaseData[0][4]%></td>
					</tr>
					<tr>
					  <td align="left" valign="top" class="boldEleven">&nbsp;</td>
					  <td class="boldEleven"><strong>Payment Terms </strong></td>
					  <td class="boldEleven"><%=purchaseData[0][5]%></td>
				  </tr>
					<tr>
						<td align="left" valign="top" class="boldEleven"><strong>Vendor</strong></td>
					    <td align="left" valign="top" class="boldEleven"><%
						 	sql =" SELECT  a.CHR_VENDORNAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
							sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
							sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
							sql = sql + " a.CHR_PHONE,a.CHR_EMAIL     ";
							sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
							sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
							sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
							sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
							sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
							sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
							sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+purchaseData[0][16];  
							String vendor[][]=CommonFunctions.QueryExecute( sql);
out.println("<b>"+vendor[0][0]+"</b>,<br>");
							 
							if(!"-".equals(vendor[0][1]))
								out.println(vendor[0][1]+",<br>");
							if(!"-".equals(vendor[0][2]))	
								out.println(vendor[0][2]+",<br>");
							if(!"-".equals(vendor[0][3]))
								out.println(vendor[0][3]+",<br>");
							if(!"-".equals(vendor[0][4]))
								out.println(vendor[0][4]+".<br>"); 
							if(!"-".equals(vendor[0][5]))
								out.println(vendor[0][5]+".<br>"); 
							if(!"-".equals(vendor[0][6]))
								out.println(vendor[0][6]+".<br>"); 
								         	
						%></td>
				      <td align="left" valign="top" class="boldEleven">
						<div align="left">
						  <div align="left"><strong>Shipping To</strong></div>
						</div>						</td>
						<td align="left" valign="top" class="boldEleven"><%=CommonFunctions.QueryExecute("SELECT FUN_GET_BRANCH_ADDRESS('"+purchaseData[0][7]+"','<br>')")[0][0]%></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td>
				<div align="center">
				<%
			  
				 sql = " SELECT  ";
				sql = sql + "  if(a.CHR_TYPE='I','Item','Product'),  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  ,  ";
				sql = sql + "  (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)  ";
				sql = sql + "  ),  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  ,  ";
				sql = sql + "  (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";
				sql = sql + "  ),  ";
				sql = sql + " a.INT_QUANTITY, a.DOU_UNITPRICE,a.CHR_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TOTAL, a.INT_WARRANTY  ";
				sql = sql +" From  inv_t_vendorpurchaseorderitem a WHERE a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";

				sql = " SELECT    ";
				sql = sql +" if(a.CHR_TYPE='I','Item','Product'),   ";  
				sql = sql +" if(a.CHR_TYPE='I',     ";
				sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)    "; 
				sql = sql +"  ,    ";
				sql = sql +" (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
				sql = sql +" ),    ";
				sql = sql +" if(a.CHR_TYPE='I',    "; 
				sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)   ";  
				sql = sql +"  ,    ";
				sql = sql +" (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";   
				sql = sql +" ),   ";  
				sql = sql +" a.INT_QUANTITY, a.DOU_UNITPRICE,a.CHR_DISCOUNT,a.DOU_UNITDISCOUNT,  ";
				sql = sql +" b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT,  ";
				sql = sql +" a.DOU_TOTAL,a.INT_WARRANTY    ";
				sql = sql +" From  inv_t_vendorpurchaseorderitem a ,inv_m_tax b  ";
				sql = sql +" WHERE a.INT_TAXID =b.INT_TAXID AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				
				  //out.println(sql);
				String itemData[][]= CommonFunctions.QueryExecute(sql);
				out.print("<table width='95%' class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#000000' >");
				out.print("<tr  bgcolor='#ffffff'>");
				out.print("<td  class='boldEleven'><b>S.No</b></td>");
				out.print("<td  class='boldEleven'><b>Type</b></td>");
				out.print("<td  class='boldEleven'><b>Item / Product</b></td>");
          		out.print("<td  class='boldEleven'><b>Description</b></td>");
                out.print("<td  class='boldEleven'><b>Quantity</b></td>");
				out.print("<td  class='boldEleven'><b>Warranty</b></td>");
                out.print("<td  class='boldEleven'><b>Unit Price</b></td>");
                //out.print("<td  class='boldEleven'><b>Discount(%)</b></td>");
               // out.print("<td  class='boldEleven'><b>Unit Discount</b></td>");
				//out.print("<th class='boldEleven'><b>Tax</b></th>");
				//out.print("<th class='boldEleven'><b>Tax (%)</b></th>");
				//out.print("<th class='boldEleven'><b>Tax Amount </b></th>");
                out.print("<td  class='boldEleven'><b>Total</b></td>");
				out.print("</tr>");
				for(int u=0; u<itemData.length;u++)
				{
					
					out.print("<tr bgcolor='#ffffff'>");	
						
					out.print("<td class='boldEleven'>"+(u+1)+"</td>");	
					out.print("<td class='boldEleven'>"+itemData[u][0]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][1]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][2]+"</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][3]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][11]+" -Yrs</td>");
                	out.print("<td class='boldEleven'>"+itemData[u][4]+"</td>");
                	//out.print("<td class='boldEleven'>"+itemData[u][5]+"</td>");
                	//out.print("<td class='boldEleven'>"+itemData[u][6]+"</td>");
                	//out.print("<td class='boldEleven'>"+itemData[u][7]+"</td>");
					//out.print("<td class='boldEleven'>"+itemData[u][8]+"</td>");
					//out.print("<td class='boldEleven'>"+itemData[u][9]+"</td>");
					out.print("<td class='boldEleven'>"+itemData[u][10]+"</td>");
					
					out.print("</tr>");
				}
				
				out.print("</table>");
			   
			  %>
				</div>				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
			  <td valign="top" class="boldEleven"><table width="100%" border="0" cellpadding="2" cellspacing="2" class="boldElevenPrint">
                  <tr>
                    <td width="14%" align="left" valign="middle"><div align="left"><strong>Description</strong></div></td>
                    <td colspan="3" align="left" valign="middle"><span class="boldEleven" style="OVERFLOW:auto;width:200px;height:100px"><%=purchaseData[0][8]%></span></td>
                  </tr>
                <tr>
                  <td colspan="2" rowspan="5" align="left" valign="middle"><div align="left">
                    <% 
						
						sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
						sql = sql + " FROM inv_t_vendorpurchaseorderitem a, inv_m_tax b ";
						sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
						sql = sql+ "  AND a.CHR_PURCHASEORDERNO ='"+purchaseno+"' ";
						sql = sql+ "  GROUP BY a.INT_TAXID ";
 						String tData[][] =  CommonFunctions.QueryExecute(sql);
						
						sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+purchaseData[0][17];
						double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
						double taxsum=0;
						
						if( (tData.length>0) || (taxvalues>0))
						{
							out.println("<table border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>");
							out.println("<tr   bgcolor='#ffffff'>");
							out.println("<td class='boldElevenPrint' align='center'><b>Tax</b></td>");
							out.println("<td class='boldElevenPrint' align='center'><b> Value</b></td>");
							out.println("<td class='boldElevenPrint' align='center'><b>Tax Amount</b></td>");
							out.println("</tr>");
							
							if(tData.length>0)
							{
							 
								for(int k=0; k<tData.length;k++)
								{
									out.println("<tr   bgcolor='#ffffff'>");
									out.println("<td class='boldElevenPrint' >"+tData[k][1]+"</td>");
									out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][0]+"</td>");
									out.println("<td class='boldElevenPrint'  align='right' >"+tData[k][3]+"</td>");
									taxsum =taxsum +Double.parseDouble(tData[k][3]);
									out.println("</tr>");
								}
							}
							 
							if(taxvalues>0)
							{
								out.println("<tr   bgcolor='#ffffff'>");
								out.println("<td class='boldElevenPrint' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ purchaseData[0][10]+"</td>");
								out.println("<td class='boldElevenPrint' align='right' >"+ purchaseData[0][14] +"</td>");
								taxsum =taxsum +Double.parseDouble(purchaseData[0][14] );
								out.println("</tr>");
							}
							 
							out.println("</table>");
						}							
						%>
                  </div></td>
                  <td width="21%" class="bold1">SubTotal</td>
                  <td width="18%" class="boldEleven"><div align="right"><%=purchaseData[0][10]%></div></td>
                </tr>
                <tr>
                  <td class="bold1">Discount [%]</td>
                  <td class="boldEleven"><div align="right"><%=purchaseData[0][19]%></div></td>
                </tr>
                <tr>
                  <td class="bold1">Tax</td>
                  <td class="boldEleven"><div align="right"><%=taxsum%></div></td>
                </tr>
                <tr>
                  <td class="bold1">Freight Charge</td>
                  <td class="boldEleven"><div align="right"><%=purchaseData[0][18]%></div></td>
                </tr>
                <tr>
                  <td class="bold1">Net Total </td>
                  <td class="boldEleven"><div align="right"><%=purchaseData[0][15]%></div></td>
                </tr>
                
              </table></td>
		  </tr>
			<tr>
			  <td valign="top" class="boldEleven">&nbsp;</td>
		  </tr>
			<tr>
			  <td valign="top" class="boldEleven">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="22%" align="left" valign="top" class="boldElevenPrint"><strong>&nbsp;Amount in words ::</strong></td>
    <td width="78%" align="left" valign="top" class="boldElevenPrint style11">&nbsp;
      
	
	 
	  <div id="Rupees"><script language="javascript">numberWord("<%=purchaseData[0][15]%>","Rupees") </script></div></td>
  </tr>
</table>
			  </td>
		  </tr>
			<tr>
			  <td valign="top" class="boldEleven">&nbsp;</td>
		  </tr>
			<tr>
			  <td valign="top" class="boldEleven"><table width="99%" border="1" align="center" cellpadding="0"
							cellspacing="0">
                <tr>
                  <td width="52%" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><br>
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
                        <td bordercolor="#CCCCCC">&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                  <td width="48%" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td class="bolddeeplogin"><div align="right">
                            <%
						out.println("For  "+cpydata[0][0]);
						%>
                        </div></td>
                      </tr>
                      <tr>
                        <td class="boldElevenPrint">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldElevenPrint">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldElevenPrint">&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldElevenPrint"><div align="right"><strong>Authorised
                          Signatory </strong></div></td>
                      </tr>
                  </table></td>
                </tr>
              </table></td>
		  </tr>
			<tr>
			  <td valign="top" class="boldEleven">&nbsp;</td>
		  </tr>
			<tr>
				<td valign="top" class="boldEleven">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<%
		  	}
			else
			{
				response.sendRedirect("Purchase Order.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>

<br>
</body>
</html>

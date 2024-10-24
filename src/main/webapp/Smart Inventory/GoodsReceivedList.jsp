<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">

					<table width="100%" border="0" cellspacing="2" cellpadding="2">
						<tr>
							<td>
							<%	
		   	try
			{
			  	String purchaseno=request.getParameter("ponumber");
				String sql = "SELECT * FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				boolean flag = false;
				flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
				if(flag)
				{
					String purchaseData[][]= CommonFunctions.QueryExecute(sql);
		  %>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td class="bolddeepred">
							<div align="center">
							<%
			  	sql = "SELECT CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_DELIVARYNO,CHR_INVOICENO,CHR_RECIVEDBY,CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived ";
			  	sql= sql + " WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'  AND CHR_SERIALNO IS NOT NULL";//
			  	sql= sql + " GROUP BY CHR_RECIVEDID ORDER BY INT_ID";
				
				String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String orderqty="";
                String receqty="";
                String idv="";
                String qtyv="";
				String id="";
				String itemid="";
				String dbreceived="";
                String receivedqty ="receivedqty";
				String chk="";
				if(itemData.length>0)
				{
					out.print("<table width='787' border='0' cellpadding='2' cellspacing='2' >");
					out.print("<th width='52' class='boldEleven'><b>S.No</b></th>");
					out.print("<th width='100' class='boldEleven'><b>Purchase No</b></th>");
					out.print("<th width='92' class='boldEleven'><b>Received No</b></th>");
					out.print("<th width='102' class='boldEleven'><b>Received Date</b></th>");
					out.print("<th width='90' class='boldEleven'><b>Delivary No</b></th>");			
					out.print("<th width='90' class='boldEleven'><b>Invoice No</b></th>");			
					out.print("<th width='90' class='boldEleven'><b>Received By</b></th>");			
					out.print("<th width='54' class='boldEleven'><b>Action</b></th>");
				   	 
					for(int u=0; u<itemData.length;u++)
				 	{
						
						if(u%2 == 0)
							out.print("<tr class='MRow1'>");
						else
							out.print("<tr class='MRow2'>");	
						out.print("<td width='52' class='boldEleven'>&nbsp;"+(u+1)+"</td>");
						out.print("<td width='100' class='boldEleven'>&nbsp;"+purchaseno.toUpperCase()+"</td>");
						out.print("<td width='52' class='boldEleven'>&nbsp;"+itemData[u][0]+"</td>");
						out.print("<td width='102' class='boldEleven'>&nbsp;"+itemData[u][1]+"</td>");
						out.print("<td width='102' class='boldEleven'>&nbsp;"+itemData[u][2]+"</td>");
						out.print("<td width='102' class='boldEleven'>&nbsp;"+itemData[u][3]+"</td>");
						out.print("<td width='102' class='boldEleven'>&nbsp;"+itemData[u][4]+"</td>");
						chk="gdreceiveno="+itemData[u][0]+"&delivaryNo="+itemData[u][2]+"&invoiceNo="+itemData[u][3];
					    out.print("<td width='50' class='boldEleven'><a href='GoodsReceiveViewList.jsp?gdreceiveno="+itemData[u][0]+"'><font class='boldgreen'>View</font></a>");
						
						String link ="GoodsReceivedSerialnoEntry.jsp?ponumber="+purchaseno;
						link = link+"&refno="+itemData[u][0];
						link = link+"&delivaryNo="+itemData[u][2];
						link = link+"&invoiceNo="+itemData[u][3];
						link= link+"&updateflag=false";
						 		
					}
					//out.print("<center><a href='GoodsReceivedChange.jsp?"+chk+"&purchaseno="+purchaseno+"'>Change</a></center>");
					
			  		out.println("<input type='hidden' name='length' id='length' value='"+itemData.length+"'>");
					out.println("</table>");
				}
				else
				{
				 
					out.print("<table><tr height='100'> <td  valign='middle' colspan='6' align='center'><center><font class='bolddeepred'>Till now, Goods are not received </font></center></td></tr></table>");
					//for this Purchase order number : "+purchaseno+"
				}
			  %>
							</div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="121" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="56">
									<%
							if(itemData.length>0)
							{
							%> <!--   <input name="Submit" type="submit" class="buttonbold"  value="Edit" onClick="return Validate()"/>
                    --> <%
							}
							%>
									</td>
									<td width="56"><input name="button" type="button"
										class="buttonbold13" onClick="redirect('GoodsRecived.jsp')"
										 value="Close"   accesskey="c"  /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center"><script language="JavaScript"
								type="text/javascript">
	function checkReceivedQty(control)
  	{
		var order= "<%=orderqty%>";
		var order1 =order.split("~");
		var position = (control.name.replace("receivedqty",""));
		pqty = parseInt(document.getElementById("qty"+position).value); 
		rqty = parseInt(control.value);
		if(rqty > pqty)
		{
			alert(" Received Quantity should be less than or equal to ordered quantity");
			control.value="0";
			control.focus();
		}	
		
	}

	function Validate()
  	{
		var reced= "<%=receqty%>";
		reced="received~receddt~receivedby~"+reced;
		var reced1 =reced.split("~");
    	var flag =false;
		for( i=0; i<reced1.length-1; i++)
		{
			var ck = "Enter Data..."+reced1[i];
			if(checkNull(escape(reced1[i]),ck))
				d=1;
			else
				return false;	
						
		}
	} 
          </script> <%
		  	}
			else
			{
				response.sendRedirect("GoodsRecived.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>
							</div>
							</td>
						</tr>
					</table>
					</form>
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

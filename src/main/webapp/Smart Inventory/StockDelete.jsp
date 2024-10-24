<%@ page import="java.io.*,java.util.*"%>
 

<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
<jsp:directive.page import="com.my.org.erp.common.CommonInfo" />

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
<script language="JavaScript">
 
 function SDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].rowid;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].rowid.checked) { count=1;}
		}
		 
		if(count>=1){			
			document.frm.action="../SmartLoginAuth";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	



  	
</script>
<body >
<%
try
{
%>

<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="20">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
					<form  AUTOCOMPLETE = "off"   action=" ../SmartLoginAuth" method="post" name="frm" id="frm">
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Stock Delete <%
			  	String branchid=""+session.getAttribute("BRANCHID");
				String itemid =request.getParameter("itemId").trim();
				String type =""+request.getParameter("type");
				type= type.toUpperCase();
				String sql="";
				if("I".equals(type))
				{
				  	sql = "SELECT  b.CHR_ITEMNAME , a.CHR_ITEMID, a.CHR_SERIALNO ,a.INT_ID FROM inv_t_vendorgoodsreceived  a ,inv_m_item b ";
					sql = sql+" WHERE a.CHR_ITEMID = '"+itemid+"' AND  a.CHR_TYPE ='I' AND a.CHR_ITEMID = b.CHR_ITEMID";
					sql = sql +" AND a.INT_BRANCHID = "+branchid;
				}
				
				if("P".equals(type))
				{
				  	sql = "SELECT CHR_ITEMID, CHR_SERIALNO FROM inv_t_vendorgoodsreceived  WHERE ";
					sql = sql+" CHR_ITEMID = '"+itemid+"' AND  CHR_TYPE ='P' AND INT_BRANCHID = "+branchid;
					
					sql="SELECT b.CHR_PRODUCTCODE,a.CHR_ITEMID,a.CHR_SERIALNO ,a.INT_ID FROM inv_t_vendorgoodsreceived a ,inv_m_produtlist b";
					sql = sql+" WHERE a.CHR_ITEMID = '"+itemid+"' AND a.CHR_ITEMID = b.CHR_PRODUCTID ";
					sql = sql +" AND a.INT_BRANCHID = "+branchid; 
				}
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
			  %>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<!--                   <td height="17" class="boldEleven">ProductId <span class="bolddeepred">* </span></td> -->
								<td height="17" colspan="3" class="boldEleven">
								<div align="center">Stock In Hand :: <%=data.length%></div>
								</td>
							</tr>
							<tr>
								<td width="383" height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td width="376" colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<div align="center">
								<%
					  	out.println("<div id='divscroll' style='OVERFLOW:auto;width:100%;height:130px' class='boldEleven'>");
				   		if(type.equals("I"))
						 {
						 	out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr>");
							out.println("<td width=50 class='bold1'>&nbsp;</td>");
							out.println("<td width=250 class='bold1'>Item Code</td>");
							out.println("<td width=250 class='bold1'>Item Name</td>");
							out.println("<td width=250 class='bold1'>Serial Number</td>");
							out.println("</tr>");
						 }
						 
						 if(type.equals("P"))
						 {
						 	out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr>");
							out.println("<td width=50 class='bold1'>&nbsp;</td>");
							out.println("<td width=250 class='bold1'>Product Code</td>");
							out.println("<td width=250 class='bold1'>Product Name</td>");
							out.println("<td width=250 class='bold1'>Serial Number</td>");
							out.println("</tr>");
						 }
						 String link="";
						for(int u=0; u<data.length;u++)
						{
							if(u%2 == 0)
								out.println("<tr class='MRow1'>");
							else
							    out.println("<tr class='MRow2'>");
								
							out.println("<td width=50 class='boldEleven'><input type='checkbox' name='rowid' value='"+data[u][3]+"'></td>");
							link = "Stockserialnumberupdate.jsp?rowid="+data[u][3];
							out.println("<td width=250 class='boldEleven'><a href='"+link+"'><font class='boldgreen'>"+data[u][1]+"</font></a> </td>");
							out.println("<td width=250 class='boldEleven'>"+data[u][0]+"  </td>");
							out.println("<td width=250 class='boldEleven'>"+data[u][2]+"  </td>");
							out.println("</tr> ");
						
						
						}
						out.println("</table");
						out.println("</div>");
				  
                    %>
								</div>
								</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="bold1">
								<div align="center">Total no :: <%=data.length%></div>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="StockInfo" /> <input name="actionS"
									type="hidden" value="INVstockDelete" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Delete" onClick=" return SEdit()"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('StockView.jsp')"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
<%
 }
 catch(Exception e)
 {
 
 }
 
 %>
</body>
</html>

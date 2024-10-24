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

<meta http-equiv="pragma" content="nocache">
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style5 {font-size: 9px}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

function SEdit()
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
		 
		if(count==1){			
			document.frm.action="Stockserialnumberupdate.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	




 function valid()
  {   
	if(
	checkNullSelect("branchid","Select Branch","Select") 
	&& checkNull("name","Enter Name") 
	&& checkNull("lname","Enter Legal Name")	
	)
		return true;
	else
		return false;	 	
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
		<td height="80">&nbsp;</td>
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
					<form  AUTOCOMPLETE = "off"   action=" " method="post" name="frm" id="frm">
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Stock <%
	//String branchid=""+session.getAttribute("BRANCHID");branch
	String branchid=""+request.getParameter("branch").trim();
	String itemid =request.getParameter("itemId").trim();
	String type =""+request.getParameter("type");
	type= type.toUpperCase();
	String sql="";
	String itype ="";
	String iitype="";
	boolean stockflag=false;
	if("I".equals(type))
	{
	  	sql = "SELECT  b.CHR_ITEMNAME , a.CHR_ITEMID, a.CHR_SERIALNO ,a.INT_ID,a.CHR_PURCHASEORDERNO,a.CHR_RECEIVEDMODE,a.CHR_FLAG  FROM inv_t_vendorgoodsreceived  a ,inv_m_item b ";
		sql = sql+" WHERE a.CHR_ITEMID = '"+itemid+"' AND  a.CHR_TYPE ='I'  AND a.CHR_GRTFLAG='N'  AND CHR_FLAG !='Y' AND a.CHR_ITEMID = b.CHR_ITEMID";
		sql = sql +" AND a.CHR_SERIALNO is not null AND  CHR_RECEIVEDMODE!='T' AND a.CHR_TYPE = 'I'  AND a.INT_BRANCHID = "+branchid +" ORDER BY a.CHR_PURCHASEORDERNO "; 
		itype="Item";
		iitype="I";
		//
	}
	
	if("P".equals(type))
	{
		
		sql = "SELECT CHR_PTYPE FROM inv_m_produtlist WHERE  CHR_PRODUCTID='"+itemid+"'";
		String ptypedata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
		if(!"S".equals(ptypedata[0][0]))
		{
		
			sql="SELECT b.CHR_PRODUCTCODE,a.CHR_ITEMID,a.CHR_SERIALNO ,a.INT_ID,a.CHR_PURCHASEORDERNO,a.CHR_RECEIVEDMODE,a.CHR_FLAG   FROM inv_t_vendorgoodsreceived a ,inv_m_produtlist b";
			sql = sql+" WHERE a.CHR_ITEMID = '"+itemid+"' AND a.CHR_GRTFLAG='N' AND  CHR_RECEIVEDMODE!='T'  AND CHR_FLAG!='Y' AND a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_TYPE = 'P' ";
			sql = sql +" AND a.CHR_SERIALNO is not null AND a.INT_BRANCHID = "+branchid +" ORDER BY a.CHR_PURCHASEORDERNO "; 
		}
		else
		{
			stockflag = true;		
			sql="SELECT b.CHR_PRODUCTCODE,a.CHR_ITEMID,a.INT_PQTY ,a.INT_ID,a.CHR_PURCHASEORDERNO,a.CHR_RECEIVEDMODE,a.CHR_FLAG   FROM inv_t_vendorgoodsreceivedconsumable a ,inv_m_produtlist b";
			sql = sql+" WHERE a.CHR_ITEMID = '"+itemid+"' AND a.CHR_GRTFLAG='N' AND  CHR_RECEIVEDMODE!='T'  AND CHR_FLAG!='Y' AND a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_TYPE = 'P' ";
			sql = sql +"   AND a.INT_BRANCHID = "+branchid +" ORDER BY a.CHR_PURCHASEORDERNO "; 
			out.println(stockflag);
		}
		
		itype="Product";
		iitype="P"; 
		//
	}
	String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	//out.println(sql);
 %>
								</td>
							</tr>

							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="136" border="0" align="right">
									<tr>
										<td width="111" height="5" class="bolddeepblue style5">
										Purchase</td>
										<td width="15" bgcolor="#FF7F50">&nbsp;</td>
									</tr>
									<tr>
										<td height="5" class="bolddeepblue style5">
										DirectPurchase</td>
										<td bgcolor="#1E90FF">&nbsp;</td>
									</tr>
									<tr>
										<td height="5" class="bolddeepblue style5">Stock Entry</td>
										<td bgcolor="#00FFFF">&nbsp;</td>
									</tr>
									<tr>
										<td height="5" class="bolddeepblue style5">Replacement</td>
										<td bgcolor="#5F9EA0">&nbsp;</td>
									</tr>
									<tr>
										<td height="5" class="bolddeepblue style5">Stock Transfer
										</td>
										<td bgcolor="#996600">&nbsp;</td>
									</tr>
									<tr>
										<td height="22" class="bolddeepblue style5">Product Split
										Entry</td>
										<td bgcolor="#8FBC8F">&nbsp;</td>
									</tr>
									<tr>
										<td height="22" class="bolddeepblue style5">Sales Return</td>
										<td bgcolor="#DAA520">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<!--                   <td height="17" class="boldEleven">ProductId <span class="bolddeepred">* </span></td> -->
								<td height="17" colspan="3" class="boldEleven">
								<div align="center" class="bold1">
								<div align="center">Stock In Hand :: <%
					if(!stockflag)
								out.println(data.length);
					%>
								</div>
								</div>
								</td>
							</tr>


							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<%
				  		 
						if(type.equals("I"))
						 {
						 	out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr>");
							out.println("<td width=50 class='bold1'>S.No</td>");
							out.println("<td width=100 class='bold1'>Type</td>");
							out.println("<td width=250 class='bold1'>Item Code</td>");
							out.println("<td width=250 class='bold1'>Item Name</td>");
							out.println("<td width=250 class='bold1'>Ref.Number</td>");
							out.println("<td width=250 class='bold1'>Serial Number</td>");	
							out.println("</tr></table>");
						 }
						 
						 if(type.equals("P"))
						 {
						 	out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr>");
							out.println("<td width=50 class='bold1'>S.No</td>");
							out.println("<td width=100 class='bold1'>Type</td>");
							out.println("<td width=250 class='bold1'>Product Code</td>");
							out.println("<td width=250 class='bold1'>Product Name</td>");
							out.println("<td width=250 class='bold1'>Ref.Number</td>");
							if(stockflag)
								out.println("<td width=250 class='bold1'>Units</td>");
							else
								out.println("<td width=250 class='bold1'>Serial Number</td>");	
							out.println("</tr></table>");
						 }
						  
						 
				  %>
								</td>
							</tr>
							<tr>
								<td height="17" colspan="3">
								<%
				   		 out.println("<div id='divscroll' style='OVERFLOW:auto;width:600px;height:300px' class='boldEleven'>");
						 out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1'><tr>");
							
						 String link="";
						for(int u=0; u<data.length;u++)
						{
							if(u%2 == 0)
								out.println("<tr class='MRow1'>");
							else
							    out.println("<tr class='MRow2'>");
								
							link = "Stockserialnumberupdate.jsp?rowid="+data[u][3];
							link=link+"&itype="+iitype+"&itemid="+data[u][1]+"&refno="+data[u][4];
							
							if("S".equals(data[u][5]))
							{
								//<input type='checkbox' name='rowid' value='"+data[u][3]+"'>
								out.println("<td width=50 class='boldEleven'>"+(u+1)+"</td>");
								out.println("<td width=100 class='boldEleven'>"+itype+"</td>");
								out.println("<td width=250 class='boldEleven'><a href='"+link+"'><font class='boldgreen'>"+data[u][1]+"</font></a> </td>");
							
							}	
							else
							{
								out.println("<td width=50 class='boldEleven'>"+(u+1)+"</td>");
								out.println("<td width=100 class='boldEleven'>"+itype+"</td>");
								out.println("<td width=250 class='boldEleven'><font class='boldgreen'>"+data[u][1]+"</font></a> </td>");
								
							
							}	
							out.println("<td width=250 class='boldEleven'>"+data[u][0]+"  </td>");
						    out.println("<td width=250 class='boldEleven'>"+data[u][4]+"</td>");
							
							if("P".equals(data[u][5]) || "-".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#FF7F50'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("D".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#1E90FF'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("S".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#996600'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("R".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#5F9EA0'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("T".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#99CCFF'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("C".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#8FBC8F'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("B".equals(data[u][5]))
								out.println("<td width=250 bgcolor='#DAA520'><font class='boldEleven'>"+data[u][2]+"</font></td>");
							else if("T".equals(data[u][5]))	
								out.println("<td width=250 class='boldEleven' bgcolor='#99CCFF'>"+data[u][2]+"-Transfer Mode</td>");
							else
							out.println("<td width=250 class='boldEleven'>"+data[u][2]+"  </td>");
							
							out.println("</tr> ");
						
						
						}
						out.println("</table>");
						out.println("</div>");
						 
				  
                    %>
								</td>
							</tr>

							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="StockInfo" /> <input name="actionS"
									type="hidden" value="INVstockUpdate" /> <input name="itemId"
									type="hidden" value="<%=itemid%>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Edit" onClick=" return SEdit()"></td>
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

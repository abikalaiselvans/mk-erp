<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
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
<style type="text/css">
tr {behavior:url(behave.htc)}
</style>

<script language="javascript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">
	function Returns()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].refid
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
			if (document.forms[0].refid.checked) { count=1;}
		}
		if(count>=1){
					
			if(checkNull("grtno","Enter Goods Return Number"))
			{
				var name=confirm("Confirm to Return")
				if (name==true)
				{ 
					document.frm.action="../SmartLoginAuth";
					return true;			
				}
				else
					return false;
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
  }
  function Validate()
  {
     
	if(checkNull("grtno","Enter Goods Return Number") 	)
		return true;
	else
		return false;	
	 
  } 
  
  
  	function Disable()
  	{
  		document.getElementById('Return').disabled=true ;
 	}	
 	
</script>

<body >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>
		<%

	String returnType=request.getParameter("returnType");
	String dcNo=request.getParameter("dcno");      		
	String sql="";
	String serialSql="";
	String link="";
	if("Invoice".equals(returnType))
	{
		sql ="SELECT CHR_SALESORDERNO,DAT_SALEDATE,INT_CUSTOMERID FROM  inv_t_customersalesorder   ";
		sql = sql+" where CHR_SALESORDERNO='"+dcNo+"'";	
		 
		serialSql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_REPLACEMENTNO,DAT_REPLACEMENTDATE,";
		serialSql=serialSql+" CHR_NEWSERIAL,CHR_NEWWARRANTY,CHR_GRTFLAG ,INT_ID from inv_t_customersalesorderitemserial  ";
		serialSql=serialSql+" where CHR_SALESORDERNO='"+dcNo+"' and CHR_GRTFLAG='y'";
		link = "tablename=inv_t_customersalesorderitemserial&rowid=";
	}
	else if("Cash".equals(returnType))
	{
		sql ="SELECT CHR_SALESNO,DAT_SALESDATE,INT_CUSTOMERID FROM inv_t_cashsales  where CHR_SALESNO='"+dcNo+"'";		
		serialSql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_REPLACEMENTNO,DAT_REPLACEMENTDATE,";
		serialSql=serialSql+" CHR_NEWSERIAL,CHR_NEWWARRANTY,CHR_GRTFLAG ,INT_ID  from inv_t_cashserialno  ";
		serialSql=serialSql+" where CHR_SALESNO='"+dcNo+"' and CHR_GRTFLAG='y'";
		link = "tablename=inv_t_cashserialno&rowid=";
	}
	else if("Direct".equals(returnType))
	{
		sql ="SELECT CHR_SALESNO,DAT_SALESDATE,INT_CUSTOMERID FROM inv_t_directsales  where CHR_SALESNO='"+dcNo+"'";		
		serialSql="SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_REPLACEMENTNO,DAT_REPLACEMENTDATE,";
		serialSql=serialSql+" CHR_NEWSERIAL,CHR_NEWWARRANTY,CHR_GRTFLAG ,INT_ID   from inv_t_swapsalesserialno  ";
		serialSql=serialSql+" where CHR_SALESNO='"+dcNo+"'  and CHR_GRTFLAG='y'";
		link = "tablename=inv_t_swapsalesserialno&rowid=";
	}
	//System.out.println(link);
	String GRNData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);			
%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<%
	try
		{
	%>

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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate();">
					<table cellspacing="2" cellpadding="2" width="627" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" align="center" valign="top" class="boldThirteen">Sales
								Return</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top">
								<table width="718" border="0" cellspacing="1" cellpadding="1">
									<tr>
										<td>
										<table width="405" border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
												<td width="99" align="center" class="boldEleven">
												<div align="left" class="copyright">Sale No.</div>
												</td>
												<td width="83" class="boldEleven">
												<div align="left"><%=GRNData[0][0]  %> <input
													type="hidden" value="<%=GRNData[0][0] %>" name="dcno"
													id="dcno"> <input type="hidden"
													value="<%=returnType %>" name="returnType" id="returnType">
												</div>
												</td>
												<td width="39" align="right" class="boldEleven">
												<div align="left"></div>
												</td>
												<td width="85" class="boldEleven">
												<div align="left" class="copyright">Sale Date</div>
												</td>
												<td width="83" class="boldEleven">
												<div align="left"><%=GRNData[0][1]%></div>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td></td>
									</tr>
									<tr>
										<td>
										<div align="center" id="ReceivedIdTable"
											style="OVERFLOW:auto;width:900px;height:130px"
											class="boldEleven">
										<%					  
					    // out.println(serialSql);
						String GRNItems[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(serialSql);	
						if(GRNItems.length>0){					    
					  %>
										<table border=0 cellspacing=2 cellpadding=2 width="100%">
											<tr>
												<th class='boldEleven'>Type</th>
												<th class='boldEleven'>Item / Product Name</th>
												<th class='boldEleven'>Serial No</th>
												<th class='boldEleven'>Warranty</th>
												<th class='boldEleven'>Sales Return No</th>
												<th class='boldEleven'>Return Date</th>
												<th class='boldEleven'>New Serial Number</th>
												<th class='boldEleven'>Warranty</th>
												<th class='boldEleven'>Action</th>
											</tr>
											<%
					   	 String type="";
						 String itemname="";
						 for(int i=0;i<GRNItems.length;i++)
						 {
					   		if(i%2==0)
								out.println("<tr class='MRow1'>");
							else
							    out.println("<tr  class='MRow2'>");	
								
					   		type = GRNItems[i][0];
							if(type.equals("I") || type.equals("1"))
							{
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+GRNItems[i][1]+"'";
								//System.out.println(sql);
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
								type = "Item";
							}
						 
							if(type.equals("P") || type.equals("2"))
							{
								sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+GRNItems[i][1]+"'";
								//System.out.println(sql);
								itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
								type = "Product";
							}
						
						
							out.println("<td class='boldEleven'>"+	type);
							out.println("<td class='boldEleven'>"+	itemname);
							out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][2]);					   		
					   		out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][3]+" -Years");					   		
					   		out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][4]);
						   	out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][5]);
						   	out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][6]);
							out.println("<td class='boldEleven'>&nbsp;"+GRNItems[i][7]);
							String slink = "SalesReplacement.jsp?"+link+GRNItems[i][9];
						   	//if(!GRNItems[i][5].equals("-"))
								//out.println("<td class='boldEleven'><a href='"+slink+"'><font class='boldgreen'>Modified</font></a>");
							//else
								//out.println("<td class='boldEleven'><a href='"+slink+"'><font class='boldgreen'>Replacement</font></a>");
							out.println("<td class='boldEleven'>&nbsp;");
						   	out.println("</tr>");
					   	 }
					   %>
										</table>
										<%
					    }
					  %>
										</div>
										</td>
									</tr>
									<tr>
										<td>
										<table border="0" align="center" cellpadding="1"
											cellspacing="1">
											<tr>
												<td width="56"><input name="filename" type="hidden"
													id="filename" value="SalesReturn"> <input
													name="actionS" type="hidden" id="actionS"
													value="INVSalesReturnAdd"></td>
												<td width="56">
												<div align="center"><input name="Submit" type="button"
													class="buttonbold13"  value="Close"   accesskey="c" 
													onClick="redirect('Sales Return.jsp')"></div>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>

								</table>
								</td>
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
		<%
	}
	catch(Exception e)
	{
		//System.out.println(e.getMessage());
	}
	%>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>

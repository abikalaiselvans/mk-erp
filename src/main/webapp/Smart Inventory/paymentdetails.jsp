<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="CategoryMaster.jsp";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].optcatid
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
			if (document.forms[0].optcatid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="CategoryMaster.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].optcatid
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
			if (document.forms[0].optcatid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
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
 	

 	function PageBack()
	{
	     //future enhancement
    }
 	
  function Validate()
  {
    /*
	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkDate("fromdt","todt"))
		return true;
	else
		return false;	
	*/	
  } 
 	
</script>

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
					<table cellspacing="2" cellpadding="2" width="863" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment Details <%
				  	String pid = request.getParameter("pid");
					out.println(pid);
					
				  %>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<%
				   //INT_PAYMENTTERMID,
				   String payment=request.getParameter("payment"); 
				  String sql = " ";
				   sql =" SELECT b.CHR_PAYMENTNAME,a.CHR_DDNUMBER,DATE_FORMAT(a.DAT_PAYMENTDATE,'%d-%m-%Y'),  a.CHR_PAYMENTDESC, a.DOU_PURCHASEAMOUNT,a.DOU_PAIDAMOUNT,a.DOU_BALANCEAMOUNT ,a.INT_PAYMENTID ,(SELECT  c.CHR_DEPOSITNAME FROM com_m_deposit_to c  WHERE a.INT_BANKID =c.INT_DEPOSITID)  FROM inv_t_vendorpurchasepayment a , inv_m_paymentterms b WHERE a.INT_PAYMENTTERMID = b.INT_PAYMENTTERMID  AND  a.CHR_PURCHASEORDERNO ='"+pid+"'";
 				
 
 
				  // out.println(sql);
				  String payData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				  out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				  
				  out.println("<tr class='MRow1'>");
				  out.println("<td width=300 class='boldEleven' align='center'><b>S.No</b></td>");
				  out.println("<td width=300 class='boldEleven' align='center'><b>Purchase Order No</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Payment Mode</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Bank Name</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Cheque/DD number</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Payment Date</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Purchase Amount</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Paid Amount</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'><b>Balance</b></td>");
				  out.println("<td  width=200 class='boldEleven' align='center'></td>");
				  String bankname="";
				  String ddno="";
				  for(int x=0; x<payData.length; x++)
				  {
				  		if(x%2==1)
							out.println("<tr class='MRow1'>");
						else
		    				out.println("<tr  class='MRow2'>");		
						out.println("<td  width=300 class='boldEleven'>"+(x+1)+".</td>");	
						out.println("<td  width=300 class='boldEleven'>"+pid+"</td>");	
						out.println("<td  width=200 class='boldEleven'>"+payData[x][0]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][8]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][1]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][2]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][4]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][5]+"</td>");
						out.println("<td  width=200 class='boldEleven'>"+payData[x][6]+"</td>");
						
						out.println("<td  class='boldEleven'>");
						if((x+1) == payData.length)
						{
							String query ="PaymentChanges.jsp?pid="+pid+"&rowid="+payData[x][7]+"&payment="+payment;
							out.println("<a href='"+query+"'><font class='boldgreen'>Changes</font></a>");
						}	
						out.println("</td>");
						
		
				  }
				  out.println("</table>");
				  %>
								</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="100" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td width=56><input type="hidden" name="payment"
											value="<%=payment %>"> <input name="Submit"
											type="submit" class="buttonbold"  value="Close"   accesskey="c" 
											onClick="redirect('Payment.jsp')"></td>
										<td>&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>


						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
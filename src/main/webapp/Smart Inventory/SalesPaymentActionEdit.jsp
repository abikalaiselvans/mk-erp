<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
	

function ChequeBounds(purId,payData,amount)
{
	var r=confirm("ARE YOU SURE YOU WANT TO CHEQUE BOUNDS THE AMOUNT  ..."+amount);
	if (r==true)
	{
		var reason=prompt("Reason  :: ","For e.g - Value has to be change."); 
		if (reason!=null && reason!="")
		{
			var d ='../SmartLoginAuth?filename=SalesPayment&actionS=INVDirectSalesChequeBounds&rowid='+purId+'&salesno='+payData;
			d=d+"&reason="+reason;
			window.location=d;
			//document.frm.action=d; 
			//document.frm.submit(); 
		}	
	}			
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
					<form  AUTOCOMPLETE = "off"   action="SalesPaymentActionModify.jsp" method="post"
						name="frm" id="frm">
					<table cellspacing="2" cellpadding="2" width="863" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment Details <%
                  String payType=request.getParameter("payType");	
				   String usertype=""+session.getAttribute("USRTYPE");
	  			
				  %> <input type="hidden" name="payType" id="payType"
									value="<%=payType %>"></td>
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
				  String salesid = request.getParameter("salesid");
                 
                  String sql="";
                    sql = "SELECT CHR_SALESORDERNO,INT_CUSTOMERID,INT_PAYMENTTERMID,"
					  +" CHR_BANKNAME, CHR_PAYNO,DAT_PAYMENTDATE,DOU_OPENDEBIT ,DOU_PAIDAMOUNT, "
					  +" INT_PAYMENTID , CHR_REMARK,if(INT_ADVANCEID > 0,'Advance adjust','0'),INT_ADVANCEID  FROM    inv_t_customersalespayment   "
					  +" WHERE CHR_SALESORDERNO ='"+salesid+"'";  
					//out.println(sql); 	
					                    
                  String payData[][] =  CommonFunctions.QueryExecute(sql);
				  
				  if(payData.length>0)
				  {
					  out.println("<center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
					  out.println("<tr class='MRow1'><td  class='boldEleven'><b>"+payType+" No</td>");
					  out.println("<td class='boldEleven'><b>Customer Name</td>");
					  out.println("<td class='boldEleven'><b>Bank Name</td>");
					  out.println("<td class='boldEleven'><b>Cheque/DD number</td>");
					  out.println("<td class='boldEleven'><b>Remark</td>");
					  out.println("<td class='boldEleven'><b>Payment Date</td>");
					  out.println("<td class='boldEleven'><b>Sales Amount</td>");
					  out.println("<td class='boldEleven'><b>Paid Amount</td>");
					  out.println("<td class='boldEleven'><b>Mode</td>");
					  out.println("<td class='boldEleven'>&nbsp;</td>");
					  out.println("<td class='boldEleven'><b>Cheque Bounce</td>");
					  
					  String bank="";
					  String purId="";
					  
					  String boundsid = CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID  FROM inv_m_paymentterms WHERE CHR_PAYMENTNAME like '%CHEQUE%'")[0][0];
					  
					  for(int u=0; u<payData.length; u++)
					  {
						if(u%2==1)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr  class='MRow2'>");	
						out.println("<td  class='boldEleven'><input type='checkbox' name='checkbox' value='checkbox' />");
						out.println(payData[u][0]+"</td>");
						sql ="SELECT FIND_A_CUSTOMER_NAME("+payData[u][1]+")" ;
						String custname[][]= CommonFunctions.QueryExecute(sql);
					
						out.println("<td class='boldEleven'>"+custname[0][0]+"</td>");
						if("0".equals(payData[u][3]) || "Select".equals(payData[u][3]) || "-".equals(payData[u][3])  || "CASH".equalsIgnoreCase(payData[u][3]))
							bank = "-";
						else
						{
							 
							String bk[][]= CommonFunctions.QueryExecute("SELECT CHR_BANKGROUPNAME FROM com_m_bankgroup WHERE INT_BANKGROUPID="+payData[u][3]);
							bank= bk[0][0];
							//SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME
						}
						out.println("<td  class='boldEleven'>"+bank+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][4]+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][9]+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][5]+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][6]+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][7]+"</td>");
						out.println("<td class='boldEleven'>"+payData[u][10]+"</td>");
						purId=payData[u][8];   
						if(payData.length-1 == u)
						{
						 String link = "../SmartLoginAuth?filename=SalesPayment&actionS=INVSalesPaymenEditDelete";
						 link = link + "&invoiceno="+payData[u][0]+"&row="+payData[u][8]+"&payType="+payType;
						 link = link + "&paidamount="+payData[u][7];
						 if(!"0".equals(payData[u][10]))
						 	link = link+"&advanceid="+payData[u][11];
						 else
						 	link = link+"&advanceid=0";	
						out.println("<td class='boldEleven' align='center'><a href='"+link+"'><font class='tMLAscreenHead'>&nbsp;&nbsp;Delete&nbsp;&nbsp;</font></a>");
						
						
						}
						else
						{
							out.println("<td class='boldEleven'>&nbsp;");
						}
						
						
						if(boundsid.equals(payData[u][2]))
						{
								if("F".equals(usertype) || "B".equals(usertype))
								{	
							out.println("<td class='boldEleven'><a href= \"javascript:ChequeBounds('"+purId+"','"+payData[u][0]+"','"+payData[u][7]+"')\"><font class=boldgreen>Cheque Bounce</font></a></td>");
								}
						}	
							
						else
							out.println("<td class='boldEleven'>&nbsp;</td>");
						
					  }
					  
					  out.println("</table></center>");				  
				}
				else
				{
					out.println("<center><fint class='bolddeepred'>Data not found</font></center>");
				}	  
				  %> <input type="hidden" name="salesid" value="<%=salesid%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<%--  <td width=56>
                        <input name="Submit2" type="submit" class="buttonbold" value="Modify">
                        </td> --%>
										<td width=56><input name="Submit" type="Button"
											class="buttonbold13"  value="Close"   accesskey="c" 
											onClick="redirect('Sales Payment.jsp')"></td>
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
catch(Exception e )
{
	System.out.println(e.getMessage());
}
%>

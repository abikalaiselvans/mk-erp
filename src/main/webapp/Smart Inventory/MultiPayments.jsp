<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
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
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<script language="javascript" src="../JavaScript/Inventory/salesmultipayment.js"></script>
<script language="JavaScript">
  function formAction()
{
	
  
  if( checkNull('From','Select From Sales Number ') && checkNull('To','Select To Sales Number ' ) )
    	return true;
  else
  	return false
		
}
 
</script>

<body>
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>
		<%
    	String payment=request.getParameter("payment"); 
		String pType=request.getParameter("payType");
		String month=request.getParameter("month"); 
		String year=request.getParameter("year"); 
		
   	%>		</td>
	</tr>
	 
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
	  <td>
	  <form  AUTOCOMPLETE = "off"   action="MultiPaymentsresponse.jsp" method="post" name="frm" id="frm" onSubmit="return formAction()">
	  <table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
			align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="412"><table width="800" border="0" align="center">
                <tr>
                  <td colspan="5"><div align="center"><span class="boldThirteen">Payment Details
                    <%	String sql="";%>
                  </span></div></td>
                  </tr>
                <tr>
                  <td colspan="2"><table width="100%" border="0">
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Search By vendor PO
                          <%
				String branchId=""+session.getAttribute("BRANCHID");
					 
			         	 
			         	String salesSQL="";
			         	
					 	if(pType.equals("CashPay"))
					 	{
				         	sql="SELECT CHR_SALESNO FROM inv_t_cashsales "+
				         	 " WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y'  ORDER BY CHR_SALESNO";    
				         	salesSQL="SELECT CHR_SALESNO , DAT_SALESDATE, INT_CUSTOMERID,DOU_TOTALAMOUNT "
				         	 +"FROM inv_t_cashsales  WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y'";
					 	}
					 	else if(pType.equals("Invoice"))
					 	{
					 		sql="SELECT CHR_INVOICENO FROM  inv_t_customersalesorder   "+
				         	 " WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y' AND CHR_INVOICESTATUS='Y'  ORDER BY CHR_SALESNO";    
					 		salesSQL="SELECT CHR_INVOICENO , DAT_SALEDATE, INT_CUSTOMERID,DOU_TOTALAMOUNT "
					 		+" FROM  inv_t_customersalesorder    WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y' AND CHR_INVOICESTATUS='Y'";
					 	}
					 	else if(pType.equals("Direct"))
					 	{
				         	/*sql="SELECT CHR_SALESNO FROM inv_t_directsales ";
							sql = sql + " WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y' ";
							sql = sql + "   AND CHR_CANCEL='N' AND FIND_A_PAYMENTCOMMITMENT(CHR_SALESNO,'C') > 0  ORDER BY CHR_SALESNO  ,DAT_SALESDATE";  
							 */
							  
							sql="SELECT CHR_SALESNO, DOU_TOTALAMOUNT, FUN_INV_GET_CUSTOMER_PAIDAMOUNT(CHR_SALESNO),";
							sql = sql + " (DOU_TOTALAMOUNT - FUN_INV_GET_CUSTOMER_PAIDAMOUNT(CHR_SALESNO))  FROM inv_t_directsales  ";
							sql = sql + " WHERE  INT_BRANCHID="+branchId+" AND CHR_CANCEL='N'  ";
							sql = sql + " AND (DOU_TOTALAMOUNT - FUN_INV_GET_CUSTOMER_PAIDAMOUNT(CHR_SALESNO)) > 10  ORDER BY DAT_SALESDATE  "; 
   
							   
				         	salesSQL="SELECT CHR_SALESNO , DATE_FORMAT(DAT_SALESDATE,'%d-%m-%Y'), INT_CUSTOMERID,DOU_TOTALAMOUNT "
				         	 +"FROM inv_t_directsales WHERE INT_BRANCHID="+branchId+" AND CHR_CANCEL='N'  AND CHR_PAYMENTSTATUS<>'Y'";
					 	}
			  
				String data[][]= CommonFunctions.QueryExecute(sql);
			%></td>
                        <td><input name="search1" type="text" class="formText135" id="search1"   onKeyUp="loadSearchVendorPO(this,'From','<%=pType%>')"></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">From</td>
                        <td><div id='Fromstaff'>
                            <select name="From" size='10' class="formText135" id="From" style="width:300; height:400">
                              <option value="" >Select</option>
                              <%
							for(int u=0;u<data.length;u++)
								out.println("<option onDblClick=\"addItem()\"   value='"+data[u][0]+"'>"+data[u][0]+"</option>");
						%>
                            </select>
                        </div></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                  <td width="39" align="center"><p>
                      <input type="button" name="add" value=">>" onClick="addItem()" class="search">
                      <br><br>
                      <input name="button" type="button" class="search" onClick="removeItem()" value="&lt;&lt;" />
                    <br>
                      <br>
                      <script language="javascript">  
function addItem()
{
	var count,k,i;
	count=document.frm.From.length;
	var _targ=document.getElementsByName('To')[0];   
	i=_targ.options.length;
	for(k=0;k<count;k++)
	{
		if(document.frm.From[k].selected==true)
		{     	   		
			selVal=document.frm.From.options[k].value;
			selText=document.frm.From.options[k].text;
			_targ.options[i]=new Option(selText,selVal);
			i=i+1;
		}
	}   
	_targ.options.length=i;  
	_targ.options.selectedIndex=0;  
	 
}

function removeItem()
{
	var count,k,i;
	count=document.frm.To.length;
	if(count>0)
	{
		for(k=0;k<count;k++)
		{
			if(document.frm.To[k].selected==true)
			{
				var x=document.getElementById("To")
				x.remove(x.selectedIndex)
			}
		}
	}
	else
	{
		alert('There is Emp to Remove');
	}
} 	 
      </script>
                        </td>
                  <td colspan="2"><table width="100%" border="0">
                      <tr>
                        <td>&nbsp;</td>
                        <td><input name="selectAll" id="selectAll" type="checkbox" value="Y" onClick="selectDeselect()">Select All
						<script language="javascript">
						
							function selectDeselect() {  
							try
							{
								var listb = document.getElementById('To');  
								var len = listb.options.length;  
								
								if(document.getElementById('selectAll').checked){
									for (var i = 0; i < len; i++) {  
										if(listb.options[i].value != "")
											listb.options[i].selected = true;  
									}
								}
								else {
									for (var i = 0; i < len; i++) {  
										if(listb.options[i].value != "")
											listb.options[i].selected = false;  
									}
								}
								
							}
							catch(err)
							{
								alert(err)
							}	  
						}
						  
						</script>
						
						</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">To</td>
                        <td><div id='Tostaff'>
                            <select name="To"  size='10' multiple class="formText135" id="To"   style="width:300; height:400"  >
                              <option value="">Select</option>
                              
                            </select>
                        </div></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td colspan="5"> </td>
                </tr>

                <tr>
                  <td width="123">&nbsp;</td>
                  <td width="234">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td width="189"><input name="filename"  id="filename" type="hidden" value="PurchasePayment" />
                    <input name="actionS" id="actionS" type="hidden" value="INVmultiPaymentAdd" />
                    <input type="hidden" name="payType" id="payType" value="<%=pType %>"></td>
                  <td width="87">&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="5"><table border="0" align="center" cellpadding="1" cellspacing="1">
                    <tr>
                      <td width="56"><input name="Submit" type="Submit" class="buttonbold13" id="submit"
											value="Submit"></td>
                      <td width="56"><input name="Button" type="Button" class="buttonbold13"   accesskey="c"
											onClick="redirect('Payment.jsp')"  value="Close" ></td>
                    </tr>
                  </table></td>
                </tr>

            </table></td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          </tr>
        </tbody>
      </table>
	  </form>
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

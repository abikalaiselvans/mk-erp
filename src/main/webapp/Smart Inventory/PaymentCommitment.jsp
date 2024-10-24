<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


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
<!--
.style3 {font-size: 10px}
-->
</style>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PaymentCommitment.js"></script>
 <script language="JavaScript">

     

	function Edit()
 	{		
		obj = findObj("salno"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}



		var count;
		count=0;
		coffee1=document.forms[0].salno;
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
			if (document.forms[0].salno.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="PaymentCommitmentEdit.jsp";
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
		
		obj = findObj("salno"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].salno
		txt="";
		var id="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				id=i;
			}
		}
		if(count==0)
		{
			if (document.forms[0].salno.checked) { count=1;}
		}
		if(count==1)
		{			
				
				
				var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE PAYMENT COMMITMENT  ..."+coffee1[id].value);
				if (r==true)
	  			{
	  				var reason=prompt("Reason for Delete :: ","For e.g - Value has to be change."); 
	  				if (reason!=null && reason!="")
  					{
	  					var d ="../SmartLoginAuth?saleno="+coffee1[id].value+"&reason="+reason;
						document.frm.action=d; 
						
						//document.frm.submit(); 
					}	
	  			}			
				
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	} 	 	
 	 
      function LoadDisable() 
	{
	  document.getElementById('btnEdit').disabled = true;
	  document.getElementById('btnDelete').disabled = true;
	  
	} 
	
	
	
function ResetSerialNumber(query,invoicenumber)
{
		var r=confirm("ARE YOU SURE YOU WANT TO RESET THE SERIAL NUMBER , INVOICE NUMBER IS ..."+invoicenumber);
		if (r==true)
	  	{
			document.frm.action=""+query; 
			document.frm.submit(); 
			
	  	}
}



function invoiceSendMail(query,invoicenumber)
{
		var r=confirm("ARE YOU SURE YOU WANT TO SEND THE INVOICE "+invoicenumber +" TO MAIL ...");
		if (r==true)
	  	{
	  		var reason=prompt("Enter  Email id","test@test.net"); 
	  		if (reason!=null && reason!="")
  			{
	  			var d =query+"&email="+reason;
	  			document.frm.action=""+d; 
				document.frm.submit(); 
			}	
	  	}
}
</script>
<!--,loadPaymentCommitment('0')
-->
<body    onLoad="LoadDisable(),loadPaymentCommitment('0')" >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" id="frm"  >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>		</td>
	</tr>
	<tr>
		<td>
		<table width="90%" height="256" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="22"  >
				<div align="center" class="whiteMedium"><span > Payment Commitment </span></div>				</td>
			</tr>
			<tr  >
				<td height="25"  >
				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="whiteMedium">
					<tr>
					  <td  >Branch
                          <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usrtype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				 
			%>                      </td>
					  <td  ><span >
					    <select  style="width:200" name="Branch" class="formText135" id="Branch" tabindex="6"  onChange="loadPaymentCommitment('0')">
                          <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usrtype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					 
					 for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					 						
				}
						
							%>
                        </select>
						<script language="javascript">setOptionValue('Branch','<%=branchid%>')</script> 
					  </span></td>
					  <td height="30"  >Sales Type </td>
					  <td colspan="5"  ><select name="salestype" class="formText135" id="salestype" onChange="loadPaymentCommitment('0')">
                        <option value="C">Customer Sales</option>
                        <option value="D">Direct Billing</option>
                        <option value="S">Service Billing</option>
                      </select></td>
					  <td  >Month</td>
					  <td  ><select name="month" id="month"
							onBlur="loadPaymentCommitment('0')">
                            <option value="0" selected>All</option>
                        <%@ include file="../JavaScript/Inventory/month.jsp"%>
                      </select></td>
					  <td  >&nbsp;</td>
				      <td  >&nbsp;</td>
				  </tr>
					<tr>
					  <td  >Customer</td>
					  <td  ><select style="width:200"
							name="customer" id="customer" class="formText135"
							onChange="loadPaymentCommitment('0')">
                        <option value="0">All</option>
                        <jsp:include page="LoadCustomer.jsp" />                      
</select></td>
					  <td height="30"  >Division</td>
					  <td colspan="5"  ><select
							name="division" class="formText135" id="division" tabindex="1"
							onChange="loadPaymentCommitment('0')">
                        <option value='0'>All</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
				      <td  >Year</td>
				      <td  ><select name="year" id="year"
							onBlur="loadPaymentCommitment('0')">
                        <%@ include file="../JavaScript/Inventory/year.jsp"%>
                      </select>
					 </td>
				      <td  >Day</td>
				      <td  ><select name="day" class="formText135" id="day" style="width:50"  onBlur="loadPaymentCommitment('0') ">
				        <option value="0" selected>All</option>
				        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
			          </select>
                      
                       <script language='JavaScript' type="text/javascript">
				     
					 	var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);
						var day=d.getDate();
						setOptionValue('day',day);	
						 	
				
				
          </script>
                      </td>
				  </tr>
				</table>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteMedium">
					<tr  >
						<td   width="150">
						<div align="center">Sale No</div>						</td>
						<td   width="150">
						<div align="center">Date</div>						</td>
						<td   width="150">
						<div align="center">Customer Name</div>						</td>
						<td   width="150">
						<div align="left">No of Commitment</div>						</td>
						<td   width="150">
						<div align="left">Invoice Amount</div>						</td>
						<td   width="150">
						<div align="left">Commit Date</div>						</td>
						<td   width="150">
						<div align="left">Commt Amount</div>						</td>
						<td   width="150">
						<div align="left">Status</div>						</td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				 
						<div id="PaymentCommitmentTable" style="OVERFLOW:auto;width:100%;height:300px" > </div>
						<br><div align="center" id="totRec"></div> <br>				</td>
		  </tr>
		</table>		</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr  >
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('0')">All</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('A')">A</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('B')">B</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('C')">C</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('D')">D</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('E')">E</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('F')">F</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('G')">G</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('H')">H</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('I')">I</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('J')">J</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('K')">K</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('L')">L</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('M')">M</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('N')">N</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('O')">O</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('P')">P</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('Q')">Q</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('R')">R</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('S')">S</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('T')">T</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('U')">U</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('V')">V</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('W')">W</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('X')">X</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('Y')">Y</a></div>				</td>
				<td >
				<div align="center"><a class="whiteMedium" href="javascript:loadPaymentCommitment('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
	  <td><input name="filename" type="hidden" value="SwapSale" /> <input
			name="actionS" type="hidden" value="INVSwapSaleDelete" />
	    <input name="Billinttype" type="hidden" id="Billinttype" value="P"></td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="3" cellspacing="3">
			<!--DWLayoutTable-->
			<tr>
				 
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="btnEdit" value="Edit"
					onclick="return Edit()" /></td>

				<!--<%
	   String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56"><input type="hidden" class="ButtonHead"
					name="Submit3" id="btnDelete" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='btnDelete'>");
		} 
		%>--><input type='hidden' id='btnDelete'>
				<td width="56"><input type="button" class="ButtonHead"
					name="submits"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>

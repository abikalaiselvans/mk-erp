<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
  
<style type="text/css">
@import url("../bootstrap/css/bootstrap.min.css");
@import url("../JavaScript/SmartStyles.css");
</style>
<script src="../bootstrap/js/jquery.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
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
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerPurchaseOrder.js"></script>
 
<script language="JavaScript">
	function SalesOrderPrint(query)
	{
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="SalesOrderViewprint.jsp?salenumber="+query;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
 	}	
	
	function QuotationPrint(query)
		{
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	
			var f ="QuotationOrderPrint.jsp?quotationnumber="+query;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
		
	function  CPOUpload(pono)
	{
		var f ="CPOUpload.jsp?pono="+pono+"";
		newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
		newWindow.focus( );
	}	
		
		
  	function Add()
	{ 
		document.frm.action="QuotationAction.jsp";
	}
	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].itemId
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
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="QuotationOrderEdit.jsp";
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
		coffee1=document.forms[0].itemId
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
			if (document.forms[0].itemId.checked) { count=1;}
		}
		if(count>=1){			
				document.frm.action="QuotationOrderView.jsp";			
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	} 	 	
 	function mainPage()
 	{
	      document.frm.action="InventoryMain.jsp";
    } 	
    function Validate()
	{
	  
	}
 	
</script>

<body    onLoad="loadSalesOrder('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
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
		<table width="900" height="199" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td  >
				<div align="center">CUSTOMER PURCHASE ORDER </div>
				</td>
			</tr>
			<tr  >
			  <td height="31" align="center"  > 
<table width="100%" border="0" cellpadding="4" cellspacing="4" class="whiteMedium">
                    <tr>
                      <td height="19" >Division</td>
                      <td ><select
							name="division" class="formText135" id="division" tabindex="1"
							onChange="loadSalesOrder('0')" style="width:150">
                        <option value='0'>All</option>
                        <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select></td>
                      <td >Customer</td>
                      <td ><select
							name="customer" id="customer" class="formText135"
							onChange="loadSalesOrder('0')" style="width:150">
                        <option value="0">All</option>
                        <jsp:include page="LoadCustomer.jsp" />                      
</select></td>
                      <td>P.O. Received </td>
                      <td><select name="poattach" class="formText135" id="poattach" style="width:150" onBlur="loadSalesOrder('0') ">
                        <option value="0">All</option>
                        <option value="Y">Yes</option>
                        <option value="N">No</option>
                      </select></td>
                      <td >&nbsp;</td>
                      <td >&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="19" >CPO Attached </td>
                      <td ><select name="status" class="formText135" id="status"  onBlur="loadSalesOrder('0') "  >
                        <option value="0">All</option>
                        <option value="N" selected="selected">Pending</option>
                        <option value="Y">Attached</option>
                      </select></td>
                      <td >Day</td>
                      <td ><select name="day" class="formText135" id="day" style="width:50"  onBlur="loadSalesOrder('0') ">
                        <option value="0" selected>All</option>
                        <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                      </select></td>
					  <td>Month</td>
                <td><select name="month" class="formText135" id="month" onChange="loadSalesOrder('0')">
                  <option value="0" selected>All</option>
                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                </select></td>
                      <td >Year</td>
                      <td ><select name="year" class="formText135" id="year"
					onChange="loadSalesOrder('0')">
                        <%@ include file="../JavaScript/Inventory/year.jsp"%>
                      </select>
			  <script language='JavaScript' type="text/javascript">
						 	
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						//setOptionValue('day',day);	
						//setOptionValue('month',month1);
						setOptionValue('year',year1);	
				</script>					  </td>
                    </tr>
                  </table>
			  </td></tr>
			 
			<tr class="MRow1">
				<td height="107" valign="top" class="footermenu">
				 
						<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px"
							class="boldEleven">
						<div id="QuotationTable"></div>
						</div>
						<br>
						<div align="center" id="totRec"></div>
						<br>
						 
				</td>
		  </tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('0')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a class="whiteMedium" href="javascript:loadSalesOrder('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr align="center">
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

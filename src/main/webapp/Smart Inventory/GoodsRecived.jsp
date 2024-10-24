<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
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
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/Inventory/Vendorgoodsreceived.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
<script language="JavaScript">
 function order()
	{ 
	
		document.frm.action="ReceiveOrder.jsp?id=1";
 	}
	
	function GoodsEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].ponumber;
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].ponumber.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="GoodsReceivedEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Purchase order number");
		    return false;
		}
		
 	}	


 	function GoodsDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].ponumber;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
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

<body    onLoad="loadReceive('0')">
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
		<table width="900" height="162" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="whiteMedium"  >GOODS RECEIVED </div>				</td>
			</tr>
			<tr  >
				<td height="31" align="center"  >
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="2" class="whiteMedium"  >
					<tr>
					<td >Division</td>
						<td ><select name="division" style="width:160"
							class="formText135" id="division" tabindex="1"
							onChange="loadReceive('0')">
							<option value='0'>All</option>
							<%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
						</select></td>
					  <td >Vendor</td>
						<td ><select name="vendor" id="vendor"  style="width:160"
							class="formText135" onChange="loadReceive('0')">
							<option value="0">All</option>

							<jsp:include page="LoadVendor.jsp" />
						</select></td>
						<td>Day</td>
                <td><select name="day" id="day"  onBlur="loadReceive('0') ">
                  <option value="0">All</option>
                  <%
						for(int u=1;u<32;u++)
							out.println("<option value='"+(u)+"'>"+u+"</option>");
						%>
                </select></td>
						<td  >Month </td>
						<td><span  > <select name="month"
							id="month" onBlur="loadReceive('0')">
							<option value="0">All</option>
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select> </span></td>
						<td><span  >Year </span></td>
						<td><span  > <select name="year"
							id="year" onBlur="loadReceive('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						var day=d.getDate();
						setOptionValue('day',day);	
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> </span></td>
					</tr>
				</table>				</td>
			</tr>
			 
			<tr>
				<td  ></td>
			</tr>

			<tr class="MRow1">
				<td height="62" valign="top" class="footermenu">
				 
						<div id="ReceiveTable" style="OVERFLOW:auto;width:100%x;height:250px"  ></div>
						<br>
						<div align="center" id="totRec"></div>	
						<br>
						
	 			</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReceive('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="GoodsReceived" />
		<input name="actionS" type="hidden" value="INVGoodsReceivedDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="119" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit" id="Edit"
					class="ButtonHead" value="Receive" onClick="return GoodsEdit()" /></td>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
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

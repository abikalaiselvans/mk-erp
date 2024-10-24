<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>

<script language="JavaScript">
 
 function fromchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
	{
		alert("Enter Starting Place");
		
	}
 }

 function tochk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
	{
		alert("Enter End Place");
	}
 }

var petrol 
	<%
	String cdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DOU_PETROL FROM m_institution  WHERE INT_ID=1");
	double price = Double.parseDouble(cdata[0][0]);
	%>
	petrol = "<%=price%>";

function kmchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Kilometer");
	else
	{
		var v0 = parseFloat(document.getElementById('km').value);
		var v = Round(v0*petrol);
		document.getElementById('kmamount').value = Round(v);
		tot();
	}	
 }

function trainchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Train/Bus Fare");
	else
		tot();
 }

function autochk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Auto Fare");
	else
		tot();
 }

function lunchchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Lunch / Dinner");
	else
		tot();
 }

function telephonechk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Telephone Charges");
	else
		tot();
 }
 
 function otheramtchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Others Amt");
	else
		tot();
 }
 
 
 
function tot()
{
	//km,kmamount,,auto,lunch,telephone,otherdesc,otheramt,total
	var v0 = parseFloat(document.getElementById('km').value);
	var v = (v0*petrol);
	var v1 = parseFloat(document.getElementById('train').value);
	var v2 = parseFloat(document.getElementById('auto').value);
	var v3 = parseFloat(document.getElementById('lunch').value);
	var v4 = parseFloat(document.getElementById('telephone').value);
	var v5 = parseFloat(document.getElementById('otheramt').value);
	var tot = v+v1+v2+v3+v4+v5;
	document.getElementById('total').value = Round(tot);
}
	
	
function Validate()
  {
  	var v =document.getElementById('total').value;
	if(v<1)
	{
		alert("We require Conveyance Claim Amount...");
		return false;
	}
	if(checkNull("total","Invalid net amount") )
		return true;
	else
		return false;
  }
  
  function mainPage()
  {
	    document.a.action="../Smart Inventory/ConveyanceAdd.jsp";
		document.a.submit();
		return true;
  }
  </script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"
	onSubmit="return Validate()">

<table width="85%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td align="center">
		<p class="tablehead">&nbsp;</p>
		<TABLE class=fontclass1 cellSpacing=1 cellPadding=0 width="100%"
			bgColor=#6f8ec5 border=0>
			<TBODY>
				<TR>
					<TD width="26%" bgColor=#6f8ec5 class=fontclass1_b>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="22%">&nbsp;</td>
							<td width="42%">
							<div align="center"><font class="boldEleven"> <%
				
				String emp=""+session.getAttribute("EMPID");
				String 	opendate = request.getParameter("opendate");
				String row = request.getParameter("id");
				String sql =" SELECT INT_CONID,CHR_EMPID,DAT_CONDATE,CHR_REPTTO,INT_DIVID,CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,";
				sql =sql+"DOU_TRAIN,DOU_AUTO,DOU_LUNCH,DOU_TELEPHONE,CHR_OTHERDESC,DOU_OTHERAMT,DOU_TOTAL ,CHR_CALLID,CHR_ACCEPT ";
				sql =sql+" FROM conveyance_t_conveyance WHERE INT_CONID="+row;
				String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				

					
				%> <font color=#ffffff>Conveyance Claim for Employee :</font></font></div>
							</td>
							<td width="22%"><font class="boldEleven"><font
								color=#ffffff> </font></font></td>
							<td width="14%">&nbsp;</td>
						</tr>
					</table>
					</TD>
				<TR>
					<TD noWrap >
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr  class='MRow1'>
							<td width="13%" class="boldEleven">&nbsp;</td>
							<td width="17%" class="boldEleven"></td>
							<td width="46%" class="boldEleven">Date ::<%=opendate%></td>
							<td width="9%" class="boldEleven">&nbsp;</td>
							<td width="15%" class="boldEleven">&nbsp;</td>
						</tr>
					</table>
					</TD>
				</TR>






				<TR>
					<TD >
					<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >
						<TR class='MRow1'>
						  <Th  class="boldEleven">Call ID </Th>

							<Th  class="boldEleven">From</Th>
							<Th  class="boldEleven">To</Th>
							<Th align=middle  class="boldEleven">Vehicle
							No of Kms</Th>
							<Th align=middle  class="boldEleven">Amount</Th>
							<Th align=middle  class="boldEleven">Train/Bus
							Fare</Th>
							<Th align=middle  class="boldEleven">Auto
							Fare</Th>
							<Th align=middle  class="boldEleven">Lunch /
							Dinner</Th>
							<Th align=middle  class="boldEleven">Telephone
							Charges</Th>
							<Th align=middle  class="boldEleven">Others
							Desc</Th>
							<Th align=middle  class="boldEleven">Others
							Amt</Th>
						  <Th align=middle  class="boldEleven">Total <input
								name="filename" type="hidden" id="filename" value="Conveyance">
							<input name="actionS" type="hidden" id="actionS"
								value="CONConveyanceEdit"> 
							<input name="id"
								type="hidden" id="id" value="<%=row%>"> <input
								name="opendate" type="hidden" id="opendate"
								value="<%=opendate%>">
							<input name="reentry" type="hidden" id="reentry" value="<%=data[0][17]%>"></Th>
						</TR>


						<tr class='MRow1'>
						  <td  class="boldEleven"><input name='callid' type='text' class='formText135'
								id='callid' onKeyUp="upperMe(this)" value="<%=data[0][16]%>"
								size=7 maxlength="16"  /></td>

							<td  class="boldEleven"><input type='text'
								size=7 onKeyUp="upperMe(this)" class='formText135' name='from'
								id='from' value="<%=data[0][5]%>" onBlur="fromchk(this)" /></td>
							<td  class="boldEleven"><input type='text'
								size=7 onKeyUp="upperMe(this)" class='formText135' name='to'
								id='to' value="<%=data[0][6]%>" onBlur="tochk(this)" /></td>
							<td  class="boldEleven"><input type='text'
								size=8 onKeyUp="upperMe(this)" class='formText135'
								onBlur="kmchk(this)" name='km' id='km' onKeyPress=" return numeric_only(event,'km','7')"
								  value="<%=data[0][7]%>" /></td>
							<td  class="boldEleven"><input type='text'
								size=8 onKeyUp="upperMe(this)" class='formText135'
								name='kmamount' id='kmamount' value="<%=data[0][7]%>"
								readonly="" /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' onBlur="trainchk(this)" name='train'
								id='train' onKeyPress=" return numeric_only(event,'train','7')"
								value="<%=data[0][9]%>" style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' onBlur="autochk(this)" name='auto'
								id='auto'  onKeyPress=" return numeric_only(event,'auto','7')"
								value="<%=data[0][10]%>" style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' onBlur="lunchchk(this)" name='lunch'
								id='lunch' onKeyPress=" return numeric_only(event,'lunch','7')"
								value="<%=data[0][11]%>" style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' onBlur="telephonechk(this)"
								name='telephone' id='telephone'
								 onKeyPress=" return numeric_only(event,'telephone','7')"
								value="<%=data[0][12]%>" style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' name='otherdesc' id='otherdesc'
								maxlength="100" value="<%=data[0][13]%>"
								style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' onBlur="otheramtchk(this)"
								name='otheramt' id='otheramt' maxlength="100"
								value="<%=data[0][14]%>"   onKeyPress=" return numeric_only(event,'otheramt','7')" style='text-align:right' /></td>
							<td  class="boldEleven"><input type='text'
								size=8 class='formText135' readonly="readonly" name='total'
								id='total' maxlength="100" value="<%=data[0][15]%>"
								style='text-align:right' /></td>
					</TABLE>
					</TD>
				</TR>
				<TR  class='MRow1'>
					<TD align=middle height=30>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT
						name=sub1 type=submit class="tfoot" value=Submit> <input
						name="Button" type="button" class="tfoot"  value="Close"   accesskey="c" 
						onClick="redirect('ConveyanceModify.jsp?opendate=<%=opendate%>')">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<p class="tablehead">&nbsp;</p>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>

</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: CONVEYANCE ::</title>

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

function kmchk(ctr)
 {
 	var v  = ctr.value;
	if(v =="")
		alert("Enter Kilometer");
	else
	{
		var v0 = parseFloat(document.getElementById('km').value);
		var v = Round(v0*1.30);
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
	var v = Round(v0*1.30);
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
							<td>
							<div align="center"><font class="boldEleven"> <%
				
				String empid=""+session.getAttribute("EMPID");
				//String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String fromdate=""+request.getParameter("fromdate");
				String todate=""+request.getParameter("todate");
				String fdt=fromdate;
				String tdt = todate;
				fromdate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				todate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String sql="";
				sql ="SELECT INT_CONID,DAT_CONDATE,CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,";
				sql = sql+"	DOU_TELEPHONE,CHR_OTHERDESC,DOU_OTHERAMT,DOU_TOTAL,CHR_STATUS,CHR_DESC,CHR_CALLID,";
				sql = sql+"	CHR_ACCSTATUS,INT_BANKID,DATE_FORMAT(DAT_CLEARINGDATE,'%d-%b-%Y'), CHR_CLEARING_DESC , ";
				sql = sql+"	DATE_FORMAT(DAT_APPROVAL_TIME ,'%d-%b-%Y') FROM conveyance_t_conveyance ";
				sql = sql+" WHERE   (DAT_CONDATE)>='"+fromdate+"' AND (DAT_CONDATE)<='"+todate+"' ";
				sql = sql+" AND CHR_EMPID='"+empid+"'";//AND
				 
	 			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
				%> <font color=#ffffff>Conveyance Claim for Employee : From : <%=fdt%> To : <%=tdt%></font></font></div>
							<font class="boldEleven"><font
								color=#ffffff> </font></font></td>
							<td width="14%">&nbsp;</td>
						</tr>
					</table>
					</TD>
				<TR>
					<TD noWrap bgColor=#ffffff>&nbsp;</TD>
				</TR>






				<TR>
					<TD bgColor=#ffffff>
					<%
			  if(data.length>0)
			{
				out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<TR  class='MRow1'>");
				out.println("<Th  class='boldEleven'>Sl.No</Th>");
				out.println("<Th  class='boldEleven' width=75>Date</Th>");
				out.println("<Th  class='boldEleven' width=75>Call Number</Th>");
				out.println("<Th  class='boldEleven'>From</Th>");
				out.println("<Th  class='boldEleven'>To</Th>");
				out.println("<Th  class='boldEleven'>Vehicle No of Kms</Th>");
				out.println("<Th  class='boldEleven'>Amount</Th>");
				out.println("<Th  class='boldEleven'>Train/Bus are</Th>");
				out.println("<Th  class='boldEleven'>Auto Fare</Th>");
				out.println("<Th  class='boldEleven'>Lunch / Dinner</Th>");
				out.println("<Th  class='boldEleven'>Telephone Charges</Th>");
				out.println("<Th  class='boldEleven'>Others Desc</Th>");
				out.println("<Th  class='boldEleven'>Others Amt</Th>");
				out.println("<Th  class='boldEleven'>Total </Th>");
				out.println("<Th  class='boldEleven'>Approval </Th>");
				out.println("<Th  class='boldEleven'>Approval Date</Th>");
				out.println("<Th  class='boldEleven'>Clearing</Th>");
				out.println("<Th  class='boldEleven'>Bank Details</Th>");
				out.println(" </TR>");
				double sum=0.0;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==1)
						out.println("<tr class='MRow1'>");
					else
						out.println("<tr  class='MRow2'>");	
					out.println("<td class='boldEleven'>"+(u+1));
					out.println("<td class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(data[u][1]));
					out.println("<td class='boldEleven'>"+data[u][15]);	
					out.println("<td class='boldEleven'>"+data[u][2]);
					out.println("<td class='boldEleven'>"+data[u][3]);
					out.println("<td class='boldEleven' align='right'>"+data[u][4]+" - KM ");
					out.println("<td class='boldEleven' align='right'>"+data[u][5]);
					out.println("<td class='boldEleven' align='right'>"+data[u][6]);
					out.println("<td class='boldEleven' align='right'>"+data[u][7]);
					out.println("<td class='boldEleven' align='right'>"+data[u][8]);
					out.println("<td class='boldEleven' align='right'>"+data[u][9]);
					out.println("<td class='boldEleven' align='right'>"+data[u][10]);
					out.println("<td class='boldEleven' align='right'>"+data[u][11]);
					out.println("<td class='boldEleven' align='right'>"+data[u][12]);
					sum=sum+Double.parseDouble(data[u][12]);
					if("N".equals(data[u][13]))
						out.println("<td class='boldEleven'><font class='boldred'>Pending</font>");
					else if("Y".equals(data[u][13]))
						out.println("<td class='boldEleven'><font class='boldgreen'>Accept</font>");
					else if("R".equals(data[u][13]))
						out.println("<td class='boldEleven'><font class='boldred'>Reject :: "+data[u][14]+"</font>");
					
					out.println("<td class='boldEleven' align='right'>"+data[u][20]);
					
					if("Y".equals(data[u][16]))
					{
						out.println("<td class='boldEleven'><b><font class='boldgreen'>Awaiting Clearance</font></b></Td>");
						out.println("<td class='boldEleven'>&nbsp;</Td>");
						/*if(!"-".equals(data[u][17]))
						{
						out.println("<td class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_BANKID,CHR_BANKNAME FROM com_m_bank WHERE INT_BANKID="+data[u][17])[0][1]+" /  Date : "+data[u][18]+"</Td>");
						}
						else
						{
							out.println("<td class='boldEleven'>&nbsp;</Td>");
						}*/
					}
					else
					{
						out.println("<td class='boldEleven'>&nbsp;</Td>");
						out.println("<td class='boldEleven'>&nbsp;</Td>");
					}
			 
				}
				out.println();
				out.println("<TR  class='MRow1' >");
				out.println("<Td colspan=14 class='boldEleven' align='right'><b>Total :: </b></Td>");
				out.println("<Td class='boldEleven' >"+com.my.org.erp.common.CommonFunctions.Round(sum)+"</Th>");
				out.println("<td class='boldEleven'>&nbsp;</Td>");
				out.println("<td class='boldEleven'>&nbsp;</Td>");
				out.println("<td class='boldEleven'>&nbsp;</Td>");
				
			out.println("</TABLE>");
		}  
   %>
					</TD>
				</TR>
				<TR bgColor=#ffffff>
					<TD align=middle height=30>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
						name="Button" type="button" class="tfoot"  value="Close"   accesskey="c" 
						onClick="redirect('ConveyanceAdd.jsp')">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<p class="tablehead">&nbsp;</p>
		</td>
	</tr>
	<tr>
		<td><a href="javascript:window.print()"><font class="boldEleven">print</font></td>
	</tr>
</table>
</form>
</body>

</html>

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
<%
 String sql = "";
String 	opendate = request.getParameter("opendate");
String opdt = opendate;
%>
<script language="JavaScript">
function assign()
{
	var nocheck=document.forms[0].row
	var val=document.getElementById("all").checked;
	if(val==false)
	{
		for(i=0;i<=nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<=nocheck.length;++ i)
		{		
			nocheck[i].checked=true;
		}
	}
		
		
		
}
 
	
	
function Validate()
  {
  	var v =document.getElementById('ntotal').value;
	if(v<1)
	{
		alert("Atleast we require one Conveyance Claim Amount...");
		return false;
	}
	if(checkNull("ntotal","Invalid net amount") )
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
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">

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
						<tr>
							<td width="13%" class="boldEleven">&nbsp;</td>
							<td width="17%" class="boldEleven"><a
								href="javascript:cal1.popup();"> </a></td>
							<td width="46%" class="boldEleven">Date :: <%=opendate%></td>
							<td width="9%" class="boldEleven">Select All</td>
							<td width="15%" class="boldEleven"><input type="checkbox"
								id="all" name="all" onClick="assign()"></td>
						</tr>
					</table>
					</TD>
				</TR>






				<TR>
					<TD >
					<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >
						<TR class="MRow1">
							<Th align=middle  class="boldEleven">Sl.No</Th>
							<Th  class="boldEleven">Call Number </Th>
							<Th  class="boldEleven">From</Th>
							<Th  class="boldEleven">To</Th>
							<Th align=middle  class="boldEleven">Vehicle	No of Kms</Th>
							<Th align=middle  class="boldEleven">Amount</Th>
							<Th align=middle  class="boldEleven">Train/BusFare</Th>
							<Th align=middle  class="boldEleven">AutoFare</Th>
							<Th align=middle  class="boldEleven">Lunch /	Dinner</Th>
							<Th align=middle  class="boldEleven">Telephone Charges</Th>
							<Th align=middle  class="boldEleven">Others Desc</Th>
							<Th align=middle  class="boldEleven">Others Amt</Th>
							<Th align=middle  class="boldEleven">Total</Th>
							<Th align=middle  class="boldEleven">Status</Th>
							<Th align=middle  class="boldEleven">&nbsp;</Th>
							<Th align=middle  class="boldEleven">Edit</Th>
							<Th align=middle  class="boldEleven"><INPUT
								name="Delete" id="Delete" type=submit class="wysiwyg"
								onclick=subformlist() value=Delete> <input
								name="filename" type="hidden" id="filename" value="Conveyance">
							<input name="actionS" type="hidden" id="actionS"
								value="CONConveyanceDelete"> 
							<input name="opendate"
								type="hidden" id="opendate" value="<%=opendate%>"></Th>
						</TR>
						

						<%
				opendate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(opendate);
				sql = " SELECT INT_CONID,CHR_FROM,CHR_TO,DOU_KM,DOU_TRAVEL,DOU_TRAIN,DOU_AUTO,DOU_LUNCH,DOU_TELEPHONE,";
				sql = sql+"CHR_OTHERDESC,DOU_OTHERAMT,DOU_TOTAL, CHR_STATUS,CHR_DESC,CHR_CALLID  FROM  conveyance_t_conveyance   ";
				sql = sql+"	WHERE CHR_EMPID='"+emp+"' AND DAT_CONDATE='"+opendate+"'";
				String link="";
				String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double sum=0.0;
				if(data.length>0)
				{
					for(int u=0; u<data.length;u++)
					{
					//link ="../SmartLoginAuth?filename=Conveyance&actionS=INVConveyanceDelete&id="+data[u][0]+"&opendate="+opendate;
						link = "ConveyanceEdit.jsp?id="+data[u][0]+"&opendate="+opdt;
						
						if(u%2==0)
							out.println("<TR  class='MRow1'>");
						else
							out.println("<TR  class='MRow2'>");
                  		out.println("<TD  class='boldEleven'>"+(u+1)+"</TD>");
						out.println("<TD  class='boldEleven'>"+data[u][14]+"</TD>");
						out.println("<TD  class='boldEleven'>"+data[u][1]+"</TD>");
                 		out.println("<TD  class='boldEleven'>"+data[u][2]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][3]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][4]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][5]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][6]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][7]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][8]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][9]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][10]+"</TD>");
                  		out.println("<TD  class='boldEleven'>"+data[u][11]+"</TD>");
						sum = sum+Double.parseDouble(data[u][11]);
						if("N".equals(data[u][12]))
						{
							out.println("<TD  class='boldEleven'>Pending</TD>");
							out.println("<TD  class='boldEleven'>&nbsp;</TD>");
							out.println("<TD  class='boldEleven'>");
							out.println("<a href="+link+">Edit</a></TD>");
							out.println("<TD  class='boldEleven'>");
							out.println("<input type='checkbox' name='row'  id='row' value='"+data[u][0]+"'>");
							//out.println("<a href="+link+">Delete</a></TD>");
						}
						else if("R".equals(data[u][12]))
						{
							out.println("<TD  class='boldEleven'><font class='boldred'>Reject<font></TD>");
							out.println("<TD  class='boldEleven'>"+data[u][13]+"</TD>");
							out.println("<TD  class='boldEleven'><a href="+link+">Edit</a></TD>");
							out.println("<TD  class='boldEleven'>");
							out.println("<input type='checkbox' name='row' value='"+data[u][0]+"'>");
							//out.println("<a href="+link+">Delete</a></TD>");
						}
						else
						{
							out.println("<TD  class='boldEleven'><font class='boldgreen'>Accept</font></TD>");
							out.println("<TD  class='boldEleven'>&nbsp;</TD>");
							out.println("<TD  class='boldEleven'>&nbsp;</TD>");
							out.println("<TD  class='boldEleven'>&nbsp;</TD>");
						}
						
						
                		out.println("</TR>");
					}
				}
				else
				{
					out.println("<tr  class='MRow1'><td colspan=15><font class='boldred'>Data not found...</font></td></tr>");
					%>
						<script language="javascript">
						document.getElementById('Delete').disabled=true;
						document.getElementById('all').disabled=true;
						 
					</script>
						<%
				} 
				 
				%>
				
				<TR  class='MRow1'>
						  <Th colspan="16" align=middle  class="boldEleven"><div align="right">SUM :: </div></Th>
						  <Th align=middle  class="boldEleven"><%=sum%></Th>
					  </TR>
					</TABLE>
					</TD>
				</TR>
				<TR   class='MRow1'>
					<TD align=middle height=30>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
						name="Button" type="button" class="tfoot"  value="Close"   accesskey="c" 
						onClick="redirect('Userframe.jsp')">
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

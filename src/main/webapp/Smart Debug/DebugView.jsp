<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> 


<%
try
{
%>


<html>
<head>
 

<title> :: DEBUG ::</title>


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

 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Debug/TicketAJAX.js"  ></script>
<script language="javascript">
function Validate()
{
		if(
			checkNullSelect('package','Select Package..', 'Select')
			&& checkNullSelect('priority','Select Priority..', 'Select')
			&& checkNull('desc', 'Enter Problem Description..')
		)
		{
			return true;
		}
		else
		{
			return false;
		}	
}		
</script>

<script language="JavaScript">

function Add()
{ 
	document.frm.action="Ticket.jsp";
}

function DEdit()
{		
	try
	{
		var count;
		count=0;
		coffee1=document.forms[0].Ticketid
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
			if (document.forms[0].Ticketid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="TicketEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Ticket Id");
		    return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
	

function Delete()
{		
	try
	{
		var count;
		count=0;
		coffee1=document.forms[0].Ticketid
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
			if (document.forms[0].Ticketid.checked) { count=1;}
		}
		if(count>=1){			
				document.frm.action="../SmartLoginAuth";			
		}
		else
		{
		    alert("Select Atleast One Ticket Id");
		    return false;
		}		
	}
	catch(err)
	{
		alert(err);
		return false;
	}
} 	 	
 	 	
     	
</script>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onLoad="LoadTicket('0')">
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="index.jsp"%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="383">
	
	<table height="227" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="whiteMedium">Ticket Informations</div>				</td>
			</tr>
			<tr  >
				<td  >
				<table width="100%" border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
					<tr>
						<td width="18" class="boldThirteen">Package</td>
						<td width="19" class="boldThirteen">
						<select name="package" id="package" onBlur="LoadTicket('0')">
							<option value='0' selected>All</option>
							<%
							
							String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME,CHR_MODULE FROM  m_projectmodule ORDER BY INT_ID");
							if(data.length>0)
								for(int u=0;u<data.length;u++)
									out.println("<option value='"+data[u][0]+"'>"+data[u][1]+"</option>");
							%>
						</select></td>
						<td width="37" class="boldThirteen">Status</td>
						<td width="37" class="boldThirteen"><select name="Status"
							id="Status" class="formText135" onBlur="LoadTicket('0')">
							<option value="0" selected="selected">All</option>
							<option value="N">Not Completed</option>
							<option value="Y">Completed</option>
						</select></td>
						<td width="74" class="boldThirteen">Month </td>
						<td width="89"><select name="Month" id="Month"
							onBlur="LoadTicket('0')">
							<option value="0"  >All</option>
							<%@ include file="../JavaScript/months.jsp"%>
						</select></td>
						<td width="50" class="boldThirteen">Year </td>
						<td width="88"><select name="Year" id="Year"
							onBlur="LoadTicket('0')">
							<%@ include file="../JavaScript/years.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Month',month1);
						setOptionValue('Year',year1);							
				//-->
          </script></td>
					</tr>
				</table>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<div align="center">
				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="whiteMedium">
					<tr  >
						<td   >
					    <div align="center">Ticket id</div></td>
						<td    >
					    <div align="center">Package</div></td>
						
						<td    >
					    <div align="center">From</div></td>
						<td   >
					    <div align="center">date</div></td>
						<td   >
					    <div align="center">Problem</div></td>
						<td   ><div align="center">Status</div></td>
					</tr>
				</table>
				</div>				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
 
					<tr>
						<td  align="center"  ></td>
					</tr>
					<tr class="MRow1">
						<td>
						<div id="ticket" style="OVERFLOW:auto;width:100%;height:300px"
							class="boldEleven"></div><br><div id="totalrec"></div>							</td>
					</tr>
				</table>				</td>
			</tr>
		</table>	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
  	<td>
  	<table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadTicket('Z')">Z</a></div></td>
          </tr>
        </table>  	</td>
  </tr>
  <tr>
    <td height="15"><input name="filename" type="hidden" value="Ticket" />
      <input
			name="actionS" type="hidden" value="DEBTicketDelete" /></td>
  </tr>
  <tr>
    <td><table border="0" align="center" cellpadding="3" cellspacing="3">
      <!--DWLayoutTable-->
      <tr>
        <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
        <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action12" id="Edit" value="Edit"
					onclick="return DEdit()" /></td>
       
	   

<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{ 
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}


		%>



	     
        <td width="56"><input name="button" type="button"
					class="ButtonHead" onClick="redirect('Debugmain.jsp')"
					 value="Close"   accesskey="c"  /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><%@ include file="../footer.jsp"%></td>
  </tr>
</table>

</form>
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
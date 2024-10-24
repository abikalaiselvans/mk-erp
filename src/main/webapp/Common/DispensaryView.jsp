<%@ page import="java.io.*,java.util.*" isErrorPage="true"
	errorPage="../error/index.jsp"%>

<%@ include file="insert.jsp"%>

<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />



<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="DispensaryAction.jsp?path=<%=path%>&qp=<%=qp%>";
 	}

	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].placeid
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
			if (document.forms[0].placeid.checked) { count=1;}
			 
		}
		if(count==1){			
			document.frm.action="DispensaryEdit.jsp?path=<%=path%>&qp=<%=qp%>";
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
		coffee1=document.forms[0].placeid;
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
			if (document.forms[0].placeid.checked) { count=1;}
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
  
  function mainPage()
 {
 	document.frm.action="AttendanceMain.jsp";
 }
 	
</script>

<body onpaste="return false;">
<form AUTOCOMPLETE="off" name="frm" method="post"><br>
<br>

<table width="100%" border="0" cellpadding="1" cellspacing="1">
	<tr>
		<td width="754">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" align="center" cellpadding="0"
			cellspacing="0" class="TableDesign">
			<tr>
				<td height="31">
				<div align="center" class="whiteMedium">Dispensary Information
				</div>
				</td>
			</tr>
			<tr>
				<td width="781" height="31">
				<div align="center">
				<table width="620" border="0" cellpadding="1" cellspacing="1"
					class="whiteMedium">
					<tr>
						<td width="10" class="bold1">&nbsp;</td>
						<td width="300">Dispensary Name</td>
						<td width="300">Pin Code</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="127" valign="top" class="footermenu">
				<table width="100%" align="center">

					<tr>
						<td bgcolor="#FFFFFF">
						<div id="divscroll"
							style="OVERFLOW: auto; width: 100%; height: 250px"
							class="boldEleven">
						<%
		 	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DESPID,CHR_DESPNAME,INT_PINCODE From com_m_dispensary order by CHR_DESPNAME ");
			out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
			for(int u=0;u<data.length;u++)
			{
				if(u%2 == 0)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr class='MRow2'>");	
				out.println("<td width=10>");
				out.println("<input type='checkbox' name='placeid' value='"+ data[u][0]+"' />");
				out.println("<td width=300 class='boldEleven'>"+data[u][1]);
				out.println("<td>"+data[u][2]);
				out.println("</tr>");
			}
			out.println("</table>");
		 %>
						</div>
						<br>
						<br>
						</td>
					</tr>

					<tr bgcolor="#FFFFFF">
						<td align="center">
						<div align="center"><font color='red'>Total no of
						Records :: <%=data.length%> </font></div>
						</td>
					</tr>
					<tr>
						<td align="center" bgcolor="#efefef"></td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Dispensary" /> <input
			type="hidden" name="actionS" value="COMDispensaryDelete" /> <!--<input name="path" type="hidden" value="<%=path%>">
      <input name="qp" type="hidden" value="<%=qp%>"></td>-->
	</tr>
	<tr>
		<td>



		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<tr>


				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Add" accesskey="s"
					onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1" value="Edit"
					onclick="return Edit()" /></td>
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" value="Delete"
					onclick="return Delete()" /></td>
				<%
	   }
	   %>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit" value="Close" accesskey="c"
					onClick="redirect('<%=closefile%>')"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

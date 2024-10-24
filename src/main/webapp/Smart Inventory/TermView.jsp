<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Term"%>
<%!
	String termId,termName;
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

<script language="JavaScript">
    function Add()
	{ 
		document.fromcat.action="TermsAction.jsp";
		// document.fromcat.submit();
 	}
	function Edit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].OptTermId
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
			if (document.forms[0].OptTermId.checked) { count=1;}
		}
		if(count==1){			
			document.fromcat.action="TermsAction.jsp";
			// document.fromcat.submit();
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
		coffee1=document.forms[0].OptTermId
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
			if (document.forms[0].OptTermId.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.fromcat.action="../SmartLoginAuth";
				// document.fromcat.submit();
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
 	 function mainPage()
	{
	     document.fromcat.action="InventoryMain.jsp";
	    // frm.submit();
    }
	   
</script>
<style type="text/css">
.style8
{
font-family: Veradana;
font-size: 12px;
}
.style9{color: #FFFFFF}
.style10 {font-family: Veradana; font-size: 12px; color: #FFFFFF }
a:visited;
{
color: #663366;
}
a:hover
{
color: #FF0000;
}
a:active
{
color: #0000FF;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
</head>
<body     >
<form  AUTOCOMPLETE = "off"   name="fromcat">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="84">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" border="1" align="center"  >
			<!--DWLayoutTable-->
			<tr>
				<td width="400" height="154" align="left" valign="top">
				<table width="101%" align="center" border="0">
					<!--DWLayoutTable-->
					<tr>
						<td width="363" height="27" align="center" valign="middle"
							class="tablehead" >Terms & Conditions</td>
					</tr>
				</table>
				<div id="divscroll" style="OVERFLOW:auto;width:400px;height:120px"
					class="sbarclr">
				<table width="100%" align="center" cellpadding="0" cellspacing="0"
					  border="0"  >
					<%
			ArrayList termList=(ArrayList) session.getAttribute("termList");
		    String bgcolor1="#ccccc";
			boolean bgflag=false;    
			for(int i=0;i<termList.size();i++)
			{
				Term term= (Term)termList.get(i);
				if(bgflag)
				{
					bgflag = false;
					bgcolor1="#FFFFFF";
				}
				else
				{
					bgflag = true;
					bgcolor1="#EEFFEE";
				}
				out.println("<tr bgcolor='"+bgcolor1+"' class='tabledata'>");				
				%>
					<td height="30" valign="middle" class="bolddeepblue">
					<%
         }
			String dis="";
			if(termList.size()==0) dis="disabled='disabled'";			
			termId=request.getParameter("termId");			
		%>
					</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Term"> <input
			type="hidden" name="actionS" value="INVtermDelete"></td>
	</tr>
	<tr>
		<td>
		<table align="center" cellpadding="1" cellspacing="1">
			<!--DWLayoutTable-->

			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1"  value="Add"   accesskey="s"   onClick=Add()></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="action1" <%=dis %> value="Edit"
					onClick="return Edit()"></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold" name="Submit" <%=dis %> value="Delete"
					onClick="return Delete()"></td>
				<td width="56"><input type="submit" class="buttonbold"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td height="108">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>

<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="indexinv.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script language="javascript">

 	function Edit()
 	{		
 	    var count=0;
 	    sel=document.forms[0].staffid;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    }
		 
 	    if(count==0)
 	    { 	       
		   if(document.forms[0].staffid.checked)
		    { 
		    	count=1;
		    }   
		    else{	    
		   	   alert("Select Record to Edit");
		   	   return false;
		   	 }
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false
 	    }
 	    if(count==1)
 	    {
		document.frmState.action="";
		document.frmState.submit();
		return true;
		}
 	}
 	
	function View()
 	{		
		document.frmState.action="";
		document.frmState.submit();
 	}	
		
	function Add()
 	{		
		document.frmState.action="";
		document.frmState.submit();
 	}		
	function mainPage()
	{
	    document.frmState.action="";
		document.frmState.submit();
		return true;
    }
	function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].staffid
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].staffid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frmState.action="../SmartLoginAuth";
				document.frmState.submit();
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
	 
	</script>
 
<style type="text/css">
<!--
.style3 {color: #000000}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   method="get" name="frmState">
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="194" align="center">
	<!--DWLayoutTable-->
	<tr>
		<td height="80" colspan="6" align="center"><br>
		<table width="636" height="177" border="1" align="center"
			cellpadding="0" cellspacing="0"  
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle"   background="">
				<td height="28"  
					class="tablehead"><span class="style3">Staff
				Registration</span></td>
			</tr>
			<tr  >
				<td height="31" align="left" valign="middle" class="boldEleven">
				<table width="640" border="0"
					  >
					<tr>
						<td width="126"><strong class="bold1">Staff Id</strong></td>
						<td width="175"><strong class="bold1">Staff Name</strong></td>
						<td width="167"><strong class="bold1"> Department</strong></td>
						<td width="154"><strong class="bold1">Designation</strong></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<div id="divscroll" style="OVERFLOW:auto;width:636px;height:190px">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				</table>
				</div>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17" colspan="6">
		<table width="579" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td width="9"><a href="">A</a></td>
				<td width="8"><a href="">B</a></td>
				<td width="9"><a href="">C</a></td>
				<td width="9"><a href="">D</a></td>
				<td width="8"><a href="">E</a></td>
				<td width="8"><a href="">F</a></td>
				<td width="9"><a href="">G</a></td>
				<td width="9"><a href="">H</a></td>
				<td width="6"><a href="">I</a></td>
				<td width="6"><a href="">J</a></td>
				<td width="8"><a href="">K</a></td>
				<td width="7"><a href="">L</a></td>
				<td width="10"><a href="">M</a></td>
				<td width="9"><a href="">N</a></td>
				<td width="10"><a href="">O</a></td>
				<td width="8"><a href="">P</a></td>
				<td width="10"><a href="">Q</a></td>
				<td width="8"><a href="">R</a></td>
				<td width="8"><a href="">S</a></td>
				<td width="8"><a href="">T</a></td>
				<td width="9"><a href="">U</a></td>
				<td width="8"><a href="">V</a></td>
				<td width="14"><a href="">W</a></td>
				<td width="8"><a href="">X</a></td>
				<td width="8"><a href="">Y</a></td>
				<td width="20"><a href="">Z</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="17" colspan="6">
		<center>
		<table border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td width="56"><input class="buttonbold" name="submit2"
					type="submit" value="Add"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="submit" value="Edit"></td>
				<td width="56"><input class="buttonbold" name="submit3"
					type="Button" value="Delete"></td>
				<td width="56"><input class="buttonbold" type="submit"
					name="Button"  value="Close"   accesskey="c" ></td>
			</tr>
		</table>
		</center>
	<tr>
		<td></td>
		<td colspan="4">
		<div align="center" class="bolddeepred">
		<div align="center"></div>
		</div>
		<td width="370">
		<td width="10">
	<tr>
</table>
<CENTER>
<table width="50%" border="1" cellspacing="2" cellpadding="2"
	 >
	<tr>
		<td align="center" class="tabledata">&nbsp;</td>
	</tr>
</table>
</CENTER>
<%@ include file="../footer.jsp"%>
</form>
</body>
</html>

<%@ page import="java.io.*,java.util.*" isErrorPage="false"	errorPage="../error/error.jsp"%>
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
 <script language="javascript" src="../JavaScript/Inventory/GoodsReturn.js"></script>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script language="JavaScript">

function redirect(URLStr) 
{ 
	location = URLStr; 
}

    function Add()
	{ 
		document.frm.action="GoodsReturnAdd.jsp";
 	}
	
	
function Edit()
{	
	try
	{	
		 
		obj = findObj("grtno"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
		
		var count;
		count=0;
		coffee1=document.forms[0].grtno;
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
			if (document.forms[0].grtno.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="GoodsReturnEdit.jsp";
			return true;
		}
		else
		{
			alert("Select Only one Goods Return Number");
			return false;
		}
	}		
	catch(err)
	{
		alert(err);
	}
}	


 	function DeleteReturn()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].grtno;
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
			if (document.forms[0].grtno.checked) { count=1;}
		}
		if(count==1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="GoodsReturnDelete.jsp";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Goods return Number");
		    return false;
		}		
 	}
 	

 	function PageBack()
	{
	     //future enhancement
    }
 	
   
 	
</script>

<body    onLoad="loadReturn('0')">
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
				<td width="901" height="31"  >
				<div align="center" class="boldThirteen">GOODS RETURN INFORMATIONS </div>				</td>
			</tr>
			<tr  >
				<td height="31" align="center" class="whiteMedium"  >
				  <table width="68%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="whiteMedium"  >
					<tr>
					  <td>Purchase Type </td>
					  <td>
					  <select name="purchasetype" id="purchasetype"  onChange="loadReturn('0')">
					  	<option value="V">Vendor Purchase</option>
						<option value="D" selected="selected">Direct Purchase</option>
					  </select>
					  </td>
						<td>Month </td>
						<td><span class="boldThirteen"> 
						<select name="month" id="month" onChange="loadReturn('0')">
							<!--<option value="0">All</option> not applicable-->
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select>
						
						 </span></td>
						<td>Year </td>
						<td><span class="boldThirteen"> 
						<select name="year" id="year" onChange="loadReturn('0')">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> 
<script language='JavaScript' type="text/javascript">
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
</script> 
</span></td>
					</tr>
				</table>				</td>
			</tr>
			<tr>
				<td  >
				<div align="center"></div>				</td>
			</tr>
			<tr>
				<td class="bold1"></td>
			</tr>

			<tr class="MRow1">
				<td height="62" valign="top" class="footermenu">
				
				<div id="ReturnTable" style="OVERFLOW:auto;height:200px"  ></div>
						<br>
						<div align="center" id="totRec"></div>
						<br>
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
		<table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('0')">All</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('A')">A</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('B')">B</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('C')">C</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('D')">D</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('E')">E</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('F')">F</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('G')">G</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('H')">H</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('I')">I</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('J')">J</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('K')">K</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('L')">L</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('M')">M</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('N')">N</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('O')">O</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('P')">P</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('Q')">Q</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('R')">R</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('S')">S</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('T')">T</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('U')">U</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('V')">V</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('W')">W</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('X')">X</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('Y')">Y</a></div>				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:loadReturn('Z')">Z</a></div>				</td>
			</tr>
		</table>		</td>
	</tr>
	<tr>
		<td>
		<%
	 	 
	  %>		</td>
	</tr>
	<tr>
		<td height="63">
		<table border="0" align="center" cellpadding="1" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="80"><input type="submit" class="ButtonHead"
					value="Goods Return" onClick="Add()" /></td>
				<td width="80"> 
					<input class='ButtonHead' type='submit' onClick='return Edit()' name='action1' id='action1' value='Replacement'>
					
			  </td>

				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56"><input name="Delete" type="submit"
					class="ButtonHead" id="Delete" value="Delete"
					onclick="return DeleteReturn()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='Delete' >");
		}
		%>


				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c" 
					onClick="redirect( 'InventoryMains.jsp') " /></td>
			</tr>
		</table>		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

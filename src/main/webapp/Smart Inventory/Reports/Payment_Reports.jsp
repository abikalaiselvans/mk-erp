<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
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
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="JavaScript">
    function Add()
	{ 
		document.frm.action="PaymentAdd.jsp";
 	}

	function PaymentEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].pid
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
			if (document.forms[0].pid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="paymentdetails.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	
 	function LoadPayment(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var payment=document.getElementById('payment').value;  
    var url = "../inventory?actionS=INVPurchasePayment&month="+escape(mon)+"&year="+escape(yea)+"&payment="+payment+"&id="+escape(startLetter);
    LoadingTables('PaymentTable');
   	initRequest(url);
   	req.onreadystatechange = PaymentRequest;
    req.open("GET", url, true);
    req.send(null);
}

function PaymentRequest() 
{	
	if(req.readyState == 4) 
    {    	
        ClearTableR('PaymentTable');
        document.getElementById('Edit').disabled=true ;
       	if (req.status == 200)
        {
        	PaymentMessages();
        }
    }
}

function PaymentMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Payments")[0];   
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
	var dt="";
	var ch="";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Purchaseid = batch.getElementsByTagName("Purchaseid")[0];
        var Vendorname = batch.getElementsByTagName("Vendorname")[0];
        var Totalamount = batch.getElementsByTagName("Totalamount")[0];
        var Paidamount = batch.getElementsByTagName("Paidamount")[0];
        var Blanace = batch.getElementsByTagName("Blanace")[0];
        var Status = batch.getElementsByTagName("Status")[0];
		 
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		
		str=str+"<tr>"
		str=str+"<td width='130' class='boldEleven'>"
		
		if(Paidamount.childNodes[0].nodeValue !="0.00")
		{
			ch="<input name='pid' type='checkbox' value='"+Purchaseid.childNodes[0].nodeValue+"' />"	;
			str=str+ch+Purchaseid.childNodes[0].nodeValue
			//"<a href='paymentdetails.jsp?pid="+Purchaseid.childNodes[0].nodeValue+"'>";
			//str = str+"<font color=#000000>"+Purchaseid.childNodes[0].nodeValue+"</font></a>";
		}
		else
		{
		str = str+Purchaseid.childNodes[0].nodeValue;
		}	
		
		str=str+"<td width='130' class='boldEleven'>"+Vendorname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Totalamount.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Paidamount.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Blanace.childNodes[0].nodeValue;
		str = str +"<td width='60' class='boldEleven'>";
		if(Status.childNodes[0].nodeValue =="P")
			str = str +"<font color='Magenta'>Par.Pay</font>";
		else if(Status.childNodes[0].nodeValue =="N")
			str = str +"<font color='red'>Pending....</font>";
		else if(Status.childNodes[0].nodeValue =="Y")
			str = str +"<font color='blue'>Completed</font>";
		
     }
     if(batchs.childNodes.length <=0)
     {
     	str = str+"<td  class='errormessage' colspan='6' height=100><center>Data not found...</center></td>";
     }
     if(batchs.childNodes.length >0)
     	document.getElementById('Edit').disabled=false ;
     else
     	document.getElementById('Edit').disabled=true ;
    
     str=str+"</table>";
     var tb=document.getElementById('PaymentTable');
  	 tb.innerHTML=str  ; 
}
</script>
<body    onLoad="LoadPayment('0')">
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
		<table width="900" height="227" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center"><span class="boldThirteen">Purchase
				Payment Details</span></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td width="843" height="31" class="BackGround">
				<div align="center" class="boldThirteen">Payment for :: <select
					name='payment' onChange="LoadPayment('0')">
					<option value="Purchase">Purchase Order Payment</option>
					<option value="Direct">Direct Purchase Payment</option>
				</select> &nbsp;&nbsp;&nbsp;Month :: <select name="month" id="month"
					onChange="LoadPayment('0')">
					<%@ include file="../JavaScript/Inventory/month.jsp"%>
				</select> &nbsp;&nbsp;&nbsp;Year :: <select name="year" id="year"
					onChange="LoadPayment('0')">
					<%@ include file="../JavaScript/Inventory/year.jsp"%>
				</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script></div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center">
				<table width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr class="BackGround">
						<td class="bold1" width="135">
						<div align="center">Purchase Order Id</div>
						</td>
						<td class="bold1" width="120">
						<div align="center">Vendor Name</div>
						</td>
						<td class="bold1" width="110">
						<div align="center">Total Amount</div>
						</td>
						<td class="bold1" width="85">
						<div align="center">Paid Amount</div>
						</td>
						<td class="bold1" width="123">
						<div align="center">Balance Amount</div>
						</td>
						<td class="bold1" width="127">
						<div align="center">Status</div>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="127" valign="top" class="footermenu">
				<table width="100%">
					<tr>
						<td class="bolddeepblue" align="center">
						<div align="center" id="totRec"></div>
						</td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td>
						<div id="divscroll" style="OVERFLOW:auto;width:920px;height:130px"
							class="boldEleven">
						<div id="PaymentTable"></div>
						</div>
						</td>
					</tr>
				</table>
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
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:LoadPayment('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="PurchasePayment" />
		<input name="actionS" type="hidden" value="INVPurchasePaymentDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="178" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="action1"  value="Add"   accesskey="s"   onclick="Add()" /></td>
				<td width="56" valign="top"><input type="submit"
					class="buttonbold13" name="Edit" id="Edit" value="Edit"
					onclick="PaymentEdit()" /></td>
				<td width="56"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

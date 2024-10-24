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
<script language="javascript"
	src="../../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<script language="javascript" src="../../JavaScript/calendar1.js"></script>
<script language="JavaScript">

    function SalesOrderPrint(query1)
		{	
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			
			var f ="PurchaseOrderPrint_Reports.jsp?ponumber="+query1;
			
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}
   var isIE;
var req;
var names;


function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

//------------Clear Table---------------------------------------
function ClearTable(ctr1)
{
	 var str="<center><font class='errormessage'>Nothing  found ...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    
  	 
}

function PClose()
	{ 
		document.frm.action="../InventoryMain.jsp.jsp";
 	}
	
	function order()
	{ 
	
		document.frm.action="ReceiveOrder.jsp?id=1";
 	}
	
	function EditPurchase()
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
			document.frm.action="PurchaseOrderEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		
 	}	


 function loadPurchase(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../../inventory?actionS=INVPurchase&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
    
	initRequest(url);
	req.onreadystatechange = PurchaseRequest;
    req.open("GET", url, true);
    req.send(null);
}

function PurchaseRequest() {
    if(req.readyState == 4) {    	
        ClearTable('PurchaseTable');
        document.getElementById('Edit').disabled=true;
        
        if (req.status == 200) {		  	
          PurchaseMessages();
        }
    }
}

function PurchaseMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("purchases")[0];   
    var str=""; 
	str=str+"<table width='100%' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
        var Refid = batch.getElementsByTagName("Refid")[0];
        var OrderDate = batch.getElementsByTagName("OrderDate")[0];
        var Branch = batch.getElementsByTagName("Branch")[0];
        var Vendor = batch.getElementsByTagName("Vendor")[0];
        var OrderFrom = batch.getElementsByTagName("OrderFrom")[0];
        var ShippingTo = batch.getElementsByTagName("ShippingTo")[0];
        var onHold = batch.getElementsByTagName("onHold")[0];
        var Status = batch.getElementsByTagName("Status")[0];
        var Payment = batch.getElementsByTagName("Payment")[0];  
        var Received = batch.getElementsByTagName("Received")[0];          
         if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		 
		if(Status.childNodes[0].nodeValue ==='0')
			tid = "<input type='checkbox' name='ponumber' value='"+Refid.childNodes[0].nodeValue+"'><font  class='boldEleven' >"+Refid.childNodes[0].nodeValue+"</font></a>";
		else
			tid = Refid.childNodes[0].nodeValue;		
		
		 
		str=str+"<td width='220' class='boldEleven'>";
		str=str+tid;
		
		str=str+"<td width='130' class='boldEleven'>"+OrderDate.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Vendor.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+OrderFrom.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+ShippingTo.childNodes[0].nodeValue;
		if(onHold.childNodes[0].nodeValue =='0')
			str=str+"<td width='60' class='boldEleven'>Hold";
		else
			str=str+"<td width='60' class='boldEleven'>Passed";
		
		if(Status.childNodes[0].nodeValue =='0')
			str=str+"<td width='60' class='boldEleven' align='center'>Not Received";
		else
			str=str+"<td width='60' class='boldEleven' align='center'>Received";
			
		if(Status.childNodes[0].nodeValue =='1')	
			if(Payment.childNodes[0].nodeValue =='N')
				str=str+"<td width='60' class='boldEleven' align='center'>Pending";
		
		if(Status.childNodes[0].nodeValue =='0')	
			if(Payment.childNodes[0].nodeValue =='N')
					str=str+"<td width='60' class='boldEleven' align='center'>N";
		var file="SalesOrderPrint(\""+Refid.childNodes[0].nodeValue+"\")";
		str=str+"<td width='60' class='boldEleven' align='center'><a href='"+"javascript:"+file+""+"'><font class='boldEleven'><font color='red'>Print";
     }
     if(batchs.childNodes.length <=0)
     {
     	str = str+"<td  class='errormessage' colspan='6' height=100><center>Data not found...</center></td>";
     	
     	document.getElementById('Edit').disabled=true;
     }
     str=str+"</table>";
     var tb=document.getElementById('PurchaseTable');
  	 tb.innerHTML=str  ; 
  	 str="<font  class='bolddeepblue'><b>Total no of Records :: "  + loop+"</b></font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str;
     if (loop==0){
      	
     	document.getElementById('Edit').disabled=true ; 	 
     }else {
      	
     	document.getElementById('Edit').disabled=false ; 	 
     
     }
     
}

 	
 	
</script>

<body    onLoad="loadPurchase('0')">
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
		<table width="900" height="162" border="1" align="center"
			cellpadding="1" cellspacing="1"  >
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<div align="center" class="boldThirteen">Purchase Order
				Informations  
				</div>
				</td>
			</tr>
			<tr class="BackGround">
				<td height="31" class="BackGround">
				<table width="28%" border="0" align="center" cellpadding="1"
					cellspacing="1" class="boldEleven">
					<tr>
						<td class="bolddeeplogin">Month ::</td>
						<td><span class="boldThirteen"> <select name="month"
							id="month" onChange="loadPurchase('0')">
							<%@ include file="../../JavaScript/Inventory/month.jsp"%>
						</select> </span></td>
						<td><span class="bolddeeplogin">Year ::</span></td>
						<td><span class="boldThirteen"> <select name="year"
							id="year" onChange="loadPurchase('0')">
							<%@ include file="../../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
          </script> </span></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="BackGround">
				<div align="center">
				<table width="919" border="0" cellspacing="1" cellpadding="1">
					<tr>
						<td width="203" class="bold1">
						<div align="left">Purchase.No</div>
						</td>
						<td width="122" class="bold1">
						<div align="left">OrderDate</div>
						</td>
						<td width="120" class="bold1">
						<div align="left">Vendor</div>
						</td>
						<td width="123" class="bold1">
						<div align="left">OrderFrom</div>
						</td>
						<td width="97" class="bold1">
						<div align="left">ShippingTo</div>
						</td>
						<td width="56" class="bold1">
						<div align="left">onHold</div>
						</td>
						<td width="45" class="bold1">
						<div align="left">Status</div>
						</td>
						<td width="60" class="bold1">
						<div align="left">Payment</div>
						</td>
						<td width="65" class="bold1">Print View</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td class="bold1"></td>
			</tr>

			<tr>
				<td height="62" valign="top" class="footermenu">
				<table width="899">
					<tr>
						<td width="158" align="center" class="bolddeepblue"></td>
					</tr>
					<tr>
						<td class="bolddeepblue" align="center" bgcolor="#efefef"></td>
					</tr>
					<tr>
						<td class="bolddeepblue">
						<div align="center" id="totRec"></div>
						</td>
					</tr>
					<tr>
						<td>

						<div id="PurchaseTable"
							style="OVERFLOW:auto;width:920px;height:130px" class="boldEleven"></div>

						</td>
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
		<td>
		<table width="900" border="0" align="center" cellpadding="1"
			cellspacing="1"  >
			<tr class="para">
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('')">All</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('A')">A</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('B')">B</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('C')">C</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('D')">D</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('E')">E</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('F')">F</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('G')">G</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('H')">H</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('I')">I</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('J')">J</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('K')">K</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('L')">L</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('M')">M</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('N')">N</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('O')">O</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('P')">P</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Q')">Q</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('R')">R</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('S')">S</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('T')">T</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('U')">U</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('V')">V</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('W')">W</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('X')">X</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Y')">Y</a></div>
				</td>
				<td class="boldEleven">
				<div align="center"><a href="javascript:loadPurchase('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="PurchaseOrder" />
		<input name="actionS" type="hidden" value="INVPurchaseOrderDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="158" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="82" valign="top"><input type="submit" id="Edit"
					class="buttonbold13" value="Print" onClick="return EditPurchase()" /></td>

				<td width="69"><input type="button" class="buttonbold13"
					name="submit"  value="Close"   accesskey="c" 
					onClick="redirect('../InventoryMain.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../../footer.jsp"%></form>
</body>
</html>

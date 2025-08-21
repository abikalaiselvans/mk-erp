var isIE;
var req;
var names;

 
function initRequest(url) 
{
    if (window.XMLHttpRequest) 
    {
        req = new XMLHttpRequest();
    } 
    else if (window.ActiveXObject) 
    {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}
 

function ClearTable(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Data not found...</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function ClearTabler(ctr1)
{
	 var str="<center><br><br><br><font class='bolddeepred'>Total No of Records : 0</font></br></br></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function adminDelete(saleno,invoicenumber)
{
		var r=confirm("ARE YOU SURE YOU WANT TO DELETE THE INVOICE NUMBER IS ..."+invoicenumber);
		if (r==true)
	  	{
	  		var reason=prompt("Reason for delete :: ","For e.g - Value has to be change."); 
	  		var email=prompt("Kindly give the email id for sending informations for deleted invoice","test@test.net"); 
			if (reason!=null && reason!="")
  			{
	  			var d =saleno+"&reason="+reason+"&email="+email;
	  			
	  			document.frm.action=""+d; 
				document.frm.submit(); 
			}	
	  	}
}




function adminReset(saleno,invoicenumber)
{
		var r=confirm("BE CAREFULL, ARE YOU SURE YOU WANT TO RESET THE INVOICE NUMBER IS ..."+invoicenumber);
		if (r==true)
	  	{
	  		var reason=prompt("Reason for Reset :: ","For e.g - Value has to be change."); 
	  		if (reason!=null && reason!="")
  			{
	  			var d =saleno+"&reason="+reason;
	  			document.frm.action=""+d; 
				document.frm.submit(); 
			}	
	  	}
}



function loadSwapSales(startletter) 
{
	console.log(startletter);
	try
	{
		var mon=document.getElementById('month').value;
	    var yea=document.getElementById('year').value;  
	    var customer=document.getElementById('customer').value; 
	    var division=document.getElementById('division').value; 
	    var day=document.getElementById('day').value;
	    var delivery=document.getElementById('delivery').value;
	    var cancel=document.getElementById('cancel').value;
	    var taxtype=document.getElementById('taxtype').value;
	    var url = "../inventoryCustomer?actionS=INVSwapSale&type=1&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&customer="+customer+"&division="+division+"&day="+day+"&delivery="+delivery+"&cancel="+cancel+"&taxtype="+taxtype;
	    console.log(url);
	    initRequest(url);   
	    req.onreadystatechange = DirectSwapRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}

function loadSwapSaless(ctr) 
{
	try
	{
		var mon=document.getElementById('month').value;
	    var yea=document.getElementById('year').value;  
	    var customer=document.getElementById('customer').value; 
	    var division=document.getElementById('division').value; 
	    var day=document.getElementById('day').value;
	    var delivery=document.getElementById('delivery').value;
	    var cancel=document.getElementById('cancel').value;
	    var url = "../inventoryCustomer?actionS=INVSwapSale&type=2&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+ctr.value+"&customer="+customer+"&division="+division+"&day="+day+"&delivery="+delivery+"&cancel="+cancel;
	    initRequest(url);   
	    req.onreadystatechange = DirectSwapRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}


function DirectSwapRequest() 
{
	ClearTable('SwapSalesTable');
    ClearTabler('totRec');
    
	if(req.readyState == 4) 
    {    	
         
        if (req.status == 200) 
        {		  	
        	
          SwapSalesMessages();
        }
    }
}



function SwapSalesMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("directSales")[0];   	    
	var str=""; 
	var invoicename=""; 
	var sumtotal=0;
    str=str+"<table width='100%'  class='table table-bordered'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#000000' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.NO</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>SALE NO</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>DIVISION</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>DATE</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CUSTOMER</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>STATUS</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>VIEW</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>AMOUNT</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PAYMENT</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>COMMITMENT</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>ENTRY BY</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>SALE TYPE</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>DELIVERY</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>LABEL</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Tax-Type</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Discount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Clone Invoice</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Inv Adjst</b></td>";
    str=str+"</tr>";
    //alert("");
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        
	    
	    var Id= batch.getElementsByTagName("salId")[0].childNodes[0].nodeValue;
	    var salNo= batch.getElementsByTagName("salNo")[0].childNodes[0].nodeValue;
	    var salDate= batch.getElementsByTagName("salDate")[0].childNodes[0].nodeValue;
	    var salTotal= batch.getElementsByTagName("salTotal")[0].childNodes[0].nodeValue;
	    var quoCust= batch.getElementsByTagName("quoCust")[0].childNodes[0].nodeValue;
	    var Status= batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
	    var PStatus= batch.getElementsByTagName("PStatus")[0].childNodes[0].nodeValue;
	    var Usertype= batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
	    var PayCommitment= batch.getElementsByTagName("PayCommitment")[0].childNodes[0].nodeValue;
	    var Entryby= batch.getElementsByTagName("Entryby")[0].childNodes[0].nodeValue;
	    var Block= batch.getElementsByTagName("Block")[0].childNodes[0].nodeValue;
	    var Saletype= batch.getElementsByTagName("Saletype")[0].childNodes[0].nodeValue; 
	    var Courier= batch.getElementsByTagName("Courier")[0].childNodes[0].nodeValue;
	    var Courierdiff= batch.getElementsByTagName("Courierdiff")[0].childNodes[0].nodeValue;
	    var Cancel= batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
	    var Division= batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
	    var CPO= batch.getElementsByTagName("CPO")[0].childNodes[0].nodeValue;
	    var Dtcheck= batch.getElementsByTagName("Dtcheck")[0].childNodes[0].nodeValue;
	    var Taxtype= batch.getElementsByTagName("Taxtype")[0].childNodes[0].nodeValue;
	    var Discount= batch.getElementsByTagName("Discount")[0].childNodes[0].nodeValue;
	    var CpyShortName= batch.getElementsByTagName("CpyShortName")[0].childNodes[0].nodeValue;
	    
	    if("Y" == Cancel)
			str=str+"<tr class='MRow0'>";
		else
		{
				if(loop%2==0)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";	
		}
		
	 
		str=str+"<td width='10' class='boldEleven'><font class='boldgreen'>"+(loop+1)+".</font></td> ";
		 
		
		if((Status=="1") || ("Y" == Cancel))
			str=str+"<td width='170' class='boldEleven'><font class='boldgreen'>"+salNo+"</font>";
		else
			str=str+"<td width='150' class='boldEleven'><input type='checkbox' id='salno'  name='salno' value='"+salNo+"'>"+salNo+"</font>";
		
		str=str+"<td width='75'   class='boldEleven'>"+Division+"</td>";
		str=str+"<td width='75'   class='boldEleven'>"+salDate+"</td>";
		str=str+"<td width='200'   class='boldEleven'>"+quoCust.replace("9865043008"," & ")+"</td>";
		console.log(Status)
		
		if(Status=="1")
		{
			str=str+"<td width='50'   class='boldEleven'>Executed</td>";
			
			str=str+"<td width='300'   class='boldEleven'>";
			str=str+"<a href=\"javascript:printProforma('SwapSaleProformaInvoicePrint.jsp?salno="+salNo+"&discount="+Discount+"')\"><font class='boldgreen'>Proforma</font></a>";
			if(Discount== "N")
				invoicename = "DirectSalesPrint_"+CpyShortName+".jsp?salno="+salNo+"&serialyes=true";
			else
				invoicename = "DirectSalesPrint_"+CpyShortName+"_Discount.jsp?salno="+salNo+"&serialyes=true"	;
			
			invoicename = "DirectSalesPrint_"+CpyShortName+".jsp?salno="+salNo+"&serialyes=true&discount="+Discount;
			str=str+"&nbsp;/&nbsp;<a href=\"javascript:Printquery('"+invoicename+"')\"><font class='boldgreen'>Invoice</font></a>";
			str=str+"&nbsp;/&nbsp;<a target='_blank' href='SwapSaleSerialView.jsp?salno="+salNo+"' ><font class='boldgreen'>View </font></a>";
			
			//SMS/MAIL/PDF 
			if("N" == Cancel)
			{
				str=str+"&nbsp; / &nbsp;<a href=\"javascript:onClick=invoiceSendMail('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleSendMail&salesno="+salNo+"','"+salNo+"')\"><font class='boldgreen'>Mail</font></a>";
				//str=str+"&nbsp; / &nbsp;<a href=\"javascript:sendSMS('CustomerSalesInvoiceSendtoSMS.jsp?saleno="+salNo+"')\"><font class='boldgreen'>SMS</font></a>";
				//str=str+"&nbsp; / &nbsp;<a target='_blank' href='../SmartLoginAuth?filename=PDFInvoiceGenerator&actionS=INVPDFInvoiceGenerator&salesno="+salNo+"'><font class='boldgreen'>PDF</font></a>" ;
				//str=str+"&nbsp; / &nbsp;<a href=\"javascript:Printquery('../SmartLoginAuth?filename=Rept_JInvoice&actionS=INVRept_JInvoice&rptfilename=Rept_JInvoice10&subRptfilename1=Rept_JInvoiceSub&reportType=pdf&BRANCHID=20&salno="+salNo+"&serialyes=false')\"><font class='boldgreen'>RTF</font></a>";
			}	
			
			//&&  ("D" == Saletype) 
			if( (Usertype == "F")  &&("N" == Cancel)  )
			{
				if(Dtcheck == "0") 
					str= str+"&nbsp; / &nbsp; <a href=\"javascript:onClick=adminDelete('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleAdminDelete&salesno="+salNo+"','"+salNo+"')\"><font class='boldgreen'>Delete</font></a>";
				
				if(Dtcheck == "0") 
					str= str+"&nbsp; / &nbsp; <a href=\"javascript:onClick=adminReset('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleAdminReset&salesno="+salNo+"','"+salNo+"')\"><font class='boldgreen'>Bill Reset</font></a>";
				if("N" == Cancel)
					if(Dtcheck == "0") 
						str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleCancel&salesno="+salNo+"')\"><font class='boldgreen'>Cancel</font></a>";
				
			}
			else
				str= str+"";
			
				
			
			
			if("Y" == Cancel)
				str = str +" &nbsp;/&nbsp;<img src='../Image/report/cancel.gif'> ";
			
			
			str=str+"</td>";
		}
		else
		{
			str=str+"<td width='50'  class='boldEleven'>Not Executed";
			str=str+"<td width='300' class='boldEleven'><font  class='boldgreen'> -  </font> &nbsp; /&nbsp; <a href=\"javascript:printProforma('SwapSaleProformaInvoicePrint.jsp?salno="+salNo +"')\"><font class='boldgreen'>Proforma</font></a>";
			str=str+"&nbsp;/&nbsp; ";
			str=str+"<a href=\"javascript:onClick=ResetSerialNumber('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleResetSerialNumber&salesno="+salNo +"','"+salNo +"')\"><font  class='boldgreen'>Reset Serialno</font></a>" ;
			
			 //&&  ("D" == Saletype)
			if( (Usertype == "F")  &&("N" == Cancel) )
			{
				//Unblock Invoice
				if( (Block == "Y")   )
					str=str+"&nbsp;&nbsp; / <a href=\"../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleUnBlock&salesno="+salNo +" \"><font class='boldgreen'>Unblock</font></a>" ;
				//Cancel Invoice
				if("N" == Cancel)
					if(Dtcheck == "0") 
						str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleCancel&salesno="+salNo+"')\"><font class='boldgreen'>Cancel</font></a>";
				
			}
			else
				str= str+"";
			
			
			if("Y" == Cancel)
				str = str +" &nbsp;/&nbsp;<img src='../Image/report/cancel.gif'> ";
			 
			
			if( (Usertype == "F") )
			{
				str= str+"&nbsp; / &nbsp; <a href=\"javascript:onClick=adminDelete('../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleAdminDelete&salesno="+salNo+"','"+salNo+"')\"><font class='boldgreen'>Delete</font></a>";
			}	
				
			str=str+"</td>";
		}
		
		 
		
		str=str+"<td width='50'   class='boldEleven'  align='right'> "+salTotal+"</td>";;
		sumtotal =sumtotal +parseFloat(salTotal);
		
		if(PStatus=="Y")
			str=str+"<td width='50'   class='boldEleven'>Paid </td>";
		else
			str=str+"<td width='50'   class='boldEleven'>Pending </td>";
		
		
		//Comitment
		if("N" == Cancel)
		{
			if("-" == PayCommitment)
				str=str+"<td width='100' align=right class='boldEleven'><font  class='boldgreen'>Commitment</font> </td>" ;	
			else if("0" == PayCommitment)	
				str=str+"<td width='100' align=right class='boldEleven'><a href='PaymentCommitmentEdit.jsp?salno="+salNo+"'><font  class='bolddeepred'>Commitment Not available</font></a></td>";		
			else  				
				str=str+"<td width='100' align=right class='boldEleven'><a href='PaymentCommitmentEdit.jsp?salno="+salNo+"'>Commitment available</a></td>";
			 
		}
		else
			str = str +"<td  class='boldEleven' align='right'>&nbsp;</td>";
		
		//Entry By
		str = str +"<td  class='boldEleven' align='right'>&nbsp;"+Entryby+"</td>";
		
		if("S" == Saletype)
			str = str +"<td  class='boldEleven' ><span class='badge'>&nbsp;Swap&nbsp;</span></td>";
		else if("R" == Saletype)
			str = str +"<td  class='boldEleven' bgcolor='#abcdef' ><b><img src='../images/msg-alert.gif' />Sales Return</b></td>";
		else
			str = str +"<td  class='boldEleven' >&nbsp;</td>";
		
		
		//Delivery
		if(("N" == Cancel) &&(Status=="1") )
		{	
			if("-" == PayCommitment)
			{
				if(Courier =="N")
					str = str +"<td  class='boldEleven' align='right'><a target='_blank' href='CourierDetails.jsp?salno="+salNo+"'  ><font class='bolddeepred'>Delivery Pending</font></a></td>";
				else if(Courier =="P")
					str = str +"<td  class='boldEleven' align='right'><a target='_blank' href='CourierDetailsEdit.jsp?salno="+salNo+"'  ><font class='boldgreen'>Progress(modify)</font></a>&nbsp; / &nbsp; <a href='CourierDetailsClose.jsp?salno="+salNo+"'   target='_blank'><font class='boldgreen'>Close</font></a>  </td>";
				else if(Courier =="R")
					str = str +"<td  class='boldEleven' align='right'> <a href='CourierDetailsClose.jsp?salno="+salNo+"'   target='_blank'><font class='bolddeepred'>Reject</font></a></td>";
				else if(Courier =="Y")
					{
						str = str +"<td  class='boldEleven' align='right'><font class='boldgreen'>Delivered</font> in "+Courierdiff+" -days";
						
						str = str +"</td>";
					}	
				
				
			}
			else
			{
				str = str +"<td  class='boldEleven' align='right'><font class='bolddeepred'>Delivery Pending</font></td>";
			}
		}
		else
			str = str +"<td  class='boldEleven' align='right'>&nbsp;</td>";
		
		
		//Label
		if("N" == Cancel)
		{
			if("-" == PayCommitment)
				str = str +"<td  class='boldEleven' align='center'><a target='_blank' href=\"LabelPrinting.jsp?salno="+salNo+"&type=directsales\"><font class='bolddeepred'>Label</font></a></td>";
			else
				str = str +"<td  class='boldEleven' align='right'>&nbsp;</td>";
			
		}
		else
			str = str +"<td  class='boldEleven' align='right'>&nbsp;</td>";
		
		str = str +"<td  class='boldEleven' align='right'><a target='_blank' href='POVerificationPrint.jsp?rowid="+CPO+"'><font class='boldgreen'>"+CPO+"</font></td>";
		str = str +"<td  class='boldEleven' >"+Taxtype+"</td>";
		str = str +"<td  class='boldEleven' >"+((Discount == "Y")? "Yes":"No" )+"</td>";
		str = str +"<td  class='boldEleven' ><a href=\"javascript:onClick=cloneInvoice('"+salNo+"')\"><font class='boldgreen'>Clone</font></a></td>";
		str = str +"<td  class='boldEleven' ><a href='SalesInvoiceAdjustment.jsp?salno="+salNo+"'><font class='boldgreen'>Inv Adjst</font></a></td>";
		
	 
		
		
		str=str+"</tr>";
     }
    
     str=str+"<tr height='25' class='MRow1'><td  colspan='7' align=right class='boldEleven'><b><font Color='red'>Total Amount</font></b></td>";
     str=str+"<td align=right class='boldEleven'><b><font Color='red'>"+sumtotal.toFixed(2)+"</font></b></td>";
     str=str+" <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>";
     str=str+"</tr>";
     str=str+"</table>";
      
     var tb=document.getElementById('SwapSalesTable');
  	 tb.innerHTML=str   ;
  	 str="<br><center><font class='bolddeepred'>Total no of Records : "  + loop+"</font></center><br>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	 
}



function printProforma(query)
{  
	var reason=prompt("Enter The Title ","PROFORMA INVOICE "); 
	query = query+"&title="+reason;
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	newWindow = window.open(query,"subWind",styleStr);
	newWindow.focus( );
}

	

function cancelInvoice(query)
{  
	
	var name=confirm("Are you Sure Confirm to Cancel")
	if (name==true)
	{
		var reason=prompt("Enter The Reason ","Cancelled"); 
		var email=prompt("Kindly give the email id for sending informations for cancelled invoice ","test@test.com"); 
		query = query+"&reason="+reason+"&email="+email;
		location = query;
		
	}	
}

function cloneInvoice(salnumber)
{  
	var name=confirm("Are you Sure Confirm to Clone");
	if (name==true)
	{
		var noofclone=prompt("Enter The No of clone ","1"); 
		noofclone = noofclone - 0;
		if(isNaN(noofclone))
	    {
			alert("The number you specified is invalid");
	    }
		else
		{
			noofclone = 1;
			var newsaleno=prompt("Kindly give the Sales Invoice No ","MKM"); 
			//../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleCancel&salesno="+salNo+"'
			var query = "../SmartLoginAuth?filename=SwapSale&actionS=INVSwapSaleClone&salesno="+salnumber+"&noofclone="+noofclone;
			location = query+"&newsaleno="+newsaleno;
		}
		
		
	}	
}




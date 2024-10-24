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


function loadPOVerification(sval) 
{
	var division=document.getElementById('division').value;
	var customer=document.getElementById('customer').value;
	var day=document.getElementById('day').value;
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var status=document.getElementById('status').value;
    var cancel=document.getElementById('cancel').value;
    var url = "../inventory?actionS=loadPOVerification&startletter="+escape(sval)+"&month="+escape(mon)+"&year="+escape(yea)+"&division="+division+"&customer="+customer+"&day="+day+"&status="+status+"&cancel="+cancel
    initRequest(url);
    req.onreadystatechange = loadPOVerificationRequest;
    req.open("GET", url, true);
    req.send(null);
}
//INVCustomerQuotation

function loadPOVerificationRequest() 
{
    ClearTable('loadPOVerificationTable');  
    ClearTabler('totRec'); 
    if(req.readyState == 4) 
    {    	
        if (req.status == 200) 
        {	
        	loadPOVerificationMessages();
        }
    }
}



function loadPOVerificationMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%' class='table table-bordered' id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    //str=str+"<td class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Reference</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Quotation</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Customer</b></td>";
    //str=str+"<td class='boldEleven' align='center'><b>Division</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Verified</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Print</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>CPO Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR Status</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>PR Inward</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Waiting for</b></td>";
    str=str+"<td class='boldEleven'><b>Progress</b></td> ";
   
    str=str+"</tr>";
    
    var sum =0;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var CPOref = batch.getElementsByTagName("CPOref")[0].childNodes[0].nodeValue;
        var Quotation = batch.getElementsByTagName("Quotation")[0].childNodes[0].nodeValue;
        var customerName = batch.getElementsByTagName("customerName")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Verified = batch.getElementsByTagName("Verified")[0].childNodes[0].nodeValue;
        var CPODate = batch.getElementsByTagName("CPODate")[0].childNodes[0].nodeValue;
        var PR = batch.getElementsByTagName("PR")[0].childNodes[0].nodeValue;
        var PRStatus = batch.getElementsByTagName("PRStatus")[0].childNodes[0].nodeValue;
        var Inward = batch.getElementsByTagName("Inward")[0].childNodes[0].nodeValue;
        var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue;
        var RFC = batch.getElementsByTagName("RFC")[0].childNodes[0].nodeValue;
        var PRModify = batch.getElementsByTagName("PRModify")[0].childNodes[0].nodeValue;
        var Usertype = batch.getElementsByTagName("Usertype")[0].childNodes[0].nodeValue;
        var Cancel= batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
        var Billed= batch.getElementsByTagName("Billed")[0].childNodes[0].nodeValue;
        var  Bar= batch.getElementsByTagName("Bar")[0].childNodes[0].nodeValue;
        
        sum = sum+parseFloat(Amount);
        
        if("Y" == Cancel)
			str=str+"<tr class='MRow0'>";
		else
		{
	        if(RFC == "Y"  || PRModify == "Y" )
	        {
	        	if(RFC == "Y")
	        		str=str+"<tr bgcolor='#5bc0de'>";
	        	
	        	if(PRModify == "Y")
	        		str=str+"<tr bgcolor='#E6BFE4'>";
	        }
	        else
	        {
		        if(loop%2==1)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";		
	        } 
	        
		}
		if("N" == Verified && "N" == Cancel)
			str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value='"+Id+"'>"+(loop+1) + " </td>";
		else
			str=str+"<td class='boldEleven'>"+(loop+1)  + " </td>";
		
		str=str+"<td class='boldEleven'>"+CPOref  + " </td>";
		str=str+"<td class='boldEleven'>"+Quotation + " </td>";
		str=str+"<td class='boldEleven'>"+customerName + " </td>"; 
		str=str+"<td class='boldEleven' align='right'>"+Amount + " </td>"; 
		
		if(Verified=="N")
			str=str+"<td class='boldEleven'><font class='bolddeepred'>Pending</font></td>";
		else
			str=str+"<td class='boldEleven'><font class='boldgreen'>Verified</font></td>";			
		
		
		str=str+"<td class='boldEleven'><a target='_blank' href='POVerificationView.jsp?rowid="+Id+"'><font class='boldgreen'>Print</font></a>";;
		if("N" == Cancel && Billed =="N")
			str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=CPOVerification&actionS=INVCPOVerificationCancel&ponumber="+CPOref+"')\"><font class='boldgreen'>Cancel</font></a>";
		str=str+"</td>";
		
		
		str=str+"<td class='boldEleven'>"+CPODate + " </td>";
		
		if(PR =="-" || PR =="No")
			str=str+"<td class='boldEleven'>&nbsp;</td>";
		else	
			str=str+"<td class='boldEleven'><a target='_blank' href='PurchaseRequestPrint.jsp?Requestno="+PR+"'  ><font class='boldgreen'>"+PR+"</font></a></td>";
		
		if(PRStatus == "Closed")
			str=str+"<td class='boldEleven'><font class='boldgreen'>"+PRStatus + "</font> </td>";
		else
			str=str+"<td class='boldEleven'><font class='bolddeepred'>"+PRStatus + "</font> </td>"; 
		
		
		if(PRStatus == "Closed")
			str=str+"<td class='boldEleven'><font class='boldgreen'>"+Inward + "</font> </td>";
		else
			str=str+"<td class='boldEleven'><font class='boldgreen'>&nbsp;</font> </td>";
			
		
		if("N" == Cancel)
		{	
			if(RFC == "Y")
	    		str=str+"<td class='boldEleven'><a href='CPOModification.jsp?rowid="+Id+"'><img src='../images/inventory/conversion.png' boredr='0'></a>&nbsp;&nbsp;</td>";
			else if(PRModify == "Y")
	    		str=str+"<td class='boldEleven'><a href='CPOModification.jsp?rowid="+Id+"'><img src='../images/inventory/conversion.png' boredr='0'></a>&nbsp;&nbsp;</td>";
			else if(Verified == "N")
	    		str=str+"<td class='boldEleven'><a href='POVerificationAdd.jsp?rowid="+Id+"'><img src='../images/inventory/verification.png' boredr='0'></a>&nbsp;&nbsp;</td>";
			else	
				str=str+"<td class='boldEleven'>&nbsp;</td>";
		}
		else
			str=str+"<td class='boldEleven'><img src='../Image/report/cancel.gif' boredr='1' >&nbsp;&nbsp;</td>";
		
		str=str+"<td class='boldEleven'> ";
	    str=str+"<div class='progress'> ";
	    str=str+"<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+Bar+"' aria-valuemin='0' aria-valuemax='100' style='width:100'> ";
	    str=str+Bar+" %"; 
	    str=str+"</div> ";
	    str=str+"</div> ";
	    str=str+" </td>";
	    
	    str=str+" </tr>";
     }
     str=str+"<tr class='MRow1'>";
     str=str+"<td class='boldEleven' colspan='4' align='right' ><b>Total&nbsp;&nbsp;</b></td>";
     str=str+"<td class='boldEleven' align='right' ><b>"+Round(sum)+"</b></td>";
     str=str+"<td class='boldEleven' colspan='8'>&nbsp;</td>";
      
    
     
     
     str=str+" </tr>";
     
     if(batchs.childNodes.length<1)
     {
     	str= str+"<td colspan='9' height=100 class='bolddeepred'><center>Data not found...</center>";
     }
     str=str+"</table>";

     var tb=document.getElementById('loadPOVerificationTable');
  	 tb.innerHTML=str   
  	 str="<table><tr><td height=10 ><center class='bolddeepred'>Total no of Records :: "  + loop+"</center></table>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
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
  
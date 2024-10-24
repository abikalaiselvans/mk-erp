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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str;
}
  
 
function AssignPaymentCommitment(ctr,billtype) 
{
	var invoicenumber=ctr.value;         
	var url = "../inventory?actionS=INVAssignPaymentCommitment&invoicenumber="+escape(invoicenumber)+"&billtype="+billtype;
	 
	initRequest(url);
    req.onreadystatechange = AssignPaymentCommitmentRequest;
    req.open("GET", url, true);
    req.send(null);
    
}

function AssignPaymentCommitmentRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('AssignPaymentCommitmentDiv');
        if (req.status == 200) 
        {		  	
          AssignPaymentCommitmentMessages();
        }
    }
}


function AssignPaymentCommitmentMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Commitments")[0];
     
	var str=""; 
	var loop;
	str=str+"<table width='98%'  id='myTable' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str=str+"<tr width='25' class='MRow1'>";
	str=str+"<td class='boldEleven'><b>S.No</b></td>";
	str=str+"<td class='boldEleven'><b>Date</b></td>";
	str=str+"<td class='boldEleven'><b>Commitment Amount</b></td>";
	str=str+"<td class='boldEleven'><b>Received Date</b></td>";
	str=str+"<td class='boldEleven'><b>Received Amount</b></td>";
	str=str+"<td class='boldEleven'><b>Status</b></td>";
	str=str+"<td class='boldEleven'><b>Updation Selection</b></td>";
	var count=0;
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{
	    
	    var batch = batchs.childNodes[loop];
        var Date = batch.getElementsByTagName("Date")[0];
        var Amount = batch.getElementsByTagName("Amount")[0];
        var RDate = batch.getElementsByTagName("RDate")[0];
        var RAmount = batch.getElementsByTagName("RAmount")[0];
        var RStatus = batch.getElementsByTagName("RStatus")[0];
        var Id = batch.getElementsByTagName("Id")[0];
        var Next = batch.getElementsByTagName("Next")[0];
        
        
        if(loop%2==1)
			str=str+"<tr width='25' class='MRow1'>";
		else
		    str=str+"<tr width='25'   class='MRow2'>";	
		str=str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>"+Date.childNodes[0].nodeValue+"</td>";  ;
		str=str+"<td class='boldEleven'>"+Amount.childNodes[0].nodeValue+"</td>";;
		str=str+"<td class='boldEleven'>"+RDate.childNodes[0].nodeValue+"</td>";;
		str=str+"<td class='boldEleven'>"+RAmount.childNodes[0].nodeValue+"</td>";;
		str=str+"<td class='boldEleven'>";
		if("Y" == RStatus.childNodes[0].nodeValue)
			str=str+"<font color='blue'> Received...</font>";
		else
			str=str+"<font color='red'> Not Received...</font>";
			
		str=str+"<td class='boldEleven'>";
		if(("N" == RStatus.childNodes[0].nodeValue) && ("N" == Next.childNodes[0].nodeValue))
		{
			str=str+" <input type='checkbox' id='checkboxs' name='checkboxs' value='"+Id.childNodes[0].nodeValue+"'>	"
			count= count+1;
		}
		else if(("N" == RStatus.childNodes[0].nodeValue) && ("Y" == Next.childNodes[0].nodeValue))
			str=str+"<font color='red'>Payment Commitment Postponed...</font>";
		else
			str=str+"<font color='red'> ...</font>";	
	}
    str=str+"</table>";
    var tb=document.getElementById('AssignPaymentCommitmentDiv');
  	tb.innerHTML=str ;  
  	document.getElementById('count').value = count;
}		

  
  
  function PaymentCommitmentCheck()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].checkboxs;
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
			if (document.forms[0].checkboxs.checked) { count=1;}
		}
		if(count==1)
		{			
			return true;
		}
		else
		{
		    alert("Please tick the payment commitment check box");
		    return false;
		}
 	}
	
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

function loadContribution(startletter) 
{
	var ref=document.getElementById('ref').value;         
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value; 
    var day=document.getElementById('day').value;
    var customer=document.getElementById('customer').value;
    
    var url = "../inventory?actionS=INVContribution&month="+escape(mon)+"&ref="+ref+"&year="+escape(yea)+"&txtSer="+startletter+"&day="+day+"&customer="+customer;
	initRequest(url);
	req.onreadystatechange = ContributionRequest;
    req.open("GET", url, true);
    req.send(null);
    
}

function ContributionRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('Contribution');
        ClearTabler('totRec'); 
        if (req.status == 200) 
        {		  	
          ContributionMessages();
        }
    }
}


function ContributionMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
	var loop;
	str=str+"<table width='100%'  id='myTable' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str=str+" <tr class='MRow2'> ";
	str=str+" <td class='boldEleven'><b>S.No</b></td> ";
	str=str+" <td class='boldEleven'><b>Invoice Number</b></td> ";
	str=str+" <td class='boldEleven'><b>Customer</b></td> ";
	str=str+" <td class='boldEleven'><b>Sale Date</b></td> ";
	str=str+" <td class='boldEleven'><b>Staff ID/Staff Name</b></td> ";
	str=str+" <td class='boldEleven'><b>Purchase Amount</b></td> ";
	str=str+" <td class='boldEleven'><b>Actual Sales Amount</b></td> ";
	str=str+" <td class='boldEleven'><b>Sales Amount</b></td> ";
	
	str=str+" <td class='boldEleven'><b>SalePercentage(%) </b></td> ";
	str=str+" <td class='boldEleven'><b>Contribution Amount</b></td> ";
	str=str+" <td class='boldEleven'><b>Contribution(%) </b></td> ";
	str=str+" </tr> ";
	 

	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Saleno = batch.getElementsByTagName("Saleno")[0].childNodes[0].nodeValue ;
        var Empid = batch.getElementsByTagName("Empid")[0].childNodes[0].nodeValue ;
        var Empname = batch.getElementsByTagName("Empname")[0].childNodes[0].nodeValue ;
        var Date = batch.getElementsByTagName("SDate")[0].childNodes[0].nodeValue ;
        var Amount = batch.getElementsByTagName("CAmount")[0].childNodes[0].nodeValue ;
        var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue ;
        var PAmount = batch.getElementsByTagName("PAmount")[0].childNodes[0].nodeValue ;
        var ActualSAmount = batch.getElementsByTagName("ActualSAmount")[0].childNodes[0].nodeValue ;
        var SAmount = batch.getElementsByTagName("SAmount")[0].childNodes[0].nodeValue ;
        var Percentage = batch.getElementsByTagName("CPercentage")[0].childNodes[0].nodeValue ;
        var SalePercentage = batch.getElementsByTagName("SalePercentage")[0].childNodes[0].nodeValue ;
        
        if( (Percentage >=25)   || (Percentage<0))
        {
    		str=str+"<tr width='25' class='MRow4'>";
        }
        else
        {
        	if(loop%2==1)
        		str=str+"<tr width='25' class='MRow1'>";
        	else
        		str=str+"<tr width='25'   class='MRow2'>";
        }	
        str=str+"<td class='boldEleven'>"+(loop+1)+"</td>";
        str=str+"<td class='boldEleven'><a target='_blank' href='SwapSaleSerialView.jsp?salno="+Saleno+"'><font class='boldgreen'>"+Saleno+"</font></a></td>";   	
        str=str+"<td class='boldEleven'>"+Customer+"</td>";
        str=str+"<td class='boldEleven'>"+Date+"</td>";
        str=str+"<td class='boldEleven'>"+Empid+" / " +Empname+"</td>";
        
		str=str+"<td class='boldEleven' align='right'>"+PAmount+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+ActualSAmount+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+SAmount+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+SalePercentage+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+Amount+"</td>";
		str=str+"<td class='boldEleven' align='right'>"+Percentage+"</td>";
		
		
     }
     str=str+"</table>";
     var tb=document.getElementById('Contribution');
  	 tb.innerHTML=str ;  
 	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
 
  	 
}		

  
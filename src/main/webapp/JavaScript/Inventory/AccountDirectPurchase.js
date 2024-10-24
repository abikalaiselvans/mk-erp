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



function AccloadDirectPurchase(startletter) 
{
	try
	{
		 var Accbranch=document.getElementById('Accbranch').value; 
		var mon=document.getElementById('month').value;
		var yea=document.getElementById('year').value;
		var vendor=document.getElementById('vendor').value;
		var division=document.getElementById('division').value;
		var Aflag=document.getElementById('Aflag').value; 
		var url = "../inventoryCustomer?actionS=INVACCDirectPurchase&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&vendor="+vendor+"&division="+division+"&Aflag="+Aflag+"&Accbranch="+Accbranch;
	   	initRequest(url);
	    req.onreadystatechange = AccDirectPurchaseRequest;
	    req.open("GET", url, true);
	    req.send(null); 
	}
	catch(err)
	{
			alert(err)
			
	}
	
}

function AccDirectPurchaseRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('DirectPurchaseTable');  
        ClearTabler('totRec');  
        if (req.status == 200) 
        {		  	
          AccDirectPurchaseMessages();
        }
    }
}


function AccDirectPurchaseMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("directPurchases")[0];   	    
	var str=""; 
	var sum=0;
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Pono = batch.getElementsByTagName("Pono")[0].childNodes[0].nodeValue;
        var Vendor = batch.getElementsByTagName("Vendor")[0].childNodes[0].nodeValue;
        var Podate = batch.getElementsByTagName("Podate")[0].childNodes[0].nodeValue;
        var InvoiceStatus = batch.getElementsByTagName("InvoiceStatus")[0].childNodes[0].nodeValue;   
        var PStatus = batch.getElementsByTagName("PStatus")[0].childNodes[0].nodeValue; 
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue; 
        var NetAmount = batch.getElementsByTagName("NetAmount")[0].childNodes[0].nodeValue;
        var Download = batch.getElementsByTagName("Download")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        
        sum = sum+parseFloat(NetAmount );
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  width='12%' class='boldEleven'>"+Pono;
		str=str+"<td  width='12%' class='boldEleven'>"+Division;
		str=str+"<td  width='12%' class='boldEleven'>"+Branch ;
		str=str+"<td  width='12%' class='boldEleven'>"+Podate ;
		str=str+"<td  width='12%' class='boldEleven'>"+Vendor .replace("98650","&");
		str=str+"<td  width='12%' class='boldEleven' align='right'>"+NetAmount ;
		str=str+"<td  width='12%' class='boldEleven'>"+PStatus ;
		
		if("Y" == InvoiceStatus  )
			str=str+"<td  width='12%' class='boldEleven'><font class='boldgreen'>Received</font</td>"
		else
			str=str+"<td  width='12%' class='boldEleven'><font class='bolddeepred'>Not Received</font</td>"
    	
		if("Y" == InvoiceStatus  )
			str=str+"<td  width='12%' class='boldEleven'>&nbsp;</td>"
		else
			str=str+"<td  width='12%' class='boldEleven'><a href='AccDirectPurchaseStatusUpdate.jsp?gdreceiveno="+Pono +"'><font class=boldgreen>Accept</font></a>" ;
		
		str=str+"<td  width='12%' class='boldEleven'><a href=\"javascript:DCUpload('"+Pono +"')\"><font class=boldgreen>Upload Invoice</font></a>" ;
		var p = Pono ;
		p = replaceAll("/","_",p);
		
		if(Download =="Y")
			str=str+"<td  width='12%'class='boldEleven'><a target='_blank' href='../uploadfiles/DCIMAGE/"+p+".pdf' download='"+Pono +".pdf' ><font class='boldgreen'>download</font></a> ";
		else
			 str=str+"<td  width='12%' >&nbsp;</td>";
		str=str+"</tr>"; 
		 
     }
     str=str+"<tr  class='MRow2'><td >&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'class='boldEleven' align='right'><b>Total : </b></td>";
     str=str+"<td width='12%'class='boldEleven' align='right'><b>"+sum+"</b></td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
     str=str+"<td width='12%'>&nbsp;</td>";
    
     str=str+"</table>";
     var tb=document.getElementById('DirectPurchaseTable');
  	 tb.innerHTML=str   
 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font class='bolddeepred'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	
  	 
}

 
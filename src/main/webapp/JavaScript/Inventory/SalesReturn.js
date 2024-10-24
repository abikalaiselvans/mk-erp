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



function loadSalesReturn(startletter) 
{
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var returnType=document.getElementById('returnType').value;
	var url = "../inventory?actionS=INVSalesReturn&month="+month+"&year="+year+"&id="+escape(startletter)+"&returnType="+escape(returnType);
	initRequest(url);
	req.onreadystatechange = LoadSalesReturnRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LoadSalesReturnRequest() 
{
	 
	ClearTable('ReturnTable');  
    ClearTabler('totRec');  
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	LoadSalesReturnMessages();
        }
    }
}

function LoadSalesReturnMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Returns")[0];    
	str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	var dt="";
	var ch="";
	var returnType=document.getElementById('returnType').value;
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Returnno = batch.getElementsByTagName("DCNO")[0];
		var Returndate = batch.getElementsByTagName("DCdate")[0];
		var Salesno = batch.getElementsByTagName("CustName")[0];
		var Itemname = batch.getElementsByTagName("ReturnStatus")[0];
		var SalesNo = batch.getElementsByTagName("SalesNo")[0];
		var sano=SalesNo.childNodes[0].nodeValue;
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td width='100' class='boldEleven'>"+Returnno.childNodes[0].nodeValue;
		str=str+"<td width='112' class='boldEleven'>"+Returndate.childNodes[0].nodeValue;
		str=str+"<td width='128' class='boldEleven'>"+Salesno.childNodes[0].nodeValue;
		status=Itemname.childNodes[0].nodeValue;
		link="";
		if(status==true){
			link="<a  href='SalesReturnView.jsp?dcno="+sano+"&returnType="+returnType+"'><font class='boldgreen'>View</font></a>";
		}
		else {
			link="<a  href='SalesReturnView.jsp?dcno="+sano+"&returnType="+returnType+"'><font class='boldred'>Return</font></a>";
		}
		str = str +"<td width='80' class='boldEleven'>"+status
		str = str +"<td width='100' class='boldEleven' align='center'>"+link;
	  }
	  
	 str=str+"</table>";
     var tb=document.getElementById('ReturnTable');
  	 tb.innerHTML=str  ; 	
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  
}





function LoadSaleNumber() 
{
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var returnType=document.getElementById('returnType').value;
	var url = "../inventory?actionS=INVSalesNumber&returnType="+escape(returnType);
	url = url +"&month="+month+"&year="+year;
	initRequest(url);
	req.onreadystatechange = SaleNumberRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SaleNumberRequest() 
{
    if(req.readyState == 4) 
    {  
    	var dropdown=document.getElementById('saleno');
    	for( i=0;i<dropdown.length;i++)
    	  	dropdown.remove(0);
    	dropdown.options[0]=new Option('Select','0');
    	if (req.status == 200) 
    	{		  	
         	SaleNumberMessages();
        }
    }
}

function SaleNumberMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Optionss")[0];   
	var dropdown=document.getElementsByName('saleno')[0];
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Optionval = batch.getElementsByTagName("Optionval")[0];
        var Optiondis = batch.getElementsByTagName("Optiondis")[0];
        dropdown.options[loop]=new Option(Optionval.childNodes[0].nodeValue,Optiondis.childNodes[0].nodeValue);
	}
}



function SelectAll()
{	
	var nocheck=document.forms[0].rowid;
	var val=document.getElementById("SAll").checked
	if(val==false){
		for(i=0;i<nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<nocheck.length;++ i)
		{		
			nocheck[i].checked=true;
		}
	}
	
}



function LoadSaleNumberItems() 
{
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var returnType=document.getElementById('returnType').value;
	var saleno=document.getElementById('saleno').value;
	var url = "../inventory?actionS=INVSalesNumberItems&returnType="+escape(returnType)+"&month="+month+"&year="+year+"&saleno="+saleno;
	initRequest(url);
	req.onreadystatechange = SaleNumberItemsRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SaleNumberItemsRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	SaleNumberItemsMessages();
        }
    }
}


function SaleNumberItemsMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("Records")[0];   
	var str = "<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str = str+"<tr class='MRow1'>";
	str = str+"<td class='boldThirteen'><b>S.No</b></td>";
	str = str+"<td class='boldThirteen'><b>Type</b></td>";
	str = str+"<td class='boldThirteen'><b>Item / Product</b></td>";
	str = str+"<td class='boldThirteen'><b>Serial No</b></td>";
	str = str+"<td class='boldThirteen'><b>Warranty</b></td>";
	str = str+"<td class='boldThirteen'><b>Return  <input type='checkbox' name='SAll' id='SAll' onClick='SelectAll()'> Select All</b></td>";
	str = str+"</tr>";
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
		buttonEnable('Submit');
		var batch = batchs.childNodes[loop];
	    var Column1 = batch.getElementsByTagName("Column1")[0].childNodes[0].nodeValue;
	    var Column3 = batch.getElementsByTagName("Column3")[0].childNodes[0].nodeValue;
	    var Column4 = batch.getElementsByTagName("Column4")[0].childNodes[0].nodeValue;
	    var Column5 = batch.getElementsByTagName("Column5")[0].childNodes[0].nodeValue;
	    var Column6 = batch.getElementsByTagName("Column6")[0].childNodes[0].nodeValue;
	    var Column7 = batch.getElementsByTagName("Column7")[0].childNodes[0].nodeValue;
	    if(loop%2 == 0)
	    	str = str+"<tr class='MRow1'>";
	    else
	    	str = str+"<tr class='MRow2'>";
	   
	   	str = str+"<td class='boldEleven'>"+(loop+1)+"</td>";
	  	str = str+"<td class='boldEleven'>"+Column4+"</td>";
		str = str+"<td class='boldEleven'>"+Column3+"</td>";
		str = str+"<td class='boldEleven'>"+Column5+"</td>";
		str = str+"<td class='boldEleven'>"+Column6+"</td>";
		str = str+"<td class='boldEleven'>";
		var fg="Y";
		if(Column7 =="Y")
			str = str +" Y ";
		else	
			str = str +"<input  type='checkbox' id='rowid' name='rowid' value='"+Column1+"' />"
		
		str = str +"</td>";
		str = str +"</tr>";
		
	}
	
	
	if(batchs.childNodes.length<1)
	  	str = str +"<td colspan='5' class='boldEleven'>Data not found...";
	 str=str+"</table>";
	
	 if(batchs.childNodes.length<=0)
	 {
	 	document.getElementById('Submit').disabled = true;
	 	
	 }	
	 else
	 {
	 	document.getElementById('Submit').disabled = false;
	 	
	 }	
	 var tb=document.getElementById('ReturnTable');
  	 tb.innerHTML=str  ; 	 
	 
}
 
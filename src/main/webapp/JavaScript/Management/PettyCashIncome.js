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
 
 
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 
 
function LoadPettyCashIncome(startLetter)
{
	var branch = document.getElementById('branch').value;
	var day = document.getElementById('day').value;
	var month = document.getElementById('month').value;
	var year = document.getElementById('year').value;
	var url = "../management?actionS=LoadPettyCashIncome&startLetter="+escape(startLetter)+"&branch="+branch+"&day="+day+"&month="+month+"&year="+year;  
	initRequest(url);
   	req.onreadystatechange = LoadPettyCashIncomeRequest;
    req.open("GET", url, true);
    req.send(null);    
}	
 

function LoadPettyCashIncomeRequest()
 {
     
    if(req.readyState == 4) 
    {
        ClearTable('divTable');
		ClearTabler('totRec');  
        if (req.status == 200) 
        {
        	LoadPettyCashIncomeMessage();
        }
    }
}

function LoadPettyCashIncomeMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";  
    str=str+" <tr class='MRow1'> ";
    str=str+"<td class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Refno</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Date</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Description</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Amount</b></td>";
    str=str+"<td class='boldEleven' align='center'><b>Entry</b></td>";
    
    
    str=str+" </tr>"; 
    var sum=0;
    for(loop=0; loop<batchs.childNodes.length; loop++)
     {
	    var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
        var Refno = batch.getElementsByTagName("Refno")[0].childNodes[0].nodeValue;
        var Branch = batch.getElementsByTagName("Branch")[0].childNodes[0].nodeValue;
        var IDate = batch.getElementsByTagName("IDate")[0].childNodes[0].nodeValue; 
        var Amount = batch.getElementsByTagName("Amount")[0].childNodes[0].nodeValue; 
        var Description = batch.getElementsByTagName("Description")[0].childNodes[0].nodeValue;
        var Entry = batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
        
        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
        	
       	str=str+"<td class='boldEleven'><input type='checkbox' name='rowid' id='rowid' value="+Rowid+">"+(loop+1)+"</td>";
       	str=str+"<td class='boldEleven'>"+Refno+"</td>";
        str=str+"<td class='boldEleven'>"+Branch+"</td>";
        str=str+"<td class='boldEleven'>"+IDate+"</td>";
        str=str+"<td class='boldEleven'>"+Description+"</td>";
        str=str+"<td class='boldEleven' align='right'>"+Amount+"</td>";
        str=str+"<td class='boldEleven'>"+Entry+"</td>";
        sum = sum +parseFloat(Amount);
		str=str+"</tr>";
     }
     str=str+"<tr class='MRow1'>";
     str=str+"<td class='boldEleven' colspan='5' align='right'><font class='bolddeepred'>Total</font></td>";
     str=str+"<td class='boldEleven'  align='right'><font class='bolddeepred'>"+sum+"</font></td><td>&nbsp;</td>";
     str=str+"</tr>";
 	 str=str+"</table>";     
  	 var tb=document.getElementById('divTable');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML="<center><font class='bolddeepred'>Total no of Staffs :: "+batchs.childNodes.length+"</font></center>"; 
 
     
}  


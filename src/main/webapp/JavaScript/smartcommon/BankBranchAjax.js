var isIE;
var req;
var names;
 
function initRequest(url) 
{
	if (window.XMLHttpRequest) 
		alert("1");
	else
		alert("2")
		
		
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

function  loadBankBranch(search) 
{
	var bank = document.getElementById('bank').value;
	var url = "../SmartCommonAjax?actionS=loadBankBranch&search="+search+"&bank="+bank;
	initRequest(url);
	req.onreadystatechange = BankBranchRequest;
    req.open("GET", url, true);
    req.send(null);
   
}

function BankBranchRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('BankTable');
        ClearTabler('totrec');
        if (req.status== 200) 
        {		  	
        	BankBranchMessages();
        }
    }
}

function BankBranchMessages() 
{	 
	var batchs = req.responseXML.getElementsByTagName("Rowss")[0];  
	 
    var str=""; 
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    str=str+"<tr class='MRow1'>";
    str=str+"<td   class='boldEleven' align='center'><b>S.No</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Name</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>IFSC</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Branch</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Address</b></td>";
    str=str+"<td   class='boldEleven' align='center'><b>Contact</b></td>";
    str=str+"</tr>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var IFSC = batch.getElementsByTagName("IFSC")[0].childNodes[0].nodeValue;
	    var MCR = batch.getElementsByTagName("MCR")[0].childNodes[0].nodeValue;
	    var BName = batch.getElementsByTagName("BName")[0].childNodes[0].nodeValue;
	    var Address = batch.getElementsByTagName("Address")[0].childNodes[0].nodeValue;
	    var Contact = batch.getElementsByTagName("Contact")[0].childNodes[0].nodeValue;
	     
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='100' class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"' />"+(loop+1)+".</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+Name+"</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+IFSC+"</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+BName+"</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+Address+"</td>";
		str=str+"<td width='100' class='boldEleven'>&nbsp;"+Contact+"</td>";
		  
		
    }
   
    if(batchs.childNodes.length<1)
      	str=str+"<tr class='MRow1'><td class='bolddeepred'><center>Data not found...</center></td></tr>";
     	
    str=str+"</table>";
     var tb=document.getElementById('BankTable');
  	 tb.innerHTML=str  ; 
  	  tb=document.getElementById('totrec');
  	 tb.innerHTML= " <center><font class='bolddeepred'>Total No of Record : "+batchs.childNodes.length  +"</font></center>"; 
  	
  	 
  	
}

  
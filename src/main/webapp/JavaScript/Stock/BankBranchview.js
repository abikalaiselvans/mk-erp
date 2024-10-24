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

function ClearTable(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function LoadBankBranch(startletter) 
{	
	var bankgroup=document.getElementById('bankgroup').value;
	var url = "../Stock?actionS=LoadBankBranch&startletter="+escape(startletter)+"&bankgroup="+bankgroup;
   	initRequest(url);
    req.onreadystatechange = BankBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
function BankBranchRequest() {
    if(req.readyState == 4) {
        Clear('divscroll');
        var tb=document.getElementById('totalrecord');
  	 	tb.innerHTML= "";
        if (req.status == 200) 
        {
          BankBranchMessages();
        }
    }
}
function BankBranchMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Branchs")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Branchid = batch.getElementsByTagName("Branchid")[0];
        var Shortname = batch.getElementsByTagName("Shortname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];
        var Branchcode = batch.getElementsByTagName("Branchcode")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];
        var Email = batch.getElementsByTagName("Email")[0];
        var Swift = batch.getElementsByTagName("Swift")[0];
        
       
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";
		  
		str=str+"<td  class='boldEleven'><input  name='BankBranchid'  id='BankBranchid'  type='checkbox' value='"+Branchid.childNodes[0].nodeValue+"' /> "+(loop+1);
		str=str+"<td  class='boldEleven'>"+Shortname.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Branchcode.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Email.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Swift.childNodes[0].nodeValue;
	 
	 }
     str=str+"</table>";
     
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str  ; 
  	 
  	 tb=document.getElementById('totalrecord');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::"+batchs.childNodes.length +"</font>"; 
  	 
}

 
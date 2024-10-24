var isIE;
var req;
var names;
var target1;
var ctrl;
 
 
function init() 
{

  var search=document.getElementById("searchstring").value; 	
  var Flag=document.getElementById("Flag").checked;
  var month =document.getElementById("month").value; 	
  var year =document.getElementById("year").value; 	
  var branch =document.getElementById("branch").value; 	
  
  var query="";
  if(Flag==true)
  		query ="../Common?actionS=commonsearch&search="+search+"&month="+month+"&year="+year+"&Flag=Y&branch="+branch;
  else
		query ="../Common?actionS=commonsearch&search="+search+"&month="+month+"&year="+year+"&Flag=N&branch="+branch;
  
  makeGetRequest(query) 
}
function createRequestObject() 
{
    var tmpXmlHttpObject;   
    if (window.XMLHttpRequest) 
    {     
        tmpXmlHttpObject = new XMLHttpRequest();	
    }
    else if (window.ActiveXObject) 
    {     
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }    
    return tmpXmlHttpObject;
}
var http = createRequestObject();
function makeGetRequest(wordId) 
{ 
 	http.open('get', wordId);
	http.onreadystatechange = processResponse;
    http.send(null);
}
function processResponse() 
{ 
    if(http.readyState == 4){        
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;		
    }
}





function initinvoice(ctr)
{
 
  	var invoiceno=document.getElementById(ctr).value;
  	var query="Rept_contributionSwapSaleSerialView.jsp?salno="+invoiceno; 
  	alert("Please Conform your Invoice details...");	
  	document.getElementById('invoicedescription').innerHTML="<font class='boldred'><b><center>Please wait the detailed sales invoice loading after you are verify for that...</center></font>";
 	makeGetRequestinvoice(query) 
}
function makeGetRequestinvoice(wordId) 
{ 
 	http.open('get', wordId);
	http.onreadystatechange = processResponseinvoice;
    http.send(null);
}
function processResponseinvoice() 
{ 
    if(http.readyState == 4){        
        var response = http.responseText;
        document.getElementById('invoicedescription').innerHTML = response;		
    }
}

 
 
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
function makeGetRequest(ctr) 
{
	var f ='OnlineTestLoad.jsp?id=' + ctr.value;
	http.open('post', f,true);
    http.onreadystatechange = processResponse;
    http.send(null);
}
 
 
 function processResponse() 
{
    if(http.readyState == 4)
    {
        var response = http.responseText;
        document.getElementById('loadonlineTest').innerHTML = response;
    }
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
   
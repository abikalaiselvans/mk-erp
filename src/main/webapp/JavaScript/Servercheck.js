 
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
        
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function loadServer()
{
 	var url = "../Common?actionS=ServerCheckSession";
 	initRequest(url);
    req.onreadystatechange = ServerRequest;
    req.open("GET", url, true);
    req.send(null);
    
    
}
 
function ServerRequest()
 {
    if(req.readyState == 4) {
         if (req.status == 200) {
          ServerMessage();
          
        }
    }
}

function ServerMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Sessions")[0];   	    
	var str=""; 
    var loop=0;
    var batch = batchs.childNodes[loop];
    var Flag = batch.getElementsByTagName("Flag")[0];
    var username = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
    
    if(Flag.childNodes[0].nodeValue == "Y")
    {
    	alert("Hi "+username+", Now SERVER COOLING  time, Please logout with in 10 minutes...");
    }	
    
 }
 
 
 
 function loadMailServer()
{
 	/*
 	var url = "Common?actionS=MailServerSession";
 	initRequest(url);
    req.onreadystatechange = MailServerRequest;
    req.open("GET", url, true);
    req.send(null);
    */
}
 
function MailServerRequest()
 {
    if(req.readyState == 4) 
    {
         if (req.status == 200) 
         {
        	 MailServerMessage();
        }
    }
}


function MailServerMessage() 
{	
    var batchs = req.responseXML.getElementsByTagName("Sessions")[0];   	    
	var str=""; 
    var loop=0;
    var batch = batchs.childNodes[loop];
    var Flag = batch.getElementsByTagName("Flag")[0];
    if(Flag.childNodes[0].nodeValue == "Y")
    {
    	alert("Mail Server Activated...");
    }	
 }
 


function loadNotification()
{
	var url = "Common?actionS=loadNotification";
	initRequest(url);
	req.onreadystatechange = NotificationRequest;
	req.open("GET", url, true);
	req.send(null);
}

function NotificationRequest()
{
   if(req.readyState == 4) 
   {
        if (req.status == 200) 
        {
        	NotificationMessage();
       }
   }
}


function NotificationMessage() 
{	
   var batchs = req.responseXML.getElementsByTagName("Rows")[0];   	    
	var str=""; 
   var loop=0;
   var batch = batchs.childNodes[loop];
   var Flag = batch.getElementsByTagName("Flag")[0].childNodes[0].nodeValue;
   var Message = batch.getElementsByTagName("Message")[0].childNodes[0].nodeValue;
   
   if(Flag == "Y")
   {
   		alert(Message);
   }	
}



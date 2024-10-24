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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 var divname="";
 var buttonname="";
 var serialname="";
 


function LoadAMCSerialNumber(control,div,tablename,fieldname,button) 
{
	var value =document.getElementById(control).value;
	{
		divname=div;
		buttonname= button;
		serialname = control;
		var url = "../AMC?actionS=LoadAMCSerialnumber&tablename="+escape(tablename);
		url = url +"&fieldname="+fieldname+"&search="+value;
		 	initRequest(url);
		req.onreadystatechange = AMCSerialNumberRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }
	
}



function AMCSerialNumberRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{	
    		AMCSerialNumberMessages();
        }
    }
}

function AMCSerialNumberMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("AMCs")[0]; 
		if(batchs.childNodes.length<1)
	 	{
	 		alert("Check Serail number...");
	 	}
	 	//setSerialno
		var str="<select name='select' id='select' size='10' class ='bolddeepgreen' ondblclick='LoadAMCcustomerinfo(this)'>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Serial= batch.getElementsByTagName("Serial")[0];
	    	str = str+"<option value='"+Serial.childNodes[0].nodeValue+"'>"+Serial.childNodes[0].nodeValue+"</option>"; 
	    }	
	 	str= str+"</select>";
	 	var tb=document.getElementById(divname);
  	 	tb.innerHTML=str  ; 
  	 	
 }
 
 

  
 function  LoadAMCcustomerinfo(ctr)
 {
	var serialnumber = ctr.value;
	var url = "../AMC?actionS=LoadAMCcustomerinfo&serialnumber="+escape(serialnumber);
	initRequest(url);
	req.onreadystatechange = customerinfoRequest;
	req.open("GET", url, true);
	req.send(null);
	
 }
 	
function customerinfoRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{	
    		customerinfoMessages();
        }
    }
}

function customerinfoMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Customers")[0]; 
		var str="<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    	str = str+"<tr height=20 bgcolor='#ffffff'>";
		str = str+"<td class='boldEleven'><b>Machine Type"; 	
		str = str+"<td class='boldEleven'><b>Customer Group"; 	
		str = str+"<td class='boldEleven'><b>Customer Name"; 	
		str = str+"<td class='boldEleven'><b>Street"; 	
		str = str+"<td class='boldEleven'><b>City"; 	
		str = str+"<td class='boldEleven'><b>State"; 	
		str = str+"<td class='boldEleven'><b>Phone"; 	
		str = str+"<td class='boldEleven'><b>Mobile";
		str = str+"<td class='boldEleven'><b>Email"; 	
		str = str+"<td class='boldEleven'><b>Description"; 
		str = str+"<td class='boldEleven'><b>Starting Date"; 
		str = str+"<td class='boldEleven'><b>Ending Date"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Type= batch.getElementsByTagName("Type")[0];
	    	Group= batch.getElementsByTagName("Group")[0];
	    	Name= batch.getElementsByTagName("Name")[0];
	    	Street= batch.getElementsByTagName("Street")[0];
	    	City= batch.getElementsByTagName("City")[0];
	    	State= batch.getElementsByTagName("State")[0];
	    	Phone= batch.getElementsByTagName("Phone")[0];
	    	Mobile= batch.getElementsByTagName("Mobile")[0];
	    	Email= batch.getElementsByTagName("Email")[0];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Category= batch.getElementsByTagName("Category")[0];
	    	Descs= batch.getElementsByTagName("Descs")[0];
	    	Start= batch.getElementsByTagName("Start")[0];
	    	End= batch.getElementsByTagName("End")[0];
	    	Enddate= batch.getElementsByTagName("Enddate")[0];
	    	
	    	
	    	
			str = str+"<tr height=20 bgcolor='#ffffff'><td class='boldEleven'>"+Type.childNodes[0].nodeValue;
			str = str+"<td class='boldEleven'>"+Group.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Name.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Street.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+City.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+State.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Phone.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Mobile.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Email.childNodes[0].nodeValue; 	
			str = str+"<td class='boldEleven'>"+Descs.childNodes[0].nodeValue;
			str = str+"<td class='boldEleven'>"+Start.childNodes[0].nodeValue;
			str = str+"<td class='boldEleven'>"+End.childNodes[0].nodeValue;
			alert("AMC/Warranty Ending Date :"+End.childNodes[0].nodeValue );
			
			
			var id=Id.childNodes[0].nodeValue;
			setOptionValue('customerid',id);
			document.getElementById('cperson').value=Name.childNodes[0].nodeValue;
			document.getElementById('cmobile').value=Mobile.childNodes[0].nodeValue;
			document.getElementById('caddress').value=Street.childNodes[0].nodeValue;
			document.getElementById('cemail').value=Email.childNodes[0].nodeValue;
			document.getElementById('endingdateandtime').value=Enddate.childNodes[0].nodeValue ;
			for (i = 0; i < 3; i++)
				if (document.frm.complainttype[i].value == Category.childNodes[0].nodeValue)
					document.frm.complainttype[i].checked = true;
			
	    }	
	 	str= str+"</table>";
	 	var tb=document.getElementById('customerinfo');
  	 	tb.innerHTML=str  ; 
  	 	
 }
  
 
 
 
 
 
 
 
 
function LoadAMCSerialNumberCustomerwise(ctr) 
{
	var value =document.getElementById(ctr).value;
	{
		var url = "../inventory?actionS=LoadAMCSerialNumberCustomerwise&id="+escape(value);
		initRequest(url);
		req.onreadystatechange = AMCSerialNumberCustomerwiseRequest;
	    req.open("GET", url, true);
	    req.send(null);
	 }
	
}



function AMCSerialNumberCustomerwiseRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{	
    		AMCSerialNumberCustomerwiseMessages();
        }
    }
}

function AMCSerialNumberCustomerwiseMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("AMCs")[0]; 
		if(batchs.childNodes.length<1)
	 	{
	 		alert("Check Serail number...");
	 	}
	 	var str="<select name='select' id='select' size='10' class ='bolddeepgreen' ondblclick='LoadAMCcustomerinfo(this)'>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Serial= batch.getElementsByTagName("Serial")[0];
	    	str = str+"<option value='"+Serial.childNodes[0].nodeValue+"'>"+Serial.childNodes[0].nodeValue+"</option>"; 
	    }	
	 	str= str+"</select>";
	 	var tb=document.getElementById("serialnumberlist");
  	 	tb.innerHTML=str  ; 
  	 	
  	 	var tb1=document.getElementById("customerinfo");
  	 	tb1.innerHTML=""  ; 
  	 	
 }
 
 
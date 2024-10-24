
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
 
 
function loadCustomer(startLetter) 
{
	var customergroup = document.getElementById('customergroup').value
	var url = "../inventory?actionS=loadCustomer&type=1&search="+escape(startLetter)+"&customergroupid="+customergroup;
	initRequest(url);
   	req.onreadystatechange = loadCustomerRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadCustomer()
{
	var customergroup = document.getElementById('customergroup').value
	var search = document.getElementById('search').value 
	var url = "../inventory?actionS=loadCustomer&type=2&search="+escape(search)+"&customergroupid="+customergroup;
	initRequest(url);
   	req.onreadystatechange = loadCustomerRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function loadCustomerRequest() 
{	
	try
	{
		if(req.readyState == 4) 
	    {    	
			ClearTable('ctable');
			ClearTabler('totalrecord');
			if (req.status == 200)
	        {
				loadCustomerMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err);
	}
}


function loadCustomerMessages() 
{
	try
	{
		var str=""; 
		var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
		str=str+"<tr class='MRow1'>";
		str=str+"<td  class='boldEleven'><center><b>S.NO</b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>Customer Name</b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>City </b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>District </b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>State </b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>Pincode </b></center></td>";
		str=str+"<td  class='boldEleven'><center><b>Mobile </b></center></td>";
		str=str+"</tr>";
		 
		for(loop=0; loop<batchs.childNodes.length; loop++) 
	    {
		    var batch = batchs.childNodes[loop];
	        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
		    var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;
		  /*  var Customer = batch.getElementsByTagName("Customer")[0].childNodes[0].nodeValue;
		    var Add1 = batch.getElementsByTagName("Add1")[0].childNodes[0].nodeValue;
		    var Add2 = batch.getElementsByTagName("Add2")[0].childNodes[0].nodeValue;
		    var Add3 = batch.getElementsByTagName("Add3")[0].childNodes[0].nodeValue;
		  */  var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
		    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
		    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
		    var Country = batch.getElementsByTagName("Country")[0].childNodes[0].nodeValue;
		    var Pincode = batch.getElementsByTagName("Pincode")[0].childNodes[0].nodeValue;
		    var Areacode = batch.getElementsByTagName("Areacode")[0].childNodes[0].nodeValue;
		    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
		    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
		    
		    
			if(loop%2==0)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
			 
			str=str+"<td  class='boldEleven'><input name='Rowid'  id='Rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+". </td>"	;
			str=str+"<td  class='boldEleven'>"+Group+"</td>";
			str=str+"<td  class='boldEleven'>"+City+"</td>";
			str=str+"<td  class='boldEleven'>"+District+"</td>";
			str=str+"<td  class='boldEleven'>"+State+"</td>";
			str=str+"<td  class='boldEleven'>"+Pincode+"</td>";
			str=str+"<td  class='boldEleven'>"+Mobile+"</td>";
			 
	     }
	     
	       str=str+"</table>";
	
	     var tb=document.getElementById('ctable');
	  	 tb.innerHTML=str  ; 
	  	
	  	 tb=document.getElementById('totalrecord');
	 	 tb.innerHTML="<br><font class='bolddeepred'>Total no of Records :: "+batchs.childNodes.length+"</font><br>"  ; 
	}
	catch(err)
	{
		alert(err);
	}
} 




function  loadAdvanceAmountPrint(salno)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="ServiceBillingPrint.jsp?salno="+salno ;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}

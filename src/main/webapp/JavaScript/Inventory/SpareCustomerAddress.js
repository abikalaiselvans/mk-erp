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


function LoadSpareCustomerAddress(startLetter)
{
	try
	{
	 	var customer = document.getElementById('customer').value;
		var url = "../inventory?actionS=LoadSpareCustomerAddress&startLetter="+escape(startLetter)+"&customer="+customer;
		initRequest(url);
		req.onreadystatechange=SpareCustomerAddressRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 function SpareCustomerAddressRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	    	
	        ClearTable('divscroll');  
	        ClearTabler('totRec');  
	    	if (req.status == 200) 
	        {		  	
	    		SpareCustomerAddressMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
 
 
function SpareCustomerAddressMessages() 
{	 
 try
 {
	  
	 var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	 var str=""; 
	 str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	 str=str+"<tr class='MRow1'>";
	 str=str+"<td  class='boldEleven'><center><b>S.No</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>CUSTOMER</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>CONTACT PERSON</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>ADDRESS1</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>ADDRESS2</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>COUNTRY</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>STATE</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>DISTRICT</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>LOCATION</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>PINCODE</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>PHONE</b></center></td>";
	 str=str+"<td  class='boldEleven'><center><b>E-MAIL</b></center></td>";
	 str=str+"</tr>";
	 for(loop = 0; loop < batchs.childNodes.length; loop++) 
	 {	     
        var batch = batchs.childNodes[loop];
        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
	    var Cperson = batch.getElementsByTagName("Cperson")[0].childNodes[0].nodeValue;
	    var Address1 = batch.getElementsByTagName("Address1")[0].childNodes[0].nodeValue;
	    var Address2 = batch.getElementsByTagName("Address2")[0].childNodes[0].nodeValue;
	    var Country = batch.getElementsByTagName("Country")[0].childNodes[0].nodeValue;
	    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
	    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
	    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
	    var Pincocde = batch.getElementsByTagName("Pincocde")[0].childNodes[0].nodeValue;
	    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
	    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
	    
	    if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td  class='boldEleven'><input id='rowid' name='rowid' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
		str=str+"<td  class='boldEleven'> "+Name+"</td>";
		str=str+"<td  class='boldEleven'> "+Cperson+"</td>";
		str=str+"<td  class='boldEleven'> "+Address1+"</td>";
		str=str+"<td  class='boldEleven'> "+Address2+"</td>";
		str=str+"<td  class='boldEleven'> "+Country+"</td>";
		str=str+"<td  class='boldEleven'> "+State+"</td>";
		str=str+"<td  class='boldEleven'> "+District+"</td>";
		str=str+"<td  class='boldEleven'> "+City+"</td>";
		str=str+"<td  class='boldEleven'> "+Pincocde+"</td>";
		str=str+"<td  class='boldEleven'> "+Phone+"</td>";
		str=str+"<td  class='boldEleven'> "+Email+"</td>";
		str=str+"</tr>";
		window.status=(loop+1);
	 }
      
	 if(batchs.childNodes.length <1)
		str=str+"<td colspan='5' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
	 str=str+"</table>";
    
	 var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records : "+batchs.childNodes.length+"</font>"; 
  	}
 	catch(err)
 	{
 		alert(err.description);
 	}    	
}



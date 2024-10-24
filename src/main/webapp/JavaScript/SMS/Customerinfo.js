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
	 var str="<center><br><font class='bolddeepred'>Total No of Records : 0</font></br>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}




function LoadCustomerinfos(startLetter)
 {
 
 	var url = "../SMS?actionS=LoadCustomerinfos&startLetter="+escape(startLetter)+"&group="+document.getElementById('group').value;
   	 
   	initRequest(url);
	req.onreadystatechange=LoadCustomerinfosRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function LoadCustomerinfosRequest() 
 {
    
	ClearTabler('totalrec');
    ClearTable('GroupTable');
	if(req.readyState == 4)
     {    	
 		document.getElementById('Edit').disabled=true; 
		document.getElementById('Delete').disabled=true;   		
        if (req.status == 200) 
        {		  	
          var tb=document.getElementById('GroupTable');
		  tb.innerHTML="<font class='bolddeepred'> Loading Data</font>"; 
		  LoadCustomerinfosMessages();
        }
    }
}

function LoadCustomerinfosMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   
     
    var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
  	str=str+"<tr class='MRow1'>";
    str=str+"<td   align='left' class='bold1'>S.No</td>";
    str=str+"<td  align='left' class='bold1'>Customer Name</td>";
    str=str+"<td  align='left' class='bold1'>Companyname </td>";
	str=str+"<td  align='left' class='bold1'>Address1 </td>";
	str=str+"<td  align='left' class='bold1'>Address2 </td>";
	str=str+"<td  align='left' class='bold1'>Address3 </td>";
	
	
	str=str+"<td  align='left' class='bold1'>State </td>";
	str=str+"<td  align='left' class='bold1'>District</td>";
	str=str+"<td  align='left' class='bold1'>City </td>";
	str=str+"<td  align='left' class='bold1'>Pincode </td>";
	str=str+"<td  align='left' class='bold1'>Phone </td>";
	str=str+"<td  align='left' class='bold1'>Mobile </td>";
	str=str+"<td  align='left' class='bold1'>Fax </td>";
	str=str+"<td  align='left' class='bold1'>Email </td>";
	str=str+"<td  align='left' class='bold1'>Website </td>";
	str=str+"<td  align='left' class='bold1'>GroupName </td>";
	str=str+"<td  align='left' class='bold1'>Active</td>";
	str=str+"</tr>";
	 
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {	     
	        var batch = batchs.childNodes[loop];
	        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
		    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		    var CName = batch.getElementsByTagName("CName")[0].childNodes[0].nodeValue;
		    var Add1 = batch.getElementsByTagName("Add1")[0].childNodes[0].nodeValue;
		    var Add2 = batch.getElementsByTagName("Add2")[0].childNodes[0].nodeValue;
		    var Add3 = batch.getElementsByTagName("Add3")[0].childNodes[0].nodeValue;
		    var City = batch.getElementsByTagName("City")[0].childNodes[0].nodeValue;
		    var District = batch.getElementsByTagName("District")[0].childNodes[0].nodeValue;
		    var State = batch.getElementsByTagName("State")[0].childNodes[0].nodeValue;
		    var Pin = batch.getElementsByTagName("Pin")[0].childNodes[0].nodeValue;
		    var Phone = batch.getElementsByTagName("Phone")[0].childNodes[0].nodeValue;
		    var Mobile = batch.getElementsByTagName("Mobile")[0].childNodes[0].nodeValue;
		    var Fax = batch.getElementsByTagName("Fax")[0].childNodes[0].nodeValue;
		    var Email = batch.getElementsByTagName("Email")[0].childNodes[0].nodeValue;
		    var Web = batch.getElementsByTagName("Web")[0].childNodes[0].nodeValue;
		    var GName = batch.getElementsByTagName("GName")[0].childNodes[0].nodeValue;
		    var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue;
		   
		    
	 	    			
		    
		    if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			   
			str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Id+"'/>&nbsp;"+(loop+1);
			str=str+"<td  class='boldEleven'>&nbsp;"+Name  ;
			str=str+"<td  class='boldEleven'>&nbsp;"+CName;
			str=str+"<td  class='boldEleven'>&nbsp;"+Add1;
			str=str+"<td  class='boldEleven'>&nbsp;"+Add2;
			str=str+"<td  class='boldEleven'>&nbsp;"+Add3;
			str=str+"<td  class='boldEleven'>&nbsp;"+State;
			str=str+"<td  class='boldEleven'>&nbsp;"+District;
			str=str+"<td  class='boldEleven'>&nbsp;"+City;
			
			str=str+"<td  class='boldEleven'>&nbsp;"+Pin;
			str=str+"<td  class='boldEleven'>&nbsp;"+Phone;
			str=str+"<td  class='boldEleven'>&nbsp;"+Mobile;
			str=str+"<td  class='boldEleven'>&nbsp;"+Fax;
			str=str+"<td  class='boldEleven'>&nbsp;"+Email;
			str=str+"<td  class='boldEleven'>&nbsp;"+Web;
			str=str+"<td  class='boldEleven'>&nbsp;"+GName;
			if(Active=="Y")
				str=str+"<td  class='boldEleven'><font color='blue'>Active</font>";
			else
				str=str+"<td  class='boldEleven'><font color='red'>Inactive</font>";	
	    }
     
	
     var tb=document.getElementById('GroupTable');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totalrec');
  	 tb.innerHTML= "<center><font class='bolddeepred'>Total no of Records ::"+batchs.childNodes.length+"</font></center>"; 
	 if(batchs.childNodes.length >0)
  	{  	 	
     	document.getElementById('Edit').disabled=false;
     	document.getElementById('Delete').disabled=false;
    }
    else
    {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     	document.getElementById('Delete').disabled=true;
     
    }	
	 str=str+"</table>";
     	
}
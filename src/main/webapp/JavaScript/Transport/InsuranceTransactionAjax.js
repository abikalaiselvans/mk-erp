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
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
  	 
}

 
function LoadInsuranceTransaction(startLetter)
 {
 	var offices= document.getElementById('offices').value;
 	var reminder= document.getElementById('reminder').value;
 	var url = "../Transport?actionS=LoadInsuranceTransaction&startLetter="+escape(startLetter)+"&reminder="+reminder+"&offices="+offices;
    
    initRequest(url);
	req.onreadystatechange=InsuranceTransactionRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function InsuranceTransactionRequest() 
 {
 	try
 	{
	    if(req.readyState == 4) 
	    {    	
	        ClearTable('divscroll');  
	        var tb=document.getElementById('divscroll');
	  	 	tb.innerHTML="" ;
	  	 	var tb1=document.getElementById('totRec');
	  	 	tb1.innerHTML=" " ;
	  		document.getElementById('Edit').disabled=true;  
	  		if (req.status == 200) 
	        {		  	
	          InsuranceTransactionMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err.description);
	} 
}
function InsuranceTransactionMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    var str=""; 
    
	str=str+"<table width='100%'  border='0' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	str=str+"<tr> ";
	str=str+"<td class='boldEleven'  ><b>S.no</b></td> ";
	//str=str+"<td class='boldEleven'  ><b>Emp Name</b></td> ";
	str=str+"<td class='boldEleven'  ><b>Reminder Name</b></td> ";
	str=str+"<td class='boldEleven'  ><b>Policy Number</b></td> ";
	str=str+"<td class='boldEleven'  ><b>Period</b></td> ";
	str=str+"<td class='boldEleven'   ><b>Premium</b></td> ";
	str=str+"<td class='boldEleven'   ><b>Due Date</b></td> ";
	//str=str+"<td class='boldEleven'><b>Sum Assured</b></td> ";
	//str=str+"<td class='boldEleven'  ><b>Ins.Issuer</b></td> ";
	str=str+"<td class='boldEleven'  ><b>Office</b></td> ";
	str=str+"<td class='boldEleven'  ><b>Description</b></td> ";
	//str=str+"<td class='boldEleven'><b>Policy Status </b></td> ";
	//str=str+"<td class='boldEleven'><b>Vehicle Status</b></td> ";
	str=str+"</tr> ";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Field1 = batch.getElementsByTagName("Field1")[0].childNodes[0].nodeValue;
	    var Field2 = batch.getElementsByTagName("Field2")[0].childNodes[0].nodeValue;
	    var Field3 = batch.getElementsByTagName("Field3")[0].childNodes[0].nodeValue;
	    var Field4 = batch.getElementsByTagName("Field4")[0].childNodes[0].nodeValue;
	    var Field5 = batch.getElementsByTagName("Field5")[0].childNodes[0].nodeValue;
	    var Field6 = batch.getElementsByTagName("Field6")[0].childNodes[0].nodeValue;
	    var Field7 = batch.getElementsByTagName("Field7")[0].childNodes[0].nodeValue;
	    var Field8 = batch.getElementsByTagName("Field8")[0].childNodes[0].nodeValue;
	    var Field9 = batch.getElementsByTagName("Field9")[0].childNodes[0].nodeValue;
	    var Field10 = batch.getElementsByTagName("Field10")[0].childNodes[0].nodeValue;
	    var Field11 = batch.getElementsByTagName("Field11")[0].childNodes[0].nodeValue;
	    var Field12 = batch.getElementsByTagName("Field12")[0].childNodes[0].nodeValue;
	    var Field13 = batch.getElementsByTagName("Field13")[0].childNodes[0].nodeValue;
	    var Field14 = batch.getElementsByTagName("Field14")[0].childNodes[0].nodeValue;
	    var Field15 = batch.getElementsByTagName("Field15")[0].childNodes[0].nodeValue;
	    var Field16 = batch.getElementsByTagName("Field16")[0].childNodes[0].nodeValue;
	    var Field17 = batch.getElementsByTagName("Field17")[0].childNodes[0].nodeValue;
	    var Field18 = batch.getElementsByTagName("Field18")[0].childNodes[0].nodeValue;
	    var Field19 = batch.getElementsByTagName("Field19")[0].childNodes[0].nodeValue;
	    var Field20 = batch.getElementsByTagName("Field20")[0].childNodes[0].nodeValue;
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'><input name='id' id='id' type='checkbox' value='"+Field1+"'/>&nbsp;"+(loop+1);
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field3;
		 
		str=str+"<td  class='boldEleven'>&nbsp;"+Field4;
		str=str+"<td  class='boldEleven'>&nbsp;"+Field5;
		str=str+"<td  class='boldEleven'>&nbsp;";
		if(Field6 =="H")
			str=str+"Haly yearly"; 
		else if(Field6 =="A")
			str=str+"Anuualy"; 
		else if(Field6 =="Q")
			str=str+"Quartely"; 
		else if(Field6 =="M")
			str=str+"Monthly"; 
		else if(Field6 =="2")
			str=str+"2-Years"; 
		else if(Field6 =="3")
			str=str+"3-Years"; 
		else if(Field6 =="4")
			str=str+"4-Years"; 
		else if(Field6 =="5")
			str=str+"5-Years"; 
								
		str=str+"<td  class='boldEleven'>&nbsp;"+Field7;	
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field8;
		str=str+"<td  class='boldEleven' width='150'  >&nbsp;"+Field9;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field10;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field11;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field12;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field13;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field14;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field15; 
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field16;
		str=str+"<td  class='boldEleven'>&nbsp;"+Field17;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field18;
		//str=str+"<td  class='boldEleven'>&nbsp;"+Field19;
		str=str+"<td  class='boldEleven'>&nbsp;"+Field20;
		
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	document.getElementById('Edit').disabled=false;
     }
     else
     {
     	str=str+"<td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td>";
     	document.getElementById('Edit').disabled=true;
     
     }	
	 str=str+"</table>";
     var tb=document.getElementById('divscroll');
  	 tb.innerHTML=str   ;
  	 
  	 tb=document.getElementById('totRec');
  	 tb.innerHTML= "<font color='red'>Total no of Records ::</font>"+batchs.childNodes.length; 
     	
}
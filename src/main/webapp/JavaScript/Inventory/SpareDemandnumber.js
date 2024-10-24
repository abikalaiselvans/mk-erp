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
	 var str="<center><font class='bolddeepred'>Data not found</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str;
}
  
 
function Assignsparedemanddetail(ctr) 
{
	var demandnumber=ctr.value; 
	 
	{
		var url = "../inventoryCustomer?actionS=INVAssignsparedemand&demandnumber="+escape(demandnumber);
		initRequest(url);
	    req.onreadystatechange = AssignsparedemandRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	 
}

function AssignsparedemandRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('AssignsparedemandDiv');
		var _targ=document.getElementsByName('consumableproduct')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select Product Code','0');
		 var tb=document.getElementById('divcodename');	 
  	 	 tb.innerHTML="";
		 var _targT=document.getElementsByName('serialproducttype')[0];       
	     _targT.options.length=0;
	     _targT.options[0]=new Option('Select Type','0');
		 var _targQ=document.getElementsByName('qty')[0];       
	     _targQ.options.length=0;
	     _targQ.options[0]=new Option('Select Qty','0');
		 var tbQ=document.getElementById('divqtyname');	 
  	 	 tbQ.innerHTML="";
		 document.getElementById('submit_btn').disabled=false;
		 var ele = document.getElementsByName("sparetype");
   			for(var i=0;i<ele.length;i++)
      			ele[i].checked = false;
        if (req.status == 200) 
        {		  	
          AssignsparedemandMessages();
        }
    }
}


function AssignsparedemandMessages() 
{
    var batchs = req.responseXML.getElementsByTagName("Rowssparedemanddetail")[0];
	var str=""; 
	var loop;
	str=str+"<table width='98%'  id='myTable' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str=str+"<tr width='25' class='MRow1'>";
	str=str+"<td class='boldEleven'><b>S.No</b></td>";
	str=str+"<td class='boldEleven'><b>Call No</b></td>";
	str=str+"<td class='boldEleven'><b>Serial No</b></td>";
	str=str+"<td class='boldEleven'><b>Raised Date</b></td>";
	str=str+"<td class='boldEleven'><b>Raised By</b></td>";
	str=str+"<td class='boldEleven'><b>Depatch Location</b></td>";
	 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{
	    var batch = batchs.childNodes[loop];
        var callno = batch.getElementsByTagName("Demandissuecallnum")[0];
        var serialno = batch.getElementsByTagName("productserialnumber")[0];
        var Raiseddate = batch.getElementsByTagName("raiseddate")[0];
        var Raisedby = batch.getElementsByTagName("raisedby")[0];
        var despatchlocation = batch.getElementsByTagName("despatchlocation")[0];
        
        if(loop%2==1)
			str=str+"<tr width='25' class='MRow1'>";
		else
		    str=str+"<tr width='25'   class='MRow2'>";
			
		str=str+"<td class='boldEleven'>"+(loop+1)+".</td>";
		str=str+"<td class='boldEleven'>"+callno.childNodes[0].nodeValue+"</td>";  
		str=str+"<td class='boldEleven'>"+serialno.childNodes[0].nodeValue+"</td>";
		str=str+"<td class='boldEleven'>"+Raiseddate.childNodes[0].nodeValue+"</td>";
		str=str+"<td class='boldEleven'>"+Raisedby.childNodes[0].nodeValue+"</td>";
		str=str+"<td class='boldEleven'>"+despatchlocation.childNodes[0].nodeValue+"</td>";
	    str=str+"</table>";
    var tb=document.getElementById('AssignsparedemandDiv');
  	tb.innerHTML=str ;  
  	
	}		
 } 
  
 
	
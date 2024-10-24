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


function loadReceivedId() 
{
	var rid=document.getElementById('rid').value;
	var purchasetype=document.getElementById('purchasetype').value;
    var url = "../inventory?actionS=INVGoodsReceivedId&rid="+escape(rid)+"&purchasetype="+purchasetype;
   	initRequest(url);
   	req.onreadystatechange = ReceivedIdRequest;
    req.open("GET", url, true);
    req.send(null);    
}

function ReceivedIdRequest() 
{		
	if(req.readyState == 4) 
    {    	
		ClearTable('ReceivedIdTable');
		 document.getElementById('Return').disabled=true ;
       	if (req.status == 200)
        {        	
        	ReceivedIdMessages();
        }
    }
}

function ReceivedIdMessages() 
{
	try
	{
		var str=""; 	
		var batchs = req.responseXML.getElementsByTagName("RcdIds")[0];   
		str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
		str=str+"<tr class='MRow1'><td width='130' class='bold1'>Type  </td>"
		str=str+"<td width='130' class='bold1'>Item / Product  </td>"
		str=str+"<td width='130' class='bold1'>Received Date</td>"
		str=str+"<td width='130' class='bold1'>Serial Number </td>";
		str=str+"<td width='130' class='bold1'>Warranty</td>";
		str=str+"<td width='130' class='bold1'>Return</td></tr>";
		var dt="";
	    var flags=""; 
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {
		    var batch = batchs.childNodes[loop];
	        var Refid = batch.getElementsByTagName("Refid")[0].childNodes[0].nodeValue;
	        var Reddate = batch.getElementsByTagName("Reddate")[0].childNodes[0].nodeValue;
	        var Itemname = batch.getElementsByTagName("Itemname")[0].childNodes[0].nodeValue;
	        var Itemtype = batch.getElementsByTagName("Itemtype")[0].childNodes[0].nodeValue;
	        var Srial = batch.getElementsByTagName("Srial")[0].childNodes[0].nodeValue;
	        var Warranty = batch.getElementsByTagName("Warranty")[0].childNodes[0].nodeValue;
	        var Flag = batch.getElementsByTagName("Flag")[0].childNodes[0].nodeValue;
			if(loop%2==0)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	
			
			 
			str=str+"<td width='130' class='boldEleven'>"+Itemtype;
			str=str+"<td width='130' class='boldEleven'>"+Itemname;
			str=str+"<td width='130' class='boldEleven'>"
			dt =Reddate.split("-");
			var ds = dt[2]+"-"+dt[1]+"-"+dt[0];
			str = str+ds;
			str=str+"<td width='130' class='boldEleven'>"+Srial;
			str=str+"<td width='130' class='boldEleven'>"+Warranty+" -years";
			str = str +"<td width='60' class='boldEleven'>";
			var fg="Y";
			var link = Refid+"~"+Srial+"~";
			if(Flag =="Y")
			{
				str = str +fg
				flags = flags+"true,";
			}
			else	
			{
				str = str +"<input  type='checkbox' name='refid'  id='refid' value='"+link+"' />"
				flags = flags+"false,";
			}	
			
	     }
	     str=str+"</table>";
	     var ch = flags.split(",");
	     var cflag ="false";
	     for(u=0;u<flags.length-1;u++)
	     	if("false" == ch[u])
	     		cflag = "true";
	     		
	     if(batchs.childNodes.length >0)
	     	document.getElementById('Return').disabled=false ;
	     else
	     	document.getElementById('Return').disabled=true ;
	    
	     if(cflag == "true")
	     	document.getElementById('Return').disabled=false ;
	     else
	     	document.getElementById('Return').disabled=true ;
	
	     var tb=document.getElementById('ReceivedIdTable');
	  	 tb.innerHTML=str  ;
	  	 
	  	if(batchs.childNodes.length < 1)
	     {
	     	str = str+"<tr class='MRow1'><td  class='bolddeepred' colspan='6' height=100><center>Data not found...</center></td></tr>";
	     	 
	     }
	}
	catch(err)
	{
		alert(err);
	}
}







//Goods Return view page
function loadReturn(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
    var purchasetype=document.getElementById('purchasetype').value;  
    var url = "../inventory?actionS=INVGoodsReturn&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter)+"&purchasetype="+purchasetype;
	initRequest(url);
	req.onreadystatechange = ReturnRequest;
    req.open("GET", url, true);
    req.send(null);
}

function ReturnRequest()
{
    if(req.readyState == 4) 
    {    	
        ClearTable('ReturnTable');
        ClearTabler('totRec'); 
         
        if (req.status == 200)
        {
        	ReturnMessages();
        }
    }
}



function ReturnMessages() 
{
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Returns")[0]; 
		var str=""; 
		str=str+"<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>";
	    str=str+"<tr class='MRow1'> ";
	    str=str+"<td class='boldEleven' align='center'><b>GRT No.</b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Vendor Name</b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Purchase </b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Type </b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Code </b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Serial </b></td>";
	    str=str+"<td class='boldEleven' align='center'><b>Status</b></td>";
	    str=str+"</tr>";
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {
		    var batch = batchs.childNodes[loop];
	        var purchaseid = batch.getElementsByTagName("purchaseid")[0].childNodes[0].nodeValue;
	        var vendorname = batch.getElementsByTagName("vendorname")[0].childNodes[0].nodeValue;
	        var Grtno = batch.getElementsByTagName("Grtno")[0].childNodes[0].nodeValue;
	        var itype = batch.getElementsByTagName("itype")[0].childNodes[0].nodeValue;
	        var Itemid = batch.getElementsByTagName("Itemid")[0].childNodes[0].nodeValue;
	        var Serial = batch.getElementsByTagName("Serial")[0].childNodes[0].nodeValue;
	        var Flag = batch.getElementsByTagName("Flag")[0].childNodes[0].nodeValue;
	         
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			
	        str=str+"<td class='boldEleven'><input  type='checkbox' name='grtno' value='"+Grtno +"' />"+Grtno +"</td>" ;
			str=str+"<td class='boldEleven'>"+vendorname+"</td>" ;;
	 		str=str+"<td class='boldEleven'>"+purchaseid +"</td>" ;;
	 		str=str+"<td class='boldEleven'>"+itype +"</td>" ;;
	 		str=str+"<td class='boldEleven'>"+Itemid +"</td>" ;;
	 		str=str+"<td class='boldEleven'>"+Serial +"</td>" ;;
	 		
	 		if(Flag == "Y")
	 			str=str+"<td class='boldEleven'><font class='boldgreen'>Replaced</font></td>" ; 
	 		else
	 			str=str+"<td class='boldEleven'><font class='bolddeepred'>Replacement Pending</font></td>" ;
	 			
	 		str=str+"</tr>";
	 		
	 		
	     }
	     if(batchs.childNodes.length < 1)
	     {
	     	str = str+"<td  class='errormessage' colspan='6' height=100><center>Data not found...</center></td>";
	     }
	     str=str+"</table>";
	     var tb=document.getElementById('ReturnTable');
	  	 tb.innerHTML=str  ; 
	  	 
	  	str="<table align='center' ><tr><td height=10 ><center class='bolddeepred'>Total no of Records :: "  + loop+"</center></table>";
	  	var tb=document.getElementById('totRec');
	  	tb.innerHTML=str   
	  	 
	  	 
	}
	catch(err)
	{
		alert(err);
	} 
}

 
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


function callloaditem()
{
	var sr=document.getElementById('search').value; 
	loadProductList(sr);
	 
} 


function callloaditems(start)
{
	loadProductList(start);
} 


function loadProductList(sval) 
{
   try
   {
           
    var group=document.getElementById('productgroup').value;
    var active=document.getElementById('active').value;
    var type=document.getElementById('type').value;
    var url = "../inventory?actionS=loadProductList&search="+escape(sval)+"&group="+group+"&active="+active+"&type="+type;
     
    initRequest(url);
    req.onreadystatechange = loadProductListRequest;
    req.open("GET", url, true);
    req.send(null);
   }
   catch(err)
   {
	   alert(err);
   }
}
 
function loadProductListRequest() 
{
	try
	{
	    if(req.readyState == 4) 
	    {
	    	ClearTable('divscroll');  
	        ClearTabler('totRec');
	        if (req.status == 200) 
	        {
	        	loadProductListMessages();
	        }
	    }
	}
   catch(err)
   {
	   alert(err);
   }
}

function loadProductListMessages() 
{
	    
	try
	{
		var batchs = req.responseXML.getElementsByTagName("Rowss")[0];   	    
		var str=""; 
	    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	    str=str+"<tr class='MRow1'>";
	    str=str+"<td  class='boldEleven'><center><b>S.NO</b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Product Group </b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Product Name </b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Description</b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Active</b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Warranty(Yrs) </b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Type</b></center></td>";
	    str=str+"<td  class='boldEleven'><center><b>Inner Configuration</b></center></td>";
	    str=str+"</tr>";
	    for(loop = 0; loop < batchs.childNodes.length; loop++) 
	    {
		    
		    window.status= Rowid;
	    	var batch = batchs.childNodes[loop];
	        var Rowid = batch.getElementsByTagName("Rowid")[0].childNodes[0].nodeValue;
		    var groupid = batch.getElementsByTagName("groupid")[0].childNodes[0].nodeValue;
		    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		    var desc = batch.getElementsByTagName("desc")[0].childNodes[0].nodeValue;
		    var warranty = batch.getElementsByTagName("warranty")[0].childNodes[0].nodeValue;
		    var active = batch.getElementsByTagName("active")[0].childNodes[0].nodeValue;
		    var type = batch.getElementsByTagName("type")[0].childNodes[0].nodeValue;
		    var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
		    var Innerconfig = batch.getElementsByTagName("Innerconfig")[0].childNodes[0].nodeValue;
		    
		    
			 
	        if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";		
			str=str+"<td  class='boldEleven'><input id='productId' name='productId' type='checkbox' value='"+Rowid+"' />"+(loop+1)+"</td>";
			str=str+"<td  class='boldEleven'> "+groupid+"</td>";
			str=str+"<td  class='boldEleven'> "+Name+"</td>";
			str=str+"<td  class='boldEleven'> "+desc+"</td>";
			if(active == "1")
				str=str+"<td><font class='boldgreen'>Active</font> </td>";						
			else
				str=str+"<td><font class='bolddeepred'>In-Active</font></td>";	
			str=str+"<td  class='boldEleven'> "+warranty+" - yrs </td>";
			str=str+"<td  class='boldEleven'> "+type+"</td>";
			if(("F" == usertype || "B" ==usertype) && (Innerconfig =="Y") )
				str=str+"<td  class='boldEleven'><a href='Productinnerconfiguration.jsp?rowid="+Rowid+"'><font class='boldgreen'>Inner Config</font></a></td>";
			else
				str=str+"<td  class='boldEleven'>&nbsp;</td>";	
			str=str+"</tr>";
	 	
		 }		
	     str=str+"</table>";
	     var tb=document.getElementById('divscroll');
	  	 tb.innerHTML=str   
	  	 str="<font color='ff0000'>Total no of Records :: "  + loop+"</font>";
	  	 var tb=document.getElementById('totRec');
	  	 tb.innerHTML=str  
	}
   catch(err)
   {
	   alert(err);
   }	  
} 
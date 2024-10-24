
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
  
 

function loadPurchaseRequestDetails() 
{
	try
	{
		var tb=document.getElementById('prdetails');
		tb.innerHTML=""  ; 
		var purchaserequest=document.getElementById('purchaserequest').value;
		var url = "../inventory?actionS=loadPurchaseRequestDetails&purchaserequest="+escape(purchaserequest);
		initRequest(url);
		req.onreadystatechange =loadPurchaseRequestDetailsRequest;
		req.open("GET", url, true);
		req.send(null);
	}
	catch(err)
	{
		alert(err)
	}
}

function loadPurchaseRequestDetailsRequest() 
{	
	try
	{
		if(req.readyState == 4) 
	    {    	
	        
	       if (req.status == 200)
	        {
	        	loadPurchaseRequestDetailsMessages();
	        }
	    }
	}
	catch(err)
	{
		alert(err)
	}	
}


function loadPurchaseRequestDetailsMessages() 
{
	try
	{
		var str=""; 
		var batchs = req.responseXML.getElementsByTagName("Rows")[0];  
		
		str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
		str=str+"<tr class='MRow1'>";
		str = str+"<td   class='boldEleven'><b>S.No</td>";
	   	str = str+"<td   class='boldEleven'><b>Type</td>";
	   	str = str+"<td   class='boldEleven'><b>Item / Product Code</td>";
	   	str = str+"<td   class='boldEleven'><b>Description</td>";
	   	str = str+"<td   class='boldEleven'><b>Quantity</td>";
	   	str = str+"<td   class='boldEleven'><b>Unit PurchasePrice</td>";
	   	str = str+"<td   class='boldEleven'><b>PurchasePrice</td>";
	   	str = str+"<td   class='boldEleven'><b>Purchase Warranty</td>";
	   	str = str+"<td   class='boldEleven'><b>Unit Sale Price</td>";
	   	str = str+"<td   class='boldEleven'><b>Sale Price</td>";
	   	str = str+"<td   class='boldEleven'><b>Sale Warranty</td>";
	   	str = str+"</tr>"; 
	   	var len,val,i,sel,s;
		for(loop=0; loop<batchs.childNodes.length; loop++) 
	    {
		    var batch = batchs.childNodes[loop] ;
	        var itype= batch.getElementsByTagName("itype")[0].childNodes[0].nodeValue;
	        var iname= batch.getElementsByTagName("iname")[0].childNodes[0].nodeValue;
	        var descc= batch.getElementsByTagName("descc")[0].childNodes[0].nodeValue;
	        var qty= batch.getElementsByTagName("qty")[0].childNodes[0].nodeValue;
	        var upprice= batch.getElementsByTagName("upprice")[0].childNodes[0].nodeValue;
	        var pprice= batch.getElementsByTagName("pprice")[0].childNodes[0].nodeValue;
	        var usprice= batch.getElementsByTagName("usprice")[0].childNodes[0].nodeValue;
	        var sprice= batch.getElementsByTagName("sprice")[0].childNodes[0].nodeValue;
	        var Date= batch.getElementsByTagName("Date")[0].childNodes[0].nodeValue;
	        var inamecode= batch.getElementsByTagName("inamecode")[0].childNodes[0].nodeValue;
	        var itypecode= batch.getElementsByTagName("itypecode")[0].childNodes[0].nodeValue;
	        var itax= batch.getElementsByTagName("itax")[0].childNodes[0].nodeValue;
	        var pwarranty= batch.getElementsByTagName("pwarranty")[0].childNodes[0].nodeValue;
	        var swarranty= batch.getElementsByTagName("swarranty")[0].childNodes[0].nodeValue;
	        
	        
	        if(loop%2==1)
	       		str = str+"<tr class='MRow2'>";
	       	else
	       		str = str+"<tr class='MRow1'>";
		
			str = str+"<td   class='boldEleven' >"+(loop+1)+"</td>";
			str = str+"<td   class='boldEleven' >"+itype+"</td>";
			str = str+"<td   class='boldEleven' >"+iname+"</td>";
			str = str+"<td   class='boldEleven' >"+descc+"</td>";
			str = str+"<td   class='boldEleven' >"+qty+"</td>";
			str = str+"<td   class='boldEleven' >"+upprice+"</td>";
			str = str+"<td   class='boldEleven' >"+pprice+"</td>";
			str = str+"<td   class='boldEleven' >"+pwarranty+" -yrs</td>";
			
			str = str+"<td   class='boldEleven' >"+usprice+"</td>";
			str = str+"<td   class='boldEleven' >"+sprice+"</td>";
			str = str+"<td   class='boldEleven' >"+swarranty+"-yrs</td>";
			str = str+"</tr>"; 
			document.getElementById('proposedpurchasedate').value= Date;
			
			/*insRow();
			var s0= "itype"+(loop+1);
			var s1= "item"+(loop+1);
			var s2 = "desc"+(loop+1);
			var s3 ="qty"+(loop+1);
			var s4 = "uprice"+(loop+1);
			var s5 = "discount"+(loop+1);
			var s6 = "unitdiscount"+(loop+1);
			var s7 = "total"+(loop+1);
			var s8 = "consumables"+(loop+1);
			var s9 = "stax"+(loop+1);
			var s10 = "staxpercentage"+(loop+1);
			var s11 = "staxamount"+(loop+1);
			var div ="div"+(loop+1);
			if("I" ==  itypecode)
				setOptionValue(s0, "1");
			else
				setOptionValue(s0 , "2");
			
			
			Loaditemproducts(s0,div);
			alert("please verify the Products..."+inamecode);
			document.getElementById(s2).value=descc;
			document.getElementById(s3).value= qty;
			document.getElementById(s4).value= upprice;
			document.getElementById(s5).value= "0";
			document.getElementById(s6).value= "0";
			document.getElementById(s11).value= "0";
			document.getElementById(s7).value= pprice;
			setOptionValue(s1, inamecode);
			setOptionValue(s9, itax);
			 
		 	 */
			 
			
	     }
	     str=str+"</table></center>";
		 var tb=document.getElementById('prdetails');
	 	 tb.innerHTML=str  ; 
	     
	}
	catch(err)
	{
		alert(err)
	}
} 

  
  
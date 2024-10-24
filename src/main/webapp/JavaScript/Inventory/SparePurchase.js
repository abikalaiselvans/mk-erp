
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
	 var str="<br><br><font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


 
function loadSparePurchase(startletter) 
{
	var mon=document.getElementById('month').value;
	var yea=document.getElementById('year').value; 
	var vendor=document.getElementById('vendor').value; 
	var division=document.getElementById('division').value; 
	var day=document.getElementById('day').value;
	var url = "../Spare?actionS=loadSparePurchase&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&vendor="+vendor+"&division="+division+"&day="+day;
  	initRequest(url);
  	req.onreadystatechange = loadSparePurchaseRequest;
  	req.open("GET", url, true);
  	req.send(null);
}


function loadSparePurchaseRequest() 
{
  if(req.readyState == 4) 
  {    	
      ClearTable('SparePurchaseTable');
      var tb=document.getElementById('totRec');
	  tb.innerHTML=" ";
      document.getElementById('btnDelete').disabled=true;
      document.getElementById('btnEdit').disabled=true;  
      if (req.status == 200) 
      {
    	  loadSparePurchaseMessages();
      }
  }
}

 
function loadSparePurchaseMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("DirectPurchases")[0];   	    
	var str=""; 
	str=str+"<table width='100%' border='0'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	var sum =0.0;   
 	for(loop = 0; loop < batchs.childNodes.length; loop++) 
	{
		  window.status=loop;
		  var batch = batchs.childNodes[loop];
	      var Id = batch.getElementsByTagName("salId")[0];
	      var salNo = batch.getElementsByTagName("salNo")[0];
	      var salDate = batch.getElementsByTagName("salDate")[0];
	      var salTotal = batch.getElementsByTagName("salTotal")[0];
	      var quoCust = batch.getElementsByTagName("quoCust")[0];   
	      var Status = batch.getElementsByTagName("Status")[0];   
	      var PStatus = batch.getElementsByTagName("PStatus")[0]; 
	      var SalesStatus = batch.getElementsByTagName("SalesStatus")[0]; 
	        
			if(loop%2==1)
				str=str+"<tr class='MRow1'>";
			else
			    str=str+"<tr  class='MRow2'>";	 
			
			str=str+"<td width='10' class='boldEleven'><font class='boldEleven'>"+(loop+1)+".</font></td>";
			temId=Id.childNodes[0].nodeValue;
			if((Status.childNodes[0].nodeValue=="N")||(SalesStatus.childNodes[0].nodeValue=="N")  )
				str=str+"<td   class='boldEleven'><input type='checkbox' name='Ponumber'  id='Ponumber' value='"+salNo.childNodes[0].nodeValue+"'>"+salNo.childNodes[0].nodeValue +" </td>";
			else
				str=str+"<td width='200' class='boldEleven'> "+salNo.childNodes[0].nodeValue +"</font></a></td>";
			
			str=str+"<td class='boldEleven'>"+salDate.childNodes[0].nodeValue+"</td>";
			str=str+"<td class='boldEleven'>"+(quoCust.childNodes[0].nodeValue).replace("9865043008"," & ");;
			var link="DirectPurchaseSerial.jsp?pono="+salNo.childNodes[0].nodeValue;
			if(Status.childNodes[0].nodeValue=="Y")
			{
				str=str+"<td class='boldEleven'><font class='boldgreen'>Received</font> </td>";
				str=str+"<td class='boldEleven'><a href='SpareReceiveViewList.jsp?gdreceiveno="+salNo.childNodes[0].nodeValue+"'><font class='boldgreen'>View</font></a> </td>";
			}	
			else
			{
				str=str+"<td class='boldEleven'><a href='"+link+"'><font class='boldgreen'>Not Received</font></a> </td>";
				str=str+"<td class='boldEleven'><font class='boldgreen'>--</font></a> </td>";
			}		
			str=str+"<td class='boldEleven'><font class='boldgreen'>"+PStatus.childNodes[0].nodeValue+"</font> </td>";
			str=str+"<td class='boldEleven' align='right'>"+salTotal.childNodes[0].nodeValue+"</td>";;
			sum =sum +parseFloat(salTotal.childNodes[0].nodeValue);
			str=str+" </tr>";
	}
 	str=str+"<tr  class='MRow2'>";	
 	str=str+"<td  class='boldEleven' colspan='7' align='right'><font  class='bolddeepred'>Total Amount ::</font></td>"; 
 	str=str+"<td  class='boldEleven'  align='right' >"+Round(sum)+"</td></tr>";
 	str=str+"</table>";
 	if(batchs.childNodes.length<1)
 	{
   		document.getElementById('btnDelete').disabled=true;
   		document.getElementById('btnEdit').disabled=true;
 	}
 	else
 	{
   		document.getElementById('btnDelete').disabled=false;
   		document.getElementById('btnEdit').disabled=false;
   	}
 	var tb=document.getElementById('SparePurchaseTable');
 	tb.innerHTML=str   
 	str="<font class='boldEleven'>Total no of Records :: "  + loop+"</font>";
 	var tb=document.getElementById('totRec');
 	tb.innerHTML=str
}

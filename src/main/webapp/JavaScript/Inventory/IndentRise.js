


function loadIndentRaise(startLetter) 
{
	var dept=document.getElementById('dept').value;
	var month=document.getElementById('month').value;
	var year=document.getElementById('year').value;
	var status=document.getElementById('status').value;
	
	var url = "../inventory?actionS=loadIndentRaise&dept="+escape(dept)+"&id="+escape(startLetter)+"&month="+month+"&year="+year+"&status="+status;
	var tb=document.getElementById('PurchaseIndent');
  	tb.innerHTML="<center><font color=red> Data not found </font></center>"  ; 
   	initRequest(url);
   	req.onreadystatechange = IndentRaiseRequest;
   	req.open("GET", url, true);
    req.send(null);
}

function IndentRaiseRequest() 
{	
	if(req.readyState == 4) 
    {    	
       if (req.status == 200)
        {
        	var tb=document.getElementById('PurchaseIndent');
  	 		tb.innerHTML=" lOADING DATA" ; 
        	IndentRaiseMessages();
        }
    }
}


function IndentRaiseMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Products")[0];   
	 
	str=str+"<table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>";
	str=str+"<tr  class='MRow2'>";
	str=str+"<td class='boldEleven'><b>Indent no </b></td> ";
	str=str+"<td class='boldEleven'><b>Indent date</b></td> ";
	str=str+"<td class='boldEleven'><b>Expect date </b></td> ";
	str=str+"<td class='boldEleven'><b>Department</b></td> ";
	str=str+"<td class='boldEleven'><b>From</b></td> ";
	str=str+"<td class='boldEleven'><strong>Contact Name </strong></td> ";
	str=str+"<td class='boldEleven'><strong>Contact Number </strong></td> ";
	str=str+"<td class='boldEleven'><strong>Amount</strong></td> ";
	str=str+"<td class='boldEleven'><strong>Status</strong></td> ";
	str=str+"<td class='boldEleven'><strong>Delete / View </strong></td> ";
	str=str+"<td class='boldEleven'><strong>Approval</strong></td> ";
	str=str+"</tr> ";

	for(loop=0; loop<batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0];
        var Po = batch.getElementsByTagName("Po")[0];
        var Indentdate = batch.getElementsByTagName("Indentdate")[0];
        var Expectdate = batch.getElementsByTagName("Expectdate")[0];
		var Depart= batch.getElementsByTagName("Depart")[0];
		var Contact= batch.getElementsByTagName("Contact")[0];
		var Number= batch.getElementsByTagName("Number")[0];
		var Amount= batch.getElementsByTagName("Amount")[0];
		var Status= batch.getElementsByTagName("Status")[0];
		var AdminStatus= batch.getElementsByTagName("AdminStatus")[0];
		var SuperAdminStatus= batch.getElementsByTagName("SuperAdminStatus")[0];
		var usertype= batch.getElementsByTagName("usertype")[0];
		var Empid= batch.getElementsByTagName("Empid")[0];
		var Name= batch.getElementsByTagName("Name")[0];
		var Desc= batch.getElementsByTagName("Desc")[0];  			
		  			
		if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td  class='boldEleven'>";
		if("N" ==AdminStatus.childNodes[0].nodeValue)
			str=str+"<input name='indentid'   id='indentid' type='checkbox' value='"+Po.childNodes[0].nodeValue+"' />"+Po.childNodes[0].nodeValue	;
		else	
			str=str+Po.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Indentdate.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'>"+Expectdate.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Depart.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Empid.childNodes[0].nodeValue +" / "+Name.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Contact.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven' >"+Number.childNodes[0].nodeValue;
		str=str+"<td  class='boldEleven'  align='right'>"+Amount.childNodes[0].nodeValue;
		//str=str+"<td  class='boldEleven' >"+Status.childNodes[0].nodeValue;
		
		if("Y" ==AdminStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven' ><font class='boldgreen'>Accept</font>";
		else if("R" ==AdminStatus.childNodes[0].nodeValue)	 
			str=str+"<td  class='boldEleven' ><font class='boldred'>Reject / "+Desc.childNodes[0].nodeValue+"</font>";
		else
			str=str+"<td  class='boldEleven' ><font class='bolddeepred'>Pending</font>";	
		
		
		
		if("F" ==usertype.childNodes[0].nodeValue)
			str= str+" <td  class='boldEleven' > <a href=\"javascript:onClick=adminDeletes('../SmartLoginAuth?filename=PurchaseIndent&actionS=INVPurchaseIndentAdminDelete&indentid="+Po.childNodes[0].nodeValue+"','"+Po.childNodes[0].nodeValue+"')\"><font class='boldgreen'>Delete</font></a> / <a href=\"javascript:BillingPrint('"+Po.childNodes[0].nodeValue+"')\"><font class='boldgreen'> View</font></a>";
		else
			str=str+"<td  class='boldEleven' ><a href=\"javascript:BillingPrint('"+Po.childNodes[0].nodeValue+"')\"><font class='boldgreen'> View</font></a>";	
			
		
		
		
		
		if("Y" ==SuperAdminStatus.childNodes[0].nodeValue)
			str=str+"<td  class='boldEleven' >Completed";
		else
			str=str+"<td  class='boldEleven' >Pending";	
		
	
     }
     str=str+"</table>";

     var tb=document.getElementById('PurchaseIndent');
  	 tb.innerHTML=str  ; 
  	
} 




function  BillingPrint(indentid)
		{
			
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			var f ="PurchaseIndentPrint.jsp?indentid="+indentid ;
			newWindow = window.open(f,"subWind",styleStr);
			newWindow.focus( );
	}

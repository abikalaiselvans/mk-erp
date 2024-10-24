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


function loadDirectPurchase(startletter) 
{
	try
	{
		var mon=document.getElementById('month').value;
	    var yea=document.getElementById('year').value; 
	    var vendor=document.getElementById('vendor').value; 
	    var division=document.getElementById('division').value; 
	    var day=document.getElementById('day').value;
	    var cancel=document.getElementById('cancel').value;
	    var taxtype=document.getElementById('taxtype').value;
	    var url = "../inventoryCustomer?actionS=INVDirectPurchase&month="+escape(mon)+"&year="+escape(yea)+"&txtSer="+startletter+"&vendor="+vendor+"&division="+division+"&day="+day+"&cancel="+cancel+"&taxtype="+taxtype;
		//alert(url);
		initRequest(url);
	    req.onreadystatechange = DirectPurchaseRequest;
	    req.open("GET", url, true);
	    req.send(null);
	}
	catch(err)
	{
		alert(err);
	}
}


function DirectPurchaseRequest() 
{
    if(req.readyState == 4) 
    {    	
        ClearTable('DirectPurchaseTable');
        //ClearTabler('totRec');
        
        if (req.status == 200) 
        {
          DirectPurchaseMessages();
        }
    }
}


//usernamer- saravananfancy@rocketmail.com
//pass- sandhiya



function DirectPurchaseMessages() 
{
    //alert("DirectPurchaseMessages");
	var batchs = req.responseXML.getElementsByTagName("DirectPurchases")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    
    str=str+"<tr class='MRow1'> ";
    str=str+"<td><div align='center'>S.NO</div></td> ";
    str=str+"<td><div align='center'>Purchase No</div></td> ";
    str=str+"<td><div align='center'>Division</div></td> ";
    str=str+"<td><div align='center'>Date</div></td> ";
    str=str+"<td><div align='center'>Vendor Name</div></td> ";
    str=str+"<td><div align='center'>Status</div></td> ";
    str=str+"<td><div align='center'>View</div></td> ";
    str=str+"<td><div align='center'>Payment</div></td> ";
    str=str+"<td><div align='center'>Amount</div></td> ";
    str=str+"<td><div align='center'>Print</div></td> ";
    str=str+"<td><div align='center'>Purchase Request</div></td> ";
    str=str+"<td><div align='center'>Entry By</div></td> ";
    str=str+"<td><div align='center'>Tax Type</div></td> ";
    str=str+"</tr> ";
	
	var sum =0.0;   
   	
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
   {
	    window.status=loop;
	    var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("salId")[0].childNodes[0].nodeValue;
        var salNo = batch.getElementsByTagName("salNo")[0].childNodes[0].nodeValue;
        var quoCust = batch.getElementsByTagName("quoCust")[0].childNodes[0].nodeValue;
        var salTotal = batch.getElementsByTagName("salTotal")[0].childNodes[0].nodeValue;
        var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
        var PStatus = batch.getElementsByTagName("PStatus")[0].childNodes[0].nodeValue;
        var salDate = batch.getElementsByTagName("salDate")[0].childNodes[0].nodeValue;
        var SalesStatus = batch.getElementsByTagName("SalesStatus")[0].childNodes[0].nodeValue;
        var PR = batch.getElementsByTagName("PR")[0].childNodes[0].nodeValue;
        var Cancel = batch.getElementsByTagName("Cancel")[0].childNodes[0].nodeValue;
        var usertype = batch.getElementsByTagName("usertype")[0].childNodes[0].nodeValue;
        var Division = batch.getElementsByTagName("Division")[0].childNodes[0].nodeValue;
        var Entry = batch.getElementsByTagName("Entry")[0].childNodes[0].nodeValue;
        var Taxtype = batch.getElementsByTagName("Taxtype")[0].childNodes[0].nodeValue;
        var TaxtypeGST = batch.getElementsByTagName("TaxtypeGST")[0].childNodes[0].nodeValue;
        
        

	    if("Y" == Cancel)
			str=str+"<tr class='MRow0'>";
		else
		{
				if(loop%2==0)
					str=str+"<tr class='MRow1'>";
				else
				    str=str+"<tr  class='MRow2'>";	
		}
	    
	    str=str+"<td width='10' class='boldEleven'>"+(loop+1)+"</td>";
		
	    
	    if("N" == Cancel)
	    {	
	    	if((Status=="N")||(SalesStatus=="N")   )
	    		str=str+"<td   class='boldEleven'><input type='checkbox' name='Ponumber'  id='Ponumber' value='"+salNo+"'>"+salNo +" </td>";
	    	else
	    		str=str+"<td width='200' class='boldEleven'> "+salNo +"</font></a></td>";
	    }
	    else
			str=str+"<td width='200' class='boldEleven'> "+salNo +"</font></a></td>";
		
	    str=str+"<td class='boldEleven'>"+Division +"</td>";
	    
	    str=str+"<td class='boldEleven'>"+salDate +"</td>";
		
		str=str+"<td class='boldEleven'>"+(quoCust).replace("9865043008"," & ");;
		var link="DirectPurchaseSerial.jsp?pono="+salNo ;
		if(Status =="Y")
		{
			str=str+"<td class='boldEleven'><font class='boldgreen'>Received</font> </td>";
			str=str+"<td class='boldEleven'><a href='DirectGoodsReceiveViewList.jsp?gdreceiveno="+salNo +"'><font class='boldgreen'>View</font></a> </td>";
		}	
		else
		{
			if("N" == Cancel)
				str=str+"<td class='boldEleven'><a href='"+link+"'><font class='boldgreen'>Not Received</font></a> </td>";
			else
				str=str+"<td class='boldEleven'><font class='boldgreen'>Not Received</font></td>";
			str=str+"<td class='boldEleven'><font class='boldgreen'>--</font></a> </td>";
		}		
		
		str=str+"<td class='boldEleven'><font class='boldgreen'>"+PStatus +"</font> </td>";
		str=str+"<td class='boldEleven' align='right'>"+salTotal +"</td>";;
		sum =sum +parseFloat(salTotal );
		
		
		str=str+"<td class='boldEleven' align='center'><a href=\"javascript:Print('"+salNo+"')\"><font class='boldgreen'>Print</font></a> ";;
		str = str +"&nbsp; /&nbsp; <a href=\" javascript:sendMail('"+salNo+"')\"  ><font class='boldgreen'>Send a mail</font><a>";
		if((Status=="N")||(SalesStatus=="N"))
			if("N" == Cancel)
				if("F" == usertype || "B" == usertype)
					str = str +"&nbsp; /&nbsp; <a href=\"javascript:onClick=cancelInvoice('../SmartLoginAuth?filename=DirectPurchase&actionS=INVDirectPurchaseCancel&pono="+salNo+"')\"><font class='boldgreen'>Cancel</font></a>";;
		
		if("Y" == Cancel)
			str = str +"&nbsp; <img src='../Image/report/cancel.gif' border='0'/>";
		str=str+"</td>";
		
		
		str=str+"<td class='boldEleven' align='right'>"+PR +"</td>";;
		str=str+"<td class='boldEleven'>"+Entry +"</td>";
		str=str+"<td class='boldEleven'>"+TaxtypeGST +"</td>";
		str=str+" </tr>";
     }
     
     str=str+"<tr  class='MRow2'>";	
     str=str+"<td  class='boldEleven' colspan='9' align='right'><font  class='bolddeepred'>Total Amount ::</font></td>"; 
	 str=str+"<td  class='boldEleven' align='right' >"+Round(sum)+"</td> ";
	 str=str+"<td  class='boldEleven' align='right'>&nbsp;</td> ";
	 str=str+"<td  class='boldEleven' align='right'>&nbsp;</td> ";
	 str=str+"<td  class='boldEleven' align='right'>&nbsp;</td></tr>";
	 str=str+"</table>";
      
     console.log(str);
     var tb=document.getElementById('DirectPurchaseTable');
  	 tb.innerHTML=str   
  	 str="<font class='bolddeepred'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str
  	 
}


function Print(pono)
{
	var width="800", height="400";
	var left = (screen.width/2) - width/2;
	var top = (screen.height/2) - height/2;
	var f =false;
	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
	var f ="PrintDirectGoodsReceived.jsp?gdreceiveno="+pono +"&serialyes="+f;;
	 
	newWindow = window.open(f,"subWind",styleStr);
	newWindow.focus( );
	
}


function cancelInvoice(query)
{  
	
	var name=confirm("Are you Sure Confirm to Cancel")
	if (name==true)
	{
		var reason=prompt("Enter The Reason ","Cancelled"); 
		var email=prompt("Kindly give the email id for sending informations for cancelled invoice ","test@test.net"); 
		query = query+"&reason="+reason+"&email="+email;
		location = query;
		
	}	
}


function sendMail(pono)
{
		var r=confirm("ARE YOU SURE YOU WANT TO SEND THE INWARD "+pono +" TO MAIL ...");
		if (r==true)
	  	{
	  		var reason=prompt("Enter  Email id","test@test.com"); 
	  		if (reason!=null && reason!="")
  			{
	  			var d ="../SmartLoginAuth?filename=DirectPurchase&actionS=INVDirectPurchaseMail&email="+reason+"&pono="+pono;
	  			location = d;
				  
			}	
	  	}
}

var isIE;
var req;
var names;

function getElementY(element){
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
    }
	return target1Top;
}

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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
function LoadingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTableR(ctr1)
{
	 var str="<table width='100%' align=centet><tr><td class='errormessage'>Data not found</td></tr></table>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	
  	 
}
function Clear(ctr1)
{
	 var str="";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTableEmpty(ctr1)
{
	 var str="Empty ...";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



function clearSelect() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];

        if (element && element.options) {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}

function MessageInfo(msg)
{
	var p=window.createPopup()
	var pbody=p.document.body
	pbody.style.backgroundColor="#ffffff"
	pbody.style.border="solid black 1px"
	pbody.innerHTML="<CENTER><BR><font color='#FF0000'>"+msg+"</FONT><BR></CENTER>";
	p.show(350,550,200,50,document.body)
}
 
//Start -Kalaiselvan--------------------------LoadAMCServiceids--------------------
function LoadAMCServiceids() 
{
	var type=document.getElementById('payType').value; 
	var startLetter = document.getElementById('idsearch').value;    
	var url = "../inventory?actionS=INVAMCServiceids&StartLetter="+escape(startLetter)+"&type="+escape(type);
	initRequest(url);
	req.onreadystatechange = LoadAMCServiceidsRequest;
    req.open("GET", url, true);
    req.send(null);
}


function LoadAMCServiceidsRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTableR('Ams_Service_id');
    	if (req.status == 200) 
    	{		  	
         	LoadAMCServiceidsMessages();
        }
    }
}


function LoadAMCServiceidsMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("ServiceIds")[0];   
    	var str="<select name='Serviceids'  id='Serviceids' size='5' class='boldEleven'  onChange='AssignAmount(this)'>"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Serviceid= batch.getElementsByTagName("Serviceid")[0];
 			str = str+"<option value="+Serviceid.childNodes[0].nodeValue+">"+Serviceid.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById('Ams_Service_id');
  	   tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------LoadAMCServiceids--------------------
 

 //Start -Kalaiselvan--------------------------UniqueIdValidate--------------------
function UniqueId(tablename,fieldname,value) 
{
	var search =document.getElementById(value).value;
	var url = "../inventory?actionS=INVUniqueId&tablename="+escape(tablename);
	url = url +"&fieldname="+fieldname+"&value="+search;
	initRequest(url);
	req.onreadystatechange = UniqueIdRequest;
    req.open("GET", url, true);
    req.send(null);
}
function UniqueIdRequest() 
{
    if(req.readyState == 4) 
    {  
    	Clear('UniqueId');
		document.getElementById('Submit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	UniqueIdMessages();
        }
    }
}
function UniqueIdMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById('Submit').disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById('Submit').disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById('UniqueId');
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------UniqueIdValidate--------------------


 //Start -Kalaiselvan--------------------------loadServiceCompalintId--------------------
function loadservicecomplaintid() 
{
	var startLetter=document.getElementById('compalintid').value; 
	var url = "../inventory?actionS=INVServiceCompalintID&servicecompalintid="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = loadservicecomplaintidRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadservicecomplaintidRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTableEmpty('complaintid');
		document.getElementById('Submit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	loadservicecomplaintidMessages();
        }
    }
}
function loadservicecomplaintidMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("ComplaintIds")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Exsist= batch.getElementsByTagName("Exsist")[0];
	    	
	    	if(Exsist.childNodes[0].nodeValue == "TRUE")
	    	{
	    		str = str+"<font class='bolddeepred'>Exist</font>";
	    		document.getElementById('Submit').disabled=true;
	    	}	
	    	if(Exsist.childNodes[0].nodeValue == "FALSE")
	    	{
	    		str = str+"<font class='changePos'>Valid</font>";	
	    		document.getElementById('Submit').disabled=false;
	    	}	
        
	 	}
	 	var tb=document.getElementById('complaintid');
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------LoadServiceComplaintId--------------------
 
 
 //Start -Kalaiselvan--------------------------LoadServiceCall--------------------
function LoadServiceCall(startLetter) 
{
	var year=document.getElementById('year').value; 
	var month = document.getElementById('month').value;    
	var url = "../inventory?actionS=INVServiceCall&StartLetter="+escape(startLetter)+"&year="+escape(year)+"&month="+escape(month);
	initRequest(url);
	req.onreadystatechange = LoadServiceCallRequest;
    req.open("GET", url, true);
    req.send(null);
}
function LoadServiceCallRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTableR('divscroll');
    	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	LoadServiceCallMessages();
        }
    }
}
function LoadServiceCallMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Servicecalls")[0];   
    	var str="<center><table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Servicerowid= batch.getElementsByTagName("Servicerowid")[0];
 			Serviceid= batch.getElementsByTagName("Serviceid")[0];
 			Staff= batch.getElementsByTagName("Staff")[0];
 			Customername = batch.getElementsByTagName("Customername")[0];
 			Customerid = batch.getElementsByTagName("Customerid")[0];
 			Customerflag = batch.getElementsByTagName("Customerflag")[0];
 			Desc = batch.getElementsByTagName("Desc")[0];
 			Startdt = batch.getElementsByTagName("Startdt")[0];
 			Attendt = batch.getElementsByTagName("Attendt")[0];
 			Enddt = batch.getElementsByTagName("Enddt")[0];
 			Status = batch.getElementsByTagName("Status")[0];
	 	 	if(loop%2==1)
        		str = str+"<tr class='MRow2'>";
        	else
        		str = str+"<tr class='MRow1'>";
        	str = str+"<td   class='boldEleven'><input type='checkbox' name='Serviceid' value='"+Servicerowid.childNodes[0].nodeValue+"'><a href=ServiceCallEdit.jsp?Serviceid="+Servicerowid.childNodes[0].nodeValue+"><font color='#000000'>"+Serviceid.childNodes[0].nodeValue+"</font></a>";
        	str = str+"<td class='boldEleven'>"+Staff.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Customername.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Startdt.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Attendt.childNodes[0].nodeValue;
        	str = str+"<td class='boldEleven'>"+Enddt.childNodes[0].nodeValue;
        	if(Status.childNodes[0].nodeValue =="Y")
        		str = str+"<td  class='boldEleven'>Completed";
        	else
       			str = str+"<td  class='boldEleven'>Not Completed";
        	
	 	}
	 	
	 	if(batchs.childNodes.length<1)
	 	{
	 		str = str+"<tr><td colspan=8 class='errormessage'>Data not found....</td>";
	 		document.getElementById('Delete').disabled=true;
     		document.getElementById('Edit').disabled=true;
	 	}
	 	else
	 	{
	 	document.getElementById('Delete').disabled=false;
     	document.getElementById('Edit').disabled=false;
	 	}	
	 	str=str+"</table></center>";
	 	 
	 	var tb=document.getElementById('divscroll');
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------LoadAMC--------------------
 
 
//Start :: KALAISELVAN  ----------------------Load AMC Customer-----------------------
function loadAMCCustomer() {	
    var txtSer1=document.getElementById('txtSer').value; 	
    var type = document.getElementById('customertype').value; 	
    var url = "../inventory?actionS=INVAMCCustomer&StartLetter="+escape(txtSer1)+"&types="+type;
    initRequest(url);
    req.onreadystatechange =customerAMCRequest;
    req.open("GET", url, true);
    req.send(null);
}
function customerAMCRequest() {
   
    if (req.readyState == 4) {
    	Clear('customerids');
    	document.getElementById('submit').disabled=true;
        if (req.status == 200) {       	 
         customerAMCMessages();
        }
    }
}
function customerAMCMessages() 
{
     
    var batchs = req.responseXML.getElementsByTagName("IDs")[0];
	var str = "<select size =5 name='customerid' id='customerid' class='formText135'>";
    for (loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
        var Customerid = batch.getElementsByTagName("Customerid")[0];        
        var Customername = batch.getElementsByTagName("Customername")[0];
        str = str+"<option  value='"+Customerid.childNodes[0].nodeValue+"'>"+ Customername.childNodes[0].nodeValue+"</option>";
    }		
    
    if(batchs.childNodes.length<1)
    {
   		str = str =+"<option value='0' selected='selected'>Select</option>";
    	str = str =+"<option value='' >Data not found...</option>";
    	document.getElementById('submit').disabled=true;
    	tableid.style.visibility="hidden";
    }
    else
    {
    	var tb=document.getElementById('customerids');
  		tb.innerHTML=str  ; 
  		document.getElementById('submit').disabled=false;
  		tableid.style.visibility="visible";
  	}	
  	str=str+"</select>"; 
  	 
}
//END  :: KALAISELVAN ----------------------Load AMC Customer-----------------------


//Start -Kalaiselvan--------------------------LoadAMC--------------------
function LoadAMC(startLetter) 
{
	
	var customertype =document.getElementById('customertype').value; 
	var year=document.getElementById('year').value;    
	var url = "../inventory?actionS=INVAMC&customertype="+customertype+"&StartLetter="+escape(startLetter)+"&year="+year;
	initRequest(url);
	req.onreadystatechange = LoadAMCRequest;
    req.open("GET", url, true);
    req.send(null);
}
function LoadAMCRequest() 
{
    if(req.readyState == 4) 
    {  
    	ClearTableR('amctable');
    	document.getElementById('Delete').disabled=true;
     	document.getElementById('Edit').disabled=true;
    	if (req.status == 200) 
    	{		  	
         	LoadAMCMessages();
        }
    }
}
function LoadAMCMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("AMCs")[0];   
    	var str="<table width='100%' >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Amcid = batch.getElementsByTagName("Amcid")[0];
        	var Customername = batch.getElementsByTagName("Customername")[0];
        	var Startdate = batch.getElementsByTagName("Startdate")[0];
        	var Enddate = batch.getElementsByTagName("Enddate")[0];
        	var Renewal = batch.getElementsByTagName("Renewal")[0];
        	if(loop % 2 == 0)
        		str = str+"<tr class='MRow2'>";
        	else
        		str = str+"<tr class='MRow1'>";
        	str = str+"<td width='12%' class='boldEleven'><input type='checkbox' name='amcid' id='amcid' value='"+Amcid.childNodes[0].nodeValue+"'><a href='AMCEdit.jsp?amcid="+Amcid.childNodes[0].nodeValue+"'><font class='boldgreen'>"+Amcid.childNodes[0].nodeValue+"</font>";
        	str = str+"<td width='28%' class='boldEleven'>"+Customername.childNodes[0].nodeValue;
        	str = str+"<td width='23%' class='boldEleven'>"+Startdate.childNodes[0].nodeValue;
        	str = str+"<td width='20%' class='boldEleven'>"+Enddate.childNodes[0].nodeValue;
        	str = str+"<td width='14%' class='boldEleven'>"+Renewal.childNodes[0].nodeValue;
        }
	 	
	 	
	 	if(batchs.childNodes.length<1)
	 	{
	 		str = str+"<tr><td colspan=6 class='errormessage'><center>Data not found....</center></td>";
	 		
	 		document.getElementById('Delete').disabled=true;
     		document.getElementById('Edit').disabled=true;
	 	}	
	 	else
	 	{
	 		document.getElementById('Delete').disabled=false;
     		document.getElementById('Edit').disabled=false;
	 
	 	}
	 	 
	 	str=str+"</table>";
	 	var tb=document.getElementById('amctable');
  	 	tb.innerHTML=str  ; 
 }
 //End -Kalaiselvan--------------------------LoadAMC--------------------
 

//Start -Kalaiselvan--------------------------LoadPurchaseIdCheck--------------------
function LoadPurchaseIdCheck() 
{
	var ponumber = document.getElementById('ponumber').value;
	var url = "../inventory?actionS=INVPurchaseIdCheck&userName="+escape(ponumber);
	initRequest(url);
	req.onreadystatechange = LoadPurchaseIdCheckRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LoadPurchaseIdCheckRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	LoadPurchaseIdCheckMessages();
        }
    }
}
function LoadPurchaseIdCheckMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    		
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById('UserTable');
  	 	tb.innerHTML=str  ; 
  	 
 }
//End -Kalaiselvan--------------------------LoadPurchaseIdCheck---------------------


//Start -Kalaiselvan--------------------------LoadBranch--------------------
function LoadBranch()
{
	var companyid = document.getElementById('company').value;
	var url = "../inventory?actionS=INVloadBranch&companyid="+escape(companyid);
	initRequest(url);
	req.onreadystatechange = LoadBranchRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LoadBranchRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	LoadBranchMessages();
        }
    }
}


function LoadBranchMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Branchs")[0];   
    	var str="<select name='branchid' class='formText135' >"; 
//    	str=str+"<option value='Select'>Select</option>";
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Branchid = batch.getElementsByTagName("Branchid")[0];
        	var Branchname = batch.getElementsByTagName("Branchname")[0];
        	str=str+"<option value="+Branchid.childNodes[0].nodeValue+" >"+Branchname.childNodes[0].nodeValue+"</option>";
	 	}
	 	str=str+"</select>";
	 	var tb=document.getElementById('BranchTable');
  	 	tb.innerHTML=str  ; 
  	 
 }
//End -Kalaiselvan--------------------------LoadBranch---------------------


//Start - Author :: Kalaiselvan----------------------Purchase-----------------------

//Start - Author :: Kalaiselvan----------------------Goods Received-----------------------

//End  - Author :: kalaiselvan -----------------------Purchse---------------------------


//Start - Author :: Kalaiselvan----------------------Goods Return-----------------------

//End - Author :: Kalaiselvan----------------------Goods Return-----------------------

 

//Start -Kalaiselvan-------------------------Customer--------------------

function loadCustomer() 
{	
    var txtSer1=document.getElementById('txtSer').value; 	
    var url = "../inventory?actionS=INVCustomer&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange =customerRequest;
    req.open("GET", url, true);
    req.send(null);
}

function customerRequest() 
{
   	if (req.readyState == 4) 
   	{
        if (req.status == 200) 
        {       	 
        	 customerMessages();
        }
    }
}

function customerMessages() 
{
   var batchs = req.responseXML.getElementsByTagName("customers")[0];
   
   var _targ=document.getElementsByName('customerId')[0];       
   _targ.options.length=0;	
    for (loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	   	var batch = batchs.childNodes[loop];
       	var firstName = batch.getElementsByTagName("customerName")[0];        
       	var batchId = batch.getElementsByTagName("id")[0];
	 	disName =firstName.childNodes[0].nodeValue+" / "+batchId.childNodes[0].nodeValue;
  		_targ.options[loop]=new Option(disName,batchId.childNodes[0].nodeValue);
    }		
	_targ.options.length=loop;
	_targ.selectedIndex=0;
		//_targ.onchange();    
}





//Start -Kalaiselvan--------------------------LoadQuotationIdCheck--------------------
function LoadQuotationIdCheck() 
{
	var quoNumber = document.getElementById('quoNumber').value;
	var url = "../inventory?actionS=INVQuotationIdCheck&quoNumber="+escape(quoNumber);
	initRequest(url);
	req.onreadystatechange = LoadQuotationIdCheckRequest;
    req.open("GET", url, true);
    req.send(null);
}
function LoadQuotationIdCheckRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	LoadPurchaseIdCheckMessages();
        }
    }
}
function LoadQuotationIdCheckMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table width=50 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	alert(str);
	 	str=str+"</table>";
	 	var tb=document.getElementById('UserTable');
  	 	tb.innerHTML=str  ; 
 }
//End -Kalaiselvan--------------------------LoadQuotationIdCheck---------------------









//Start -Kalaiselvan----------------------LoadSaleNumber------------------------

//End -Kalaiselvan--------------------------LoadSaleNumber---------------------




//Start -Kalaiselvan----------------------LoadSaleNumberItems------------------------

//End -Kalaiselvan--------------------------LoadSaleNumberItems---------------------








//Start -Kalaiselvan----------------------SalesReturn------------------------

//End -Kalaiselvan--------------------------SalesReturn---------------------


//Start - NPR--------------------------LoadCustomerPurchaseNo--------------------
var dId;
function CheckUniqueNO(sval,divId,tableName,filedName) 
{
	var quoNumber = sval.value;
	var url = "../inventory?actionS=INVCheckUnique";
	url=url+"&quoNumber="+escape(quoNumber);
	url=url+"&tableName="+escape(tableName)+"&fieldName="+escape(filedName);	
	initRequest(url);	
	dId=divId;	
	req.onreadystatechange = CheckCustPONORequest;
    req.open("GET", url, true);
    req.send(null);
}
function CheckCustPONORequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
			//alert("ASDqwe");
         	CheckCustPONOMessages();
        }
    }
}
function CheckCustPONOMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("Usernames")[0];   
    	var str="<table width=50 >"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Status = batch.getElementsByTagName("Status")[0];
        	if(Status.childNodes[0].nodeValue == "true")
        	{
	    		document.getElementById('Submit').disabled=true;
	    		str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
	    	}
	    	else
	    	{
	    		document.getElementById('Submit').disabled=false;
	    		str = str+"<tr><td class='changePos'>Valid...</td></tr>";
	    	}	
	 	}
	 	str=str+"</table>";
	 	var tb=document.getElementById(dId);
  	 	tb.innerHTML=str  ; 
 }
 
 
//End -NPR--------------------------LoadCustomerPurchaseNo---------------------



//Start Kalai--------------------------AMC Payment---------------------
function AMCPayment(startLetter)
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;  
	var payType=document.getElementById('payType').value;
	var url = "../inventory?actionS=INVAMCPayment&month="+escape(mon)+"&year="+escape(yea)+"&payType="+payType+"&id="+escape(startLetter);
    initRequest(url);
	req.onreadystatechange = payTypes;
	req.open("GET",url,true);
	req.send(null);
} 
function payTypes()
{
	if(req.readyState==4)
	{
		ClearTableR('PaymentTable');
		document.getElementById('btnEdit').disabled = true;
	 	document.getElementById('btnDelete').disabled = true;
		if (req.status == 200)
		{
			LoadPayTypes();
		}
	}
}


function LoadPayTypes()
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Payments")[0];   
	str=str+"<table width='100%' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='0' cellspacing='0'>";
	var dt="";
	var ch="";
	var t = document.getElementById('payType').value;
	var f ="";
	if(t === "Invoice")
		f ="A"
	if(t === "CashPay")
		f ="S"
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
		var AmcServiceid = batch.getElementsByTagName("AmcServiceid")[0];
		var Customerid = batch.getElementsByTagName("Customerid")[0];
		var Customername = batch.getElementsByTagName("Customername")[0];
		var Date = batch.getElementsByTagName("Date")[0];
		var Amount = batch.getElementsByTagName("Amount")[0];
		var PaidAmount = batch.getElementsByTagName("PaidAmount")[0];
		var Balance = batch.getElementsByTagName("Balance")[0];
		var Status = batch.getElementsByTagName("Status")[0];
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<tr>"
		var s =AmcServiceid.childNodes[0].nodeValue+"~"+f+"~";
		str=str+"<td width='114' class='boldEleven'><input name='salesid' id ='salesid' type='checkbox' value='"+s+"'/>";
		str=str+"<a href='AMCPaymentEdit.jsp?salesid="+s+"'><font color='#000000'>"+ AmcServiceid.childNodes[0].nodeValue+"</font>";
		str=str+"<td width='101' class='boldEleven'>"+Date.childNodes[0].nodeValue;
		str=str+"<td width='151' class='boldEleven'>"+Customername.childNodes[0].nodeValue;
		str=str+"<td width='117' class='boldEleven'>"+Amount.childNodes[0].nodeValue;
		str=str+"<td width='88' class='boldEleven'>"+PaidAmount.childNodes[0].nodeValue;
		str=str+"<td width='132' class='boldEleven'>"+Balance.childNodes[0].nodeValue;
		str=str+"<td width='51' class='boldEleven'>"+Status.childNodes[0].nodeValue;
     }
     if(batchs.childNodes.length <=0)
     {
     	str = str+"<td  class='errormessage' colspan='6' height=100><center>Data not found...</center></td>";
     	document.getElementById('btnEdit').disabled = true;
	 	document.getElementById('btnDelete').disabled = true;
     }
     else
     {
     	document.getElementById('btnEdit').disabled = false;
	 	document.getElementById('btnDelete').disabled = false;
     
     }
    
     str=str+"</table>";
     var tb=document.getElementById('PaymentTable');
  	 tb.innerHTML=str  ; 

}
//End Kalai--------------------------AMC Payment---------------------







//Start Kalai--------------------------QuotationEdit---------------------
var divname="";
var itemid="";
function QuotationEdit(itype,itemids,diviname)
{
	divname = diviname;
	itemid = itemids;
	var url = "../inventory?actionS=INVQuotationEdit&type="+escape(itype);
    initRequest(url);
	req.onreadystatechange = QuotationEditRequest;
	req.open("GET",url,true);
	req.send(null);
	alert();
} 

function QuotationEditRequest()
{
	if(req.readyState==4)
	{
		if (req.status == 200)
		{
			QuotationEditMessages();
		}
	}
}
function QuotationEditMessages()
{
	   
    var batchs = req.responseXML.getElementsByTagName("items")[0];   
   	var idposition = divname.replace("div","");
	s1 ='item'+idposition;
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135' onblur=\"assignValues(this,'"+idposition+"')\">"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
			
			if(itemid === Id.childNodes[0].nodeValue)
				str = str+"<option selected='selected' value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
			else
				str = str+"<option  value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";	
			
       }
       str=str+"</select>";
	   var tb=document.getElementById(divname);
  	   tb.innerHTML=str  ; 

}
//End Kalai--------------------------QuotationEdit---------------------





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
//--------------------Clear Select ---------------------
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


//-------------------Item Select-------------------------------
function loadSelectItem() {	
  
    var id=document.getElementById('selProduct').value;
    var txtSer1="";//document.getElementById('txtSer').value;        
    var url = "../marketing?actionS=MKTItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = itemSelectRequest;
    req.open("GET", url, true);
    req.send(null);
}
function itemSelectRequest() {
    if (req.readyState == 4) {
        if (req.status == 200) {
         itemSelectMessages();
        }
    }
}
function itemSelectMessages() {
   	clearSelect('itemId');
    var batchs = req.responseXML.getElementsByTagName("items")[0];
    var _targ=document.getElementsByName('itemId')[0];       
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("itemName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
		 disName =firstName.childNodes[0].nodeValue+" / "+batchId.childNodes[0].nodeValue;
        _targ.options[loop]=new Option(disName,batchId.childNodes[0].nodeValue);
        }		
		_targ.options.length=loop;
		_targ.selectedIndex=0;
		//_targ.onchange();  

}
//----------------------Item List-----------------------
function loadItem() {
    var id=document.getElementById('selProduct').value;
   // alert("id"+id);
    var txtSer1=document.getElementById('txtSer').value;        
    var url = "../marketing?actionS=MKTItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    alert(url);
    initRequest(url);
    req.onreadystatechange = itemRequest;
    req.open("GET", url, true);
    req.send(null);
}
function loadItemC(sval) {
	document.getElementById('txtSer').value=sval;
    var id=document.getElementById('selProduct').value;
    var txtSer1=document.getElementById('txtSer').value;  
       txtSer1=txtSer1.toUpperCase();   
    var url = "../marketing?actionS=MKTItem&id="+escape(id)+"&txtSer="+escape(txtSer1);
    initRequest(url);
    req.onreadystatechange = itemRequest;
    req.open("GET", url, true);
    req.send(null);
}
function itemRequest() {
    if(req.readyState == 4) {
        ClearTableTrible('ItemTable');
        document.getElementById('btnDelete').disabled=true;
        document.getElementById('btnEdit').disabled=true;
        if (req.status == 200) {
          itemMessages();
        }
    }
}
function itemMessages() {
    var batchs = req.responseXML.getElementsByTagName("items")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var batchId = batch.getElementsByTagName("id")[0];
        var firstName = batch.getElementsByTagName("itemName")[0];
        var itemDes = batch.getElementsByTagName("itemDes")[0];
        var itemStock = batch.getElementsByTagName("itemStock")[0];
        var itemPurPrice = batch.getElementsByTagName("itemPurPrice")[0];
        var itemSalesPrice = batch.getElementsByTagName("itemSalesPrice")[0];
        var itemActive = batch.getElementsByTagName("itemActive")[0];                                    
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='15px' align='right' class='boldEleven'>"+(loop+1);
		itemId=batchId.childNodes[0].nodeValue;
		str=str+"<td width='125px'><input type='checkbox' name='itemId' value='"+itemId+"'>";
		str=str+"<font class='boldEleven'>"+batchId.childNodes[0].nodeValue;
		str=str+"</font>";		
		str=str+"<td width='160px'  class='boldEleven'>"+"<a href='ItemAction.jsp?action1=Edit&itemId="+itemId+"'><font class='boldEleven'>"+firstName.childNodes[0].nodeValue;
		str=str+"</font></a>";
		str=str+"<td width='75px' align=center class='boldEleven'>"+itemStock.childNodes[0].nodeValue;
		str=str+"<td width='75px' align=center class='boldEleven'>"+itemPurPrice.childNodes[0].nodeValue;
		str=str+"<td width='75px' align=center class='boldEleven'>"+itemSalesPrice.childNodes[0].nodeValue;
		str=str+"<td width='75px' align=center class='boldEleven'>"+itemActive.childNodes[0].nodeValue;						
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('btnDelete').disabled=false
     document.getElementById('btnEdit').disabled=false  	 
}
function ClearTableTrible(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    
  	 
}




//----------------------phone---------------------
function loadPhone(startletter) 
{
	var branch=document.getElementById('branch').value;
	var url = "../marketing?actionS=MKTphone&id="+escape(branch);
	initRequest(url);
    req.onreadystatechange = PhoneRequest;
    req.open("GET", url, true);
    req.send(null);
}
function PhoneRequest()
{
    if(req.readyState == 4) {    	
        ClearTable('marketing');        
        if (req.status == 200) {		  	
          PhoneMessages();
        }
    }
}
function PhoneMessages()
{
    var batchs = req.responseXML.getElementsByTagName("phones")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var phoneId = batch.getElementsByTagName("Id")[0];
        var phoneNo = batch.getElementsByTagName("phoneNo")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		str=str+"<td width='125px'><input type='checkbox' name='phoneId' value='"+phoneId.childNodes[0].nodeValue+"'>"+phoneNo.childNodes[0].nodeValue;	
		str=str+"</td></tr>"; 	
     }
     str=str+"</table>";
     var tb=document.getElementById('marketing');
  	 tb.innerHTML=str     	 
}
function ClearTable(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Incentive----------------------------------------------
function loadIncentive(startLetter) 
{	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTIncentive&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange=IncentiveRequest;
    req.open("GET", url, true);
    req.send(null);
}
function IncentiveRequest() {
    if(req.readyState == 4) {    	
        ClearTables('incentiveTable');       
        if (req.status == 200) {		  	
          IncentiveMessages();
        }
    }
}
function IncentiveMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("incentives")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var Incentiveid = batch.getElementsByTagName("Incentiveid")[0];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0]; 
        var Amount = batch.getElementsByTagName("Amount")[0];         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td width='20' class='boldEleven'><input name='incentive' id='incentive' type='checkbox' value='"+Incentiveid.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"'/>"
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'><a href='IncentiveEdit.jsp?incentive="+Incentiveid.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"'><font class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"</font></a>";		
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+Amount.childNodes[0].nodeValue;
    }
    if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('incentiveTable');
  	tb.innerHTML=str;   	
}
function ClearTables(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


//----------------------------------Retailer Allocation----------------------------------------------
function loadAllocateRetailer(startLetter) 
{	

	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTAllocateRetailer&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	
	req.onreadystatechange=LoadAllRetailerRequest;
    req.open("GET", url, true);
    req.send(null);
}
function LoadAllRetailerRequest() {
    if(req.readyState == 4) {    	
        ClearTableFour('retailerAllocateTable');       
        if (req.status == 200) {		  	
          LoadAllRetailerMessages();
        }
    }
}
function LoadAllRetailerMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("AllRetailers")[0];   
    var str=""; 
	str=str+"<table width='883' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var Staffid = batch.getElementsByTagName("Staffid")[0];	    
	    var Staffname = batch.getElementsByTagName("Staffname")[0];    
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0];         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			   
		str=str+"<td width='130' class='boldEleven'><input name='Staffid' id='Staffid' type='checkbox' value='"+Staffid.childNodes[0].nodeValue+"'/>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;	
    }
    if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('retailerAllocateTable');
  	tb.innerHTML=str;   	
}
function ClearTableFour(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



//----------------------------------Doctor Allocation----------------------------------------------
function loadAllocateDoctor(startLetter) 
{	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTAllocateDoctor&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange=LoadAllDoctorRequest;
    req.open("GET", url, true);
    req.send(null);
}
function LoadAllDoctorRequest() {
    if(req.readyState == 4) {    	
        ClearTableTwo('doctorAllocateTable');       
        if (req.status == 200) {		  	
          LoadAllDoctorMessages();
        }
    }
}
function LoadAllDoctorMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("AllDoctors")[0];   
	var smonth=document.getElementById('month').value;
    var syear=document.getElementById('year').value;        

    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var Staffid = batch.getElementsByTagName("Staffid")[0];	    
	    var Staffname = batch.getElementsByTagName("Staffname")[0].childNodes[0].nodeValue;    
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0];         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			   
			str=str+"<td width='130' class='boldEleven'><input name='Staffid' id='Staffid' type='checkbox' value='"+Staffid.childNodes[0].nodeValue+"'/>&nbsp;"+Staffid.childNodes[0].nodeValue;
			str=str+"<td width='130' class='boldEleven'><a href=AppointmentView.jsp?month="+smonth+"&year="+syear+"&Staffid="+Staffid.childNodes[0].nodeValue+"&submit=Edit>&nbsp;<font color='blue'>"+Staffname+"</font></a>";
			str=str+"<td width='130' class='boldEleven'>&nbsp;"+Depart.childNodes[0].nodeValue;
			str=str+"<td width='130' class='boldEleven'>&nbsp;"+Desig.childNodes[0].nodeValue;	
    }
    if(batchs.childNodes.length<1)
    str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
    str=str+"</table>";
    var tb=document.getElementById('doctorAllocateTable');
  	tb.innerHTML=str;   	
}
function ClearTableTwo(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Target----------------------------------------------
function loadTarget(startLetter) 
{	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTTarget&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	//alert("sss :"+url);
	initRequest(url);
	req.onreadystatechange = TargetRequest;
    req.open("GET", url, true);
    req.send(null);
}
function TargetRequest(){
    if(req.readyState == 4){    	
        ClearTl('targetTable'); 
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true;      
        if (req.status == 200){		  	
          TargetMessages();
        }
    }
}
function TargetMessages() 
{	 
   var batchs = req.responseXML.getElementsByTagName("targets")[0];   
   var str=""; 
   str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart=batch.getElementsByTagName("Depart")[0]; 
        var Desig=batch.getElementsByTagName("Desig")[0]; 
         var Status=batch.getElementsByTagName("QtyStatus")[0]; 
       // var Qty=batch.getElementsByTagName("Qty")[0]; 
       // var Price=batch.getElementsByTagName("Price")[0]; 
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'><input name='staffid' id='staffid' type='checkbox' value='"+Empid.childNodes[0].nodeValue+"' />"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'><a href='TargetEdit.jsp?staffid="+Empid.childNodes[0].nodeValue+"'><font class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Status.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+Qty.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+Price.childNodes[0].nodeValue;
    }     
     if(batchs.childNodes.length<1)
     str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
        if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
     var tb=document.getElementById('targetTable');
  	 tb.innerHTML=str  ;   	
}
function ClearTl(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//-------------------Primary scale-------------
function loadPrimaryStock(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTPrimaryScale&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	alert("url :"+url);
	initRequest(url);
	req.onreadystatechange = PrimaryRequest;
    req.open("GET", url, true);
    req.send(null);
}
function PrimaryRequest() {
    if(req.readyState == 4) {    	
        ClearTable4('PrimaryTable');
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true;
        if (req.status== 200) {		  	
          primaryMessages();
        }
    }
}
function primaryMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("PrimaryScales")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	    
	    var batch = batchs.childNodes[loop];
	    var primaryId = batch.getElementsByTagName("primaryId")[0];
	    var superName = batch.getElementsByTagName("superName")[0];	 
        var dtOfsale = batch.getElementsByTagName("DtOfSale")[0];           
	    var qty = batch.getElementsByTagName("qty")[0];        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			   			 
		str=str+"<td width='130' class='boldEleven'><input name='primaryId' id='primaryId' type='checkbox' value='"+primaryId.childNodes[0].nodeValue+"' />"+primaryId.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'><a href='PrimaryStockEdit.jsp?primaryId="+primaryId.childNodes[0].nodeValue+"'><font class='boldEleven'>"+superName.childNodes[0].nodeValue;		
		str=str+"<td width='130' class='boldEleven'>"+dtOfsale.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+qty.childNodes[0].nodeValue;	
    }
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
    if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
     var tb=document.getElementById('PrimaryTable');
  	 tb.innerHTML=str  ;   	 
  	
}

function ClearTable4(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//-------------------Primary scale Distributor-------------
function loadPrimaryDistributor(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTPrimaryDistributor&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = primaryDistributorRequest;
    req.open("GET", url, true);
    req.send(null);
}

function primaryDistributorRequest() {
    if(req.readyState == 4) {    	
        ClearTable5('PrimaryDistributorTable');
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
        if (req.status== 200) {		  	
          primaryDistributorMessages();
        }
    }
}
function primaryDistributorMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("PrimaryDistributors")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	   var primaryId = batch.getElementsByTagName("primaryId")[0];
	    var distributorName = batch.getElementsByTagName("disName")[0];	 
        var dtOfsale = batch.getElementsByTagName("DtOfSale")[0];           
	    var qty = batch.getElementsByTagName("qty")[0]; 
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='primaryId' id='primaryId' type='checkbox' value='"+primaryId.childNodes[0].nodeValue+"' />"+primaryId.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'><a href='PrimaryScaleDistributorEdit.jsp?primaryId="+primaryId.childNodes[0].nodeValue+"'><font class='boldEleven'>"+distributorName.childNodes[0].nodeValue;		
		str=str+"<td width='130' class='boldEleven'>"+dtOfsale.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+qty.childNodes[0].nodeValue;	
	
    }
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
     var tb=document.getElementById('PrimaryDistributorTable');
  	 tb.innerHTML=str  ;   	 
  	
}

function ClearTable5(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str   
}

//-------------------Sample-------------
function loadSample(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTSample&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	alert(url);
	initRequest(url);
	req.onreadystatechange = sampleRequest;
    req.open("GET", url, true);
    req.send(null);
}

function sampleRequest() {
    if(req.readyState == 4) {    	
        ClearTable8('SampleTable');
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true;
        if (req.status== 200) {		  	
          sampleMessages();
        }
    }
}
function sampleMessages() 
{	 

    var batchs = req.responseXML.getElementsByTagName("Samples")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    
	      var sampleId = batch.getElementsByTagName("sampleId")[0];
	    var doctorName = batch.getElementsByTagName("doctorName")[0];	 
        var dtOfsale = batch.getElementsByTagName("DtOfSale")[0];           
	    var qty = batch.getElementsByTagName("qty")[0]; 
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='sampleId' id='sampleId' type='checkbox' value='"+sampleId.childNodes[0].nodeValue+"' />"+sampleId.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'><a href='SampleEdit.jsp?sampleId="+sampleId.childNodes[0].nodeValue+"'><font class='boldEleven'>"+doctorName.childNodes[0].nodeValue;		
		str=str+"<td width='130' class='boldEleven'>"+dtOfsale.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+qty.childNodes[0].nodeValue;	
	
    }
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
     var tb=document.getElementById('SampleTable');
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
  	 tb.innerHTML=str  ;   	 
  	
}

function ClearTable8(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


//-------------------Secondary Scale Distributor-------------



function loadSecondaryDistributor(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTSecondaryDistributor&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	alert(url);
	initRequest(url);
	req.onreadystatechange = SecondaryDistributorRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SecondaryDistributorRequest() {
    if(req.readyState == 4) {    	
        ClearTable6('SecondaryDistributorTable');
        if (req.status== 200) {		  	
          SecondaryDistributorMessages();
        }
    }
}
function SecondaryDistributorMessages() 
{	 

    var batchs = req.responseXML.getElementsByTagName("SecondaryDistributors")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var disid = batch.getElementsByTagName("disid")[0];
	    var itemName = batch.getElementsByTagName("Itemid")[0];
	    var distName = batch.getElementsByTagName("DistributorName")[0];
        var dtOfsale = batch.getElementsByTagName("DtOfSale")[0];           
	    var qty = batch.getElementsByTagName("qty")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='staffid' id='staffid' type='checkbox' value='"+disid.childNodes[0].nodeValue+"' />"+disid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+itemName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+distName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+dtOfsale.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+qty.childNodes[0].nodeValue;
	
    }
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
     var tb=document.getElementById('SecondaryDistributorTable');
  	 tb.innerHTML=str  ;   	 
  	
}

function ClearTable6(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//-------------------Complement-------------

function loadComplement(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTComplement&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	initRequest(url);
	req.onreadystatechange = ComplementRequest;
    req.open("GET", url, true);
    req.send(null);
}

function ComplementRequest() {
    if(req.readyState == 4) {    	
        ClearTable7('ComplementTable');
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 
        if (req.status== 200) {		  	
          complementMessages();
        }
    }
}
function complementMessages() 
{	 

    var batchs = req.responseXML.getElementsByTagName("Complements")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Compid = batch.getElementsByTagName("Compid")[0];
	    var CompName = batch.getElementsByTagName("CompName")[0];
	    var DtOfComplement = batch.getElementsByTagName("DtOfComplement")[0];
        var price = batch.getElementsByTagName("price")[0];           
	    var qty = batch.getElementsByTagName("qty")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='compid' id='compid' type='checkbox' value='"+Compid.childNodes[0].nodeValue+"' />"+Compid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+CompName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+DtOfComplement.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+qty.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+price.childNodes[0].nodeValue;
	
    }
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
    if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
     var tb=document.getElementById('ComplementTable');
  	 tb.innerHTML=str  ;   	 
  	
}

function ClearTable7(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//-------------------Primary scale Distributor-------------
   function loadAcademic(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTAcademic&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	initRequest(url);
	req.onreadystatechange = AcademicRequest;
    req.open("GET", url, true);
    req.send(null);
}

function AcademicRequest() {
    if(req.readyState == 4) {    	
        ClearTableOne('AcademicTable');
        if (req.status== 200) {		  	
          AcademicMessages();
        }
    }
}
function AcademicMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Academics")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Academicid = batch.getElementsByTagName("Academicid")[0];
	    var AcaName = batch.getElementsByTagName("AcaName")[0];
	    var AcaPerson = batch.getElementsByTagName("AcaPerson")[0];
        var DtOfAcademic = batch.getElementsByTagName("DtOfAcademic")[0];           
	    var price = batch.getElementsByTagName("price")[0];
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='130' class='boldEleven'><input name='Academicid' id='Academicid' type='checkbox' value='"+Academicid.childNodes[0].nodeValue+"' />"+Academicid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+AcaName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+AcaPerson.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+DtOfAcademic.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+price.childNodes[0].nodeValue;
	
    }
    
   
    if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
   
    str=str+"</table>";
     var tb=document.getElementById('AcademicTable');
  	 tb.innerHTML=str  ;   	
  	
}

function ClearTableOne(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Training----------------------------------------------
function loadTraining(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTTraining&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	initRequest(url);
	req.onreadystatechange = TrainingRequest;
    req.open("GET", url, true);
    req.send(null);
}

function TrainingRequest() {
    if(req.readyState == 4) {    	
        ClearTablessss('TrainingTable');       
        if (req.status == 200) {		  	
          TrainingMessages();
        }
    }
}
function TrainingMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Trainings")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   
	    var batch = batchs.childNodes[loop];
	    var programId = batch.getElementsByTagName("programId")[0];
	    var programName = batch.getElementsByTagName("programName")[0];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart=batch.getElementsByTagName("Depart")[0]; 
        var Desig=batch.getElementsByTagName("Desig")[0];         
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='20' class='boldEleven'><input name='programid' id='programid' type='checkbox' value='"+programId.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"' />";
		//str=str+"<td width='130' class='boldEleven'>"+programName.childNodes[0].nodeValue;
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		
    }
     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('TrainingTable');
  	 tb.innerHTML=str  ; 
  	
}
function ClearTablessss(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//------------------------------ SuperStock ----------------------
function loadSuperStock(startLetter) 
{	    
    var url = "../marketing?actionS=MKTSuperStock&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = SuperStockRequest;
    req.open("GET", url, true);
    req.send(null);
}

function SuperStockRequest() {
    if(req.readyState == 4) {    	
        ClearTablessss('SuperStockTable'); 
        document.getElementById('action12').disabled=true;
        document.getElementById('Submit3').disabled=true;        
        if (req.status == 200) {		  	
          SuperStockMessages();
        }
    }
}
function SuperStockMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("SuperStocks")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   
	    var batch = batchs.childNodes[loop];
	    var SuperStockId = batch.getElementsByTagName("SuperStockId")[0];
	    var Name = batch.getElementsByTagName("Name")[0];
	    var LName = batch.getElementsByTagName("LName")[0];
	    var City = batch.getElementsByTagName("City")[0];
	    var State = batch.getElementsByTagName("State")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];     
        var Fax=batch.getElementsByTagName("Fax")[0]; 
        var Active=batch.getElementsByTagName("Active")[0];         
        var Since=batch.getElementsByTagName("Since")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'><input name='SuperStockId' id='SuperStockId' type='checkbox' value='"+SuperStockId.childNodes[0].nodeValue+"' />"+SuperStockId.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+LName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+State.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Fax.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Active.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Since.childNodes[0].nodeValue;
		
    }
     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('SuperStockTable');
  	 tb.innerHTML=str  ; 
  	 str="Total no of Records :: "  + loop
  	 if(loop!=0)
  	 {
  	 document.getElementById('Submit3').disabled=false;
     document.getElementById('action12').disabled=false;
  	 }  	
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 
  	
}


//------------------------------ Distributor ----------------------
function loadDistributor(startLetter) 
{	    
	 var url = "../marketing?actionS=MKTDistributor&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = DistributorRequest;
    req.open("GET", url, true);
    req.send(null);
}

function DistributorRequest() {
    if(req.readyState == 4) {    	
        ClearTabe('DistributorTable');   
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	     
        if (req.status == 200) {		  	
          DistributorMessages();
        }
    }
}
function DistributorMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Distributors")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   
	    var batch = batchs.childNodes[loop];
	    var distributorId = batch.getElementsByTagName("DistributorId")[0];
	    var Name = batch.getElementsByTagName("Name")[0];
	    var LName = batch.getElementsByTagName("LName")[0];
	    var City = batch.getElementsByTagName("City")[0];
	    var State = batch.getElementsByTagName("State")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];     
        var Fax=batch.getElementsByTagName("Fax")[0]; 
        var Active=batch.getElementsByTagName("Active")[0];         
        var Since=batch.getElementsByTagName("Since")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'><input name='distributorId' id='distributorId' type='checkbox' value='"+distributorId.childNodes[0].nodeValue+"'/>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+LName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+State.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Fax.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Active.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Since.childNodes[0].nodeValue;		
    }     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('DistributorTable');
     if(batchs.childNodes.length==0)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
  	 tb.innerHTML=str  ; 
   	
}


function ClearTabe(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



//------------------------------ Retailer ----------------------
function loadRetailer(startLetter) 
{	    
	 var url = "../marketing?actionS=MKTRetailer&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = RetailerRequest;
    req.open("GET", url, true);
    req.send(null);
}

function RetailerRequest() {
    if(req.readyState == 4) {    	
        ClearTable3('RetailerTable');   
        document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	    
        if (req.status == 200) {		  	
          RetailerMessages();
        }
    }
}
function RetailerMessages() 
{ 
    var batchs = req.responseXML.getElementsByTagName("Retailers")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   
	    var batch = batchs.childNodes[loop];
	    var retailerId = batch.getElementsByTagName("RetailerId")[0];
	    var Name = batch.getElementsByTagName("Name")[0];
	    var LName = batch.getElementsByTagName("LName")[0];
	    var City = batch.getElementsByTagName("City")[0];
	    var State = batch.getElementsByTagName("State")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];     
        var Fax=batch.getElementsByTagName("Fax")[0]; 
        var Active=batch.getElementsByTagName("Active")[0];         
        var Since=batch.getElementsByTagName("Since")[0];
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'><input name='retailerId' id='retailerId' type='checkbox' value='"+retailerId.childNodes[0].nodeValue+"'/>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+LName.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+State.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Fax.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Active.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Since.childNodes[0].nodeValue;		
    }     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('RetailerTable');
     if(batchs.childNodes.length<1)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }
  	 tb.innerHTML=str  ; 
   	
}
function ClearTable3(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


//------------------------------ Doctor Table  ----------------------
function loadDoctor(startLetter) 
{	    
	var url = "../marketing?actionS=MKTDoctor&id="+escape(startLetter);
	initRequest(url);
	req.onreadystatechange = DoctorRequest;
    req.open("GET", url, true);
    req.send(null);
}

function DoctorRequest() {
    if(req.readyState == 4) {    	
        ClearTable4('DoctorTable');              
        if (req.status == 200) {		  	
          DoctorMessages();
        }
    }
}
function DoctorMessages() 
{ 
    var batchs = req.responseXML.getElementsByTagName("Doctors")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   
	    var batch = batchs.childNodes[loop];
	    var doctorId = batch.getElementsByTagName("DoctorId")[0];
	    var Name = batch.getElementsByTagName("Name")[0];	    
	    var City = batch.getElementsByTagName("City")[0];
	    var State = batch.getElementsByTagName("State")[0];
        var Phone = batch.getElementsByTagName("Phone")[0];       
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		str=str+"<td width='130' class='boldEleven'><input name='doctorId' id='doctorId' type='checkbox' value='"+doctorId.childNodes[0].nodeValue+"'/>"+Name.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+City.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+State.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Phone.childNodes[0].nodeValue;
		 }     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('DoctorTable');
     if(batchs.childNodes.length==0)
     {
     	document.getElementById('submit1').disabled=true;
     	document.getElementById('submit2').disabled=true; 	 
     }
     else
     {
     	document.getElementById('submit1').disabled=false;
    	document.getElementById('submit2').disabled=false; 	 
     }    
  	 tb.innerHTML=str  ; 
   	
}
function ClearTable4(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
//----------------------------------Traveling----------------------------------------------

function loadTraveling(startLetter) 
{
	
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTTraveling&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	initRequest(url);
	req.onreadystatechange = TravelingRequest;
    req.open("GET", url, true);
    req.send(null);
}

function TravelingRequest() {
    if(req.readyState == 4) {    	
        ClearTabe('TravelingTable');       
        if (req.status == 200) {		  	
          TravelingMessages();
        }
    }
}
function TravelingMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Travelings")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {   	   
	    var batch = batchs.childNodes[loop];
	    var travelingId = batch.getElementsByTagName("TravelingId")[0];	  
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart=batch.getElementsByTagName("Depart")[0]; 
        var Desig=batch.getElementsByTagName("Desig")[0];         
        var Place=batch.getElementsByTagName("Place")[0];     
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='20' class='boldEleven'><input name='traveling' id='traveling' type='checkbox' value='"+travelingId.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"' />";
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		//str=str+"<td width='130' class='boldEleven'>"+Place.childNodes[0].nodeValue;
		
    }
     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('TravelingTable');
  	 tb.innerHTML=str  ; 
  	
}
function ClearTablessss(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Incoming----------------------------------------------

function loadIncoming(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTIncoming&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	//alert(url);
	initRequest(url);
	req.onreadystatechange = IncomingRequest;
    req.open("GET", url, true);
    req.send(null);
}

function IncomingRequest() {
    if(req.readyState == 4) {    	
        ClearTabless('incomingTable');       
        if (req.status == 200) {		  	
          IncomingMessages();
        }
    }
}
function IncomingMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("incomings")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var phoneid = batch.getElementsByTagName("Transid")[0];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0]; 
        var Calls = batch.getElementsByTagName("Calls")[0]; 
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		 
		str=str+"<td width='20' class='boldEleven'><input name='phoneid' id='phoneid' type='checkbox' value='"+phoneid.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"'/>";
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+Calls.childNodes[0].nodeValue;
    }
     
     if(batchs.childNodes.length<1)
     	str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('incomingTable');
  	 tb.innerHTML=str  ; 
  	
}
function ClearTabless(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Outgoing----------------------------------------------

function loadOutgoing(startLetter) 
{
	var mon=document.getElementById('month').value;	
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTOutgoing&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);
	
	initRequest(url);
	req.onreadystatechange = OutgoingRequest;
    req.open("GET", url, true);
    req.send(null);
}

function OutgoingRequest() {
    if(req.readyState == 4) {    	
        ClearTabess('OutgoingTable');       
        if (req.status == 200) {		  	
          OutgoingMessages();
        }
    }
}
function OutgoingMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Outgoings")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var phoneid = batch.getElementsByTagName("Phoneid")[0];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0]; 
        var OutCalls = batch.getElementsByTagName("OutCalls")[0]; 
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";	
		   			 
		str=str+"<td width='20' class='boldEleven'><input name='phoneid' id='phoneid' type='checkbox' value='"+phoneid.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"'/>";
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+OutCalls.childNodes[0].nodeValue;
    }
     
     if(batchs.childNodes.length<1)
     str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('OutgoingTable');
  	 tb.innerHTML=str  ; 
  	
}
function ClearTabess(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

//----------------------------------Conveyance----------------------------------------------

function loadConveyance(startLetter) 
{
	var mon=document.getElementById('month').value;
    var yea=document.getElementById('year').value;        
    var url = "../marketing?actionS=MKTConveyance&month="+escape(mon)+"&year="+escape(yea)+"&id="+escape(startLetter);;
	initRequest(url);
	req.onreadystatechange = conveyanceRequest;
    req.open("GET", url, true);
    req.send(null);
}
function conveyanceRequest() {
    if(req.readyState == 4) {    	
        ClearTabl('conveyanceTable');       
        if (req.status == 200) {		  	
          conveyanceMessages();
        }
    }
}
function conveyanceMessages() 
{
	 
    var batchs = req.responseXML.getElementsByTagName("Conveyances")[0];   
    var str=""; 
	str=str+"<table width='900' border='1' bordercolor='#EEEAFE' class='boldEleven' cellpadding='1' cellspacing='1'>";
   	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    
	    var batch = batchs.childNodes[loop];
	    var Conveyanceid = batch.getElementsByTagName("Conveyanceid")[0];
	    var Empid = batch.getElementsByTagName("Empid")[0];
	    var Staffname = batch.getElementsByTagName("Staffname")[0];
	    var Companyname = batch.getElementsByTagName("Companyname")[0];
        var Branchname = batch.getElementsByTagName("Branchname")[0];     
        var Depart = batch.getElementsByTagName("Depart")[0]; 
        var Desig = batch.getElementsByTagName("Desig")[0]; 
        var Amount = batch.getElementsByTagName("Amount")[0]; 
        
        if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";			   			 
		str=str+"<td width='20' class='boldEleven'><input name='conveyance' id='conveyance' type='checkbox' value='"+Conveyanceid.childNodes[0].nodeValue+"~"+Empid.childNodes[0].nodeValue+"'/>";
		str=str+"<td width='100' class='boldEleven'>"+Empid.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Staffname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Companyname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Branchname.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Depart.childNodes[0].nodeValue;
		str=str+"<td width='130' class='boldEleven'>"+Desig.childNodes[0].nodeValue;
		//str=str+"<td width='100' class='boldEleven'>"+Amount.childNodes[0].nodeValue;
    }     
     if(batchs.childNodes.length<1)
     str=str+"<tr><td class='bolddeepred'><center> Data not found...</center></td></tr>";
     str=str+"</table>";
     var tb=document.getElementById('conveyanceTable');
  	 tb.innerHTML=str  ; 
  	
}
function ClearTabl(ctr1)
{
	 var str="<font class='boldEleven'><center> Nothing  found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}



//-------------------District values--------------
function loadDistrictValues(dval) {	
    stateId=dval.value;      
    if(stateId==="select")
    {stateId=0;}
    var url = "../marketing?actionS=MKTDistrict&id="+escape(stateId);  
    initRequest(url);    
    req.onreadystatechange = districtValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function districtValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('district');
        if (req.status == 200) {
          districtValueMessages();
        } 
    }
}
function districtValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("districts")[0];
    var _targ=document.getElementsByName('district')[0];
    _targ.options.length=0;	  
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("Districtname")[0];  
         var stateId = batch.getElementsByTagName("Stateid")[0];      
        var batchId = batch.getElementsByTagName("Districtid")[0];
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
	 _targ.selectedIndex=0;
	 _targ.onchange(); 
}

//-------------------District Combo values--------------
function loadComboDistrictValues(dval) {	
    stateId=dval.value;       
    
    var url = "../marketing?actionS=MKTDistrict&id="+escape(stateId);  
    initRequest(url);    
    req.onreadystatechange = districtComboValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function districtComboValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('district');
        if (req.status == 200) {
          districtComboValueMessages();
        } 
    }
}
function districtComboValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("districts")[0];
  var _targ=document.getElementsByName('district')[0];
     
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("Districtname")[0];  
         var stateId = batch.getElementsByTagName("Stateid")[0];      
        var batchId = batch.getElementsByTagName("Districtid")[0];
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
     //_targ.onchange();
	
}


//-------------------Town values--------------
function loadTownValues() {		
	
    var stateid=document.getElementById('state').value;     
	var districtid=document.getElementById('district').value;  
	var svalue="";    
    var url="../marketing?actionS=MKTTown&id="+escape(districtid)+"&state="+escape(stateid)+"&txt="+svalue;    
    initRequest(url);    
    req.onreadystatechange = townValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function townValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('town');
        if (req.status == 200) {
          townValueMessages();
        } 
    }
}
function townValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("towns")[0];
    var _targ=document.getElementsByName('town')[0];
    _targ.options.length=0;	  
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
	     var townId = batch.getElementsByTagName("Townid")[0];        
        var stateId=batch.getElementsByTagName("Stateid")[0];        
        var districtId=batch.getElementsByTagName("Districtid")[0];       
        var townName = batch.getElementsByTagName("Townname")[0];   
        _targ.options[loop]=new Option(townName.childNodes[0].nodeValue,townId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
	 _targ.selectedIndex=0;
	 _targ.onchange(); 
}

//-------------------Town Combo values--------------
function loadComboTownValues() {	
	var svalue="0";    
  var stateid=document.getElementById('state').value;     
	var districtid=document.getElementById('district').value;     
     var url="../marketing?actionS=MKTTown&id="+escape(districtid)+"&state="+escape(stateid)+"&txt="+svalue;    
   
    initRequest(url);    
    req.onreadystatechange = townComboValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function townComboValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('town');
        if (req.status == 200) {
          townComboValueMessages();
        } 
    }
}
function townComboValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("towns")[0];
  var _targ=document.getElementsByName('town')[0];
     
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var townId = batch.getElementsByTagName("Townid")[0];        
        var stateId=batch.getElementsByTagName("Stateid")[0];        
        var districtId=batch.getElementsByTagName("Districtid")[0];       
        var townName = batch.getElementsByTagName("Townname")[0];   
         _targ.options[loop]=new Option(townName.childNodes[0].nodeValue,townId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;
	
}

// --------------------Town Table------------------------
function loadTownTable(sval) {	
	var svalue=sval;    
	var stateid=document.getElementById('state').value; 	
	var districtid=document.getElementById('district').value;     
	var url="../marketing?actionS=MKTTown&id="+escape(districtid)+"&state="+escape(stateid)+"&txt="+svalue;     
    initRequest(url);
    req.onreadystatechange = townRequest;
    req.open("GET", url, true);
    req.send(null);
}
function townRequest() {
    if(req.readyState == 4) {
        ClearTable1('townTable');     
        if (req.status == 200) {
         townMessages();
        }
    }
}

function townMessages() {

    var batchs = req.responseXML.getElementsByTagName("towns")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var town = batchs.childNodes[loop];
        var townId = town.getElementsByTagName("Townid")[0];        
        var stateId=town.getElementsByTagName("Stateid")[0];        
        var districtId=town.getElementsByTagName("Districtid")[0];       
        var townName = town.getElementsByTagName("Townname")[0];                                            
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		
		var twn=townId.childNodes[0].nodeValue;		
		state=stateId.childNodes[0].nodeValue;
		district=districtId.childNodes[0].nodeValue;				
		str=str+"<td width='120px'><input type='checkbox' name='TxtTown' value='"+twn+"'><font class='boldEleven'>"+townId.childNodes[0].nodeValue;
		str=str+"<td width='125px'><font class='boldEleven'>"+townName.childNodes[0].nodeValue;		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     
       if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true; 	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
    	document.getElementById('btnEdit').disabled=false ; 	 
     }
     var tb=document.getElementById('townTable');
  	 tb.innerHTML=str     
  	  str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str  	 
}
function ClearTable1(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     	
  	
}


//-------------------Area values--------------
function loadComboAreaValues() {	
	var val1="";	
 var stateid=document.getElementById('state').value;     
	var districtid=document.getElementById('district').value; 
	var townid=document.getElementById('town').value;    
    var url="../marketing?actionS=MKTArea&id="+escape(districtid)+"&state="+escape(stateid)+"&townid="+townid+"&txt="+val1;        
    initRequest(url);
   
    req.onreadystatechange = areaComboValueRequest;
    req.open("GET", url, true);
    req.send(null);
}
function areaComboValueRequest() {
    if (req.readyState == 4) {
       	clearSelect('area');
        if (req.status == 200) {
          areaComboValueMessages();
        } 
    }
}
function areaComboValueMessages() {
    var batchs = req.responseXML.getElementsByTagName("areas")[0];
  var _targ=document.getElementsByName('area')[0];
     
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	  var area = batchs.childNodes[loop];
	    var stateId=area.getElementsByTagName("Stateid")[0];        
        var townId = area.getElementsByTagName("Townid")[0];       
        var districtId=area.getElementsByTagName("Districtid")[0];       
        var areaId=area.getElementsByTagName("Areaid")[0];    
        var areaName = area.getElementsByTagName("Areaname")[0];      
         
         _targ.options[loop]=new Option(areaName.childNodes[0].nodeValue,areaId.childNodes[0].nodeValue);
     }        
     _targ.options.length=loop;	
}

// --------------------Area Table------------------------
function loadAreaTable(sval) {
	var val=sval;	
	
	var stateid=document.getElementById('state').value;     
	var districtid=document.getElementById('district').value; 
	var townid=document.getElementById('town').value;    
    var url="../marketing?actionS=MKTArea&id="+escape(districtid)+"&state="+escape(stateid)+"&townid="+townid+"&txt="+val;     
    initRequest(url);
    req.onreadystatechange = areaRequest;
    req.open("GET", url, true);
    req.send(null);
}
function areaRequest() {
    if(req.readyState == 4) {
        ClearTable2('areaTable');
         if (req.status == 200) {
         areaMessages();
        }
    }
}

function areaMessages() {

    var batchs = req.responseXML.getElementsByTagName("areas")[0];   	    
	var str=""; 
    str=str+"<table width='100%' border='0' class='boldEleven'>";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {    
	    var area = batchs.childNodes[loop];
	    var stateId=area.getElementsByTagName("Stateid")[0];        
        var townId = area.getElementsByTagName("Townid")[0];       
        var districtId=area.getElementsByTagName("Districtid")[0];       
        var areaId=area.getElementsByTagName("Areaid")[0];    
        var areaName = area.getElementsByTagName("Areaname")[0];                                                     
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		var txtarea=areaId.childNodes[0].nodeValue;		
		state=stateId.childNodes[0].nodeValue;
		district=districtId.childNodes[0].nodeValue;	
		town=townId.childNodes[0].nodeValue;	
					
		str=str+"<td width='125px'><input type='checkbox' name='TxtArea' value='"+txtarea+"'><font class='boldEleven'>"+areaId.childNodes[0].nodeValue;
		str=str+"<td with='125px'><font class='boldEleven'>"+areaName.childNodes[0].nodeValue;		
		str=str+"</td></tr>";
     }
     str=str+"</table>";
     
        if(batchs.childNodes.length<1)
     {
     	document.getElementById('btnDelete').disabled=true;
     	document.getElementById('btnEdit').disabled=true; 	 
     }
     else
     {
     	document.getElementById('btnDelete').disabled=false;
    	document.getElementById('btnEdit').disabled=false ; 	 
     }
     var tb=document.getElementById('areaTable');
  	 tb.innerHTML=str     	 
  	 	  str="Total no of Records :: "  + loop
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str      	
}
function ClearTable2(ctr1)
{
	 var str="Nothing  found";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     	
}



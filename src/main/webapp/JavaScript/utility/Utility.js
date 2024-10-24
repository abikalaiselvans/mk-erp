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
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
	 var tb=document.getElementById('totRec');	 
  	 tb.innerHTML="Total no of Records :: 0"    ;
  	 
}
 
function Clear(ctr1)
{
	 var str="<center class='boldEleven'>Data not found<center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}
 


function loadAllStaff(sval) {
    if(!(sval == "0"))
		document.getElementById('search').value ="";
	var search=document.getElementById('search').value; 
	var category =document.getElementById('category').value;     
    var url = "../Utility?actionS=LoadStaff&search="+escape(search)+"&startletter="+sval+"&category="+category;
    
   	initRequest(url);
    req.onreadystatechange = staffRequest;
    req.open("GET", url, true);
    req.send(null);
}
  
function staffRequest() {
    if(req.readyState == 4) {
        document.getElementById('Edit').disabled=true;
        Clear('StafTable');
        if (req.status == 200) {
          staffMessages();
        }
    }
}
function staffMessages() {
    var batchs = req.responseXML.getElementsByTagName("Staffs")[0];   	    
	var str=""; 
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
    for(loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var Staffid = batch.getElementsByTagName("Staffid")[0];
        var StaffName = batch.getElementsByTagName("StaffName")[0];
        var UserName = batch.getElementsByTagName("UserName")[0];
        var Type = batch.getElementsByTagName("Type")[0];
        var Live = batch.getElementsByTagName("Live")[0];
                                            
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2' >";	
		str=str+"<td    class='boldEleven'  onmouseover='this.bgColor=color1'  onmouseout='this.bgColor=color2'><input type='checkbox' name='loginName' value='"+UserName.childNodes[0].nodeValue+"'> "+StaffName.childNodes[0].nodeValue;
		str=str+"<td      class='boldEleven'>"+Staffid.childNodes[0].nodeValue;
		str=str+"<td   class='boldEleven'>"+UserName.childNodes[0].nodeValue;
		str=str+"<td    class='boldEleven'>";
		if("F" == Type.childNodes[0].nodeValue)
			str=str+"Super Admin";	
		else if("B" == Type.childNodes[0].nodeValue)
			str=str+"Branch Admin";	
		else if("S" == Type.childNodes[0].nodeValue)
			str=str+"Employee";	
		else
			str=str+"Admin";	
		
		str=str+"<td  class='boldEleven'>";
		if("Y" == Live.childNodes[0].nodeValue)
			str=str+"Active";	
		if("N" == Live.childNodes[0].nodeValue)
			str=str+"Inactive";	
		
	 }
     str=str+"</table>";
     var tb=document.getElementById('StafTable');
  	 tb.innerHTML=str  ; 
  	 str="<font color='ff0000'>Total no of Records :: "  + loop+"</font>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	 document.getElementById('Edit').disabled=false ; 	 
}

 
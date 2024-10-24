var isIE;
var req;
var names;
var target1;
var ctrl;

function getElementY(element)
{
	var target1Top = 0;
	if (element.offsetParent) 
	{
		while (element.offsetParent) 
		{
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} 
	else if (element.y) 
	{
		target1Top += element.y;
    }
	return target1Top;
}


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

function LoadingTables(ctr1)
{
	 var str="<font class='bolddeepred'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
{
	 var str="<font class='bolddeepred'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


function loadItemData(startLetter) 
{
    
    var id=document.getElementById('itemgroup').value;   
    var url = "../Asset?actionS=loadItemData&itemgroup="+escape(id)+"&startLetter="+escape(startLetter);   
    initRequest(url);
    req.onreadystatechange = ItemRequest;
    req.open("GET", url, true);
    req.send(null);
}


function ItemRequest() 
{
    if(req.readyState == 4) 
    {    
        ClearTables('ItemTable');
        document.getElementById('Delete').disabled=true;
        if (req.status == 200) 
        {
          ItemDetails();
        }
    }
}

function ItemDetails() 
{
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];      
	var str=""; 
     
    str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
	    var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;        
        var Group = batch.getElementsByTagName("Group")[0].childNodes[0].nodeValue;         
        var Item = batch.getElementsByTagName("Item")[0].childNodes[0].nodeValue;         
        var Desc = batch.getElementsByTagName("Desc")[0].childNodes[0].nodeValue; ;         
        var Active = batch.getElementsByTagName("Active")[0].childNodes[0].nodeValue; ;       
        var Return = batch.getElementsByTagName("Return")[0].childNodes[0].nodeValue; ;
        	      
       	                                    
		if(loop%2==1)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";				
		
		str=str+"<td  width='10%' class='boldEleven'><input type='checkbox' name='id' name='id' value='"+Id+"'>"+(loop+1)+"</td>";
		str=str+"<td  width='20%' class='boldEleven'>"+Group+"</td>";
		str=str+"<td  width='30%' class='boldEleven'>"+Item+"</td>";		
		str=str+"<td  width='30%' class='boldEleven'>"+Desc+"</td>";
		if(Active =="1")
			str=str+"<td  width='15%' class='boldEleven'><font class='boldgreen'>Active</font></td>";
		else
			str=str+"<td  width='15%' class='boldEleven'><font class='bolddeepred'>In-active</font></td>";
		
		if(Return =="Y")
			str=str+"<td  width='15%' class='boldEleven'><font class='boldgreen'>Returnable</font></td>";
		else
			str=str+"<td   width='15%'class='boldEleven'><font class='bolddeepred'>Non returnable</font></td>";
		
		 
		str=str+"</tr>";
     }
     str=str+"</table>";
     if(batchs.childNodes.length<1)
     	document.getElementById('Delete').disabled = true;
     else
     	document.getElementById('Delete').disabled=false;
     var tb=document.getElementById('ItemTable');
  	 tb.innerHTML=str   
  	 str="<br> <center><font class='bolddeepred'>Total no of Records :: "  + loop+"</font></center><br>";
  	 var tb=document.getElementById('totRec');
  	 tb.innerHTML=str   
  	
}



 
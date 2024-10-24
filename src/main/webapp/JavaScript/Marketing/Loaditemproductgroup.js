 

function LoaditemproductGroup() 
{
	var itype = document.getElementById('itype').value;
	 
	if(itype=="")
	{
		alert("Kindly select Product or Item")
		document.getElementById('itype').focus();
	}
	else
	{
		var url = "../inventory?actionS=INVItemProductGroup&id="+itype ;
		initRequest(url);
		req.onreadystatechange = LoaditemproductGroupRequest;
		req.open("GET", url, true);
		req.send(null);
	}	
}

function LoaditemproductGroupRequest() 
{
    if(req.readyState == 4) 
    {  
    	 var _targ=document.getElementsByName('pgroup')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select','0'); 
	    
	     _targ=document.getElementsByName('item')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select','0'); 
	    
	    if (req.status == 200) 
    	{		  	
	    	LoaditemproductGroupMessages();
        }
    }
}

function LoaditemproductGroupMessages() 
{
	
	var batchs = req.responseXML.getElementsByTagName("items")[0]; 
    var _targ=document.getElementsByName('pgroup')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  

    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Idname")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
  }




//Load Item / Product depends on  item/product group
 
function LoaditemproductdependsGroup() 
{
	
	var itype = document.getElementById('itype').value;
	var group = document.getElementById('pgroup').value;
	if(itype=="")
	{
		alert("Kindly select Product or Item")
		document.getElementById('itype').focus();
	}
	else
	{
		var url = "../inventory?actionS=LoaditemproductdependsGroup&itype="+itype+"&group="+group ;
		initRequest(url);
		req.onreadystatechange = LoaditemproductdependsGroupRequest;
		req.open("GET", url, true);
		req.send(null);
	}	
}

function LoaditemproductdependsGroupRequest() 
{
    if(req.readyState == 4) 
    {  
    	 var _targ=document.getElementsByName('item')[0];       
	     _targ.options.length=0;
	     _targ.options[0]=new Option('Select','0'); 
	    
	    
    	if (req.status == 200) 
    	{		  	
    		LoaditemproductdependsGroupMessages();
        }
    }
}

function LoaditemproductdependsGroupMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("items")[0]; 
    var _targ=document.getElementsByName('item')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('Select','0');  

    for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Idname")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    } 
 }






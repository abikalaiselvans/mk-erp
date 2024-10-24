var isIE;
var req;
var names;
var target1;
var ctrl;
  

function createRequestObject() 
{
    var tmpXmlHttpObject;   
    if (window.XMLHttpRequest) 
    {     
        tmpXmlHttpObject = new XMLHttpRequest();	
    }
    else if (window.ActiveXObject) 
    {     
        tmpXmlHttpObject = new ActiveXObject("Microsoft.XMLHTTP");
    }    
    return tmpXmlHttpObject;
}

var http = createRequestObject();

function init() 
{
 	var sel=document.getElementById("com-Id"); 
 	
 		
  	makeGetRequest(sel) 
}

function makeGetRequest(wordId) 
{
	try
	{
	
		//find office id
		obj = findObj("office");
		var offc="";;
		if(obj == null)
			offc="0";
		else
			offc =document.getElementById("office").value;
		
		//fine dept id
		obj = findObj("dept");
		var dept="";;
		if(obj == null)
			dept="0";
		else
			dept =document.getElementById("dept").value;
			
			
		obj = findObj("Category");
		var Category="";;
		if(obj == null)
			Category="0";
		else
			Category =document.getElementById("Category").value;
		
		var Resigned="N";
		if(document.getElementById("Resigned").checked == true)
			Resigned="N"
		else
			Resigned="Y"	
		//alert("../autocomplete?action=complete1&search="+ wordId.value+"&office="+offc+"&dept="+dept+"&Category="+Category+"&Resigned="+Resigned);
		http.open('get', '../autocomplete?action=complete1&search='+ wordId.value+"&office="+offc+"&dept="+dept+"&Category="+Category+"&Resigned="+Resigned );
		http.onreadystatechange = processResponse;
	    http.send(null);
    
	}
	catch(err)
	{
			alert(err);
	}

    
}

function processResponse() 
{ 
    if(http.readyState == 4)
    {        
        var response = http.responseText;
         
        document.getElementById('staffloaddescription').innerHTML = response;		
    }
}

 
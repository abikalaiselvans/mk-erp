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


function loadTestTypeQuestion(startletter)
 {
 	var url = "../SmartHRM?actionS=loadTestTypeQuestion&search="+startletter+"&typeid="+document.getElementById('type').value ;
	initRequest(url);
	req.onreadystatechange=loadTestTypeQuestionRequest;
    req.open("GET", url, true);
    req.send(null);
}
 
 function loadTestTypeQuestionRequest() 
 {
    if(req.readyState == 4) 
    {    	
        ClearTable('TestTypeTable');  
        ClearTabler('totalRec');  
		if (req.status == 200) 
        {		  	
         	loadTestTypeQuestionMessages();
        }
    }
}

function loadTestTypeQuestionMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    
    var str=""; 
    var query="";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
	str=str+"<table width='100%'  class='boldEleven'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";
	str=str+"<tr class='MRow2'><td class='boldEleven'><b>S.No ";
	str=str+"<td class='boldEleven'><b>Type ";
	str=str+"<td class='boldEleven'><b>Question ";
	str=str+"<td class='boldEleven'><b>Answer1  ";
	str=str+"<td class='boldEleven'><b>Answer2  ";
	str=str+"<td class='boldEleven'><b>Answer3  ";
	str=str+"<td class='boldEleven'><b>Answer4  ";
	
	
	 
	
  	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var ID = batch.getElementsByTagName("ID")[0].childNodes[0].nodeValue;
	    var Type = batch.getElementsByTagName("Type")[0].childNodes[0].nodeValue;
	    var Question = batch.getElementsByTagName("Question")[0].childNodes[0].nodeValue;
	     var Answer1 = batch.getElementsByTagName("Answer1")[0].childNodes[0].nodeValue;
	      var Answer2 = batch.getElementsByTagName("Answer2")[0].childNodes[0].nodeValue;
	       var Answer3 = batch.getElementsByTagName("Answer3")[0].childNodes[0].nodeValue;
	        var Answer4 = batch.getElementsByTagName("Answer4")[0].childNodes[0].nodeValue;
	        
	         
	        Type=Type.replace( "9865043008" ,"<");
	        Question=Question.replace( "9865043008" ,"<");
	        Answer1=Answer1.replace( "9865043008" ,"<");
	        Answer2=Answer2.replace( "9865043008" ,"<");
	        Answer3=Answer3.replace( "9865043008" ,"<");
	        Answer4=Answer4.replace( "9865043008" ,"<");
	        
	        
	        Type=Type.replace( "9629314396","&");
	        Question=Question.replace( "9629314396","&");
	        Answer1=Answer1.replace( "9629314396","&");
	        Answer2=Answer2.replace( "9629314396","&");
	        Answer3=Answer3.replace( "9629314396","&");
	        Answer4=Answer4.replace( "9629314396","&");
	    
	    if(loop%2==0)
			str=str+"<tr class='MRow1'>";
		else
		    str=str+"<tr  class='MRow2'>";		
		   
		str=str+"<td  class='boldEleven'>"+(loop+1)+"<input type='checkbox' id='id' name='id' value='"+ID+"'></td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Type+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Question+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Answer1+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Answer2+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Answer3+"</td>";
		str=str+"<td  class='boldEleven'>&nbsp;"+Answer4+"</td>";
		
		str=str+"</tr>";
    }
	 if(batchs.childNodes.length >0)
  	 {  	 	
     	var tb=document.getElementById('totalRec');
  	 	tb.innerHTML="<center> <font  class='bolddeepred'>Total No of Records : "+batchs.childNodes.length+"</font></center>" ;
		
		
     }
     else
     {
     	str=str+"<tr class='MRow1'><td colspan='8' class='bolddeepred'><br><br><br><center>Data not found..</center></td></tr>";
     	 
     }	
	 str=str+"</table>";
     var tb=document.getElementById('TestTypeTable');
  	 tb.innerHTML=str  
  	 
  	 
  	  
}




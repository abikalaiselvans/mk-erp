<html>

<script language="Javascript" type="text/javascript">
<!--

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
function makeGetRequest(wordId) 
{ 
    http.open('get', '../autocomplete?action=complete1&id='+ wordId.value);
    http.onreadystatechange = processResponse;
    http.send(null);
}
function processResponse() 
{
 
    if(http.readyState == 4){	        
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;		
    }
}
-->
</script>
<body  onpaste='return false;'>
<form name=f1>
<h1>Simple AJAX Date Retriving from Data Base</h1>
<input type=text onkeyup="makeGetRequest(this)">
<table width="50%" border="1">
	<tr height="100%">
		<td width="260">
		<div id="description"></div>
		</td>
	</tr>
</table>
</form>
</body>
</html>

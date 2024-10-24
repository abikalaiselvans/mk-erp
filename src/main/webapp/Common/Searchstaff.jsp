<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

</head>

<script language="javascript">

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
		http.open('get', '../Common?action=loadStaff&id='+ wordId.value);
		alert('../Common?action=loadStaff&id='+ wordId.value);
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
</script>

<body onpaste='return false;'>
<table width="100%" border="1" cellpadding="5" cellspacing="0">
	<!--DWLayoutTable-->
	<tr class="tabledata">
		<td width="190" height="66" align="left" valign="middle"
			class="boldEleven">&nbsp;Search&nbsp;&nbsp;&nbsp; <input
			size="15" maxlength="20" type="text" name="com-Id" id="com-Id"
			onkeyup="makeGetRequest(this)" class="tabledata" /></td>
		<td width="267" valign="top" class="boldEleven">
		<div class="boldEleven" id="description"></div>
		</td>
	</tr>
</table>
</body>
</html>

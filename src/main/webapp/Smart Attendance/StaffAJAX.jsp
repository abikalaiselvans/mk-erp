<%-- Copyright 2005 Sun Microsystems, Inc. All rights reserved. You may not modify, use, reproduce, or distribute this software except in compliance with the terms of the License at: http://developer.sun.com/berkeley_license.html
$Id: index.jsp,v 1.4 2005/05/01 18:01:05 tnorbye Exp $ --%>
<html>
<head>
<style type="text/css">

.mouseOut {
background: #7A8AFF;
color: #FFFAFA;
}

.mouseOver {
background: #FFFAFA;
color: #000000;
}
</style>
<script type="text/javascript">
var isIE;
var req;
var names;
var target;


function getElementY(element){
	var targetTop = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			targetTop += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		targetTop += element.y;
    }
	return targetTop;
}

function init() {
    target = document.getElementById("complete-field");
    var menu = document.getElementById("auto-row");
    var autorow = document.getElementById("menu-popup");
    autorow.style.top = getElementY(menu) + "px";
    
}

function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function doCompletion() {
    alert(escape(target.value));
    var url = "autocomplete?action=complete&id=" + escape(target.value);
    initRequest(url);
    req.onreadystatechange = processRequest;    
    req.open("GET", url, true);
    req.send(null);   	
}

function processRequest() {
    if (req.readyState == 4) {
        if (req.status == 200) {
          parseMessages();
        } else if (req.status == 204){
            alert("clearing table");
            clearTable();
        }
    alert(req.status);
    }
}

function parseMessages() {
    if (!names) names = document.getElementById("names");

    clearTable();
	var employees = req.responseXML.getElementsByTagName("employees")[0];
     for (loop = 0; loop < employees.childNodes.length; loop++) {
	    var employee = employees.childNodes[loop];
        var firstName = employee.getElementsByTagName("firstName")[0];       
        var employeeId = employee.getElementsByTagName("id")[0];
        appendEmployee(firstName.childNodes[0].nodeValue,employeeId.childNodes[0].nodeValue);

    }
}

function clearTable() {
    if (names) {
      for (loop = names.childNodes.length -1; loop >= 0 ; loop--) {
        names.removeChild(names.childNodes[loop]);
      }
    }
}

function appendEmployee(firstName,employeeId) {
    var firstNameCell;
    var lastNameCell;
    if (isIE) {
        row = names.insertRow(names.rows.length);
        nameCell = row.insertCell(0);
    } else {
        row = document.createElement("tr");
        nameCell = document.createElement("td");
        row.appendChild(nameCell);
        names.appendChild(row);
    }
    row.setAttribute("border", "0");
    nameCell.setAttribute("onmouseout", "this.className='mouseOver';");
    nameCell.setAttribute("onmouseover", "this.className='mouseOut';");
    nameCell.setAttribute("bgcolor", "#FFFAFA");
    nameCell.setAttribute("border", "0");
    var linkElement = document.createElement("a");
    linkElement.setAttribute("style", "text-decoration: none "); 
    linkElement.setAttribute("href", "autocomplete?action=lookup&id=" + employeeId);
    var nameFontElement = document.createElement("font");
    nameFontElement.setAttribute("size", "+1");
    nameFontElement.setAttribute("color", "black");
    nameFontElement.appendChild(document.createTextNode(firstName));
    linkElement.appendChild(nameFontElement);
    nameCell.appendChild(linkElement);
}
</script>

<title> :: ATTENDANCE ::</title>


</head>
<body  onpaste="return false;" onLoad="init()">

<form  AUTOCOMPLETE = "off"   name="autofillform" action="autocomplete" method="get"><input
	type="hidden" name="action" value="lookupbyname" />
<table border="0" cellpadding="5" cellspacing="0">
	<tr>
		<td><b>Employee Name:</b></td>
		<td><input type="text" size="20" id="complete-field" name="id"
			onkeyup="doCompletion()"></td>
		<td align="left"><input id="submit_btn" type="Submit"
			value="Lookup Employee"></td>
	</tr>
	<tr>
		<td id="auto-row" colspan="2">
		<td />
	</tr>
</table>
</form>
<div style="position: absolute; top:170px;left:140px" id="menu-popup">
<table id="names" bgcolor="#FFFAFA" border="1" bordercolor="black"
	cellspacing="0" cellpadding="0" />
	</div>
</body>
</html>

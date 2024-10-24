

//Convert Uppercase
function toUpper(obj) 
{
    var mystring = obj.value;
    var sp = mystring.split(' ');
    var wl=0;
    var f ,r;
    var word = new Array();
    for (i = 0 ; i < sp.length ; i ++ ) 
    {
        f = sp[i].substring(0,1).toUpperCase();
        r = sp[i].substring(1).toLowerCase();
        word[i] = f+r;
    }
    newstring = word.join(' ');
    obj.value = newstring;
    return true;   
}


function findObj(theObj, theDoc) {

	var p, i, foundObj;
	if (!theDoc)
		theDoc = document;
	if ((p = theObj.indexOf("?")) > 0 && parent.frames.length) {
		theDoc = parent.frames[theObj.substring(p + 1)].document;
		theObj = theObj.substring(0, p);
	}

	if (!(foundObj = theDoc[theObj]) && theDoc.all)
		foundObj = theDoc.all[theObj];
	for (i = 0; !foundObj && i < theDoc.forms.length; i++)
		foundObj = theDoc.forms[i][theObj];

	for (i = 0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++)
		foundObj = findObj(theObj, theDoc.layers[i].document);

	if (!foundObj && document.getElementById)
		foundObj = document.getElementById(theObj);

	return foundObj;

}

function checkNullSelect(ctr, msg, def) 
{
	try 
	{
		var val = document.getElementById(ctr).value;
		if (val === def) 
		{
			alert(msg);
			document.getElementById(ctr).focus();
			return false;
		}
		else
			return true;
	} 
	catch (err) 
	{
		alert(ctr + "-----" + err);
		return false;
	}
}


function checkNull(ctr, msg) 
{
	try {
		obj = findObj(ctr);
		if (obj == null) {
			alert(ctr + " Object not available");
			return false;
		}
		var val = document.getElementById(ctr).value;
		//val = trimFunction(ctr);
		if (val == "") 
		{
			alert(msg);
			document.getElementById(ctr).value = val;
			document.getElementById(ctr).focus();
			return false;
		}
		else
			return true;
	} 
	catch (err) 
	{
		alert(ctr + " -  not found.     error : " + err);
		return false;
	}
}


//setOption value
function setOptionValue(ctr, value) {
	try {
		 
		var len, val, i, sel;
		len = document.getElementById(ctr).length;
		for (i = 0; i < len; i++) {
			val = document.getElementById(ctr).options[i].value;
			if (val == value)
				sel = i;
		}
		document.getElementById(ctr).selectedIndex = sel;
	} catch (err) {
		alert(err);
	}

}


function numeric_only(e, ctr, len)// firfox
{
	var txtval = document.getElementById(ctr).value;

	var unicode = e.charCode ? e.charCode : e.keyCode;
	if (unicode == 8 || unicode == 9 || (unicode >= 48 && unicode <= 57)) {
		if (txtval != "")
			if (txtval.length >= len) {
				unicode = 0;
				alert("Max char reached");
				return false;
			}
		return true;
	} else
		return false;
}


function confirmMessage(message) {
	var userselection = confirm(message);
	if (userselection == true) {
		return true;
	} else {
		return false;
	}
}
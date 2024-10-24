var isIE;
var req;
var names;
var target1;
var ctrl;
 

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
//--------------------------------------------------
function doCompletion() {
    var url = "../autocomplete?action=complete&id="+ escape(target1.value); 
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
        var sel=document.getElementById("ename");   
        sel.options[loop].text=firstName.childNodes[0].nodeValue + "  /  "+employeeId.childNodes[0].nodeValue;          
        sel.options[loop].value=employeeId.childNodes[0].nodeValue;
    }        
}

function clearTable() {
    for(i=0;i<100;i++){
        var sel=document.getElementById("ename");   
         sel.options[i].text="";
    } 
}
//----------------------For Staff With Department ---------------
function loadDepartment() {	
    var url = "../autocomplete?action=Department&id=a";
    initRequest(url);
    req.onreadystatechange = departRequest;
    req.open("GET", url, true);
    req.send(null);
}
function departRequest() {
    clearSelect('Department','ename');
    if (req.readyState == 4) {         
        if (req.status == 200) {
          departMessages();
        }    }
}
function departMessages() {
    var loop;
    var batchs = req.responseXML.getElementsByTagName("departments")[0];
    var _targ=document.getElementsByName('Department')[0];
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("valName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
        _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
    }		
	_targ.options.length=loop;
	_targ.selectedIndex=0;	
	_targ.onchange();  
	loadDesignation();
}

//----------------------For Staff With Designation---------------
function loadDesignation() {	
    var url = "../autocomplete?action=Designation&id=a";
    initRequest(url);
    req.onreadystatechange = desigRequest;
    req.open("GET", url, true);
    req.send(null);
}
function desigRequest() {
	clearSelect('Designation','ename');
    if (req.readyState == 4) {
        if (req.status == 200) {
          desigMessages();
        }
    }
}
function desigMessages() {
    var loop;
    var batchs = req.responseXML.getElementsByTagName("designations")[0];
    var _targ=document.getElementsByName('Designation')[0];
    _targ.options.length=0;	
    for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("valName")[0];        
        var batchId = batch.getElementsByTagName("id")[0];
        _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }		
	_targ.options.length=loop;
	_targ.selectedIndex=0;
	_targ.onchange();
}
//----------------------For Staff With Id/Name---------------
function loadStaff() {
	var depId=document.getElementById("Department").value;
	var desId=document.getElementById("Designation").value;
	var staffName=document.getElementById("staffName").value;
    var url = "../autocomplete?action=StaffList&depId="+escape(depId)+"&desId="+escape(desId)+"&staffName="+escape(staffName);
    initRequest(url);
    req.onreadystatechange = staffRequest;
    req.open("GET", url, true);
    req.send(null);
}
function staffRequest() {
	clearSelect('ename');
    if (req.readyState == 4) {
        if (req.status == 200) {
            staffMessages();
        }
    }
}
function staffMessages() {
    var loop;
    var batchs = req.responseXML.getElementsByTagName("StaffLists")[0];
     var _targ=document.getElementsByName('ename')[0];
    _targ.options.length=0;	
     for (loop = 0; loop < batchs.childNodes.length; loop++) {
	    var batch = batchs.childNodes[loop];
        var firstName = batch.getElementsByTagName("firstName")[0];
        var batchId = batch.getElementsByTagName("id")[0];
        var dis_name=batch.getElementsByTagName("firstName")[0] +" / "+ batch.getElementsByTagName("id")[0];
         _targ.options[loop]=new Option(firstName.childNodes[0].nodeValue,batchId.childNodes[0].nodeValue);
     }		
	_targ.options.length=loop;
//	_targ.selectedIndex=0;
}

//----------------New AJAX FUNCTION---------------


function init() {
 
  var sel=document.getElementById("com-Id"); 	
  makeGetRequest(sel) 
}

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
	
	var Resigned="";
	if(document.getElementById("Resigned").checked)
		Resigned="N"
	else
		Resigned="Y"	
	
	//alert('../autocomplete?action=complete1&id='+ wordId.value+"&office="+offc+"&dept="+dept+"&Resigned="+Resigned);
	http.open('get', '../autocomplete?action=complete1&id='+ wordId.value+"&office="+offc+"&dept="+dept+"&Resigned="+Resigned);
	http.onreadystatechange = processResponse;
    http.send(null);
}
function processResponse() 
{ 
    if(http.readyState == 4)
    {        
        var response = http.responseText;
         
        document.getElementById('staffloaddescription').innerHTML = response;		
    }
}


//---------------------------------------------------
//-------------------------------------Single Choice of Staff

function init1() {

  var sel=document.getElementById("com-Id"); 	
  makeGetRequest1(sel) 
}
function createRequestObject1() 
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
var http = createRequestObject1();
function makeGetRequest1(wordId) 
{ 
    http.open('get', '../autocomplete?action=comp&id='+ wordId.value);
    http.onreadystatechange = processResponse1;
    http.send(null);
}
function processResponse1() 
{ 
    if(http.readyState == 4){        
        var response = http.responseText;
        document.getElementById('staffloaddescription').innerHTML = response;		
    }
}
//---------------------------------------------------
//----------------New elam AJAX FUNCTION---------------

function initBasic() {
 
  var sel=document.getElementById("staffId"); 	
  makeGetRequestBasic(sel) 
}
function createRequestObjectBasic() 
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
var http = createRequestObjectBasic();
function makeGetRequestBasic(wordId) 
{ 
    http.open('get', '../autocomplete?action=complete2&id='+ wordId.value);
    
    http.onreadystatechange =BasicRequestResponse;
    http.send(null);
}
function BasicRequestResponse() 
{ 
    if(http.readyState == 4){        
        var response = http.responseText;
        document.getElementById('descript').innerHTML = response;		
        
    }
}



function validateAdvId() {	
    var target = document.getElementById("advanceid");
    var url = "../autocomplete?action=advancevalid&id=" + escape(target.value);
    initRequest(url);
    req.onreadystatechange = processRequestAdvID;
    req.open("GET", url, true); 
    req.send(null);
}

function processRequestAdvID() {
    if (req.readyState == 4) {
        if (req.status == 200) { 
            var message = req.responseXML.getElementsByTagName("valid")[0].childNodes[0].nodeValue;
            setMessageUsingDOM(message);
            var submitBtn = document.getElementById("submit_btn");
            if (message == "true") {
              submitBtn.disabled = true;
            } else {
              submitBtn.disabled = false;
            }
        }
    }
}
function setMessageUsingDOM(message) {
     var userMessageElement = document.getElementById("advDiv");
     var messageText;
     if (message == "true") {
         userMessageElement.style.color = "red";
         messageText = "Id Allready Exists";
     } else {
         userMessageElement.style.color = "green";
         messageText = "Valid Id";
     }
     var messageBody = document.createTextNode(messageText);
     if (userMessageElement.childNodes[0]) {
         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
     } else {
         userMessageElement.appendChild(messageBody);
     }
 }
 
 
//----------------------------------------------------------------------------
function loadStaff()
{
   	var wordId=document.getElementById("com-Id").value;
   	var officeid=document.getElementById("office").value;
   	var departid=document.getElementById("dept").value;
   	var Resigned="";
		if(document.getElementById("Resigned").checked)
			Resigned="N"
		else
			Resigned="Y"
	http.open('get', '../autocomplete?action=complete10&id='+ wordId+"&office="+officeid+"&dept="+departid+"&Resigned="+Resigned);
	http.onreadystatechange = conveaccResponse;
    http.send(null);	
	
}
function conveaccResponse()
{
   
	if(http.readyState == 4)
	{
        var response = http.responseText;
        document.getElementById('description').innerHTML = response;		
    }
}
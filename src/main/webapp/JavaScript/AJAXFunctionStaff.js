var isIE;
var req;
var names;
var target;

function initRequest(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function validateUserId() {
    if (!target) target = document.getElementById("id");
    var url = "../autocomplete?action=valid&id=" + escape(target.value);
    initRequest(url);
    req.onreadystatechange = processRequestID;
    req.open("GET", url, true); 
    req.send(null);
}

function processRequestID() {
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

function setMessageUsingInline(message) {
    mdiv = document.getElementById("userIdMessage");
    if (message == "false") {
       mdiv.innerHTML = "<div style=\"color:red\">Invalid User Id</div>";
    } else {
       mdiv.innerHTML = "<div style=\"color:green\">Valid User Id</div>";
    }  
}

function setMessageUsingDOM(message) {
     var userMessageElement = document.getElementById("userIdMessage");
     var messageText;
     if (message == "true") {
         userMessageElement.style.color = "red";
         messageText = " Staff Id Allready Exists";
     } else {
         userMessageElement.style.color = "green";
         messageText = "Valid Staff Id";
     }
     var messageBody = document.createTextNode(messageText);
     if (userMessageElement.childNodes[0]) {
         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
     } else {
         userMessageElement.appendChild(messageBody);
     }
 }

function disableSubmitBtn() {
    var submitBtn = document.getElementById("submit_btn");
    submitBtn.disabled = true;
}

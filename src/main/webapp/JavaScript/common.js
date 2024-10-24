 

function isUidExist(textBoxObj){
    var uid = textBoxObj.value;
    if(uid!=null && uid!="")
        LoginAction.isUidExist(uid,setUidDetails);
}
function setUidDetails(map){
    if(map!=null){
        if(map.ERROR!=null && map.ERROR!=""){
            document.forms[0].uid.value = "";
            alert(map.ERROR);
        } else {
            if(map!=null && map.uid!=null && map.uid!="") {
                alert(map.uid+" UID Already Exist! ");
                document.forms[0].uid.value = "";
                return false;
            }
        }
    }
    return true;
} 


var iChars = "~`!%^&*()+={}[]\\\';|\":<>?";

/*
 * This Function used for given values is number or not --  
 */
function isNumber(txtBoxObj){
    x = txtBoxObj.value;
    nos=new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E',
        'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','!','@','#','$','%','^','&','(',')','|','?','>','<','[',']','{','}','*','"','`','~','.','-','_','+','=','*');
    for(i=0;i<txtBoxObj.value.length;i++){
        for(j=0;j<=nos.length;j++){
            if(x.charAt(i) == nos[j]){
                alert("Only Numbers Are Allowed")
                txtBoxObj.value="";
                return false;
            }
        }
    }
    return true;
}

/*
 * This Function used for given values is not number or not
 */
function numberNotAllowed(txtBoxObj){
    x = txtBoxObj.value;
    nos=new Array('0','1','2','3','4','5','6','7','8','9');
    for(i=0;i<txtBoxObj.value.length;i++){
        for(j=0;j<=nos.length;j++){
            if(x.charAt(i) == nos[j]){
                alert("Numbers Are not Allowed")
                txtBoxObj.value="";
                return false;
            }
        }
    }
    return true;
}

/*
 * This function used for give value is proper mail id or not --  
 */
function validateEmailid(txtBoxObj) {
    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    var address = txtBoxObj.value;
    if(address!=null && address!="" && reg.test(address) == false) {
        alert('Invalid Email Address');
        txtBoxObj.value="";
        return false;
    }
    return true;
}

/*
 * This function used for Special Characters --  
 */
function specialCharNotAllowed(txtBoxObj)
{
   
    var fieldValue = txtBoxObj.value;
    var fieldName = txtBoxObj.name;
    for (var i = 0; i < fieldValue.length; i++) {
        if (iChars.indexOf(fieldValue.charAt(i)) >= 0) {
            alert (fieldName+" has special characters. \nSpecial Caharacters are not allowed.\n");
            txtBoxObj.value = "";
            return false;
        }
    }
    return true;
}


/*
 * This function used for check enter value having any special character onkeyup
 * This method not allowed ~`!#%^&*()+={}[]'";:,./|\?<>
 *  
 */
function specialCharactersCheck(textBoxObj) {
    textBoxObj.value = filterNum(textBoxObj.value)

    function filterNum(str) {
        re = /\~|\`|\!|\#|\%|\^|\&|\*|\(|\)|\+|\=|\{|\}|\[|\]|\'|\"|\;|\:|\\|\||\?|\>|\<|/g;
        return str.replace(re, "");
    }
}



function specialCharactersChecks(textBoxObj) {
    textBoxObj.value = filterNum(textBoxObj.value)

    function filterNum(str) {
        re = /\~|\`|\!|\#|\%|\^|\$|\@|\&|\*|\(|\)|\+|\=|\{|\}|\[|\]|\'|\"|\;|\:|\\|\||\?|\>|\<|/g;
        return str.replace(re, "");
    }
}


function specialCharactersChecksNco(textBoxObj) {
    textBoxObj.value = filterNum(textBoxObj.value)

    function filterNum(str) {
        re = /\~|\`|\!|\#|\%|\^|\$|\@|\&|\*|\(|\)|\+|\=|\_|\-|\{|\}|\[|\]|\'|\"|\;|\:|\,|\.|\\|\||\?|\/|\>|\<|/g;
        return str.replace(re, "");
    }
}

/*
 * This function used Exit the Screen --  
 */
function exitScreen(){
    document.forms[0].action="LoginAction.htm";
    document.forms[0].method.value="loginPage";
    document.forms[0].submit();
}

/*
 * This function used for check the value most contain Alpha and Number
 
 */
function isAlphaNumeric(txtBoxObj){
    var textString = txtBoxObj.value;
    var re = /[\D]/g
    var re1 = /[^a-zA-Z]/g;
    if( (!textString.match(re)) || (!textString.match(re1)) ){
        alert(txtBoxObj.name+' Should be AlphaNumeric');
        txtBoxObj.value="";
        return ;
    }
}

/*
 * This method used for Password checking and Password should cantain minimum 5 Characters
 
 */
function passwordCheck(txtBoxObj){
    var x = txtBoxObj.value
    if(x!=""){
        if(txtBoxObj.value.length < 5) {
            alert("Error: Password must contain at least Five characters!");
            txtBoxObj.value="";
            return false;
        }
    //isAlphaNumeric(obj);
    }
    return true;
}

/**
 * This function check the special characters in particular Form
 * This method not allowed !#$%^&*()+=-[]\\\';,./{}|\":<>?
 *  
 */
function checkTotalFormSpecialCharacters(doc){
    var fields=doc.getElementsByTagName("input");
    for(var i=0;i<fields.length;i++) {
        if(!(fields[i].type=="button") && !(fields[i].type=="hidden")) {
            for (var j = 0; j < fields[i].value.length; j++) {
                //if (iChars.indexOf(fields[i].value.charAt(j)) != -1) {
                if (iChars.indexOf(fields[i].value.charAt(j)) >= 0) {
                    alert(fields[i].name+" Contains special characters. \n These are not allowed.\n Please remove and try again.");
                    return false;
                }
            }
        }
    }
    return true;
}

function pincodeValidate(objval){
    var val = objval.value;
    if(val.substring(0,1)!='6'){
        alert("Please Enter Proper Pincode");
        objval.value = "";
        return false;
    }else if(val.length !=6){
        alert("Please Enter Proper Pincode");
        objval.value = "";
        return false;
    }
    return true;
}

//the following function is used to verify the script are eployed in apache server properly or not

function alertscriptversion(){
    alert('Version 1.2.1.1');
}

function isFloatRangeValid(obj,fromrange,torange,fieldlength,percision,fieldname){
    var floatValue = obj.value;
    var errormessage = fieldname + " should be in the range of " + fromrange +" - "+ torange;
    if(floatValue!=null && floatValue!="" && floatValue.length>0){
        if(isValidFloatRange(obj,fieldlength,percision,errormessage)){
            if(parseFloat(floatValue) < parseFloat(fromrange) || parseFloat(floatValue) > parseFloat(torange)){
                alert(errormessage);
                obj.value = "";
                return false;
            }
        }
    }
    return true;
}

function isValidFloatRange(obj,fieldlength,percision,errorMessage){
    var idName = obj.id;
    var doubleValueId = document.getElementById(idName);
    var numberPattern = /^-{0,1}\d*\.{0,1}\d+$/;
    if(percision==null || percision=="" || percision=="undefined" || percision=="0")
        percision = "2";
    var addZeros = "";
    var fieldLengthValue = "";
    if(doubleValueId.value.length > 0){
        if(doubleValueId.value == '.'){
            alert(errorMessage);
            doubleValueId.value = "";
            return false;
        } else if(!numberPattern.test(doubleValueId.value)){
            alert(errorMessage);
            doubleValueId.value = "";
            return false;
        } else{
            var arval = doubleValueId.value.split(".");
            if(arval[0]==null || arval[0]=="" || arval[0]=="undefined")
                arval[0] = "0";
            if(arval[1]==null || arval[1]=="" || arval[1]=="undefined")
                arval[1] = "0";
            if(arval[0] != null && arval[0]!= "" && arval[0] != "undefined"){
                for(var fl=1; fl<=fieldlength; fl++){
                    if(fieldLengthValue!=null && fieldLengthValue!="")
                        fieldLengthValue = fieldLengthValue+"9";
                    else
                        fieldLengthValue = "9";
                }
                if(arval[0] > parseInt(fieldLengthValue)){
                    alert(errorMessage);
                    doubleValueId.value = "";
                    return false;
                } else if (percision < arval[1].length) {
                    alert("Entered percision value should not cross "+percision+" digits");
                    doubleValueId.value = "";
                    return false;
                } else if (doubleValueId.value.indexOf(".") == -1) {
                    for(var zero=1; zero<=percision; zero++){
                        if(addZeros!=null && addZeros!="")
                            addZeros = addZeros+"0";
                        else
                            addZeros = "0";
                    }
                    doubleValueId.value = arval[0]+"."+addZeros;
                } else{
                    var percisionValue = arval[1];
                    var remaintZeros = percision - arval[1].length;
                    for(var zero=1; zero<=remaintZeros; zero++){
                        percisionValue = percisionValue+"0";
                    }
                    doubleValueId.value = arval[0]+"."+percisionValue;
                }
            }
            return true;
        }
    } else{
        return true;
    }
    return true;
}

 


function numberValueCheck(textBoxObj){
   x = textBoxObj.value;
   var splittedVal;
    nos=new Array('0','1','2','3','4','5','6','7','8','9');
    for(i=0;i<textBoxObj.value.length;i++){
        for(j=0;j<=nos.length;j++){
            if(x.charAt(i) == nos[j]){
               splittedVal=x.split(j);
               textBoxObj.value=splittedVal[0];
                return false;
            }
        }
    }
    return true;
}




var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
	if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
	if (i==2) {this[i] = 29}
   }
   return this
}

function isValidDate(textBoxObj){
    var elementValue = textBoxObj.value;
    var daysInMonth = DaysArray(12)
    var pos1=elementValue.indexOf(dtCh)
    var pos2=elementValue.indexOf(dtCh,pos1+1)
    var strDay=elementValue.substring(0,pos1)
    var strMonth=elementValue.substring(pos1+1,pos2)
    var strYear=elementValue.substring(pos2+1)
    strYr=strYear
    if (strDay.charAt(0)=="0" && strDay.length>1)
        strDay=strDay.substring(1)
    if (strMonth.charAt(0)=="0" && strMonth.length>1)
        strMonth=strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
    }
    month=parseInt(strMonth)
    day=parseInt(strDay)
    year=parseInt(strYr)
    if(elementValue!="") {
        if (pos1==-1 || pos2==-1){
            return errorMessage("The date format should be : dd/mm/yyyy", textBoxObj);
        }
        if (strMonth.length<1 || month<1 || month>12){
            return errorMessage("Please enter a valid month", textBoxObj);
        }
        if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
            return errorMessage("Please enter a valid day", textBoxObj);
        }
        if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
            return errorMessage("Please enter a valid 4 digit year between "+minYear+" and "+maxYear, textBoxObj);
        }
        if (elementValue.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(elementValue, dtCh))==false){
            return errorMessage("Please enter a valid date", textBoxObj);
        }
    }
    return true;
}

function errorMessage(message, element) {
    alert(message);
    element.value='';
    element.focus();
    return false;
}

function formatDate(textBoxObj) {
    var elementValue = textBoxObj.value;
    for (i=0; i<elementValue.length; i++){
        if(((i==2)||(i==5))){}
        else {
            var c = elementValue.charAt(i);
            if (((c < "0") || (c > "9"))){
                alert("Only Numbers Are Allowed");
                textBoxObj.value='';
                return false;
            }
        }
    }
    if((elementValue.length==2)||(elementValue.length==5)){
        textBoxObj.value=elementValue+'/';
    }
    return true;
}

/**
 * Below Function used for check the enter date is Future data and Minor Date or not
 */
function minorValidateDate(textBoxObj){
    var toDayDate = document.forms[0].todaydate.value;
    var textBoxValue=textBoxObj.value;
    if(textBoxValue.length!=''){
        if(textBoxValue.length==10){
            var dobArray,dobDay,dobMonth,dobYear;
            if(textBoxValue!=""){
                dobArray=textBoxValue.split("/")
                dobDay=dobArray[0];
                dobMonth=dobArray[1];
                dobYear=dobArray[2];
            }

            var toDayDateArray,currentDay,currentMonth,currentYear;
            if(toDayDate!=""){
                toDayDateArray=toDayDate.split("/")
                currentDay=toDayDateArray[0];
                currentMonth=toDayDateArray[1];
                currentYear=toDayDateArray[2] ;
            }

            if((dobYear>currentYear) || (dobYear==currentYear && dobMonth>currentMonth) || (dobYear==currentYear && dobMonth==currentMonth && dobDay>currentDay)){
                alert("Date of Birth cann't be a Future Date");
                textBoxObj.value='';
                return false;
            }

            var yearAge = currentYear - dobYear;

            var dateAge = "";
            var monthAge = "";
            if (currentMonth >= dobMonth){
                monthAge = currentMonth - dobMonth;
            } else {
                yearAge--;
                monthAge = 12 + currentMonth -dobMonth;
            }
            if (currentDay >= dobDay){
                dateAge = currentDay - dobDay;
            } else {
                monthAge--;
                dateAge = 31 + currentDay - dobDay;
                if (monthAge < 0) {
                    monthAge = 11;
                    yearAge--;
                }
            }
            if(yearAge<14){
                alert("Date of Birth should be a greater than 14 years");
                textBoxObj.value='';
                return false;
            }
        }
    }
    return true;
}
function futureValidateDate(textBoxObj){
    var toDayDate = document.forms[0].todaydate.value;
    var textBoxValue=textBoxObj.value;
    if(textBoxValue.length!=''){
        if(textBoxValue.length==10){
            var dobArray,dobDay,dobMonth,dobYear;
            if(textBoxValue!=""){
                dobArray=textBoxValue.split("/")
                dobDay=dobArray[0];
                dobMonth=dobArray[1];
                dobYear=dobArray[2];
            }

            var toDayDateArray,currentDay,currentMonth,currentYear;
            if(toDayDate!=""){
                toDayDateArray=toDayDate.split("/")
                currentDay=toDayDateArray[0];
                currentMonth=toDayDateArray[1];
                currentYear=toDayDateArray[2] ;
            }

            if((dobYear>currentYear) || (dobYear==currentYear && dobMonth>currentMonth) || (dobYear==currentYear && dobMonth==currentMonth && dobDay>currentDay)){
                alert("Date of Birth cann't be a Future Date");
                textBoxObj.value='';
                return false;
            }
        }
    }
    return true;
}
function futureValidateYear(textBoxObj,lab){
    var toDayDate = document.forms[0].todaydate.value;
    var textBoxValue=textBoxObj.value;
 
    if(textBoxValue.length!=''){
        if(textBoxValue.length==4){
            var dobArray,dobDay,dobMonth,dobYear;
            dobYear = textBoxValue;

 
            var toDayDateArray,currentDay,currentMonth,currentYear;
            if(toDayDate!=""){
                toDayDateArray=toDayDate.split("/")
                currentDay=toDayDateArray[0];
                currentMonth=toDayDateArray[1];
                currentYear=toDayDateArray[2] ;
            }
             if(dobYear>currentYear){
                alert(lab+" sholud not be greater than the current Year");
                textBoxObj.value='';
                return false;
            }
        }
    }
    return true;
}

function qualAgeValidateDate(textBoxObj) {
    var toDayDate = document.forms[0].todaydate.value;
    var textBoxValue=textBoxObj.value;
    if(textBoxValue.length!=''){
        if(textBoxValue.length==10){
            var dobArray,dobDay,dobMonth,dobYear;
            if(textBoxValue!=""){
                dobArray=textBoxValue.split("/")
                dobDay=dobArray[0];
                dobMonth=dobArray[1];
                dobYear=dobArray[2];
            }

            var toDayDateArray,currentDay,currentMonth,currentYear;
            if(toDayDate!=""){
                toDayDateArray=toDayDate.split("/")
                currentDay=toDayDateArray[0];
                currentMonth=toDayDateArray[1];
                currentYear=toDayDateArray[2] ;
            }

            if((dobYear>currentYear) || (dobYear==currentYear && dobMonth>currentMonth) || (dobYear==currentYear && dobMonth==currentMonth && dobDay>currentDay)){
                alert("Date of Birth cann't be a Future Date");
                textBoxObj.value='';
                return false;
            }

            var yearAge = currentYear - dobYear;

            var dateAge = "";
            var monthAge = "";
            if (currentMonth >= dobMonth){
                monthAge = currentMonth - dobMonth;
            } else {
                yearAge--;
                monthAge = 12 + currentMonth -dobMonth;
            }
            if (currentDay >= dobDay){
                dateAge = currentDay - dobDay;
            } else {
                monthAge--;
                dateAge = 31 + currentDay - dobDay;
                if (monthAge < 0) {
                    monthAge = 11;
                    yearAge--;
                }
            }
            if(yearAge<14){
                alert("To add Qualification Candidate should be completed 15 years");
                textBoxObj.value='';
                return false;
            }
        }
    }
    return true;
}

/**
 * This function used for checking the enterd date is Future data or not
 */
function futureDataChecking(obj) {
    var todaydate = document.forms[0].todaydate.value;
    if(obj.value!=''){
        if(isFutureDate(obj,todaydate)){
            alert("Entered date can not be greater than the working date");
            obj.value='';
        }
    }
}

/**
 * This function used for checking the enterd date is Past data or not
 */
function pastDataChecking(obj) {
    var todaydate=document.forms[0].todaydate.value;
    if(obj.value!=''){
        if(!isFutureDate(obj,todaydate)){
            alert("Entered date can not be less than the working date");
            obj.value="";
        }
    }
}

function isFutureDate(txtbox,obj) {
    var db=txtbox.value;
    var strArray=db.split("/")
    var arrDay=strArray[0]
    var arrMonth=strArray[1]
    var arrYear=strArray[2]

    var db1=obj;

    if(db1!=""){
        var stArray=db1.split("/")
        var thisDay=stArray[0]
        var thisMonth=stArray[1]
        var thisYear=stArray[2]
    }
    if(arrYear>thisYear || (arrYear==thisYear && arrMonth>thisMonth) || (arrYear==thisYear && arrMonth==thisMonth && arrDay>thisDay)) {
        return true;
    } else {
        return false;
    }
}




function confirmMessage(message) {
	var userselection = confirm(message);
	if (userselection == true) {
		return true;
	} else {
		return false;
	}
}
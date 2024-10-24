// JavaScript Document
 
 
var isIE;
var req;
var names;
var target1;
var ctrl;
var color1="#FFDAB9";
var color2="#EEFFEE"; 

 

 
function addDate()
{
	try
	{
		var myDate=new Date();
		myDate.setDate(myDate.getDate()+15);
		alert(myDate);
	}
	catch(err)
	{
		alert(err);
	}	
}



function subtractDate()
{
	try
	{
		var myDate=new Date();
		myDate.setDate(my.getDate()-15);
		alert(myDate);
	}
	catch(err)
	{
		alert(err);
	}
}
 
 





function MessageAlert(msg)
{
	try
	{
		var p=window.createPopup()
		var pbody=p.document.body
		pbody.style.backgroundColor="#ffffff"
		pbody.style.border="solid black 0px"
		pbody.innerHTML="<CENTER><font class='newsarticlesmall'>"+msg+"</font></CENTER>";
		p.show(600, screen.height/4,300,75,document.body)
	}
	catch(err)
	{
		alert(err);
	}
}




function buttonDisable(ctr)
{
	try
	{
		document.getElementById(ctr).disabled = true;
	}
	catch(err)
	{
		alert(err);
	}
	
}







var dot=".";
var i;
function doubleValue(ctr,len)
{	
	var txtval=document.getElementById(ctr).value;
	window.status=""
	if(txtval.length==0 && event.keyCode==32)
	{ 
		event.keyCode=0; 
	}	
	 if(txtval.length<len)	
	{
		if((txtval.indexOf(dot))==-1) 
		{
			if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || event.keyCode==46)
				 event.keyCode;				 
						
			else
				event.keyCode=0;

 		}
	   	else if((txtval.indexOf(dot))!=-1) 
		{  
			if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 )
				 event.keyCode;                  
			
			else
				event.keyCode=0;
		}
		else
			event.keyCode=0;
	}
	 else if(event.keyCode==13)
		event.keyCode;
	else
	{	
		event.keyCode=0;		
		window.status="Maximum char reached"
		msg="Max char reached";		
		show_popup();
	}
}


function charOnly(ctr,size)// it also accept '-'minus charactor
{
	var txtval=document.getElementById(ctr).value;
	var len=size;
	if(txtval.length==0 && event.keyCode==32){ event.keyCode=0; }
	if(txtval.length<len)	
	{
		if((event.keyCode>96 && event.keyCode<=122) || (event.keyCode>64 && event.keyCode<91) || event.keyCode==13 ||  event.keyCode==32 ||  event.keyCode==45)
    		event.keyCode;
	   	else   
			event.keyCode=0;
	}	
	else
	{	
		event.keyCode=0;		
		window.status="Maximum char reached"
		msg="Max char reached";		
		show_popup();
	}	
}



function alphaNumerics(ctr,len) 
{
        var name = document.getElementById(ctr).value;
        var pattern = /^[A-Za-z0-9 ]{3,20}$/;
        if (pattern.test(name)) 
        {
            return true;
        } 
        else 
        {
            alert("Name is not valid.Please input alphanumeric value!");
            return false;
        }
}



function timeOnly(ctr)
{
	var txtval=document.getElementById(ctr).value;
	window.status=""
	if(txtval.length==0 && event.keyCode==32 ||(txtval.length==0 && event.keyCode==58)){ event.keyCode=0; }
   	if(event.keyCode>=48 && event.keyCode<=58 && txtval.length<8)
		event.keyCode;
	else
		event.keyCode=0;	
}
function dateOnly(ctr)
{
	event.keyCode=0;	
}






function checkDateTimes(ctr,msg)
{
	if(checkDateTime(ctr) )
		return true;
	else
		{
			alert(msg);	
			document.getElementById(ctr).focus();
	  	  	return false;
		}
}




 
function checkDate(ctr1,ctr2)
  {
   try
   {
  	var date1=document.getElementById(ctr1).value;
  	var d1=date1.substr(0,2);
	var m1=date1.substr(3,2);
	var y1=date1.substr(6,4);
  	var date2=document.getElementById(ctr2).value;
	var d2=date2.substr(0,2);
	var m2=date2.substr(3,2);
	var y2=date2.substr(6,4);
	if(!isNaN(d1) && !isNaN(m1) && !isNaN(y1))
	{
	  if(!isNaN(d2) && !isNaN(m2) && !isNaN(y2))
	  { 
		 if((d1<=d2 && m1==m2 && y1==y2) ||(d1<=d2 && m1<=m2 && y1<=y2) ||
		 (m1<m2 && y1==y2) || (y1<y2) )
		  {
		    return true;
		  }
		  else
		  {
		 	alert(" To Date Should Be Greater Than From Date");
		 	document.getElementById(ctr2).value="";
		    document.getElementById(ctr2).focus();
		   	return false;
		  }
	  }
	  else
	  {
		  alert("Enter Correct Date");
		  document.getElementById(ctr2).value="";
		  document.getElementById(ctr2).focus();
		  return false;
	  }	  
	}
	else
	{
	  alert("Enter Correct Date");
	  document.getElementById(ctr1).value="";
	  document.getElementById(ctr1).focus();
	  return false;
	}
   }
   catch(err)
   {
      alert(err);
   }
  }
  


/*
 * Annai Apartments A4, Block A, 6th cross Street, Nethaji colony, Velachery,
 * Chennai - 600 042. Ph : 0 94444 22673, 0 93800 03954 mailid :
 * software@mmi.co.in,info@mmi.co.in
 */


// save as file
function windowSave(filename)
{
	document.execCommand("SaveAs","1",filename);
	return false;
}




// table border style style="border-width: 5px; border-color: #F48442;
// border-style: solid;"
function setCurrentMonth(ctr)
{
	var d=new Date()
	var month1=d.getMonth() + 1
	if(month1<10) month1="0"+month1;
	var year1=d.getFullYear();
	setOptionValue(ctr,month1);
						
}

function setCurrentYear(ctr)
{
	var d=new Date()
	var month1=d.getMonth() + 1
	if(month1<10) month1="0"+month1;
	var year1=d.getFullYear();
	setOptionValue(ctr,year1);
						
}


function setCurrentDate(ctr)
{
	var d=new Date()
	var day=d.getDate()
	if(day<10) day="0"+day;
	var month=d.getMonth() + 1
	if(month<10) month="0"+month;
	var year=d.getFullYear()
	document.getElementById(ctr).value=day + "-" + month + "-" + year;
}

function setCurrentDateandTime(ctr)
{
	var d=new Date()
	var day=d.getDate()
	if(day<10) day="0"+day;
	var month=d.getMonth() + 1
	if(month<10) month="0"+month;
	var year=d.getFullYear()
	var h=d.getHours()
    var m=d.getMinutes()
    var s=d.getSeconds()
    
	document.getElementById(ctr).value=day + "-" + month + "-" + year +" " +h+":"+m+":"+s;
}

function echeck(str) // don't call this function directly
{
			var at="@"
			var dot="."
			var lat=str.indexOf(at)
			var lstr=str.length
			var ldot=str.indexOf(dot)
			if (str.indexOf(at)==-1){
		   		alert("Invalid E-mail ID")
		   		return false
			}
			if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   		alert("Invalid E-mail ID")
		   		return false
			}
			if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    	alert("Invalid E-mail ID")
		    	return false
			}
		 	if (str.indexOf(at,(lat+1))!=-1){
		    	alert("Invalid E-mail ID")
		    	return false
		 	}
		 	if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    	alert("Invalid E-mail ID")
		    	return false
		 	}
		 	if (str.indexOf(dot,(lat+2))==-1){
		    	alert("Invalid E-mail ID")
		   		return false
		 	}
		 	if (str.indexOf(" ")!=-1){
		    	alert("Invalid E-mail ID")
		    	return false
		 	}
 			 return true					
}

v=false;
ct=String;
function Trim(TRIM_VALUE)
{
	if(TRIM_VALUE.length<1)
		{return""}
	TRIM_VALUE=RTrim(TRIM_VALUE);
	TRIM_VALUE=LTrim(TRIM_VALUE);
	if(TRIM_VALUE=="")
		{return""}
	else
		{return TRIM_VALUE}
}

function RTrim(VALUE)
{
	var w_space=ct.fromCharCode(32);
	var fs=VALUE.length;
	var strTemp="";
	if(fs<0)
	{
		return""
	}
	var iTemp=fs-1;
	while(iTemp>-1)
	{
		if(VALUE.charAt(iTemp)==w_space)
		{}
		else
		{
			strTemp=VALUE.substring(0,iTemp+1);
			break
		}
		iTemp--
	}
	return strTemp
}

function LTrim(VALUE)
{
	var w_space=ct.fromCharCode(32);
	if(v_length<1)
		{return""}
	var v_length=VALUE.length;
	var strTemp="";
	var iTemp=0;
	while(iTemp<v_length)
	{
		if(VALUE.charAt(iTemp)==w_space)
		{}
		else
		{
			strTemp=VALUE.substring(iTemp,v_length);
			break
		}
		iTemp++
	}
	return strTemp
}


function TxtTrim(field)
{
	var val=field.value; 	
	val=Trim(val);
	field.value=val;	
}



function isAddress(ctr,len)
{	
	var txtval=document.getElementById(ctr).value;       
	window.status=""
	if(txtval.length==0 && event.keyCode==32)
		{ 
		event.keyCode=0; 
		}
	if(txtval.length<len)	
	{

	}
	else if(event.keyCode==13)
		event.keyCode;
	else
	{	
		event.keyCode=0;		
		window.status="Maximum char reached"
		msg="Max char reached";	
		show_popup(msg);				
	}
}


function copyDropdown(from, to)
{

		var x=document.getElementById( from );
		var i;
		var _targ=document.getElementsByName( to )[0];       
    	_targ.options.length=0;
    	
		for (i=0;i<x.length;i++)
			_targ.options[i+1]=new Option(x.options[i].text,x.options[i].value);
}


function checkTimeFormat(ctr,msg)
{
	try
	{
		var val=document.getElementById(ctr).value;
		var regex = new RegExp("([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])");
		if(!regex.test(val))
		{
		   alert(msg);	
		   document.getElementById(ctr).focus();
		   return false;
		}
		else
		   return true;
	}
	catch(err)
	{
		alert(ctr+"-----"+err);
		return false;
	}
}


function dateCompare(time1,time2) 
{
	try
	{
		  var t1 = new Date();
		  var parts = time1.split(":");
		  t1.setHours(parts[0],parts[1],parts[2],0);
		  var t2 = new Date();
		  parts = time2.split(":");
		  t2.setHours(parts[0],parts[1],parts[2],0);
	
		  // returns 1 if greater, -1 if less and 0 if the same
		  if (t1.getTime()>t2.getTime()) return true;
		  if (t1.getTime()<t2.getTime()) return false;
		  if (t1.getTime()==t2.getTime()) return true;
		  
	}
	catch(err)
	{
		alert(ctr+"-----"+err);
		return false;
	}

}	




function emailcheck(str)// Don't call the Function directly
	{
		var at="@";
		var dot=".";
		var lat=str.indexOf(at);
		var lstr=str.length;
		var ldot=str.indexOf(dot);
		var cdot=0;
		var i;
		for(i=0;i<lstr;i++)
		{
			if(str.charAt(i)==dot)
			{
			cdot=cdot+1;
			}
		}		
		if(cdot>2)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at)==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at)==0 || str.indexOf(at)==lstr)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot)==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot)==-1 || str.indexOf(dot)==0)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot,(ldot+1))==(lstr-1) || str.indexOf(dot)==(lstr-1))
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at,(lat+1))!=-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot,(lat+2))==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
			return true;
	}


	function userNameChk(ctr,len)
	{	  
	    var txtval=ctr.value;	    
	    window.status=""
		if(event.keyCode==32){ event.keyCode=0; }
		if(txtval.length<len)	
		{
			if(event.keyCode>=48 && event.keyCode<58 || 
			   (event.keyCode>96 && event.keyCode<=122) || (event.keyCode>64 && event.keyCode<91) ||
			   event.keyCode==95 || event.keyCode==46 || event.keyCode==32)
	    		event.keyCode;
		   	else   
				event.keyCode=0;
		}
		else if(event.keyCode==13)
			event.keyCode;
		else
		{	
			event.keyCode=0;
			window.status="Maximum char reached"
			show_popup();			
		}
	}


// Author: kalaiselvan :: Redirect to particular URL
	function redirect(URLStr) 
	{ 
		var rs=confirm("You press a close button");
		if (rs==true)
  		 	location = URLStr; 
  	}
  	
  	function redirects(URLStr ,message) 
	{ 
		var rs=confirm(message);
		if (rs==true)
  		 	location = URLStr; 
  	}	 
		
	

	function redirectValue(URLStr,ctr,nam) 
	{ 
		var val=(document.getElementById(ctr).value);
		location = URLStr+"&"+nam+"="+val; 
	}


	// Author: kalaiselvan :: Check password and username length
	function checkUserandPass(ctr,msg,len)
	{
		
		var val=(document.getElementById(ctr).value);	
		if(val === "")
		{
		  alert(msg);	
	  	  document.getElementById(ctr).focus();
		   return false;
		}
		
		var l = parseInt(len);
		if(val.length == l) 
		{
			return true;
		}
		else
		{
	 	  alert(msg);	
	  	  document.getElementById(ctr).focus();
	  	  return false;
		}
		
	}


// Author: kalaiselvan :: Fload Validation
	function isNumberFloat(inputString)
	{
	  	return (!isNaN(parseFloat(inputString))) ? true : false;
	}


	function  CheckFloatingPoint(ValueNumeric)
	{
	    var objRegex = /(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;

		if(objRegex.test(ValueNumeric))
		{
			 return true;
		}
		else
		{
			alert("Your Given Input\""+ValueNumeric+"\" Is Not  Correct.");
			return false;
		}
	}

	function isNumberInt(inputString)
	{
	 	 
	 	return (!isNaN(parseInt(inputString))) ? true : false;
	}

	function checkFloat(inputString)
	{
	  	var f =isNumberFloat(document.getElementById(inputString).value);
	  	var f1 = isNumberFloat(document.getElementById(inputString).value);
	  	if(!f && f1)  	
	  	{
	  		alert("Enter the correct format...");
	  		document.getElementById(inputString).value="";
	 	}
	}


// Price checking
function amountValidation(ctr)
{
	var value =document.getElementById(ctr).value;
	if(isNumberFloat(value))
	{
		
		var result = value.indexOf(".");
		var afterdigit;
		if(result <0)
		{
			alert("Invalid Amount...")
			document.getElementById(ctr).focus();
			return false;
		}	
		else
		{
			var snum= value.split(".");
			afterdigit =snum[1];
			result = afterdigit.length;
			if(result>2)
			{
				alert("Invalid Amount 'e.g 25000.25'")
				document.getElementById(ctr).focus();
				return false;
			}
			return true;
		}	
	}
	else
	{
		alert("Invalid Amount 'e.g 25000.25'")
		ctr.focus();
		return false;
	
	}		
}

// Author: kalaiselvan :: Manual Date Validation
	function numericHypenOnly(ctr,len)
	{	
		var txtval=document.getElementById(ctr).value;
		window.status="";
		if(txtval.length==0 && event.keyCode==32)
			event.keyCode=0; 
			
		if(txtval.length<len)
		{  
			if(txtval.length<2)
			{
				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13)
				 	event.keyCode;    			
		   		else	   
					event.keyCode=0;
			}
			
			if(txtval.length==2)
			{
				Message("Enter '-' Symbol");
				if(event.keyCode==45)
				    event.keyCode;	
				else	   
					event.keyCode=0;    
			}
			
			if(txtval.length>2 && txtval.length<5)
			{
				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13)
					event.keyCode;    			
		   		else	   
					event.keyCode=0;
			}                          
	                                
			if(txtval.length==5)
			{
				Message("Enter '-' Symbol");
				if(event.keyCode==45)
				    event.keyCode;	
				else	   
					event.keyCode=0;    
			}                                
			if(txtval.length>5)
			   {
				if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13)
				 
	    			event.keyCode;    			
		   		else	   
					event.keyCode=0;
			   } 
			 } 		
			else if(event.keyCode==13)
				event.keyCode;		
			else if(txtval.length>len)
			{	
				event.keyCode=0;		
				
			}		
	} 



// Check Amount only
	function priceOnly(sval)
	{	
		
		ssval=sval.value;
		var deciamlplace =ssval.indexOf(".");
		if(deciamlplace>0)
		{
			var pval = ssval.split(".");
			var l =pval[1].length;
			if(l <2)
			{
				return true;
			}
			else
			{
				alert("After 2digit not allowed");
				document.getElementById(sval).value="";
				document.getElementById(sval).focus();
			}
		}		
		for(i=0;i<ssval.length;i++)
		{
			if(ssval.charAt(i)=="." &&  event.keyCode==46) 
			{
					event.keyCode=0;
					return false;
			}
		}
		if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || event.keyCode==46)
		{
			return true;
		}
		else
		{
			event.keyCode=0;
		}
	}

// Check Amount only
	function pricesOnly(sval)
	{	
		
		ssval=document.getElementById(sval).value;
		var deciamlplace =ssval.indexOf(".");
		if(deciamlplace>0)
		{
			var pval = ssval.split(".");
			var l =pval[1].length;
			if(l <=2)
			{
				return true;
			}
			else
			{
				alert("Should be in price format");
				document.getElementById(sval).value="";
				document.getElementById(sval).focus();
			}
		}		
		for(i=0;i<ssval.length;i++)
		{
			if(ssval.charAt(i)=="." &&  event.keyCode==46) 
			{
					event.keyCode=0;
					return false;
			}
		}
		if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || event.keyCode==46)
		{
			return true;
		}
		else
		{
			event.keyCode=0;
		}
	}




// check duplicate entries
// Start
	 function getValues(name,length,divname,buttonname)
	 {
	 	var validstring="";
	 	for( i=1;i<=length;i++)
	 	{
	 		s=name+i;
	 		s =document.getElementById(s).value;
	 		if(!( s ==""))
	 		  validstring= validstring+s+",";
	 		  
	 	}
	 	duplicateCheck(validstring,name,divname,buttonname);
	 }
	 
	 
	function duplicateCheck(string ,name,divname,buttonname) 
	{
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = string.split(",");	
		secondaryArray = string.split(",");	
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			for(j=i+1;j<lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=j;
				}	
				
			
		}
		var d=ss.length
		if(d >1)
		{
			alert("Duplicate Entry");
			document.getElementById(divname).innerHTML="Duplicate available";
			document.getElementById(buttonname).disabled=true;
		}
		else
		{
			document.getElementById(divname).innerHTML="";
			document.getElementById(buttonname).disabled=false;
		}	
	}
// End




	
// check duplicate entries passing Collection of String
	function getValuesreturn(validstring,divname,buttonname)
	 {
	 	
	 	alert(duplicateCheckreturn(validstring,name,divname,buttonname));
	 }
	 
	function duplicateCheckreturn(string ,name,divname,buttonname) 
	{
		
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = string.split(",");	
		secondaryArray = string.split(",");	
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			for(j=i+1;j<lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=j;
				}	
				
			
		}
		var d=ss.length
		if(d >1)
		{
			alert("Duplicate Entry");
			document.getElementById(divname).innerHTML="Duplicate available";
			document.getElementById(buttonname).disabled=true;
			return true;
		}
		else
		{
			document.getElementById(divname).innerHTML="";
			document.getElementById(buttonname).disabled=false;
			return false;
		}	
	}
// End
	 


// select All value inS elect in drop down box
function selectAllvalueinSelect(dropdown,assign)
{
	var s = "";
	for(k=0;k<document.frm.dropdown.length;k++)
	 	s= s+document.frm.dropdown.options[k].value+"~";
	document.getElementById(assign).value = s;
	alert(s);
}


// Close window
function Close()
{
	try
	{
	  window.close();
	}
	catch(err)
	{
		alert(err);
	}
}

 
// ReadCookies
function readCookie(name)
{
  var cookieValue = "";
  var search = name + "=";
  if(document.cookie.length > 0)
  { 
    offset = document.cookie.indexOf(search);
    if (offset != -1)
    { 
      offset += search.length;
      end = document.cookie.indexOf(";", offset);
      if (end == -1) end = document.cookie.length;
      cookieValue = unescape(document.cookie.substring(offset, end))
    }
  }
  return cookieValue;
}
  
// WriteCookies
function writeCookie(name, value, hours)
{
  var expire = "";
  if(hours != null)
  {
    expire = new Date((new Date()).getTime() + hours * 3600000);
    expire = "; expires=" + expire.toGMTString();
  }
  document.cookie = name + "=" + escape(value) + expire;
}

function kbToMb(KB) { return KB / 1024; }

function mbToKb(MB) { return MB * 1024; }

function decToHex(dec)
{
  var hexStr = "0123456789ABCDEF";
  var low = dec % 16;
  var high = (dec - low)/16;
  hex = "" + hexStr.charAt(high) + hexStr.charAt(low);
  return hex;
}


// convert hexa to decimal
function hexToDec(hex) { return parseInt(hex,16); }


// set a message to status bar
function setStatusBar(msgStr) { self.status = msgStr; }

// print a page
function printPage() { print(document); }

 

// convert minutes to hours
function minutesToHours(min)
{
  var hrs = Math.floor(min/60);
  min = min % 60;
  if(min<10) min = "0" + min;
  return hrs + ":" + min;
}


// convert minutes to seconds
function minutesToSeconds(min) { return min*=60; }


// converts seconds to Hours
function secondsToHours(sec)
{

  var hrs = Math.floor(sec/3600);
  var min = Math.floor((sec%3600)/60);
  sec = sec % 60;
  if(sec<10) sec = "0" + sec;
  if(min<10) min = "0" + min;
  return hrs + ":" + min + ":" + sec;

}


// convert seconds to Minutes
function secondsToMinutes(sec)
{
  var min = Math.floor(sec/60);
  sec = sec % 60;
  if(sec<10) sec = "0" + sec;
  if(min<10) min = "0" + min;
  return min + ":" + sec;
}

// generate random numbers
function randomNumber(limit)
{
  return Math.floor(Math.random()*limit);
}


 
// set random background color
function randomBgColor()
{

  var r,g,b;
  r = decToHex(randomNumber(256)-1);
  g = decToHex(randomNumber(256)-1);
  b = decToHex(randomNumber(256)-1);
  document.bgColor = "#" + r + g + b;
}



// display coordianl dates
function DDtoDay(inputDate)
{
  var dateString = new Array('','st','nd','rd','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','th','st','nd','rd','th','th','th','th','th','th','th','st');
  returnDate = '';
  tempDate = parseInt(inputDate);
  if (tempDate >= 1 && tempDate <= 31)
  {
	  returnDate = inputDate + dateString[tempDate];
  }
 return returnDate;

}


// convert hour to minutes
function hoursToMinutes(hrs) 
{ 
return hrs*=60; 
}


// convert hours to seconds
function hoursToSeconds(hrs) { return hrs*=3600; }


 
// sorting of the array
function bubbleSort(theArray)
{

  var i, j;
  for (i = theArray.length - 1; i >= 0; i--)
  {
    for (j = 0; j <= i; j++)
    {
      if (theArray[j+1] < theArray[j])
      {
        var temp = theArray[j];
        theArray[j] = theArray[j+1];
        theArray[j+1] = temp;
      }

    }

  }
  return theArray;
}

 

// hide the layers
function showHideLayers()
{ 
  var i, visStr, obj, args = showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3)
  {
    if ((obj = findObj(args[i])) != null)
    {
      visStr = args[i+2];
      if (obj.style)
      {
        obj = obj.style;
        if(visStr == 'show') visStr = 'visible';
        else if(visStr == 'hide') visStr = 'hidden';
      }
      obj.visibility = visStr;
    }
  }
}



function replaceCharacters(conversionString,inChar,outChar)
{
  var convertedString = conversionString.split(inChar);
  convertedString = convertedString.join(outChar);
  return convertedString;
}


function replaceCharacters(conversionString,inChar,outChar)

{

  var convertedString = conversionString.split(inChar);

  convertedString = convertedString.join(outChar);

  return convertedString;

}

// set the background color
function setColor(objName, fg, bg)
{
  obj = findObj(objName);
  if (obj.style)
  {
    obj.style.color = fg;
    obj.style.backgroundColor = bg;
  }
}

 
 
// remove extra spaces
function removeExtraSpaces(string, delimiter)
{
  var returnString = "";
  splitstring = string.split(delimiter);
  for(i = 0; i < splitstring.length; i++)
  {
	  if (splitstring[i]!="") returnString += splitstring[i] + delimiter;
  }
  return returnString;
}

// length of the string
function minLength(inputString,inputLength)
{
  return (inputString.length >= inputLength) ? true : false;
}  

// only numbers
function onlyNumbers(inputString)
{
  var searchForNumbers = /\D+\_+\W+\s+\S+/
  return searchForNumbers.test(inputString);
} 

function onlyNumberss(chr){
 return !(chr > 31 && (chr < 48 || chr > 57))
}



// only character
function onlyCharacters(inputString)
{
  var searchForNumbers = /\d+/
  return (searchForNumbers.test(inputString))  

}
 
// capitalise the words
function capitalizeWords(string)
{

	var tmpStr, tmpChar, preString, postString, strlen;
	tmpStr = string.toLowerCase();
	stringLen = tmpStr.length;
	if (stringLen > 0)
	{
	  for (i = 0; i < stringLen; i++)
	  {
   		if (i == 0)
        {
			tmpChar = tmpStr.substring(0,1).toUpperCase();
		    postString = tmpStr.substring(1,stringLen);
      		tmpStr = tmpChar + postString;
	    }
    	else
		{
      		tmpChar = tmpStr.substring(i,i+1);
			if (tmpChar == " " && i < (stringLen-1))
			{
				tmpChar = tmpStr.substring(i+1,i+2).toUpperCase();
				preString = tmpStr.substring(0,i+1);
				postString = tmpStr.substring(i+2,stringLen);
				tmpStr = preString + tmpChar + postString;
     		}
    	}

  	 }

	}
	return tmpStr;
}

 


// Float Check
function stringToFloat (inputString)
{
  return parseFloat(inputString);
}


// Int Check
function stringToInteger (inputString)
{
  return parseInt(inputString);
}





// count the words in a sentences
function howManyWords(inputString)
{
  return inputString.split(' ').length;
}

// check length of the string
function minLength(inputString,inputLength)
{
  return (inputString.length <= inputLength) ? true : false;
} 


 


   
// All capital Letters
function stringToUppercase(inputString)
{
  return inputString.toUpperCase();
}



// Check for characters
function checkForCharacters(inputString, checkString, startingIndex)
{
  if (!startingIndex) startingIndex = 0;
  return inputString.indexOf(checkString);
}

// Has Atleast One Character
function hasAtLeastOneCharacter (inputString)
{
  return inputString.length;
}


// is not a number
function isNotaNumber (inputString)
{
  return isNaN(inputString);
}



// Lowercase
function stringToLowercase(inputString)
{
  return inputString.toLowerCase();
}


// number to string
function numberToString(inputNumber,base)
{

  var prefix = '';
  if (!base) base = 10;
  if (base=8) prefix = '0';
  if (base=16) prefix = '0x'
  return (prefix + inputNumber.toString(base));
}


// String Length
function stringLength(inputString)
{
  return inputString.length;
}


// return total no of days in month
function totalDays(month ,year) 
{
		var itemArray = " 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31 ".split(",");
		if (year % 4 == 0)
			itemArray[2] = 29;
		return (itemArray[mon]);
}


// check date different
function checkDateDifferent(fromdate,todate,limit)
{
	// var fdate = document.getElementById(fromdate).value;
	// var tdate = document.getElementById(todate).value;
	var fdate = fromdate;
	var tdate = todate;
	
	 
	var diff = limit;
	var array1 = fdate.split("-");
	var array2 = tdate.split("-");
	var d1 = parseInt(array1[0]);
	var m1 = parseInt(array1[1]);
	var y1 = parseInt(array1[2]);
	var d2 = parseInt(array2[0]);
	var m2 = parseInt(array2[1]);
	var y2 = parseInt(array2[2]);
	var date=0;
	var month=0;
	var year=0;
	if(d2>=d1)
	{
		date= d2-d1;
	}
	else
	{
	 	var getnoofdays = totalDays(m2 ,y2)
	 	d2 = d2 +getnoofdays;
	 	date = d2-d1;
	 	m2 = m2-1;
	}	
		
	if(m2 >=m1)
	{
		month = m2-m1;
	}
	else
	{
		m2 = m2+12;
		month = m2 - m1;
		y2 = y2-1;
	}
	year = y2 -y1;
	
	var datediff = year+"-"+month+"-"+date;
	alert(datediff);
	return datediff;	
		
}



// return Month in number format
function getMonthNumber(month) 
{
		var mon = 0;
		if (month=="January")  	{	mon = 1; 	}
		if (month=="February") 	{	mon = 2; 	} 
		if (month=="March")    	{	mon = 3;	}
		if (month=="April") 	{	mon = 4;	}
		if (month=="May") 		{	mon = 5;	} 
		if (month=="June") 		{	mon = 6;	}
		if (month=="July") 		{	mon = 7;	}
		if (month=="August") 	{	mon = 8;	}
		if (month=="September") {	mon = 9;	} 
		if (month=="October") 	{	mon = 10;	} 
		if (month=="November") 	{	mon = 11;	} 
		if (month=="December") 	{	mon = 12;	}
		return mon;

	}


// return Month in number format
function getMonthCharacter(month) 
{
		var mon = "";
		if (month=="01")  	{	mon = "January"; 	}
		if (month=="02") 	{	mon = "February"; 	} 
		if (month=="03")    {	mon = "March";		}
		if (month=="04") 	{	mon = "April";		}
		if (month=="05") 	{	mon = "May";		} 
		if (month=="06") 	{	mon = "June";		}
		if (month=="07") 	{	mon = "July";		}
		if (month=="08") 	{	mon = "August";		}
		if (month=="09") 	{	mon = "September";	} 
		if (month=="10") 	{	mon = "October";	} 
		if (month=="11") 	{	mon = "November";	} 
		if (month=="12") 	{	mon = "December";	}
		return mon;
	}


function getMonthName(month) 
{
		var mon = 0;
		mon = parseInt(mon);
		// Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
		if (month==1)  	{	mon = "JAN"; 	}
		if (month==2) 	{	mon = "FEB"; 	} 
		if (month==3)    {	mon = "MAR";	}
		if (month==4) 	{	mon = "APR";	}
		if (month==5) 	{	mon = "MAY";	} 
		if (month==6) 	{	mon = "JUN";	}
		if (month==7) 	{	mon = "JUL";	}
		if (month==8) 	{	mon = "AUG";	}
		if (month==9) 	{	mon = "SEP";	} 
		if (month==10) 	{	mon = "OCT";	} 
		if (month==11) 	{	mon = "NOV";	} 
		if (month==12) 	{	mon = "DEC";	}
		return mon;

	}



// get Month
function GetMonth(intMonth){
    var MonthArray = new Array("January", "February", "March",
                               "April", "May", "June",
                               "July", "August", "September",
                               "October", "November", "December") 
    return MonthArray[intMonth] 	  	 
    }

 // get Date
 function getDateStr()
 {
    var today = new Date()
    var year = today.getYear()
    if(year<1000) year+=1900
    var todayStr = GetMonth(today.getMonth()) + " " + today.getDate()
    todayStr += ", " + year
    return todayStr
 }
 
 function GetDay(intDay)
 {
    var DayArray = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
    return DayArray[intDay]
 }
 
 //
 function getDateStrWithDOW()
 {
    var today = new Date()
    var year = today.getYear()
    if(year<1000) year+=1900
    var todayStr = GetDay(today.getDay()) + ", "
    todayStr += GetMonth(today.getMonth()) + " " + today.getDate()
    todayStr += ", " + year
    return todayStr
}

// Currency
// 1234.34567 is set to 1234.34
function formatPrice(value) 
{
	var result= Math.floor(value) + ".";
	var cents = 100 * (value-Math.floor(value)) + 0.5;
	result += Math.floor(cents / 10);
	result += Math.floor(cents % 10);
	alert(result);
	return result;
}
 
// Currency
// 1234.34567 is set to 1234.345 divided by 1000
// 1234.345 is set to 1234.34 divided by 100
// 1234.345 is set to 1234.3 divided by 10

function formatAmount(ctr)
{
	var original=ctr.value;
	var result=Math.round(original*100)/100  ;
	ctr.value= result;
	 
	
}


function days_between(d1, d2) 
{
	try
	{
		var date1 = d1.value;
		var date2 = d2.value;
		alert(date1)
		var ONE_DAY = 1000 * 60 * 60 * 24;
	    var date1_ms = date1.getTime();
	    var date2_ms = date2.getTime();
	    var difference_ms = Math.abs(date1_ms - date2_ms);
	    alert(Math.round(difference_ms/ONE_DAY));
	    // return Math.round(difference_ms/ONE_DAY)
	}
	catch(err)
		{
			alert(err.description)
		}	    
}



// display number to words

function numberWord(num,divname) 
{
	 
	var snum= num.split(".");
	num = snum[0];
	var beforeadd="";
	for(i=0;i<(10-num.length);i++)
		beforeadd=beforeadd+"0";
	num = beforeadd+num	
	
	var crore = num.substring(0,3);
	var lakh = num.substring(3,5);
	var thousand = num.substring(5,7);
	var base = num.substring(7,10);
	
	var s=" <img src='../Image/report/Rupee.jpeg' width='10' height='10'>   ";
	if(crore >=1)
	  s = s+numberWords(crore)+" Crore "; 
	  
	if(lakh >=1)
	  s = s+numberWords(lakh)+" Lakh "; 

	if(thousand >=1)
	  s = s+numberWords(thousand)+" Thousand "; 
	 
	if(base >=1)
	  s = s+numberWords(base) 
	s= s+" Only";  
	
	 var tb=document.getElementById(divname);	 
  	 tb.innerHTML="( <b>"+s+ "</b>)";   
}


var numArray = new Array('','One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten');
var tensArray = new Array('','Ten','Twenty','Thirty','Forty','Fifty','Sixty','Seventy','Eighty','Ninety');
var teensArray = new Array('Ten','Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Nineteen');
function numberWords(num) 
{
	var hundreds = Math.floor(num/100);
	var tens = Math.floor((num-(hundreds * 100))/10);
	var ones = num - ((hundreds*100) + (tens*10));
	if (num==0) return "zero";
	else if (hundreds >= 1)
	{
		if(tens == 1)
		{
			tmp = numArray[hundreds] + " Hundred " + teensArray[ones];
		}
    	else tmp = numArray[hundreds] + " Hundred " + tensArray[tens] +' '+ numArray[ones];
	}
	else if (tens >= 1) 
	{
		if(tens == 1)
		{
			tmp = teensArray[ones];
		}
		else tmp = tensArray[tens] +' '+ numArray[ones];
	}
	else tmp = numArray[ones];
	return tmp;
}

// <BODY onLoad="ScreenGoToURL('Login.jsp','errorindex.html')">
function ScreenGoToURL(Big,Medium) 
{
	var screen_height = screen.height;
	var screen_width = screen.width;
	var buffer = (document.all || document.layers ||documentGetElementByID) ? 30 : 48;
	if (screen_height >= 768) 
	{
		screen_width = 1024;
		screen_height = 768;
	 	var window_width = 1024-12;
     	var window_height = 768-buffer;
     	var window_top = 0;
     	var window_left = 0;
     	window.open(Big,'',' resizable=no,toolbar=yes,scrollbars=yes, status=no,width=' + window_width + ',height=' + window_height + ',top=' + window_top + ',left=' + window_left + '');
	} 
	else 
	{
		screen_width = 800;
		screen_height = 600;
		var window_width =  800-12;
    	var window_height = 600-buffer;
		var window_top = 0;
    	var window_left = 0;
    	window.open(Medium,'','resizable=no,status=yes,width=' + window_width + ',height=' + window_height + ',top=' + window_top + ',left=' + window_left + '');
	}
}



function checkScreen()
{
	if ((screen.width == 1024) && (screen.height == 768))
	{
		alert('Your screen resolution is 1024x768.  This site is best viewed at 1024x768 resolution.')
	}
	else if ((screen.width == 640) && (screen.height == 480))
	{
		alert('Your screen resolution is 640x480.  This site is best viewed at 1024x768 resolution.')
	}
	else if ((screen.width == 1152) && (screen.height == 864))
	{
		alert('Your screen resolution is 1152x864.  This site is best viewed at 1024x768 resolution.')
	}
	else if ((screen.width == 1280) && (screen.height == 1024))
	{
		alert('Your screen resolution is 1280x1024.  This site is best viewed at 1024x768 resolution.')
	}
	else if ((screen.width == 1600) && (screen.height == 1200))
	{
		alert('Your screen resolution is 1600x1200.  This site is best viewed at 1024x768 resolution.')
	}


}

// <A HREF="javascript:onClick=Minimize()">Minimize</A>
// <A HREF="javascript:onClick=Maximize()">Maximize</A>
function Minimize() 
{
	window.innerWidth = 100;
	window.innerHeight = 100;
	window.screenX = screen.width;
	window.screenY = screen.height;
	alwaysLowered = true;
}

function Maximize() 
{
	window.innerWidth = screen.width;
	window.innerHeight = screen.height;
	window.screenX = 0;
	window.screenY = 0;
	alwaysLowered = false;
}
 
// <a href=http://www.hairclub.com onFocus="if(this.blur)this.blur()">Hair Club
// for Men</a>


// calculating date different
function dayDifferent(date1 ,date2, split)
{
        var t1=date1 ;
        var t2=date2;
        var one_day=1000*60*60*24; 
		var x=t1.split(split);     
        var y=t2.split(split);
        var date1=new Date(x[2],(x[1]-1),x[0]);
        var date2=new Date(y[2],(y[1]-1),y[0])
        var month1=x[1]-1;
        var month2=y[1]-1;
        var _Diff=Math.ceil((date2.getTime()-date1.getTime())/(one_day)); 
        alert(_Diff);
		
}

// confiramtion box
function confirms(message)
{
  	var r=confirm(message);
  	if (r==true)
    {
    	return true;
    }
 	else
    {
    	return false;
    }
}

// set the focus
function setFocus(ctr)
{
	document.getElementById(ctr).focus();
}
 
// onkeyup="checkLen(this,this.value)"
// automatically jumps to the next field when a field's maxlength has been
// reached:
function checkLen(x,y)
{
	if (y.length==x.maxLength)
	{
		var next=x.tabIndex
		if (next<document.getElementById("frm").length)
		{
			document.getElementById("frm").elements[next].focus();
		}
	}
}

// remove item in dropdown list
function removeOption(ctr)
{
  var x=document.getElementById(ctr);
  x.remove(x.selectedIndex);
}

// onLoad="javascript:window.print(), window.close()"
function pagePrint()
{
	window.print();
	window.close();
}


// amount rounded and fixed to 2 digig number
function currencyValue(profits)
{
	 return parseFloat(profits ).toFixed(2);
}


// check url
function isValidURL(url)
{
    var RegExp = /^(([\w]+:)?\/\/)?(([\d\w]|%[a-fA-f\d]{2,2})+(:([\d\w]|%[a-fA-f\d]{2,2})+)?@)?([\d\w][-\d\w]{0,253}[\d\w]\.)+[\w]{2,4}(:[\d]+)?(\/([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)*(\?(&?([-+_~.\d\w]|%[a-fA-f\d]{2,2})=?)*)?(#([-+_~.\d\w]|%[a-fA-f\d]{2,2})*)?$/;
    if(RegExp.test(url))
    {
        return true;
    }
    else
    {
        return false;
    }
}


// complete emailvalidation check mailid
function isValidEmail(email)
{
    var RegExp = /^((([a-z]|[0-9]|!|#|$|%|&|'|\*|\+|\-|\/|=|\?|\^|_|`|\{|\||\}|~)+(\.([a-z]|[0-9]|!|#|$|%|&|'|\*|\+|\-|\/|=|\?|\^|_|`|\{|\||\}|~)+)*)@((((([a-z]|[0-9])([a-z]|[0-9]|\-){0,61}([a-z]|[0-9])\.))*([a-z]|[0-9])([a-z]|[0-9]|\-){0,61}([a-z]|[0-9])\.)[\w]{2,4}|(((([0-9]){1,3}\.){3}([0-9]){1,3}))|(\[((([0-9]){1,3}\.){3}([0-9]){1,3})\])))$/
    if(RegExp.test(email))
    {
        return true;
    }
    else
    {
        return false;
    }
}

// Export to Excel sheet
function CreateExcelSheet()
{
	try
	{
		var x=myTable.rows
		var xls = new ActiveXObject("Excel.Application")
		alert(xls)
		xls.visible = true
		xls.Workbooks.Add
		for (i = 0; i < x.length; i++)
		{
			var y = x[i].cells
			for (j = 0; j < y.length; j++)
			{
				xls.Cells( i+1, j+1).Value = y[j].innerText
			}
		}
	}
	catch(err)
	{
		alert(err);
	}
}


function CreateExcelSheet1( ) 
{ 

	var detailsTable = document.getElementById("myTable"); 
	var oExcel = new ActiveXObject("Excel.Application"); 
	var oBook = oExcel.Workbooks.Add; 
	var oSheet = oBook.Worksheets(1); 
	for (var y=0;y<detailsTable.rows.length;y++) 
	{ 
		for (var x=0;x<detailsTable.rows(y).cells.length;x++) 
		{ 
			oSheet.Cells(y+1,x+1) =detailsTable.rows(y).cells(x).innerText; 

		} 
	} 
	oExcel.Visible = true; 
	oExcel.UserControl = true; 
} 






/*
 * <form name="frmValidate" onSubmit="return checkField()"> function
 * checkField(){ var frm = document.frmValidate, error = "";
 * if(!isValidURL(frm.url.value)){ error += "Please enter a valid URL\n"; }
 * if(!isValidEmail(frm.email.value)){ error += 'Please enter a valid Email\n'; }
 * if(error != ""){ alert(error); return false; }else{ return true; } }
 * 
 * 
 * <a href=javascript:; onClick="windowSave('sample.txt')">Save</a>
 * 
 * 
 * <a href="JavaScript:location.reload(true);"> Refresh this page </a>
 * 
 * 
 */

// Refresh the page
function Refresh()
{
	location.reload(true);
}

// run Executable file in a specified path
// onLoad='javascript:run("file:///D:/Program%20Files/mmi/MySQL-Front/MySQL-Front.exe")'
function run(file) 
{ 
	var ws = new ActiveXObject("WScript.Shell"); 
	ws.run(file); 
	history.back(1);
}

// Display data copied to clipboard
function getClipboarDdata()
{
	alert(window.clipboardData.getData('text'));
}


// if object not available its return null
/*
 * obj = findObj("textfield2s"); if(obj == null) alert("object not available");
 */
function findObj(theObj, theDoc)
{

  var p, i, foundObj;
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }

  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];

  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);

  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);

  return foundObj;

}


function checkfindObject(ctr,msg)
{
	try
	{
		obj = findObj(ctr); 
		if(obj == null)
		{
			alert(msg);
			return false;
		}	
		else
			return true;
	}
	catch(err)
	{
		alert(err)
		return false;
	}
}


		
		
/*
 * Random background color <body onpaste="return false;"
 * onLoad="randomBgColor()">
 */
function randomBgColor()
{
	var r,g,b;
  	r = decToHex(randomNumber(256)-1);
  	g = decToHex(randomNumber(256)-1);
  	b = decToHex(randomNumber(256)-1);
  	document.bgColor = "#" + r + g + b;
}

// Randomised image
// randomImage(['0.gif',50,50,'1.gif',25,25,'2.gif',50,25]);
function randomImage(imgArr)
{
  var imgSrc, imgW, imgH, r;
  r = randomNumber(imgArr.length / 3)-1;
  
  imgSrc = imgArr[r * 3];
  imgW = imgArr[(r * 3)+1];
  imgH = imgArr[(r * 3)+2];

  document.write('<IMG SRC='+imgSrc+' WIDTH='+imgW+' HEIGHT='+imgH+'>');
}

// Mouse rightclick button disabled
function disableRightClick(e)
{

  var message = "Right click disabled";
  if(!document.rightClickDisabled) // initialize
  {
    if(document.layers) 
    {
      document.captureEvents(Event.MOUSEDOWN);
      document.onmousedown = disableRightClick;
    }
    else document.oncontextmenu = disableRightClick;
    return document.rightClickDisabled = true;

  }

  if(document.layers || (document.getElementById && !document.all))
  {
    if (e.which==2||e.which==3)
    {
      alert(message);
      return false;
    }
  }
  else
  {
    alert(message);
    return false;
  }
}

function dojandregidcheck(ctr,shortname)
{
	var regid = document.getElementById(ctr).value;	
	var serverid = document.getElementById('serverid').value;	
	regid=regid.toUpperCase();
	
	var l = regid.length;
	var cpy = regid.substring(0,(l-13));
	var mth = regid.substring((l-13),(l-10));
	var year = regid.substring((l-10),(l-6));
	var id = regid.substring((l-6),l);
		
	var date= document.getElementById('doj').value;
	var dt= date.split("-");
	var dojday=dt[0];
	var dojmonth = dt[1];
	var dojyear=dt[2];
	
	var getmonth = getMonthName(dojmonth);
	 
	if((getmonth === mth) && (dojyear===year) &&(serverid===id))
	{
		return true;
	}	
	else
	{
		alert("Kindly check the Registration id ...");
		return false;
	}	
}

function companyregistration(ctr,shortname)
{
	var regid = document.getElementById(ctr).value;	
	regid=regid.toUpperCase();
	if(regid.length != 16)
	{
		alert("Invalid Registration Number");
		document.getElementById(ctr).focus();
		return false;
	}	
	else
	{
		var l = regid.length;
		var cpy = regid.substring(0,(l-13));
		var mth = regid.substring((l-13),(l-10));
		var year = regid.substring((l-10),(l-6));
		var id = regid.substring((l-6),l);
		/*
		 * var v="cdddcsjun2007002070"; var l = v.length; alert((l-6));
		 * alert(v.substring((l-6),l)); alert(v.substring((l-10),(l-6)));
		 * alert(v.substring((l-13),(l-10))); alert(v.substring(0,(l-13)));
		 */
		 
		
		if(companycheck(cpy,shortname) && (monthcheck(mth)) && (!isNaN(year))&&(!isNaN(id)))
			return true;
		else
		{
			alert("Invalid Registration Number");
			document.getElementById(ctr).focus();
			return false	
		}	
	}
}

function companycheck(cpy,shortname)
{
	var name = shortname.split(",");
	var f = false;
	
	for(i=0;i<name.length-1;i++)
		if(name[i] == cpy)
			f = true;
	
	 
	if(f)
	{
		return true;
	}	
	else
	{
		alert("Invalid company");
		return false;
	}	

	// if((cpy=="CIS") ||(cpy=="CCS")||(cpy=="CNS"))
		// return true;
	// else
		// return false
}

function monthcheck(cpy)
{
	// Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
	if((cpy=="JAN") ||(cpy=="FEB")||(cpy=="MAR")||(cpy=="APR")||(cpy=="MAY")||(cpy=="JUN")||(cpy=="JUL")||(cpy=="AUG")||(cpy=="SEP")||(cpy=="OCT")||(cpy=="NOV")||(cpy=="DEC"))
		return true;
	else
	{
		alert("Invalid month");
		return false	
	}	
}

// Image Sliding
/*
 * <script>
 * 
 * var slideShowSpeed = 2000 var crossFadeDuration = 3
 * 
 * var Pic = new Array() // don't touch this Pic[0] =
 * '../Image/General/ACCOUNTS.jpg' Pic[1] = '../Image/General/ATTENDANCE.jpg'
 * Pic[2] = '../Image/General/HRM.jpg' Pic[3] = '../Image/General/INVENTORY.jpg'
 * Pic[4] = '../Image/General/PAYROLL.jpg'
 * 
 * 
 * var t var j = 0 var p = Pic.length
 * 
 * var preLoad = new Array() for (i = 0; i < p; i++){ preLoad[i] = new Image()
 * preLoad[i].src = Pic[i] }
 * 
 * function runSlideShow(){ if (document.all){
 * document.images.SlideShow.style.filter="blendTrans(duration=2)"
 * document.images.SlideShow.style.filter="blendTrans(duration=crossFadeDuration)"
 * document.images.SlideShow.filters.blendTrans.Apply() }
 * document.images.SlideShow.src = preLoad[j].src if (document.all){
 * document.images.SlideShow.filters.blendTrans.Play() } j = j + 1 if (j >
 * (p-1)) j=0 t = setTimeout('runSlideShow()', slideShowSpeed) } </script>
 * 
 * 
 * <body onpaste="return false;" onLoad="runSlideShow()"> <table border="0"
 * cellpadding="0" cellspacing="0"> <tr> <td id="VU" height=150 width=150> <img
 * src="../Image/General/ACCOUNTS.jpg" name='SlideShow' width=150 height=150></td>
 * </tr> </table>
 * 
 * </body>
 */



function createRequestObject() 
{
   var req;
   if(window.XMLHttpRequest)
   {
      // Firefox, Safari, Opera...
      req = new XMLHttpRequest();
    } 
    else if(window.ActiveXObject) 
    {
      // Internet Explorer 5+
      req = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else 
    {
      // There is an error creating the object,
      // just as an old browser is being used.
      alert('There was a problem creating the XMLHttpRequest object');
    }
    return req;
} 


// Coding for AJAX
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


function InitialisingTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Loading Data...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}

function ClearTables(ctr1)
{
	 var str="<font class='errorMessage'><center> Data not found...</font></center>";
	 var tb=document.getElementById(ctr1);	 
  	 tb.innerHTML=str     
}


/*
 * function LoadUserName() { var uname =
 * document.getElementById('userName').value; var url =
 * "../Common?actionS=LoadUserName&userName="+escape(uname); initRequest(url);
 * req.onreadystatechange = LoadUserNameRequest; req.open("GET", url, true);
 * req.send(null); }
 * 
 * function LoadUserNameRequest() { if(req.readyState == 4) { if (req.status ==
 * 200) { LoadUserNameMessages(); } } }
 * 
 * 
 * function LoadUserNameMessages() { var batchs =
 * req.responseXML.getElementsByTagName("Usernames")[0]; var str="<table >";
 * for(loop = 0; loop < batchs.childNodes.length; loop++) { var batch =
 * batchs.childNodes[loop]; var Status =
 * batch.getElementsByTagName("Status")[0]; if(Status.childNodes[0].nodeValue ==
 * "true") str = str+"<tr><td><font class='bolddeepred' >Exists..</font></td></tr>";
 * else str = str+"<tr><td class='changePos'>Valid...</td></tr>"; }
 * str=str+"</table>"; var tb=document.getElementById('UserTable');
 * tb.innerHTML=str ;
 *  }
 * 
 * <script language="JavaScript" type="text/javascript"> var d=new Date() var
 * weekday=new
 * Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
 * var monthname=new
 * Array("January","February","March","April","May","June","July","August","September","October","November","December")
 * document.write('<b><font face=verdana size=1 font color=ff6500>'
 * +weekday[d.getDay()]+", "+d.getDate()+" - "+monthname[d.getMonth()]+", "
 * +d.getFullYear() +'</font>'); </script>
 */

// weekday
function Weekday(dt)
{
	var d=new Date();
	birthday = new Date(1977,10,21)
	alert(">>>>"+birthday.getDay())
	var weekdays=new Array(7);
	weekdays[0]="Sunday"
	weekdays[1]="Monday"
	weekdays[2]="Tuesday"
	weekdays[3]="Wednesday"
	weekdays[4]="Thursday"
	weekdays[5]="Friday"
	weekdays[6]="Saturday"
	alert(weekdays[d.getDay()]);
}


 


// Round for 2digits
function Round(value) 
{
	var num=2;
	var  pow=100;
	var tmp=Math.round(value*100);
    var itmp=parseInt(tmp);
    tmp=itmp;
    tmp/=pow;
    return tmp;
}		


function Rounds(value) 
{
	var num=2;
	var  pow=Math.pow(10,num);
    var tmp=value*pow;
    var itmp=parseInt(tmp);
    tmp=itmp;
    alert(tmp);
    tmp/=pow;
    return tmp;
}		



// General Array Function
function MakeArray(n) 
{   
  this.length=n;   
  for (var i=1; i<=n; i++) this[i]=0;   
}


// Initialize Days of Week Array
days=new MakeArray(7);
days[0]="Saturday"; days[1]="Sunday"; days[2]="Monday";
days[3]="Tuesday"; days[4]="Wednesday"; days[5]="Thursday";
days[6]="Friday";


// Initialize Months Array
months=new MakeArray(12);
months[1]="January";   months[2]="February"; 
months[3]="March";     months[4]="April";
months[5]="May";       months[6]="June";
months[7]="July";      months[8]="August";
months[9]="September"; months[10]="October";
months[11]="November"; months[12]="December";


// Day of Week Function
function compute(day,month,year) 
{   
	var val1=parseInt(day,10)   
	if ((val1 < 0) || (val1 > 31)) 
	{      
		alert("Day is out of range")   
	}   
	var val2 = parseInt(month, 10)   
	if ((val2 < 0) || (val2 > 12)) 
	{      
		alert("Month is out of range")   
	}     
	var val2x = parseInt(month, 10)   
	var val3 = parseInt(year, 10)   
	if (val3 < 1900)  { alert("You're that old!"); }   
	if (val2 == 1)    { val2x=13;  val3=val3-1;    }   
	if (val2 == 2)    { val2x=14;  val3=val3-1;    }   
	var val4 = parseInt(((val2x+1)*3)/5, 10)   
	var val5 = parseInt(val3/4, 10)   
	var val6 = parseInt(val3/100, 10)   
	var val7 = parseInt(val3/400, 10)   
	var val8 = val1+(val2x*2)+val4+val3+val5-val6+val7+2   
	var val9 = parseInt(val8/7, 10)   
	var val0 = val8-(val9*7)   
	return days[val0];
}   

	
// return nof days in a month
function daysInMonth(iMonth, iYear)
 {
     
     return 32 - new Date(iYear, iMonth, 32).getDate();
 }
 	
 	
 // check current month and year to server month year
 function servercheck(cm,cy,sm,sy)
 {
 	var f = false;
 	if((cm = sm) && (cy=sy))
 	{
 		f = true;
 	}	
 	else
 	{
 		alert("Please verify month");
 		f =  false;	
 	}	
 }	
// scrolling window status bar <body onpaste="return false;"
// onload="scrollMsg()">
var msg = "Thanks for visiting our Web site! ... ";
function scrollMsg()
{
    window.status = msg;
    msg = msg.substring(1,msg.length) + msg.substring(0,1);
    setTimeout("scrollMsg()",150);
}

// URL Checking
function check_it()
{
     var theurl=document.myForm.t1.value;
     var tomatch= /http:\/\/[A-Za-z0-9\.-]{3,}\.[A-Za-z]{3}/
     if (tomatch.test(theurl))
     {
         return true;
     }
     else
     {
         window.alert("URL invalid. Try again.");
         return false;
     }
}

// Date Validation
function isValidDate(sText) 
{
        var reDate = /(?:0[1-9]|[12][0-9]|3[01])\/(?:0[1-9]|1[0-2])\/(?:19|20\d{2})/;
        return reDate.test(sText);
}        


// fix a decimal after the fraction point 0.2343443 2 = 0.23
function formatNumber(theNum, numDecPlaces)
{
     var num = new String();
     num = "" + theNum;
     var pos = 0;
     count = 0;
     while (num.substring(pos-1,pos)!== ".") {
       pos += 1 ;
       count += 1;
     }
     while (pos < (count+numDecPlaces)){
       pos +=1;
     }
     return num.substring(0,pos);
}


// disable all element in a particular for
function frmdisable(frmname) 
{
    var limit = document.forms[frmname].elements.length;
    for (i=0;i<limit;i++) 
      document.forms[frmname].elements[i].disabled = true;
    
}


function clearSelect() 
{
    for (var i = 0; i < arguments.length; i++) 
    {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementsByName(element)[0];

        if (element && element.options) 
        {
            element.options.length = 0;
            element.selectedIndex = -1;
        }
    }
}


function checkall(ctr1, ctr2)
{

	 var ref = ctr2;
	 var withdetails=ctr1;
	 count=document.frm.ref.length;
	 if(document.frm.withdetails.checked)
	 	for(k=0;k<count;k++)
	 		document.frm.ref[k].selected=true;
	 else
	 	for(k=0;k<count;k++)
	 		document.frm.ref[k].selected=false;
}


// Converts carriage returns to <BR> for display in HTML

function ConvertBR(ctr) 
{
	var input = ctr.value;
	var output = "";
	for (var i = 0; i < input.length; i++) 
	{
		if ((input.charCodeAt(i) == 13) && (input.charCodeAt(i + 1) == 10)) 
		{
			i++;
			output += "<BR>";
		} 
		else 
		{
		output += input.charAt(i);
	   	}
	}
	return output;
}


// return sunday
function returnsunday(ctr)
{
	var d1 = ctr.value;
	var dd1 = d1.split("-");
	var ds = compute(dd1[0],dd1[1],dd1[2]) ;
	if(ds=="Sunday")
	{
		alert("You are select Sunday");
		return false;
	}
	 return true;
}	



function chkemail(ctr)
{
	var f =	document.getElementById(ctr).value;
	if(!(f==""))
	{
		var Email=document.getElementById(ctr); 
		if((Email.value.length)!=0)
		{
		  if(checkEmail(ctr)==false)
			{
			  	alert("Invalid Email ID");
			  	Email.focus();
				return false;  	
			}
			else
				return true;
		}
		else
			return false;	
	}
	else
		return true;		
}


function chkemail1(ctr,msg)
{
	try
	{
		var f =	document.getElementById(ctr).value;
		if(!(f==""))
		{
			var Email=document.getElementById(ctr).value; 
			if((Email.length)!=0)
			{
				if(checkEmail(ctr)==false)
				{
					alert(msg); 
					document.getElementById(ctr).focus();
					return false;  	
				}
				else
					return true;
			}
			else
			{
				alert(msg);
				document.getElementById(ctr).focus();
				return false;	
			}
		}
		else
			return true;	
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}


// onClick="checkEmail(document.signupform.email.value)"
function checkEmail(ctr)
{	
	var inputvalue = document.getElementById(ctr).value;
	var pattern=/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
    if(pattern.test(inputvalue))
    {         
    	return true;;
    }
    else
    {   
    	
    	document.getElementById(ctr).focus();
    	return false;
    }
}



function emailcheck(str)// Don't call the Function directly
	{
		var at="@";
		var dot=".";
		var lat=str.indexOf(at);
		var lstr=str.length;
		var ldot=str.indexOf(dot);
		var cdot=0;
		var i;
		for(i=0;i<lstr;i++)
		{
			if(str.charAt(i)==dot)
			{
			cdot=cdot+1;
			}
		}		
		if(cdot>2)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at)==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at)==0 || str.indexOf(at)==lstr)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot)==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot)==-1 || str.indexOf(dot)==0)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot,(ldot+1))==(lstr-1) || str.indexOf(dot)==(lstr-1))
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(at,(lat+1))!=-1)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot)
		{
			alert("Invalid Email ID");
			return false;
		}
		if(str.indexOf(dot,(lat+2))==-1)
		{
			alert("Invalid Email ID");
			return false;
		}
			return true;
	}



function dispLink(fnName,tblWidth,divName)
{    
	    var a = ['0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
		var str="";
		var tbl=document.getElementById(divName);
		str="<table width='"+tblWidth+"' border='0' align='center' cellpadding='0' cellspacing='0' bordercolor='#94C1E4'>"
		str+="<tr class='para'>"
		var j;
      	for (i=0;i<a.length;i++)
      	{
			j=a[i]
			if (a[i]=='0') j='All';
	    	if (fnName.indexOf("jsp")!=-1)
				str+="<td><div align='center'><a href="+fnName+a[i]+"><font class='boldEleven' style='color: blue'>"+j+"</font></a></div></td>"
			else
				str+="<td><div align='center'><a href=\"javascript:"+fnName+"('"+a[i]+"')\"><font class='boldEleven' style='color: blue'>"+j+"</font></a></div></td>"	
			j=""
		}
		str+="<tr></table>";
		 tbl.innerHTML=str;     
	}	


 
function Printquery(query)
	{  
		 
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}

	
	
	
	
	
	// use for this
	// input type="text" size="25" name="email"
	// onblur="if(!validEmail(this.value)) this.focus();">
      
	var chkDot = true;
 	var usEmail = true;
   	function validEmail(eAddr) 
   	{ 
     try
     	{
      		  var lenSuffix = (usEmail) ? 4 : 3;
		      var result = false;
		      var ndxAt = ndxDot =  0;
		      ndxAt  = eAddr.indexOf("@");
		      ndxDot = eAddr.indexOf(".") ;
		      ndxDot = eAddr.lastIndexOf(".") ;
		          
		      if ((ndxDot < 0) || (ndxAt < 0))
		         alert("Your email address lacks '.' or '@'. The format is 'you@dom.suf'"); 
		      else if (chkDot && (ndxDot < ndxAt) )
		         chkDot = !( 
		            confirm("You entered a 'dot' before the '@' Are you sure that is right?") );
		      else if ( (ndxDot2 - 3) <= ndxAt)
		         alert("You may be missing your domain name. The format is 'you@dom.suf'");
		      else if (tmpStr.length < ndxDot2 + lenSuffix) 
		         usEmail = !( confirm("You have fewer than 3 characters as a domain suffix. Are you sure that is right?") );
		      else 
		           result=true; 
		          
		      return result; 
		}
		catch(err)
		{
			alert(err.description)
		}			      
   } 	
   
   
   
   
 /*
	 * function checkLength(ctr,msg,len) { var
	 * val=document.getElementById(ctr).value; val=Trim(val);
	 * document.getElementById(ctr).value=val; if(val=="") { alert(msg);
	 * document.getElementById(ctr).focus(); return false; } else if(val.length
	 * <8) { alert(msg); document.getElementById(ctr).focus(); return false; }
	 * return true; }
	 * 
	 * 
	 * function checkLoginPass(ctr1,ctr2,msg) { var
	 * val1=document.getElementById(ctr1).value; var
	 * val2=document.getElementById(ctr2).value; val1=Trim(val1);
	 * val2=Trim(val2); document.getElementById(ctr1).value=val1;
	 * document.getElementById(ctr2).value=val2; if(val1 == val2) return true;
	 * else {
	 * 
	 * alert("Kindly check retype password...");
	 * document.getElementById(ctr1).value="";
	 * document.getElementById(ctr2).value="";
	 * document.getElementById(ctr1).focus(); return false;
	 *  } }
	 * 
	 * 
	 * function checkAge(ctr,msg,value) { var
	 * val=(document.getElementById(ctr).value).split("-"); var age =
	 * parseInt(val[2]); var vage =parseInt(value); var d=new Date() var
	 * year=d.getFullYear() age = year-age; if(age<vage) { alert(msg);
	 * document.getElementById(ctr).focus(); return false; } else return true; }
	 * 
	 */

function textArea(ctr,size)// it also accept '-'minus charactor
{
  	var txtval=document.getElementById(ctr).value;
	var len=size;
	 if(txtval.length>len)	
	{
		
		msg="Max char reached";		
		alert(msg);
		// show_popup(msg);
		document.getElementById(ctr).value=txtval.substring(0,size);
		document.getElementById(ctr).focus();
	}
}

function redirectauto(URLStr) 
	{ 
  		 	location = URLStr; 
  	}	

   
   
 
function lengthCheck(ctr, size,msg)
 {
	var len = (document.getElementById(ctr).value).length;
	if(len == size)
		return true;
	else
		{
			alert(msg);
			document.getElementById(ctr).focus();
			return false;
		}
 } 
   
   
function DateCompares (fromdate,todate, msg)
{
	
	var str1 = 	document.getElementById(fromdate).value	;
	var str2 = 	document.getElementById(todate).value	;
	var d1 = parseInt(str1.substring(0,2),10);
	var m1 = parseInt(str1.substring(3,5),10);
	var y1 = parseInt(str1.substring(6,10),10);
	var d2 = parseInt(str2.substring(0,2),10);
	var m2 = parseInt(str2.substring(3,5),10);
	var y2 = parseInt(str2.substring(6,10),10);
	var date1 = new Date(y1,m1,d1);
	var date2 = new Date(y2,m2,d2);
	 
	if(date1>date2)
	{
		alert(msg +"  From Date : "+ str1 + " To Date : "+str2);
		 
		return false;
	}
	else
	{
		return true;
	}
	
	
}


function DateComparision (fromdate,todate, msg)
{
	
	var str1 = 	document.getElementById(fromdate).value	;
	var str2 = 	document.getElementById(todate).value	;
	var d1 = parseInt(str1.substring(0,2),10);
	var m1 = parseInt(str1.substring(3,5),10);
	var y1 = parseInt(str1.substring(6,10),10);
	var d2 = parseInt(str2.substring(0,2),10);
	var m2 = parseInt(str2.substring(3,5),10);
	var y2 = parseInt(str2.substring(6,10),10);
	var date1 = new Date(y1,m1,d1);
	var date2 = new Date(y2,m2,d2);
	 
	if(date1>date2)
	{
		alert(msg +"  From Date : "+ str1 + " To Date : "+str2);
		 
		return false;
	}
	else
	{
		return true;
	}
	
	
}

function checkServerDateLock(ctr1,ctr2,ctr3)
{
	 
	var str1 = 	document.getElementById(ctr1).value	;
	var str2 = 	document.getElementById(ctr2).value	;
	var str3 = 	document.getElementById(ctr3).value	;
	if(str3 == "Y") 
	{
		var d1 = parseInt(str1.substring(0,2),10);
		var m1 = parseInt(str1.substring(3,5),10);
		var y1 = parseInt(str1.substring(6,10),10);
		var d2 = parseInt(str2.substring(0,2),10);
		var m2 = parseInt(str2.substring(3,5),10);
		var y2 = parseInt(str2.substring(6,10),10);
		var date1 = new Date(y1,(m1-1),d1);
		var date2 = new Date(y2,(m2-1),d2);
		if(date2<=date1)
		{
			return true;
		}
		else
		{
			alert(" Entry Date : "+ str2 + " Should not less than To Server Date : "+str1);
			return false;
		}
	}
	else
		return true;
}



   /*
	 * 
	 * function noBack() { window.history.forward(); }
	 * 
	 * noBack(); window.onload=noBack;
	 * window.onpageshow=function(evt){if(evt.persisted)noBack();}
	 * window.onunload=function(){void(0);}
	 * 
	 */
   
   
  
function getDaysInMonth(aDate){
   // returns the last day of a given month
    var m = new Number(aDate.getMonth());
    var y = new Number(aDate.getYear());

    var tmpDate = new Date(y, m, 28);
    var checkMonth = tmpDate.getMonth();
    var lastDay = 27;

    while(lastDay <= 31){
        temp = tmpDate.setDate(lastDay + 1);
        if(checkMonth != tmpDate.getMonth())
            break;
        lastDay++
    }
    return lastDay;
}



// Dynamic Add Table Row and Column


function addCol(table){
	var table = document.getElementById(table);	
	var th = document.createElement('th');
	th.innerHTML = "<input type='button' value='X' onclick=\"deleteCol(this);\">";	
	table.rows[0].appendChild(th);
	for(i=1; i<table.rows.length; i++){
		var td = document.createElement('td');
		td.innerHTML = "<input type='text' size='1'>";
		table.rows[i].appendChild(td);
	}
}



function addRow(table){
	var table = document.getElementById(table);
	var firstRow = table.rows[0];
	var row = document.createElement('tr');
	var th = document.createElement('th');
	th.innerHTML = "<input type='button' value='X' onclick=\"deleteRow(this);\">";
	row.appendChild(th);
	for(i=1; i<firstRow.cells.length; i++){
		var td = document.createElement('td');
		td.innerHTML = "<input type='text' size='1'>";
		row.appendChild(td);	
	}
	table.tBodies[0].appendChild(row);
}


function deleteCol(id){
	var table = id.parentNode.parentNode.parentNode;
	var td = id.parentNode;	
	position = getPosition(table,td);
	for(i=0; i<table.rows.length; i++){
		removeTd = table.rows[i].cells[position['col']];
		table.rows[i].removeChild(removeTd);
	}
}


function deleteRow(id){
	var table = id.parentNode.parentNode.parentNode;
	var td = id.parentNode;
	position = getPosition(table,td);
	removeTr = table.rows[position['row']];
	table.removeChild(removeTr);
}


function getPosition(table,td){
	for(i=0; i<table.rows.length; i++){	
		for(j=0; j<table.rows[i].cells.length; j++){
			if(table.rows[i].cells[j] == td){
				var position = new Array();
				position['row'] = i;
				position['col'] = j;
				return position;
			}
		}
	}
}



function reverse_options(select)
{
	try
	{
	    select_box = document.getElementById(select);
	    options = select_box.options;    
	    var text_array = new Array();
	    var value_array = new Array(); 
	    var len = options.length;   
	
	    for(var i=0; i<len; i++)
	    { 
	        text_array[i] = options[i].text;
	        value_array[i] = options[i].value; 
	    }    
	
	    text_array.reverse();
	    value_array.reverse();  
	
	    for(var o=0; o<len; o++){ 
	        options[o].text = text_array[o];
	        options[o].value = value_array[o];
	    }
	}
	catch(err)
	{
		alert(err);
	}	    
}


   function alphanumericValidate(ctr,len) 
   {
        var name = document.getElementById(ctr).value;
        var pattern = /^[A-Za-z0-9 ]{3,20}$/;
        if(name.length<len)	
        {
	        if (pattern.test(name)) 
	        {
	            alert(name +" has alphanumeric value");
	            return true;
	        } else 
	        {
	            alert("Name is not valid.Please input alphanumeric value!");
	             return false;
	        }
	     }
	     else
		 {	
				alert("Maximum char reached");
				window.status="Maximum char reached";
				
		 }
    }
  


function numbercheck(ctr,msg)
{
	var v = document.getElementById(ctr).value;
	if(v == "")
	{
		alert("Value should not empty");
		document.getElementById(ctr).value ="0";
		document.getElementById(ctr).focus();
		return false;
	}
	var f = isNaN(v);
	if(f)
	{
		alert(msg);
		document.getElementById(ctr).value ="0";
		document.getElementById(ctr).focus();
		return false;
	}
	else
		return true;
	
}

function GetRadioButtonValue(id)
{
    var radio = document.getElementsByName(id);
    for (var ii = 0; ii < radio.length; ii++)
    {
        if (radio[ii].checked)
            alert(radio[ii].value);
    }
}  
  
/*
 * The system is currently under maintenance. Please try again after some time.
 * We apologize for your inconvenience.
 */


function zoomIn()
{
	var wd,ht,l
	wd=CityMap.style.width;
	l=wd.length
	wd=wd.substr(0,parseInt(l)-2);
	wd=parseInt(wd)-100;
	ht=CityMap.style.height; 
	l=ht.length
	ht=ht.substr(0,parseInt(l)-2);
	ht=parseInt(ht)-100;	
	if ((wd>100)&&(ht>200))
	{
		CityMap.style.width =wd;
		CityMap.style.height=ht;
		
	}
	Sho.innerHTML  =" Image View : <br> " + wd + " x " +ht;
			 	
}
function zoomOut()
{
	var wd,ht,l
	wd=CityMap.style.width;
	l=wd.length;
	wd=wd.substr(0,parseInt(l)-2);
	wd=parseInt(wd)+100;
	ht=CityMap.style.height; 
	l=ht.length;
	ht=ht.substr(0,parseInt(l)-2);
	ht=parseInt(ht)+100;	
	if ((wd<=1100)&&(ht<=1700))
	{
		CityMap.style.width =wd;
		CityMap.style.height=ht;
		
	}
	Sho.innerHTML  =" Image View : <br> " + wd + " x " +ht;
			 	
}



 
    
    
/*
 * 
 * <table Border="0" width="100%"> <tr><td align="Right"> <input type="Button"
 * class="tMLAscreenHead" OnClick="zoomIn()" Value="ZoomIn"> <input
 * type="Button" class="tMLAscreenHead" OnClick="zoomOut()" Value="ZoomOut">
 * 
 * <Div ID="Sho" class="boldornge"></Div> </td> <tr><td > <img Border=1
 * Id="CityMap" src="Image/80G.jpg"
 * style="position:absolute;width:400;Height:600"> </td></tr> </table>
 * 
 * //Play video file *.swf
 * 
 * <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 * codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"
 * WIDTH="100%" HEIGHT="90%" style="border-style: solid; border-width: 0px;
 * border-color: #000000;"> <PARAM NAME=movie VALUE="smart erp.swf?build=1">
 * <PARAM NAME=quality VALUE=best> <PARAM NAME=bgcolor VALUE=#000000> <PARAM
 * NAME=scale VALUE="exactfit"> <EMBED src="smart att.swf?build=1" quality=best
 * bgcolor=#000000 scale="exactfit" WIDTH="100%" HEIGHT="90%" ALIGN=""
 * TYPE="application/x-shockwave-flash"
 * PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED> </OBJECT>
 */
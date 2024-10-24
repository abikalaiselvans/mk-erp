// JavaScript Document

  
function upperMe(field)
{
	try
	{
		field.value=field.value.toUpperCase();
	}
	catch(err)
	{
		alert(err);
	}
}  



function replaceAll(find, replace, str) 
{
	  return str.replace(new RegExp(find, 'g'), replace);
}




function Message(msg)
{
	try
	{
		var p=window.createPopup()
		var pbody=p.document.body
		pbody.style.backgroundColor="#ffffff"
		pbody.style.border="solid black 2px"
		pbody.innerHTML="<CENTER><BR><font color='red'><b>"+msg+"</b></FONT><BR></CENTER>";
		p.show(screen.width/2, screen.height/2,300,50,document.body)
	}
	catch(err)
	{
		alert(err);
	}
}



function DisableButton(b)
{
	try
	{
		b.disabled = true;
		b.value = 'Submitting';
		b.form.submit();
	}
	catch(err)
	{
		alert(err);
	}
}
   
   
   
   
function show_popup()
{
	try
	{
		var p=window.createPopup()
		var pbody=p.document.body
		pbody.style.backgroundColor="#DEE7FF"
		pbody.style.border="solid red 1px"
		pbody.innerHTML="<center><font color='red'><h3>Max char reached</h3></font><center>";
		p.show(350,550,200,25,document.body)
	}
	catch(err)
	{
		alert(err);
	}
}


// Function is used to the numeric value should be greater than 0
function checkZero(ctr)
{	
	try
	{
		var txtval=parseInt(document.getElementById(ctr).value);
		alert(txtval);
		if(txtval < 1)
		{
			window.status="Zero not allowed";
			msg="Zero not allowed";
			show_popup(msg);	
		}
	}
	catch(err)
	{
		alert(err);
	}
}




function numbersonly(e)
{
	var unicode=e.charCode? e.charCode : e.keyCode
	if (unicode!=8)
	{ // if the key isn't the backspace key (which we should allow)
		// onkeypress="return numbersonly(event)"
		if (unicode<48||unicode>57) // if not a number
			return false // disable key press
	}
}



function buttonEnable(ctr)
{
	try
	{
		document.getElementById(ctr).disabled = false;
	}
	catch(err)
	{
		alert(err);
	}
	
}


function trim(s)
{
	var l=0; var r=s.length -1;
	while(l < s.length && s[l] == ' ')
	{	l++; }
	while(r > l && s[r] == ' ')
	{	r-=1;	}
	return s.substring(l, r+1);
}

function trims(str) 
{
    return str.replace(/^\s+|\s+$/g,'');
} 

 function checkAll(ctr)
 {
	var f = document.getElementById(ctr).checked;
	var sel=document.forms[0].Benefits;
	if(f == true)
		for(i=0;i<sel.length;i++)
		 	sel[i].checked = true;
	else	
		for(i=0;i<sel.length;i++)
		 	sel[i].checked = false;

 
 }
function numericValue(ctr,len)
{	
	try
	{
		var txtval=document.getElementById(ctr).value;
		 
		window.status=""
		if(txtval.length==0 && event.keyCode==32)
		{ 
		event.keyCode=0; 
		}
		if(txtval.length<len)	
		{
			if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13)
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
			msg="Max char reached";
			show_popup(msg);			
		}
	}
	catch(err)	
	{
		 
	}
}




function numeric_comma_only(e,ctr,len )// firfox
{	 
	var txtval=document.getElementById(ctr).value;
	var unicode = e.charCode ? e.charCode : e.keyCode;
	if( unicode == 8 || unicode == 9 || unicode == 188 || ( unicode >= 48 && unicode <= 57 ) )
	{
		if(txtval !="")
		if(txtval.length>len)
		{	
			unicode=0;		
			alert("Max char reached");
			return false;
		}
		return true;
	}	
	else
		return false;
}



function numeric_only(e,ctr,len )// firfox
{
	var txtval=document.getElementById(ctr).value;
	
	var unicode = e.charCode ? e.charCode : e.keyCode;
	if( unicode == 8 || unicode == 9 || ( unicode >= 48 && unicode <= 57 ) )
	{
		if(txtval !="")
		if(txtval.length>=len)
		{	
			unicode=0;		
			alert("Max char reached");
			return false;
		}
		return true;
	}	
	else
		return false;
}



function isAlphanumeric(elem, helperMsg){
	var alphaExp = /^[0-9a-zA-Z]+$/;
	if(elem.value.match(alphaExp)){
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
	}
}

 
function websiteOnly(ctr,size)
{
	var txtval=document.getElementById(ctr).value;
	var len=size;
	if(txtval.length==0 && event.keyCode==32){ event.keyCode=0; }
	if(txtval.length<len)	
	{
		if((event.keyCode>96 && event.keyCode<=122) || (event.keyCode>64 && event.keyCode<91) || event.keyCode==13 ||  event.keyCode==32 ||  event.keyCode==45 ||  event.keyCode==46)
    		event.keyCode;
	   	else   
			event.keyCode=0;
	}	
	else
		event.keyCode=0;	
}





function alphaNumeric(ctr,len)
{	
	var txtval=document.getElementById(ctr).value;
	window.status=""
	if(txtval.length==0 && event.keyCode==32){ event.keyCode=0; }
	if(txtval.length<len)	
	{
		if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 ||
		   (event.keyCode>96 && event.keyCode<=122) || (event.keyCode>64 && event.keyCode<91) ||
		   event.keyCode==95 || event.keyCode==45 || event.keyCode==32)
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




function NumericValidation(eventObj)
{
    var keycode;
 
    if(eventObj.keyCode) // For IE
        keycode = eventObj.keyCode;
    else if(eventObj.Which)
        keycode = eventObj.Which;  // For FireFox
    else
        keycode = eventObj.charCode; // Other Browser
 
    if (keycode!=8) // if the key is the backspace key
    {
        if (keycode<48||keycode>57) // if not a number
            return false; // disable key press
        else
            return true; // enable key press
     }        
 }
 
 
 
 
function checkTime(ctr1,ctr2)
{
	var time1=document.getElementById(ctr1).value;
  	var h1=time1.substr(0,2);
  	var c1=time1.substr(2,1);
	var m1=time1.substr(3,2);
  	var c2=time1.substr(5,1);
	var s1=time1.substr(6,2);
	var time2=document.getElementById(ctr2).value;
  	var h2=time2.substr(0,2);
  	var c3=time2.substr(2,1);
	var m2=time2.substr(3,2);
  	var c4=time2.substr(5,1);
	var s2=time2.substr(6,2);
	if(!isNaN(h1) && !isNaN(m1) && !isNaN(s1) && isNaN(c1) && isNaN(c2) && h1<=24 && m1<60 && s1<60)
	{
		if(!isNaN(h2) && !isNaN(m2) && !isNaN(s2) && isNaN(c3) && isNaN(c4) && h2<=24 && m2<60 && s2<60 )
		{			
			if((h1==h2 && m1<m2) || (h1<h2))
		    {
		    	return true;
		    }
		    else
		    {
			 	alert(" To Time Should Be Greater Than From Time");
			 	document.getElementById(ctr2).value="";
			    document.getElementById(ctr2).focus();
			   	return false;
		    }
		}
		else
		{
			alert("Enter Correct Time eg(13:45:00)");
			document.getElementById(ctr2).value="";
			document.getElementById(ctr2).focus();
			return false;
		}		
	}
	else
	{
		alert("Enter Correct Time eg(13:45:00)");
		document.getElementById(ctr1).value="";
		document.getElementById(ctr1).focus();
		return false;
	}
}




function checkPermissionTime(fromtime,totime,limit)
{
	try
	{
		var f = checkTime(fromtime,totime);
		 
		var lim = parseInt(limit);
		if( f == true)
		{
			 
			var t1=document.getElementById(fromtime).value;
			var t2=document.getElementById(totime).value;
			 
			var time1=t1.split(":");
	  		var time2=t2.split(":");
	  		
	  		var fromhour = parseInt(time1[0]);
	  		var fromminute = parseInt(time1[1]);
	  		var fromsecond = parseInt(time1[2]);
	  		
	  		var tohour = parseInt(time2[0]);
	  		var tominute= parseInt(time2[1]);
	  		var tosecond = parseInt(time2[2]);
	  		
	  		 
	  		
	  		var h=0;
	  		var m=0;
	  		var s=0;
	  		var fl = false;
	  		
	  		// Second
	  		if(fromsecond > tosecond)
	  		{
	  			tosecond = tosecond +60;
	  			tominute = tominute-1;
	  			s = tosecond-fromsecond;
	  		}
	  		else
	  			s = tosecond-fromsecond;
	  		
	  		
	  		// minutes
	  		if(fromminute>tominute)
	  		{
	  			tominute = tominute +60;
	  			tohour = tohour-1;
	  			m = tominute-fromminute;
	  		}
	  		else
	  		{
	  			m = tominute-fromminute;
	  		}
	  		
	  		// hours
	  		h = tohour-fromhour;
	  		
	  		 	
	  		 
	  		if((h<lim) ||((h==lim)&& (s==0)&&(m==0)))
	  		{
	  		  	return true;
	  		} 	
	  		else
	  		{
	  			alert("Time difference should be less than or equal to "+lim);
	  			return false; 
	  		}
	  	}
	  	else
	  	{
	  		alert("Enter Correct Time...");
	  		return false; 
	  	}
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}


function checkNullSelect(ctr,msg,def)
{
	try
	{     
		var val=document.getElementById(ctr).value;	
		if(val===def) 
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



function checkDateTime(ctr) 
{
    try 
	{
            var isValidDate = false;
            var dt=document.getElementById(ctr).value;
            var arr1 = dt.split('-');
            var year=0;var month=0;var day=0;var hour=0;var minute=0;var sec=0;
            if(arr1.length == 3)
            {
                var arr2 = arr1[2].split(' ');
                if(arr2.length == 2)
                {
                    var arr3 = arr2[1].split(':');
                    try
                    {
                        year = parseInt(arr2[0],10);
                        month = parseInt(arr1[1],10);
                        day = parseInt(arr1[0],10);
                        hour = parseInt(arr3[0],10);
                        minute = parseInt(arr3[1],10);
                        sec = parseInt(arr3[0],10);
                        sec = 0;
                        var isValidTime=false;
                        if(hour >=0 && hour <=23 && minute >=0 && minute<=59 && sec >=0 && sec<=59)
                            isValidTime=true;
                        else if(hour ==24 && minute ==0 && sec==0)
                            isValidTime=true;

                        if(isValidTime)
                        {
                            var isLeapYear = false;
                            if(year % 4 == 0)
                                 isLeapYear = true;

                            if((month==4 || month==6|| month==9|| month==11) && (day>=0 && day <= 30))
                                    isValidDate=true;
                            else if((month!=2) && (day>=0 && day <= 31))
                                    isValidDate=true;

                            if(!isValidDate)
                            {
                                if(isLeapYear)
                                {
                                    if(month==2 && (day>=0 && day <= 29))
                                        isValidDate=true;
                                }
                                else
                                {
                                    if(month==2 && (day>=0 && day <= 28))
                                        isValidDate=true;
                                }
                            }
                        }
                    }
                    catch(er){isValidDate = false;}
                }

            }

            return isValidDate;
        }
        catch (err) 
        { 
           alert('ValidateDate: ' + err); 
        }
    }

function checkIsNumeric(ctr,msg)
{
	try
	{
		var inputString = document.getElementById(ctr).value;
		if(IsNumeric(inputString))
			return true;
		else
			{
				alert(msg);
				document.getElementById(ctr).value="";
				document.getElementById(ctr).focus();  
				return false; 
			}
	}
	catch(err)
	{
		alert(err);
	}
}



function IsNumeric(input)
{
    return (input - 0) == input && (input+'').replace(/^\s+|\s+$/g, "").length > 0;
}


function allnumericdot(ctr,msg)  
{  
  var numbers = /^[-+]?[0-9]+\.[0-9]+$/; 
  var inputString = document.getElementById(ctr).value;; 
  if(inputString.match(numbers))  
  {  
  	  
 	return true;  
  }  
  else  
  {  
  	alert(msg);
	document.getElementById(ctr).value="";
	document.getElementById(ctr).focus();  
    return false;  
  }  
}  



function checkNull(ctr,msg)
{
	try
	{
		obj = findObj(ctr); 
		if(obj == null)
		{
			alert(ctr + " Object not available");
			return false;
		}
		
		var val=document.getElementById(ctr).value;
		if(val=="")
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
		alert(ctr+" -  not found.     error : "+err);
		return false;
	}
}
 
 
  
  
function setOptionValue(ctr,value) 
{
	try
	{
		var len,val,i,sel;
		len=document.getElementById(ctr).length;
		for(i=0;i<len;i++){
	 		val=document.getElementById(ctr).options[i].value;
	 		if(val==value) sel=i;
	 	}
	 	document.getElementById(ctr).selectedIndex=sel;
	}
	catch(err)
	{
		alert(err);
	}
	 
}



function setOptionText(ctr,value) 
{
	
	 var x=document.getElementById(ctr);
	 x.options[x.selectedIndex].text=value;
														
	 
}




function setCurrentDateandTimes(ctr)
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
    
	document.getElementById(ctr).value=day + "-" + month + "-" + year +" " +h+":"+m;
}

function UpperCase(ctr)
{	
	var txtval=document.getElementById(ctr).value;
	document.getElementById(ctr).value=txtval.toUpperCase();
}


function LowerCase(ctr)
{	

	var txtval=document.getElementById(ctr).value;
	document.getElementById(ctr).value=txtval.toLowerCase();
}



function validEmail(email)
{
	var exclude=/[^@\-\.\w]|^[_@\.\-]|[\._\-]{2}|[@\.]{2}|(@)[^@]*\1/;
	var hc=/\.[a-zA-Z]{2,4}$/;
	if((email.search(exclude)!=-1)||(email.search(hc)==-1)){return v}atPos=email.indexOf("@",0);
	pPos1=email.indexOf(".",0);
	periodPos=email.indexOf(".",atPos);
	pos1=pPos1;
	pos2=0;
	while(pos2>-1)
	{
		pos2=email.indexOf(".",pos1+1);
		if(pos2==pos1+1)
			{return v}
		else
			{pos1=pos2}
	}
	if(atPos==-1)
		{return v}
	if(atPos==0)
		{return v}
	if(pPos1==0)
		{return v}
	if(email.indexOf("@",atPos+1)>-1)
		{return v}
	if(periodPos==-1)
		{return v}
	if(atPos+1==periodPos)
		{return v}
	if(periodPos+3>email.length)
		{return v}
	return true
}

	

function isEmailID(ctr,len)
{	
	var txtval=document.getElementById(ctr).value;       
	window.status=""
	if(txtval.length==0 && event.keyCode==32)
		{ 
		event.keyCode=0; 
		}
	if(txtval.length<len)	
	{
		if(event.keyCode>=48 && event.keyCode<58 || event.keyCode==13 || 

	(event.keyCode>96 && event.keyCode<=122) || (event.keyCode>64 && event.keyCode<91) || 
 
	event.keyCode==95 || event.keyCode==64 || event.keyCode==46)
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
		msg="Max char reached";	
		show_popup(msg);				
	}
}



function lengthEqualCheck(ctr,len,msg)
{
	var txtval=(document.getElementById(ctr).value);
	if(txtval.length == len)
		return true;
	else
		{
			alert(msg);
			document.getElementById(ctr).focus();
			return false;
			
		}
}

function phoneValue(ctr,len)
{	
	var txtval=document.getElementById(ctr).value;
	window.status=""
	if(txtval.length==0 && event.keyCode==32)
	{ 
	event.keyCode=0; 
	}
	if(txtval.length<len)	
	{
		if(event.keyCode>=48 && event.keyCode<58 ||event.keyCode==13 || event.keyCode==45 || event.keyCode==44 )
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
		msg="Max char reached";
		show_popup(msg);			
	}
}


function checkTimeCompare(time1,time2,msg)
{
	try
	{
		var val1=document.getElementById(time1).value;
		var val2=document.getElementById(time2).value;
		var regex = new RegExp("([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])");
		if(dateCompare(val1,val2))
		{
		   alert(msg);	
		   document.getElementById(time2).focus();
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




// Two fielda are equals
	function  passwordCheck(ctr1,ctr2)
	{	 	 
		var f1 = document.getElementById(ctr1).value;
		var f2 = document.getElementById(ctr2).value;
		if(f1 != f2)
		{
			alert("Password and Retypepassword are not equal..."); 
			document.getElementById(ctr1).value="";
			document.getElementById(ctr2).value="";
			document.getElementById(ctr1).focus();
		}	
	 }	
 
 
 
 
// Duplicate Errase in single dimension array
function Duplicate(string )
{
	var s = string;
	var array1 = s.split("~");
	var array2 = s.split("~");
	var arraylength = array1.length-1;
	var count=0;
	for(u=0; u<arraylength; u++)
	{
		count=0;
		for(v=0; v<arraylength; v++)
		{
			if(array2[u] == array1[v])
				count = count +1;
			if(count > 1)
				array1[v]="";
		}
	}
	var hs2="";
	for(v=0; v<arraylength; v++)
		if(array1[v]!="")
			hs2 = hs2 +	array1[v]+",";
	return hs2;
}


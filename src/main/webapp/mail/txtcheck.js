var numchararray=["~","`","!","(",")","'","$","%","^","&","*","-","+","|","<",">",",","/","?","@","#","[","]","\"","=",":",";","{","}","[","]","0", "1","2","3","4","5", "6","7","8","9","_","\\","."];
var chararray=["~","`","!","(",")","'","$","%","^","&","*","-","+","|","<",">",",","/","?","@","#","[","]","\"","=",":",";","{","}","[","]","\\"," ","."];
var charnamarray=["~","`","!","(",")","'","$","%","^","&","*","-","+","|","<",">",",","/","?","@","#","[","]","\"","=",":",";","{","}","[","]","_","\\","0", "1","2","3","4","5", "6","7","8","9"];
var numcharray=["0", "1","2","3","4","5", "6","7","8","9"];
var telcharray=["0", "1","2","3","4","5", "6","7","8","9","-","/"];
var emailarray=["~","`","!","(",")","'","$","%","^","&","*","+","|","<",">",",","/","?","#","[","]","\"","=",":",";","{","}","[","]","\\"," "];
var val;
function nullcheck(s)
{
     if(s.type=="select-one")
		 val=s.options[s.selectedIndex].value
	 else
		 val=s.value;
   if(val=="")
	   return false;
	return true;
}

function lencheck(s) 
{
	var stind;
	var endind;
	var fla=false;
	val=s.value;
		 for(i=0;i<val.length;i++)
		{
			    if(val.charAt(i)!=' ')
				{
			
					  if (fla==false)
					{
						  stind=i;
						  fla=true;
					}
							endind=i;
				}
		}
       

		if(s.name!="password")
		{
		val=val.substring(stind,endind+1);
		}
		
		if(s.name=="rpincode")
		{
			if(val.length<5)
			 return false;
		}

		if(s.name=="login")
		{
			if (val.length<3)
					return false;
        }

		  if(s.name=="password")
		{
			   if(val.length<6)
				   return false;
		}

		return true;
}   
	 
function firchcheck(s)
{
	val=s.value;
	for(j=0;j<numchararray.length;j++)
	{
			if(val.charAt(0)==numchararray[j])
					return false;
	} 
	return true;
}

  function spchcheck(s)
  {
	  val=s.value;
		for(i=1;i<val.length;i++)
		{
					for(j=0;j<chararray.length;j++)
					{
							if(val.charAt(i)==chararray[j])
									return false;
					} 
			 }
		return true;
	}


  function namecheck(s)
  {
	    lencheck(s);
		for(i=0;i<val.length;i++)
		{
					for(j=0;j<charnamarray.length;j++)
					{
							if(val.charAt(i)==charnamarray[j])
									return false;
					} 
			 }
		return true;
	}

function numcheck(s)
{
	var numfla;
    if(! lencheck(s))
		return false;
	for(i=0;i<val.length;i++)
	{
		numfla=false;
		for(j=0;j<numcharray.length;j++)
		{
			if(val.charAt(i)==numcharray[j])
				numfla=true;
		}
		if(numfla==false)
			return false;
	}
		return true;
}

function telcheck(s)
{
	var numfla;
	val=s.value;
	for(i=0;i<val.length;i++)
	{
		numfla=false;
		for(j=0;j<telcharray.length;j++)
		{
			if(val.charAt(i)==telcharray[j])
				numfla=true;
		}
		if(numfla==false)
			return false;
	}
		return true;
}

  function degcheck(s)
  {
		val=s.value;
		for(i=0;i<val.length;i++)
		{
					for(j=0;j<charnamarray.length;j++)
					{
							if(val.charAt(i)==charnamarray[j])
							{		
								if(val.charAt(i)==",")
									return true;
								return false;
							}
					} 
			 }
		return true;
	}


function equlcheck(s,t)
{
    if (s.name=="password" && t.name=="repassword")
    {
		if(s.value!=t.value)
			return false;		
	}
	else if (s.name=="login" && t.name=="password")
    {
		if(s.value==t.value)
			return false;		
	}

   return true;
}

function emailcheck(s){
	var mail=s.value;
	var at = mail.indexOf('@');
	var dot  = mail.indexOf('.');
	var lg = mail.length;
	var hyp=mail.indexOf('-');
	var undscr=mail.indexOf('_');
if(! firchcheck(s))
	return false;
	
	for(i=0;i<lg;i++)
		{
					for(j=0;j<emailarray.length;j++)
					{
							if(mail.charAt(i)==emailarray[j])
								
							return false;
							}
			} 
			 
if (hyp!=-1)
{
	if(hyp <at || hyp >dot )
		return false;
	while(hyp!=-1)
    {
		if(mail.indexOf('-',hyp+1)!=-1)
			{
				if((mail.indexOf('-',hyp+1) -hyp) <2) 
					return false;
			}
				hyp=mail.indexOf('-',hyp+1);

		}
}
	if(! ( mail.indexOf(' ') == -1 && at > 2 && dot > 5 && dot-at > 3 && undscr < at)) return false;
	if( lg - dot < 3 || at != mail.lastIndexOf('@') || dot-mail.lastIndexOf('-') < 2) return false; 
	while(dot!=-1)
	{
		if(mail.indexOf('.',dot+1)!=-1)
		{
			if((mail.indexOf('.',dot+1) -dot) <2 || lg - mail.indexOf('.',dot+1) < 3 )
			    return false;
		}
		dot=mail.indexOf('.',dot+1);
	}
	return true;
	}



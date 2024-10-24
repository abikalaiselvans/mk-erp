/*
mvar cookie_date = new Date ( ); 
cookie_date.setTime ( cookie_date.getTime() - 1 );
document.cookie = "logged_in=;expires=" + cookie_date.toGMTString();
Kindly Prepare	following basic topics.
	
	
	core java	;	Lang package, 
				Util package, 
				Io package
				Sql package

	J2ee		:	Servlet, 
				Jsp, 
				Mail, 
				XMl
				Ajax basic preparation

	Data Base	:	Basic function, 
				Function, 
				Procedure, 
	
	Script		:	Javascript.
	
	Editor		:	Dreamweaver/Eclipse/JDeveloper/JBuilder
	
*/

var d = new Date();
document.cookie = "v0=1;expires=" + d.toGMTString() + ";" + ";";

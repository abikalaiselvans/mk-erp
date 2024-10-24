<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.text.*"%>
<html>
<head>
<title>Forex Cap Chat</title>
<%!
public String replaceSubString(String s, String oldToken, String newToken) {	
if (s == null || oldToken == null || newToken == null) {		
return s;
	}	
int tokenPos = s.indexOf(oldToken);	
if (tokenPos == -1)
 {
		return s;	}	

String start = s.substring(0,tokenPos);    
String end = s.substring(tokenPos + oldToken.length());        
return start + newToken + end;    
}


%>

</head>

<body  onpaste="return false;" bgcolor="#993300" topmargin="0" leftmargin="0">

<%-- <jsp:include page="loginheader.htm"  flush="true"/> --%>

<%!
//public boolean equalsIgnoreCase(String textMessage);
String textMessage;
String emoti="True" ;
%>

<%
textMessage =request.getParameter("message");

//textMessage.equalsIgnoreCase=request.getParameter("message");

if(emoti=="True")
{
textMessage =replaceSubString( textMessage,  "Hello",  "Bye");
textMessage =replaceSubString( textMessage,  "bye",  "hello");
textMessage = replaceSubString(textMessage, ":)", "<img src=smiley/smile0.gif border=0>");
textMessage = replaceSubString(textMessage, "O:-)", "<img src=smiley/smile1.gif border=0>");
textMessage = replaceSubString(textMessage, ":ROLLEYES:", "<img src=smiley/smile2.gif border=0>");
textMessage = replaceSubString(textMessage, ":D", "<img src=smiley/smile3.gif border=0>");
textMessage = replaceSubString(textMessage, ":NERD:", "<img src=smiley/smile4.gif border=0>");
textMessage = replaceSubString(textMessage, ":-/", "<img src=smiley/smile5.gif border=0>");
textMessage = replaceSubString(textMessage, ":?:", "<img src=smiley/smile6.gif border=0>");
textMessage = replaceSubString(textMessage, ":TDOWN:", "<img src=smiley/smile7.gif border=0>");
textMessage = replaceSubString(textMessage, ":TUP:", "<img src=smiley/smile8.gif border=0>");
textMessage = replaceSubString(textMessage, ":(", "<img src=smiley/smile9.gif border=0>");
textMessage = replaceSubString(textMessage, "X(", "<img src=smiley/smile10.gif border=0>");
textMessage = replaceSubString(textMessage, ":BA:", "<img src=smiley/smile11.gif border=0>");
textMessage = replaceSubString(textMessage, ":EEK:", "<img src=smiley/smile12.gif border=0>");
textMessage = replaceSubString(textMessage, "8)", "<img src=smiley/smile13.gif border=0>");
textMessage = replaceSubString(textMessage, "X-(", "<img src=smiley/smile14.gif border=0>");
textMessage = replaceSubString(textMessage, ":MAD:", "<img src=smiley/smile15.gif border=0>");
textMessage = replaceSubString(textMessage, ":LOVE:", "<img src=smiley/smile16.gif border=0>");
textMessage = replaceSubString(textMessage, ":p", ":P");
textMessage = replaceSubString(textMessage, ":P", "<img src=smiley/smile17.gif border=0>");
textMessage = replaceSubString(textMessage, ":CRY:", "<img src=smiley/smile18.gif border=0>");
textMessage = replaceSubString(textMessage, ":NAUGHTY:", "<img src=smiley/smile19.gif border=0>");
textMessage = replaceSubString(textMessage, ":INPAIN:", "<img src=smiley/smile20.gif border=0>");
textMessage = replaceSubString(textMessage, ":BLUSH:", "<img src=smiley/smile21.gif border=0>");
textMessage = replaceSubString(textMessage, "lol", "LOL");
textMessage = replaceSubString(textMessage, "LOL", "<img src=smiley/smile22.gif border=0>");
textMessage = replaceSubString(textMessage, ":SMOKE:", "<img src=smiley/smile23.gif border=0>");
textMessage = replaceSubString(textMessage, ":MEPISSED:", "<img src=smiley/smile24.gif border=0>");
textMessage = replaceSubString(textMessage, ":FINGER:", "<img src=smiley/smile25.gif border=0>");

}
%>



<%


if(textMessage!=null)
{

String jfont =request.getParameter("jfont");
String jsize =request.getParameter("jsize");
String jcolor =request.getParameter("jcolor");
//size='"+jsize+"' color='"+jcolor+"'



application.setAttribute("ChatLine10", (String)application.getAttribute("ChatLine9"));
application.setAttribute("ChatLine9", (String)application.getAttribute("ChatLine8"));
application.setAttribute("ChatLine8", (String)application.getAttribute("ChatLine7"));
application.setAttribute("ChatLine7", (String)application.getAttribute("ChatLine6"));
application.setAttribute("ChatLine6", (String)application.getAttribute("ChatLine5"));
application.setAttribute("ChatLine5", (String)application.getAttribute("ChatLine4"));
application.setAttribute("ChatLine4", (String)application.getAttribute("ChatLine3"));
application.setAttribute("ChatLine3", (String)application.getAttribute("ChatLine2"));
application.setAttribute("ChatLine2", (String)application.getAttribute("ChatLine1"));
application.setAttribute("ChatLine1","<b>"+"<font face='verdana,helvetica, arial, helvetica' size='2' color='#000000'>" + request.getParameter("id")+" : </b></font> "+"<font face='" + jfont+ "' color='" + jcolor+ "'  size='" + jsize+ "'>"+textMessage+"</font>");


}


%>




</body>
</html>
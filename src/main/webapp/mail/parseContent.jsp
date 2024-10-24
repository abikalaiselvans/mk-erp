<%@ page language="java"%> 

<%
String ctrl=request.getParameter("ctrl");
out.println("The ctrl is: "+ctrl);
String Message_body=(String)session.getAttribute("ForwardContent");
String subject=(String)session.getAttribute("subject");
//out.println("This is the body content:<br><font color=red>"+Message_body+"</font>");

if(Message_body==null)
{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
}
else{
String sub="";
subject=subject.trim();
int p =subject.indexOf(" ");
if(p==-1)
    {
subject=subject; 
    }
else 
    {
for(int k=0; k<subject.length();k++){
    char c=subject.charAt(k);
    if(c==' '){
        sub+="&nbsp;";
            }
       else{ sub+=c;}
    }
    subject=sub;
}
String forward="";
//out.println("Message body"+Message_body);
for(int i=0;i<Message_body.length();i++)
{
	char c=Message_body.charAt(i);
	if(c=='"')
		forward+="\\";
		forward+=c;
		//out.println(c);

}
int pos=0;
String temp="";
boolean tobreak=false;
try{
for(int i=0;i<forward.length();i++)
{
if(i==0)
	{
		pos= forward.indexOf('\n');
		if(pos==-1 || pos>forward.length())break;
		Message_body="";
	}
else {
	i=pos+1;
	pos= forward.indexOf('\n',i);
	if(pos==-1 || pos>forward.length())
    {
    pos=forward.length()-1;
    tobreak=true;
    }
}
temp= forward.substring(i,pos);
Message_body=Message_body+temp.trim()+"<br>";
request.setAttribute("ForwardContent",Message_body);

if(tobreak)
    {
    tobreak=false;
    break;
    }
}
if((ctrl!=null)&&(ctrl.equals("fwd")))
    {
subject="Fwd:&nbsp;"+subject;
out.println("inside forward");
    }
if((ctrl!=null)&&(ctrl.equals("rep")))

    {
   subject="Re:&nbsp;"+subject;
   out.println("inside reply");
      }
request.setAttribute("subject",subject);
}catch(Exception e){out.println(e);}

%>
<jsp:forward page="compose_mail.jsp"/>
<%}%>
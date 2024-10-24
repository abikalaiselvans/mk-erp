
<%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
int myear = ms+1900;
int startyear=2006;
int endyear = myear+2;

for(int u=startyear;u<=endyear;u++)
	out.println("<option value='"+u+"'>"+u+"</option>");
  %>

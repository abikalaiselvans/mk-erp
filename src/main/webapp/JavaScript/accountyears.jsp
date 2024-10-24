<%
java.util.Date dts = new java.util.Date();
int ms = 1900+dts.getYear();
int startyear=2006;
int endyear = ms+2;
for(int i=startyear;i<=endyear;i++)
	out.println("<option value="+i+">"+i+" - "+(i+1)+"</option>");

%>
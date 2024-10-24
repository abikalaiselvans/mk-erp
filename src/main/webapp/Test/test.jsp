<link href="../JavaScript/css/maven-base.css" rel="stylesheet" type="text/css">

<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
 
	 

<%
Vector mn = new Vector();
Vector child= null;

for(int u=1;u<100;u++)
{
	child = new Vector();
	child.addElement(new Integer(u));
	for(int k=1;k<10;k++)
		child.addElement("Mythra---"+u+k);
	mn.add(child);
} 
 
mn.add(child);
request.setAttribute("table",mn);
%>


  
			   
			   <display:table   id="_table" name="table"  pagesize="99" export="true">
			   
			   
			   <display:caption> <jsp:scriptlet>	out.println(" Testing Purpose ");  </jsp:scriptlet> 	</display:caption>
		
		
					<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					
					 
					<display:column title="No#" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Name" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Expression" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:setProperty name="export.csv.filename" value="test.csv"/>
					<display:setProperty name="export.excel.filename" value="test.xls"/>
					<display:setProperty name="export.xml.filename" value="test.xml"/>
					<display:setProperty name="export.pdf.filename" value="test.pdf"/>
					<display:setProperty name="export.pdf" value="true" />

		</display:table> 

 
	
	
<%
						for(int k=0;k<10;k++);
							//out.println("<display:column title=\"No#"+k+"\" sortable=\"true\">"+temp.elementAt(k)"+</display:column>");
						
					%>
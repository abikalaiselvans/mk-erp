 <%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
 
  	<%
Vector mn = new Vector();
Vector child= null;

child = new Vector();
child.addElement(new Integer(1));
child.addElement("--");
child.addElement("**");
mn.add(child);

child = new Vector();
child.addElement(new Integer(2));
child.addElement("==");
child.addElement("&&");
mn.add(child);
child = new Vector();
child.addElement(new Integer(3));
child.addElement("$$");
child.addElement("@@");
mn.add(child);
request.setAttribute("results",mn);
%>
 
  
  
	<display:table  id="_table" name="results" export="true">
		
		 <display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
		
		<display:setProperty name="export.pdf.filename" value="example.pdf" />
		<display:setProperty name="export.rtf.filename" value="example.rtf" />
		
		<display:column title="No#" sortable="true"><%=temp.elementAt(0)%></display:column>
		<display:column title="Name" sortable="true"><%=temp.elementAt(1)%></display:column>
		<display:column title="Expression" sortable="true"><%=temp.elementAt(2)%></display:column>
				
		

	</display:table>
	
    

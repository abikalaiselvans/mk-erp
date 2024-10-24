 <%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<head>
 

  
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>
 
 
<body  onpaste='return false;'><br><br> 
<%
 

 String reportheader="STATE LIST REPORT "; 
 String sql="";

 

	 sql="  SELECT a.CHR_STATENAME FROM com_m_state a ORDER BY a.CHR_STATENAME ";
  
  	 String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
     Vector mn = new Vector();
	 Vector child= null;
     for(int u=0; u<data.length;u++)
	 {
	     	child = new Vector();
			child.addElement((u+1));
			child.addElement(data[u][0]);
			mn.add(child);
     } 
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> "+reportheader+" </h3></center><br>");
 
  
  
 
%>



<display:table   id="_table" name="table"   export="true" pagesize="25">

	<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
	<display:column title="S.NO" sortable="true"><%=temp.elementAt(0)%></display:column>
	<display:column title="STATE" sortable="true"><%=temp.elementAt(1)%></display:column>
	  
	<display:setProperty name="export.excel.filename" value="Rept_State.xls"/>
	<display:setProperty name="export.pdf.filename" value="Rept_State.pdf"/>
	<display:setProperty name="export.csv.filename" value="Rept_State.csv"/>
	<display:setProperty name="export.pdf"  value="true" />
	 
</display:table>     
 		
<br><br> <center><a href='commonmain.jsp'><b class="deepred">CLOSE</b></a></center>	<br>		

 
</body>
 
 

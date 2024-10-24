<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.my.org.erp.menu.*"%>

<link rel="stylesheet" href="styles.css">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="script.js"></script>
 
<div id="cssmenu">

    <ul>
            <%
             
            Menu.views();
            
            Iterator iterator = Menu.viewpart.entrySet().iterator();
            while(iterator.hasNext())
            {
                String url="";
               Map.Entry mEntry=(Map.Entry) iterator.next();
               ArrayList<String> ob=(ArrayList)mEntry.getValue();
               try
               {
                   url=Menu.urlpart.get((String)mEntry.getKey());
                  
                   if(url==null)
                       url="#";
               }
               catch(Exception e)
               {
                   
               }
                
          
                
              %>  
                 <li><a href=<%=url %>><span><%=(String)mEntry.getKey() %></span></a>
                      <div>
	      <ul>
              <% 
                 if(!ob.isEmpty())
                 {
               %>
                    
               <%
                     for(String value:ob)
                     {
                       try
                       {
                           url=Menu.urlpart.get(value);
                            System.out.println(""+url);
                            if(url==null)
                             url="#";
                       }
                       catch(Exception e)
                       {
                           
                       }
               %>    
                     
                      <li><a href=<%=url%>><span><%=value %></span></a></li>
            	     
                <%
                     }
                 }
                 %>
                 
                 </ul>
                 </div>
                 </li>
                 <%
              }    
            %>
       
       
		
       
     
    </ul>
	
</div>


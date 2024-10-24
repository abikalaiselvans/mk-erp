<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%
java.util.Date dts = new java.util.Date();
int ms = dts.getYear();
int myear = ms+1900;
int startyear=2006;
int endyear = myear+2;
%>	
<select name="Year" class="formText135" id="Year" style="width:100">
	<%
      for(int u=startyear;u<=endyear;u++)
		out.println("<option value='"+u+"'>"+u+"</option>");

     %>
</select>
<script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();					
						setOptionValue('Year',year1);							
				//-->
          </script>

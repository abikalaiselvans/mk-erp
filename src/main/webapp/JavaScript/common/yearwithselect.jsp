<select name="year" class="boldEleven" id="year" class="formText135">
	<option value="Select">Select</option>
	<%
			 
		java.util.Date dts = new java.util.Date();
		@SuppressWarnings("deprecation")
		int ms = dts.getYear();
		int myear = ms+1900;
		int startyear=2006;
		int endyear = myear+50;
	 	for(int u=startyear;u<=endyear;u++)
			out.println("<option value='"+u+"'>"+u+"</option>"); 	
  %>
</select>
<script language='JavaScript' type="text/javascript">
				<!--			
						var yd=new Date()
						var ymonth1=yd.getMonth() + 1
						if(ymonth1<10) ymonth1="0"+ymonth1;
						var yyear1=yd.getFullYear();					
						setOptionValue('year',yyear1);							
				//-->
</script>
  
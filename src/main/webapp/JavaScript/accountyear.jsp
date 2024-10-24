<select name="Year" class="formText135" id="Year"  >
<%
java.util.Date dts = new java.util.Date();
int ms = 1900+dts.getYear();
int startyear=2006;
int endyear = ms+2;
for(int i=startyear;i<=endyear;i++)
	out.println("<option value="+i+">"+i+" - "+(i+1)+"</option>");
%>
</select>
<script language='JavaScript' type="text/javascript">
	<!--			
			var d=new Date();
			var month1=parseInt(d.getMonth() + 1);
			var year1=parseInt(d.getFullYear());
			var m="";
			if(month1<4)
				year1 = year1-1;
			if(month1<10) 
				m="0"+month1;
			
			setOptionValue('Year',year1);	
								
	//-->
</script>
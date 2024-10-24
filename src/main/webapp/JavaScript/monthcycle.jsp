<%@ page  import="com.my.org.erp.common.CommonFunctions"  %>
  
<%
String cycledt[][] = CommonFunctions.QueryExecute("SELECT INT_FROM, INT_TO  FROM  att_m_basicsettings WHERE INT_ID=1 ");

%>

<select name="month" class="formText135" id="month"  style="width:150">
	<option value="0">Select cycle</option>
	<option value="01"><%=cycledt[0][0]%> th January - <%=cycledt[0][1]%> th February</option>
	<option value="02"><%=cycledt[0][0]%> th February - <%=cycledt[0][1]%> th March</option>
	<option value="03"><%=cycledt[0][0]%> th March - <%=cycledt[0][1]%> th April</option>
	<option value="04"><%=cycledt[0][0]%> th April - <%=cycledt[0][1]%> th May</option>
	<option value="05"><%=cycledt[0][0]%> th May - <%=cycledt[0][1]%> th June</option>
	<option value="06"><%=cycledt[0][0]%> th June - <%=cycledt[0][1]%> th July</option>
	<option value="07"><%=cycledt[0][0]%> th July - <%=cycledt[0][1]%> th August</option>
	<option value="08"><%=cycledt[0][0]%> th August - <%=cycledt[0][1]%> th September</option>
	<option value="09"><%=cycledt[0][0]%> th September - <%=cycledt[0][1]%> th October</option>
	<option value="10"><%=cycledt[0][0]%> th October - <%=cycledt[0][1]%> th November</option>
	<option value="11"><%=cycledt[0][0]%> th November - <%=cycledt[0][1]%> th December</option>
	<option value="12"><%=cycledt[0][0]%> th December - <%=cycledt[0][1]%> th January</option>
</select>
<script language='JavaScript' type="text/javascript">setCurrentMonth('month')</script>
			 

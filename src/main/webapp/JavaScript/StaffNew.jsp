<table border="1" cellpadding="5" cellspacing="0"  >
	<tr>
		<td class="tabledata"><b>Department :&nbsp;</b> <select
			class="tabledata" name="Department" id="Department"
			style="width: 116; height:22" onchange="loadStaff()">
			<option value="-1">All</option>
			<%
	  		String sql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart";
	  		String depName[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	  		for(int i=0;i<depName.length;i++){
	  			out.println("<option value='"+depName[i][0]+"'>"+depName[i][1]+"</option>");
	  		}
	  	%>
		</select></td>
		<td class="tabledata" width="300"><b>&nbsp;Designation
		:&nbsp;</b> <select class="tabledata" name="Designation" id="Designation"
			style="width: 200; height:26" onchange="loadStaff()">
			<option value="-1">All</option>
			<%
	  		sql="SELECT INT_DESIGID,CHR_DESIGNAME FROM com_m_desig";
	  		String desName[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	  		for(int i=0;i<desName.length;i++){
	  			out.println("<option value='"+desName[i][0]+"'>"+desName[i][1]+"</option>");
	  		}
	  	%>
		</select></td>
	</tr>
	<tr>
		<td class="tabledata"><b>Staff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:&nbsp;</b> <input type="text" size="15" name="staffName" id="staffName"
			onkeyup="upperMe(this),loadStaff()"></td>
		<td width="241"><select class="tabledata" name="ename" id="ename"
			multiple="multiple" size="10" style="width: 350; height:150">
			<option value="0">SELECT</option>
		</select></td>
	</tr>
</table>

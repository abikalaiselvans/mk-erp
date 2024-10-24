
<select name="bg"  id="bg" class="formText135" style="width:170">
	<option value="0">Select</option>
	<%
	String bloodsql=" SELECT INT_BLOODGROUPID,CHR_GROUPNAME  FROM  com_m_bloodgroup  ORDER BY CHR_GROUPNAME ";
	String bloodData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(bloodsql);
	if (bloodData.length>0)
		for (int i=0; i<bloodData.length; i++) 
			out.println("<option value="+bloodData[i][0]+">"+bloodData[i][1] +"</option>");			
	
						%>

</select>



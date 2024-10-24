<table border="1" cellpadding="5" cellspacing="0"  >
	<tr>
		<td class="tabledata"><b>From</b>&nbsp;&nbsp;&nbsp;&nbsp; <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <input type=text size=15 name="fdate" id="fdate"
			onkeypress="dateOnly(this)"> <a
			href="javascript:cal3.popup();"><img
			src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
			alt="Click Here to Pick up the date"></a></td>
		<script language="JavaScript">
	var cal3 = new calendar1(document.forms['frm'].elements['fdate']);
	cal3.year_scroll = true;
	cal3.time_comp = false;
	setCurrentDate('fdate');				
 </script>
		<td class="tabledata" width="241"><b>To&nbsp; </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp; <b>:</b> <input type=text size=15 name="tdate" id="tdate"
			onkeypress="dateOnly(this)"> <a
			href="javascript:cal4.popup();"><img
			src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
			alt="Click Here to Pick up the date"></a></td>
	</tr>
	<script language="JavaScript">
			var cal4 = new calendar1(document.forms['frm'].elements['tdate']);
			cal4.year_scroll = true;
			cal4.time_comp = false;
			setCurrentDate('tdate');				
	</script>

	<tr>
		<td class="tabledata"><b>Department :</b> <select
			name="Department" id="Department" style="width: 116; height:22"
			onchange="loadStaff()">
			<option value="0">SELECT</option>
		</select></td>
		<td class="tabledata" width="241"><b>&nbsp;Designation
		:&nbsp; </b> <select name="Designation" id="Designation"
			style="width: 132; height:26" onchange="loadStaff()">
			<option value="0">SELECT</option>
		</select></td>
	</tr>
	<tr>
		<td class="tabledata"><b>Staff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		: </b> <input type="text" size="15" name="staffName" id="staffName"
			onkeyup="loadStaff()"></td>
		<td width="241"><select name="ename" id="ename"
			multiple="multiple" size="5" style="width: 241; height:86">
			<option value="0">SELECT</option>
		</select></td>
	</tr>
</table>

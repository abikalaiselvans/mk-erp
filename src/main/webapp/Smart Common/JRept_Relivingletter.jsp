 
<html>
<body>
<form action="../letter">
${param.file }<br>

<center><table>
   
<tr><td>Employee ID
  <input type="hidden" id="file"  name="file" value="RelieveLetter"/></td><td><input name="empid"/></td></tr>
<tr><td>Export Type:</td><td><select name="export">
<option>pdf</option>
<option>rtf</option>
<option>html</option>
<option>xls</option>
<option>csv</option>
</select></td></tr>
<tr><td colspan="2" align="center"><input type="submit" value="Submit" /></td></tr>
<tr><td colspan="2" >
 

</td></tr>
</table></center>

</form>
</body>
</html>
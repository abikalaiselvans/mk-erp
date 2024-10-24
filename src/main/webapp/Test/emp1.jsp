<html>
 <head><title>Upload page</title></head></p> <p><body  onpaste='return false;'>
 <form action="emp2.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
   <center>
   <table border="2">
       <tr>
	       <td align="right"><b>Employee Name:</td>
		   <td ><input name="emp_name" type="text" value="kalaiselva"></td>
	   </tr>
	   <tr>
	       <td align="right"><b>Employee Address:</td>
		   <td ><input name="address1" type="text" value="2/8A, North Street"></td>
		   
	   </tr>
	   <tr>
	       <td>
		   </td>
		   <td>
		      <input name="address2" type="text" value="Abinimangalam">
		   </td>
	   </tr>
	   <tr>
	       <td align="right"><b>Contact Number:</td>
		   <td ><input name="contact_number" type="text" value="9865043008"></td>
	   </tr>
       <tr>
	       <td align="right"><b>Employee Email ID:</td>
		   <td ><input name="email_id" type="text"></td>
	   </tr>
	   
       <tr>
	       <td align="right"><b>Employee Image </td>
	       <td>
		       <input name="file" type="file" id="file">
		   <td>
	   </tr>
	   
		 <tr>
		    <td align="center">
               <input type="submit" name="Submit" value="Submit"   accesskey="s"   />
			   <input type="reset" name="Reset" value="Reset"/>

			</td>
		 </tr>
    </table>
	</center>
 </form>
 </body>
 </html>
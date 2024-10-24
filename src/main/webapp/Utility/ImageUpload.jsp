<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<%@include file="Redirect.jsp" %>	

<title> :: UTILITY :: </title>
  
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />



<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 
	
function Load()
{

	try
	{  		 
		if(   
			 checkNullSelect('category','Select Logo ','0') 
			&& checkNull('F1','Select Photo ') 
			&&  findSize('F1','File should be less than 40Kb')  )
  		{
			var file = document.getElementById("F1").value;
			var fileExtn = file.lastIndexOf(".");
			var Extn=file.substring(fileExtn);
			if( (Extn == ".jpeg") ||(Extn == ".JPEG") ||(Extn == ".JPG") ||(Extn == ".jpg") )
			{
				
				var query="ImageCopy.jsp?category="+document.getElementById('category').value;
				document.frm.action=query;
  				//document.uploadForm.submit();
				return true;
				
				 
				 
			}	
			else
			{
				alert("Only possible JPEG only");
				return false;
			}
		}
   		else
		{
   			
			return false;
  		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
}  
	
function findSize(ctr,msg) 
{
    var fileInput =  document.getElementById(ctr);
    try
	{
		var s = parseInt(fileInput.files[0].size);
		// 1 MB = 1048579 bytes  20kb = 20480
		if( s <= 40960)  
			return true;
		else
		{
			alert(msg);
			return false;
		}	
         
    }
	catch(e)
	{
        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
        var e = objFSO.getFile( fileInput.value);
        var fileSize = e.size;
        if( parseInt(fileSize)  <= 40960)
			return true;
		else
		{
			alert(fileSize);
			return false;
		}	  
		 
    }
}

</script>



<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>

		<FORM name="frm"  ENCTYPE="multipart/form-data"   METHOD="POST" onSubmit="return Load()">
		
		
		
		<table border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td   valign="top"><table width="450" border="0" align="center" cellpadding="2" cellspacing="2"  >
                    <tr>
                      <td colspan="2"><p align= "center"><B> UPLOADING LOGO </B></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Logo</td>
                      <td> 
					  <select name="category" id="category">
					  <option value="0">Select Logo</option>
					  <option value="logo">Logo</option>
					  <option value="payslip">Payslip watermark</option>
					  <option value="hImage">Header Image</option>
					  <option value="fImage">Footer Image</option>
                      </select>
                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Choose the file To Upload:</td>
                      <td><INPUT NAME="F1" id="F1"  type="file" ></td>
                    </tr>
                    <tr>
                      <td colspan="2"    class="errormessage"><div align="center">( file should be &lt;= 30Kb ) </div></td>
                    </tr>
                    <tr>
                      <td colspan="2"><div align="center"><img src="../StaffPhoto/default.jpg"
			width="100" height="130" border="1" id="Photo"  name="Photo" title="Image should be 100 x 130 pixel" /></div></td>
                    </tr>
                    <tr>
                      <td colspan="2"><p align="right">
                        <INPUT name="submit" TYPE="submit" VALUE="Upload File" >
                      </p></td>
                    </tr>
                    <tr>
                      <td colspan="2"><table width="53" align="center">
                          <tr>
                            <td width="56"><input class="buttonbold" type="button"
										name="Button"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                          </tr>
                      </table>
					 
					  </td>
                    </tr>
                    <tr>
                      <td colspan="2">&nbsp;</td>
                    </tr>
                  </table></td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"></td>
				</tr>
			</tbody>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="106">&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
</html>
